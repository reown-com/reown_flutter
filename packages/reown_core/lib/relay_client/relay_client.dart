import 'dart:async';
import 'dart:convert';

import 'package:event/event.dart';
import 'package:reown_core/i_core_impl.dart';
import 'package:reown_core/pairing/utils/json_rpc_utils.dart';
import 'package:reown_core/relay_client/i_message_tracker.dart';
import 'package:reown_core/relay_client/i_relay_client.dart';
import 'package:reown_core/relay_client/json_rpc_2/src/parameters.dart';
import 'package:reown_core/relay_client/json_rpc_2/src/peer.dart';
import 'package:reown_core/relay_client/websocket/i_websocket_handler.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_core/relay_client/websocket/websocket_handler.dart';
import 'package:reown_core/store/i_generic_store.dart';
import 'package:reown_core/utils/utils.dart';

import 'package:reown_core/models/basic_models.dart';
import 'package:reown_core/utils/constants.dart';
import 'package:reown_core/utils/errors.dart';
import 'package:reown_core/version.dart';

class RelayClient implements IRelayClient {
  static const IRN_PUBLISH = 'publish';
  static const IRN_SUBSCRIPTION = 'subscription';
  static const IRN_SUBSCRIBE = 'subscribe';
  static const IRN_UNSUBSCRIBE = 'unsubscribe';
  static const WC_PROPOSE_SESSION = 'proposeSession';
  static const WC_APPROVE_SESSION = 'approveSession';

  /// Events ///
  /// Relay Client

  @override
  final Event<EventArgs> onRelayClientConnect = Event();

  @override
  final Event<EventArgs> onRelayClientDisconnect = Event();

  @override
  final Event<ErrorEvent> onRelayClientError = Event<ErrorEvent>();

  @override
  final Event<MessageEvent> onRelayClientMessage = Event<MessageEvent>();

  @override
  final Event<MessageEvent> onLinkModeMessage = Event<MessageEvent>();

  /// Subscriptions
  @override
  final Event<SubscriptionEvent> onSubscriptionCreated =
      Event<SubscriptionEvent>();

  @override
  final Event<SubscriptionDeletionEvent> onSubscriptionDeleted =
      Event<SubscriptionDeletionEvent>();

  @override
  final Event<EventArgs> onSubscriptionResubscribed = Event();

  @override
  final Event<EventArgs> onSubscriptionSync = Event();

  @override
  bool get isConnected => jsonRPC != null && !jsonRPC!.isClosed;

  bool get _relayIsClosed => jsonRPC != null && jsonRPC!.isClosed;

  bool _initialized = false;
  bool _active = true;
  bool _connecting = false;
  Future _connectingFuture = Future.value();
  bool _handledClose = false;

  // late WebSocketChannel socket;
  // IWebSocketHandler? socket;
  Peer? jsonRPC;

  /// Stores all the subs that haven't been completed
  Map<String, Future<dynamic>> pendingSubscriptions = {};

  IMessageTracker messageTracker;
  IGenericStore<String> topicMap;
  final IWebSocketHandler socketHandler;

  IReownCore core;

  bool _subscribedToHeartbeat = false;

  RelayClient({
    required this.core,
    required this.messageTracker,
    required this.topicMap,
    IWebSocketHandler? socketHandler,
  }) : socketHandler = socketHandler ?? WebSocketHandler();

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await messageTracker.init();
    await topicMap.init();

    // Setup the json RPC server
    await _connect();
    _subscribeToHeartbeat();

    _initialized = true;
  }

  @override
  Future<void> publish({
    required String topic,
    required String message,
    required PublishOptions options,
  }) async {
    _checkInitialized();

    final Map<String, dynamic> data = {
      'topic': topic,
      'message': message,
      ...options.toJson(),
    };

    core.logger.i('[$runtimeType] publish, topic: $topic, ${options.toJson()}');

    try {
      await messageTracker.recordMessageEvent(topic, message);
      final _ = await _sendJsonRpcRequest(
        id: JsonRpcUtils.payloadId(entropy: 6),
        method: _buildIRNMethod(IRN_PUBLISH),
        parameters: data,
      );
    } catch (e, s) {
      core.logger.e('[$runtimeType], publish: $e', stackTrace: s);
      onRelayClientError.broadcast(ErrorEvent(e));
    }
  }

  @override
  Future<void> publishPayload({
    required Map<String, dynamic> payload,
    required PublishOptions options,
  }) async {
    _checkInitialized();

    final Map<String, dynamic> parameters = {
      ...payload,
      ...options.toJson(),
    };

    core.logger.t('[$runtimeType] publishPayload: ${jsonEncode(parameters)}');

    try {
      if (options.publishMethod == RelayClient.WC_PROPOSE_SESSION) {
        final topic = payload['pairingTopic'];
        final message = payload['sessionProposal'];
        await messageTracker.recordMessageEvent(topic, message);
      } else {
        final topic = payload['sessionTopic'];
        final message = payload['sessionProposalResponse'];
        await messageTracker.recordMessageEvent(topic, message);
      }
      final _ = await _sendJsonRpcRequest(
        id: JsonRpcUtils.payloadId(entropy: 6),
        method: _buildWCMethod(options.publishMethod!),
        parameters: parameters,
      );
    } catch (e, s) {
      core.logger.e('[$runtimeType], publishPayload: $e, $s');
      onRelayClientError.broadcast(ErrorEvent(e));
    }
  }

  @override
  Future<String> subscribe({
    required SubscribeOptions options,
  }) async {
    _checkInitialized();

    final topic = options.topic;
    core.logger.i('[$runtimeType] subscribe, $topic');
    pendingSubscriptions[topic] = _onSubscribe(options);

    return await pendingSubscriptions[topic];
  }

  @override
  Future<void> unsubscribe({required String topic}) async {
    _checkInitialized();

    core.logger.i('[$runtimeType] unsubscribe, $topic');

    String id = topicMap.get(topic) ?? '';

    try {
      await _sendJsonRpcRequest(
        id: JsonRpcUtils.payloadId(entropy: 6),
        method: _buildIRNMethod(IRN_UNSUBSCRIBE),
        parameters: {'topic': topic, 'id': id},
      );
    } catch (e, s) {
      core.logger.e('[$runtimeType], unsubscribe: $e', stackTrace: s);
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    // Remove the subscription
    pendingSubscriptions.remove(topic);
    await topicMap.delete(topic);

    // Delete all the messages
    await messageTracker.delete(topic);
  }

  @override
  Future<void> connect({String? relayUrl}) async {
    _checkInitialized();

    core.logger.i('[$runtimeType]: Connecting to relay');

    await _connect(relayUrl: relayUrl);
  }

  @override
  Future<void> disconnect() async {
    _checkInitialized();

    core.logger.i('[$runtimeType]: Disconnecting from relay');

    await _disconnect();
  }

  /// PRIVATE FUNCTIONS ///

  Future<void> _connect({String? relayUrl}) async {
    core.logger.d(
      '[$runtimeType]: _connect $relayUrl, isConnected: $isConnected',
    );
    if (isConnected) {
      return;
    }

    core.relayUrl = relayUrl ?? core.relayUrl;
    core.logger.i('[$runtimeType] Connecting to relay url ${core.relayUrl}');

    // If we have tried connecting to the relay before, disconnect
    if (_active) {
      await _disconnect();
    }

    try {
      // Connect and track the connection progress, then start the heartbeat
      _connectingFuture = _createJsonRPCProvider();
      await _connectingFuture;
      _connecting = false;
      _subscribeToHeartbeat();
      //
    } on TimeoutException catch (e, s) {
      core.logger.e('[$runtimeType], _connect timeout: $e', stackTrace: s);
      onRelayClientError.broadcast(ErrorEvent('Connection to relay timeout'));
      _connecting = false;
      _connect();
    } catch (e, s) {
      core.logger.e('[$runtimeType], _connect error: $e', stackTrace: s);
      onRelayClientError.broadcast(ErrorEvent(e));
      _connecting = false;
    }
  }

  Future<void> _disconnect() async {
    core.logger.d('[$runtimeType]: _disconnecting from relay');
    _active = false;

    final bool shouldBroadcastDisonnect = isConnected;

    await jsonRPC?.close();
    jsonRPC = null;
    await socketHandler.close();
    _unsubscribeToHeartbeat();

    if (shouldBroadcastDisonnect) {
      onRelayClientDisconnect.broadcast();
    }
  }

  Future<void> _createJsonRPCProvider() async {
    _connecting = true;
    _active = true;
    final signedJWT = await core.crypto.signJWT(core.relayUrl);
    core.logger.d('[$runtimeType]: Signed JWT: $signedJWT');
    final url = ReownCoreUtils.formatRelayRpcUrl(
      protocol: ReownConstants.CORE_PROTOCOL,
      version: ReownConstants.CORE_VERSION,
      sdkVersion: packageVersion,
      relayUrl: core.relayUrl,
      auth: signedJWT,
      projectId: core.projectId,
      packageName: (await ReownCoreUtils.getPackageName()),
    );

    if (jsonRPC != null) {
      await jsonRPC!.close();
      jsonRPC = null;
    }

    core.logger.d('[$runtimeType]: Initializing WebSocket with $url');
    await socketHandler.setup(url: url);
    await socketHandler.connect();

    jsonRPC = Peer(socketHandler.channel!);

    jsonRPC!.registerMethod(
      _buildIRNMethod(IRN_SUBSCRIPTION),
      _handleSubscription,
    );
    jsonRPC!.registerMethod(
      _buildIRNMethod(IRN_SUBSCRIBE),
      _handleSubscribe,
    );
    jsonRPC!.registerMethod(
      _buildIRNMethod(IRN_UNSUBSCRIBE),
      _handleUnsubscribe,
    );

    if (jsonRPC!.isClosed) {
      throw const ReownCoreError(
        code: 0,
        message: 'WebSocket closed',
      );
    }

    jsonRPC!.listen();

    // When jsonRPC closes, emit the event
    _handledClose = false;
    jsonRPC!.done.then(
      (value) {
        _handleRelayClose(
          socketHandler.closeCode,
          socketHandler.closeReason,
        );
      },
    );

    onRelayClientConnect.broadcast();
    core.logger.i('[$runtimeType]: Connected to relay ${core.relayUrl}');
  }

  Future<void> _handleRelayClose(int? code, String? reason) async {
    if (_handledClose) {
      core.logger.d('[$runtimeType]: Relay close already handled');
      return;
    }
    _handledClose = true;

    core.logger.d(
      '[$runtimeType]: Handling relay close, code: $code, reason: $reason',
    );
    // If the relay isn't active (Disconnected manually), don't do anything
    if (!_active) {
      return;
    }

    // If the code requires reconnect, do so
    final reconnectCodes = [1001, 4008, 4010, 1002, 1005, 10002];
    if (code != null) {
      if (reconnectCodes.contains(code)) {
        await _connect();
      } else {
        await disconnect();
        final errorReason = code == 3000
            ? reason ?? WebSocketErrors.INVALID_PROJECT_ID_OR_JWT
            : '';
        onRelayClientError.broadcast(
          ErrorEvent(ReownCoreError(
            code: code,
            message: errorReason,
          )),
        );
        core.logger.e('[$runtimeType], _handleRelayClose: $core, $errorReason');
      }
    }
  }

  void _subscribeToHeartbeat() {
    if (!_subscribedToHeartbeat) {
      core.heartbeat.onPulse.subscribe(_heartbeatSubscription);
      _subscribedToHeartbeat = true;
    }
  }

  void _unsubscribeToHeartbeat() {
    core.heartbeat.onPulse.unsubscribe(_heartbeatSubscription);
    _subscribedToHeartbeat = false;
  }

  void _heartbeatSubscription(EventArgs? args) async {
    if (_relayIsClosed) {
      await _handleRelayClose(10002, null);
    }
  }

  String _buildIRNMethod(String method) {
    return '${ReownConstants.RELAYER_DEFAULT_PROTOCOL}_$method';
  }

  String _buildWCMethod(String method) {
    return '${ReownConstants.RELAYER_WC_PROTOCOL}_$method';
  }

  // This method could be placed directly into pairings API but it's place here for consistency with onRelayClientMessage
  @override
  Future<bool> handleLinkModeMessage(String topic, String message) async {
    core.logger.d('[$runtimeType]: handleLinkModeMessage: $topic, $message');

    // if client calls dispatchEnvelope with the same message more than once we do nothing.
    final recorded = messageTracker.messageIsRecorded(topic, message);
    if (recorded) return true;

    // Broadcast the message
    onLinkModeMessage.broadcast(
      MessageEvent(
        topic,
        message,
        DateTime.now().millisecondsSinceEpoch,
        TransportType.linkMode,
      ),
    );
    return true;
  }

  /// JSON RPC MESSAGE HANDLERS

  Future<bool> handlePublish(String topic, String message) async {
    core.logger.d('[$runtimeType]: Handling Publish Message: $topic, $message');
    // If we want to ignore the message, stop
    if (await _shouldIgnoreMessageEvent(topic, message)) {
      core.logger.d('[$runtimeType]: Ignoring Message: $topic, $message');
      return false;
    }

    // Record a message event
    await messageTracker.recordMessageEvent(topic, message);

    // Broadcast the message
    onRelayClientMessage.broadcast(
      MessageEvent(
        topic,
        message,
        DateTime.now().millisecondsSinceEpoch,
        TransportType.relay,
      ),
    );
    return true;
  }

  Future<bool> _handleSubscription(Parameters params) async {
    String topic = params['data']['topic'].value;
    String message = params['data']['message'].value;
    return await handlePublish(topic, message);
  }

  int _handleSubscribe(Parameters params) {
    return params.hashCode;
  }

  void _handleUnsubscribe(Parameters params) {
    core.logger.d('[$runtimeType]: handle unsubscribe $params');
  }

  /// MESSAGE HANDLING

  Future<bool> _shouldIgnoreMessageEvent(String topic, String message) async {
    if (!await _isSubscribed(topic)) return true;
    return messageTracker.messageIsRecorded(topic, message);
  }

  /// SUBSCRIPTION HANDLING

  Future<dynamic> _sendJsonRpcRequest({
    required String method,
    int? id,
    dynamic parameters,
  }) async {
    // If we are connected and we know it send the message!
    if (isConnected) {
      // Here so we dont return null
    }
    // If we are connecting, then wait for the connection to establish and then send the message
    else if (_connecting) {
      await _connectingFuture;
    }
    // If we aren't connected but should be (active), try to (re)connect and then send the message
    else if (!isConnected && _active) {
      await connect();
    }
    // In all other cases return null
    else {
      return null;
    }
    return await jsonRPC!.sendRequest(
      method,
      parameters,
      id,
    );
  }

  Future<String> _onSubscribe(SubscribeOptions options) async {
    String? requestId;
    final topic = options.topic;
    final transportType = options.transportType;

    // Sign 2.5
    if (options.skipSubscribe) {
      final subId = '$topic${await core.crypto.getClientId()}';
      requestId = core.crypto.getUtils().hashMessage(subId);
      await topicMap.set(topic, requestId);
      pendingSubscriptions.remove(topic);

      core.logger.t(
        '[$runtimeType] skipSubscribe, topic: $topic, requestId: $requestId',
      );

      return requestId;
    }

    try {
      if (transportType == TransportType.relay) {
        requestId = await _sendJsonRpcRequest(
          id: JsonRpcUtils.payloadId(entropy: 6),
          method: _buildIRNMethod(IRN_SUBSCRIBE),
          parameters: {'topic': topic},
        );
      }
    } catch (e, s) {
      core.logger.e(
        '[$runtimeType], _onSubscribe: Topic, $topic, Error: $e',
        stackTrace: s,
      );
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    if (requestId == null) {
      return '';
    }

    await topicMap.set(topic, requestId.toString());
    pendingSubscriptions.remove(topic);

    core.logger.t(
      '[$runtimeType], _onSubscribe, topic: $topic, requestId: $requestId',
    );

    return requestId;
  }

  Future<bool> _isSubscribed(String topic) async {
    if (topicMap.has(topic)) {
      return true;
    }

    if (pendingSubscriptions.containsKey(topic)) {
      await pendingSubscriptions[topic];
      return topicMap.has(topic);
    }

    return false;
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
