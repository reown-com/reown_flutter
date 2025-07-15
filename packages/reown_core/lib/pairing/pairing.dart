import 'dart:async';
import 'dart:convert';

import 'package:event/event.dart';
import 'package:reown_core/events/models/link_mode_events.dart';
import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_core/models/tvf_data.dart';
import 'package:reown_core/pairing/i_json_rpc_history.dart';
import 'package:reown_core/relay_client/relay_client.dart';
import 'package:reown_core/store/i_generic_store.dart';
import 'package:reown_core/crypto/crypto_models.dart';
import 'package:reown_core/i_core_impl.dart';
import 'package:reown_core/pairing/i_pairing.dart';
import 'package:reown_core/pairing/i_pairing_store.dart';
import 'package:reown_core/pairing/utils/pairing_models.dart';
import 'package:reown_core/pairing/utils/json_rpc_utils.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_core/utils/utils.dart';
import 'package:reown_core/models/uri_parse_result.dart';
import 'package:reown_core/models/basic_models.dart';
import 'package:reown_core/utils/constants.dart';
import 'package:reown_core/utils/errors.dart';
import 'package:reown_core/utils/method_constants.dart';

class PendingRequestResponse {
  Completer completer;
  String method;
  dynamic response;
  JsonRpcError? error;

  PendingRequestResponse({
    required this.completer,
    required this.method,
    this.response,
    this.error,
  });
}

class Pairing implements IPairing {
  bool _initialized = false;

  @override
  final Event<PairingEvent> onPairingCreate = Event<PairingEvent>();
  @override
  final Event<PairingActivateEvent> onPairingActivate =
      Event<PairingActivateEvent>();
  @override
  final Event<PairingEvent> onPairingPing = Event<PairingEvent>();
  @override
  final Event<PairingInvalidEvent> onPairingInvalid =
      Event<PairingInvalidEvent>();
  @override
  final Event<PairingEvent> onPairingDelete = Event<PairingEvent>();
  @override
  final Event<PairingEvent> onPairingExpire = Event<PairingEvent>();

  /// Stores all the pending requests
  Map<int, PendingRequestResponse> pendingRequests = {};

  final IReownCore core;
  final IPairingStore pairings;
  final IJsonRpcHistory history;

  /// Stores the public key of Type 1 Envelopes for a topic
  /// Once a receiver public key has been used, it is removed from the store
  /// Thus, this store works under the assumption that a public key will only be used once
  final IGenericStore<ReceiverPublicKey> topicToReceiverPublicKey;

  Pairing({
    required this.core,
    required this.pairings,
    required this.history,
    required this.topicToReceiverPublicKey,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    _registerRelayEvents();
    _registerExpirerEvents();
    _registerheartbeatSubscription();

    await core.expirer.init();
    await pairings.init();
    await history.init();
    await topicToReceiverPublicKey.init();

    await _cleanup();

    await _resubscribeAll();

    _initialized = true;
  }

  @override
  Future<void> checkAndExpire() async {
    for (var pairing in getPairings()) {
      await core.expirer.checkAndExpire(pairing.topic);
    }
  }

  @override
  Future<CreateResponse> create({
    List<List<String>>? methods,
    TransportType transportType = TransportType.relay,
    bool skipSubscribe = false,
  }) async {
    _checkInitialized();
    final String symKey = core.crypto.getUtils().generateRandomBytes32();
    final String topic = await core.crypto.setSymKey(symKey);
    final int expiry = ReownCoreUtils.calculateExpiry(
      ReownConstants.FIVE_MINUTES,
    );
    final Relay relay = Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL);
    final PairingInfo pairing = PairingInfo(
      topic: topic,
      expiry: expiry,
      relay: relay,
      active: false,
      methods: methods?.expand((e) => e).toList() ?? [],
    );
    final Uri uri = ReownCoreUtils.formatUri(
      protocol: core.protocol,
      version: core.version,
      topic: topic,
      symKey: symKey,
      relay: relay,
      methods: methods,
      expiry: expiry,
    );

    onPairingCreate.broadcast(
      PairingEvent(
        topic: topic,
      ),
    );

    await pairings.set(topic, pairing);
    await core.relayClient.subscribe(
      options: SubscribeOptions(
        topic: topic,
        transportType: transportType,
        skipSubscribe: skipSubscribe,
      ),
    );
    await core.expirer.set(topic, expiry);

    return CreateResponse(
      topic: topic,
      uri: uri,
      pairingInfo: pairing,
    );
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
    bool activatePairing = false,
  }) async {
    _checkInitialized();

    // print(uri.queryParameters);
    final int expiry = ReownCoreUtils.calculateExpiry(
      ReownConstants.FIVE_MINUTES,
    );
    final URIParseResult parsedUri = ReownCoreUtils.parseUri(uri);
    if (parsedUri.version != URIVersion.v2) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'URI is not WalletConnect version 2 URI',
      );
    }

    final String topic = parsedUri.topic;
    final Relay relay = parsedUri.v2Data!.relay;
    final String symKey = parsedUri.v2Data!.symKey;
    final PairingInfo pairing = PairingInfo(
      topic: topic,
      expiry: expiry,
      relay: relay,
      active: false,
      methods: parsedUri.v2Data!.methods,
    );

    try {
      JsonRpcUtils.validateMethods(
        parsedUri.v2Data!.methods,
        routerMapRequest.values.toList(),
      );
    } on ReownCoreError catch (e) {
      // Tell people that the pairing is invalid
      onPairingInvalid.broadcast(
        PairingInvalidEvent(
          message: e.message,
        ),
      );

      // Delete the pairing: "publish internally with reason"
      // await _deletePairing(
      //   topic,
      //   false,
      // );

      rethrow;
    }

    try {
      await pairings.set(topic, pairing);
      await core.crypto.setSymKey(symKey, overrideTopic: topic);
      await core.relayClient.subscribe(
        options: SubscribeOptions(
          topic: topic,
          transportType: TransportType.relay,
        ),
      );
      await core.expirer.set(topic, expiry);

      onPairingCreate.broadcast(
        PairingEvent(
          topic: topic,
        ),
      );

      if (activatePairing) {
        await activate(topic: topic);
      }
    } catch (e) {
      rethrow;
    }

    return pairing;
  }

  @override
  Future<void> activate({required String topic}) async {
    _checkInitialized();
    final int expiry = ReownCoreUtils.calculateExpiry(
      ReownConstants.THIRTY_DAYS,
    );
    // print('Activating pairing with topic: $topic');

    onPairingActivate.broadcast(
      PairingActivateEvent(
        topic: topic,
        expiry: expiry,
      ),
    );

    await pairings.update(
      topic,
      expiry: expiry,
      active: true,
    );
    await core.expirer.set(topic, expiry);
  }

  @override
  void register({
    required String method,
    required Function(String, JsonRpcRequest, [TransportType]) function,
    required ProtocolType type,
  }) {
    if (routerMapRequest.containsKey(method)) {
      final registered = routerMapRequest[method];
      if (registered!.type == type) {
        throw const ReownCoreError(
          code: -1,
          message: 'Method already exists',
        );
      }
    }

    routerMapRequest[method] = RegisteredFunction(
      method: method,
      function: function,
      type: type,
    );
  }

  @override
  Future<void> setReceiverPublicKey({
    required String topic,
    required String publicKey,
    int? expiry,
  }) async {
    _checkInitialized();
    await topicToReceiverPublicKey.set(
      topic,
      ReceiverPublicKey(
        topic: topic,
        publicKey: publicKey,
        expiry: ReownCoreUtils.calculateExpiry(
          expiry ?? ReownConstants.FIVE_MINUTES,
        ),
      ),
    );
  }

  @override
  Future<void> updateExpiry({
    required String topic,
    required int expiry,
  }) async {
    _checkInitialized();

    // Validate the expiry is less than 30 days
    if (expiry >
        ReownCoreUtils.calculateExpiry(
          ReownConstants.THIRTY_DAYS,
        )) {
      throw const ReownCoreError(
        code: -1,
        message: 'Expiry cannot be more than 30 days away',
      );
    }

    await pairings.update(
      topic,
      expiry: expiry,
    );
    await core.expirer.set(
      topic,
      expiry,
    );
  }

  @override
  Future<void> updateMetadata({
    required String topic,
    required PairingMetadata metadata,
  }) async {
    _checkInitialized();
    await pairings.update(
      topic,
      metadata: metadata,
    );
  }

  @override
  List<PairingInfo> getPairings() {
    return pairings.getAll();
  }

  @override
  PairingInfo? getPairing({required String topic}) {
    return pairings.get(topic);
  }

  @override
  Future<void> ping({required String topic}) async {
    _checkInitialized();

    await _isValidPing(topic);

    if (pairings.has(topic)) {
      // try {
      final bool _ = await sendRequest(
        topic,
        MethodConstants.WC_PAIRING_PING,
        {},
      );
    }
  }

  @override
  Future<void> disconnect({required String topic}) async {
    _checkInitialized();

    core.logger.i('[$runtimeType] disconnect $topic');

    await _isValidDisconnect(topic);
    if (pairings.has(topic)) {
      // Send the request to delete the pairing, we don't care if it fails
      try {
        sendRequest(
          topic,
          MethodConstants.WC_PAIRING_DELETE,
          Errors.getSdkError(Errors.USER_DISCONNECTED).toJson(),
        );
      } catch (_) {}

      // Delete the pairing
      await pairings.delete(topic);

      onPairingDelete.broadcast(
        PairingEvent(
          topic: topic,
        ),
      );
    }
  }

  @override
  IPairingStore getStore() {
    return pairings;
  }

  @override
  Future<void> isValidPairingTopic({required String topic}) async {
    if (!pairings.has(topic)) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "pairing topic doesn't exist: $topic",
      );
    }

    if (await core.expirer.checkAndExpire(topic)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'pairing topic: $topic',
      );
    }
  }

  // RELAY COMMUNICATION HELPERS

  @override
  Future<dynamic> sendRequest(
    String topic,
    String method,
    Map<String, dynamic> params, {
    int? id,
    int? ttl,
    EncodeOptions? encodeOptions,
    String? appLink,
    bool openUrl = true,
    TVFData? tvf,
  }) async {
    final payload = JsonRpcUtils.formatJsonRpcRequest(
      method,
      params,
      id: id,
    );
    final requestId = payload['id'] as int;

    final isLinkMode = (appLink ?? '').isNotEmpty;

    final message = await core.crypto.encode(
      topic,
      payload,
      options: isLinkMode
          ? EncodeOptions(type: EncodeOptions.TYPE_2)
          : encodeOptions,
    );

    if (message == null) {
      return;
    }

    // print('adding payload to pending requests: $requestId');
    final resp = PendingRequestResponse(
      completer: Completer(),
      method: method,
    );
    resp.completer.future.catchError((err) {
      // Catch the error so that it won't throw an uncaught error
    });
    pendingRequests[requestId] = resp;

    if (isLinkMode) {
      // during wc_sessionAuthenticate we don't need to openURL as it will be done by the host dapp
      if (openUrl) {
        final redirectURL = ReownCoreUtils.getLinkModeURL(
          appLink!,
          topic,
          message,
        );
        await ReownCoreUtils.openURL(redirectURL);
      }
      // Send Event through Events SDK
      core.events.recordEvent(LinkModeRequestEvent(
        direction: 'sent',
        correlationId: requestId,
        method: method,
      ));
      core.logger.d(
        '[$runtimeType] sendRequest linkMode ($appLink), '
        'id: $requestId topic: $topic, method: $method, '
        'params: $params, ttl: $ttl',
      );
    } else {
      RpcOptions opts = MethodConstants.RPC_OPTS[method]!['req']!;
      if (ttl != null) {
        opts = opts.copyWith(ttl: ttl);
      }
      //
      await core.relayClient.publish(
        topic: topic,
        message: message,
        options: PublishOptions(
          ttl: ttl ?? opts.ttl,
          tag: opts.tag,
          correlationId: requestId,
          // tvf data is sent only on tvfMethods methods
          tvf: _shouldSendTVF(opts.tag) ? tvf?.toJson() : null,
        ),
      );
      core.logger.d(
        '[$runtimeType] sendRequest relayClient, '
        'id: $requestId topic: $topic, method: $method, '
        'params: $params, ttl: ${ttl ?? opts.ttl}',
      );
    }

    // Get the result from the completer, if it's an error, throw it
    try {
      if (resp.error != null) {
        throw resp.error!;
      }

      // print('checking if completed');
      if (resp.completer.isCompleted) {
        return resp.response;
      }

      return await resp.completer.future;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Sign 2.5
  /// Substitutes wc_sessionPropose sendRequest()
  /// during signEngine.connect()
  ///
  @override
  Future<dynamic> sendProposeSessionRequest(
    String topic,
    Map<String, dynamic> params, {
    int? id,
    EncodeOptions? encodeOptions,
  }) async {
    final proposeSessionPayload = JsonRpcUtils.formatJsonRpcRequest(
      MethodConstants.WC_SESSION_PROPOSE,
      params,
      id: id,
    );
    final requestId = proposeSessionPayload['id'] as int;

    final proposeSessionMessage = await core.crypto.encode(
      topic,
      proposeSessionPayload,
      options: encodeOptions,
    );

    if (proposeSessionMessage == null) {
      return;
    }

    // print('adding payload to pending requests: $requestId');
    final resp = PendingRequestResponse(
      completer: Completer(),
      method: MethodConstants.WC_SESSION_PROPOSE,
    );
    resp.completer.future.catchError((err) {
      // Catch the error so that it won't throw an uncaught error
    });
    pendingRequests[requestId] = resp;

    final payload = {
      'pairingTopic': topic,
      'sessionProposal': proposeSessionMessage,
    };

    final options = PublishOptions(
      correlationId: requestId,
      ttl: null, // ttl is not required in this case, it's assigned relay-side
      tag: null, // tag is not required in this case, it's assigned relay-side
      publishMethod: RelayClient.WC_PROPOSE_SESSION,
    );

    await core.relayClient.publishPayload(
      payload: payload,
      options: options,
    );
    core.logger.d(
      '[$runtimeType] sendProposeSessionRequest relayClient, '
      'payload: ${jsonEncode(payload)}, options: ${jsonEncode(options.toJson())}',
    );

    // Get the result from the completer, if it's an error, throw it
    try {
      if (resp.error != null) {
        throw resp.error!;
      }

      // print('checking if completed');
      if (resp.completer.isCompleted) {
        return resp.response;
      }

      return await resp.completer.future;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> sendResult(
    int id,
    String topic,
    String method,
    dynamic result, {
    EncodeOptions? encodeOptions,
    String? appLink,
    TVFData? tvf,
  }) async {
    final payload = JsonRpcUtils.formatJsonRpcResponse<dynamic>(
      id,
      result,
    );
    final resultId = payload['id'] as int;

    final isLinkMode = (appLink ?? '').isNotEmpty;

    final String? message = await core.crypto.encode(
      topic,
      payload,
      options: isLinkMode
          ? EncodeOptions(type: EncodeOptions.TYPE_2)
          : encodeOptions,
    );

    if (message == null) {
      return;
    }

    if (isLinkMode) {
      final redirectURL = ReownCoreUtils.getLinkModeURL(
        appLink!,
        topic,
        message,
      );
      await ReownCoreUtils.openURL(redirectURL);
      // Send Event through Events SDK
      core.events.recordEvent(LinkModeResponseEvent(
        direction: 'sent',
        correlationId: resultId,
        method: method,
      ));
      core.logger.d(
        '[$runtimeType] sendResult linkMode ($appLink), '
        'id: $id topic: $topic, method: $method, result: $result',
      );
    } else {
      final opts = MethodConstants.RPC_OPTS[method]!['res']!;
      //
      await core.relayClient.publish(
        topic: topic,
        message: message,
        options: PublishOptions(
          ttl: opts.ttl,
          tag: opts.tag,
          correlationId: resultId,
          // tvf data is sent only on tvfMethods methods
          tvf: _shouldSendTVF(opts.tag) ? tvf?.toJson(includeAll: true) : null,
        ),
      );
      core.logger.d(
        '[$runtimeType] sendResult relayClient, '
        'id: $id topic: $topic, method: $method, result: $result',
      );
    }
  }

  ///
  /// Sign 2.5
  /// Substitutes wc_sessionPropose sendResult() and WC_SESSION_SETTLE sendRequest()
  /// during signEngine.approveSession()
  ///
  @override
  Future<dynamic> sendApproveSessionRequest(
    String sessionTopic,
    String pairingTopic, {
    required int responseId,
    required Map<String, dynamic> sessionProposalResponse,
    required Map<String, dynamic> sessionSettlementRequest,
    EncodeOptions? encodeOptions,
  }) async {
    final pairingPayload = JsonRpcUtils.formatJsonRpcResponse<dynamic>(
      responseId,
      sessionProposalResponse,
    );

    final String? pairingResponseMessage = await core.crypto.encode(
      pairingTopic,
      pairingPayload,
      options: encodeOptions,
    );

    if (pairingResponseMessage == null) {
      return;
    }

    //
    final sessionSettlePayload = JsonRpcUtils.formatJsonRpcRequest(
      MethodConstants.WC_SESSION_SETTLE,
      sessionSettlementRequest,
    );

    final String? sessionSettlementRequestMessage = await core.crypto.encode(
      sessionTopic,
      sessionSettlePayload,
      options: encodeOptions,
    );

    if (sessionSettlementRequestMessage == null) {
      return;
    }

    final payload = {
      'sessionTopic': sessionTopic,
      'pairingTopic': pairingTopic,
      'sessionProposalResponse': pairingResponseMessage,
      'sessionSettlementRequest': sessionSettlementRequestMessage,
    };

    final options = PublishOptions(
      correlationId: responseId,
      ttl: null, // ttl is not required in this case, it's assigned relay-side
      tag: null, // tag is not required in this case, it's assigned relay-side
      publishMethod: RelayClient.WC_APPROVE_SESSION,
    );

    await core.relayClient.publishPayload(
      payload: payload,
      options: options,
    );
    core.logger.d(
      '[$runtimeType] sendApproveSessionRequest relayClient, '
      'payload: ${jsonEncode(payload)}, options: ${jsonEncode(options.toJson())}',
    );
  }

  @override
  Future<dynamic> sendError(
    int id,
    String topic,
    String method,
    JsonRpcError error, {
    EncodeOptions? encodeOptions,
    RpcOptions? rpcOptions,
    String? appLink,
    TVFData? tvf,
  }) async {
    final Map<String, dynamic> payload = JsonRpcUtils.formatJsonRpcError(
      id,
      error,
    );
    final resultId = payload['id'] as int;

    final isLinkMode = (appLink ?? '').isNotEmpty;

    final String? message = await core.crypto.encode(
      topic,
      payload,
      options: isLinkMode
          ? EncodeOptions(type: EncodeOptions.TYPE_2)
          : encodeOptions,
    );

    if (message == null) {
      return;
    }

    if (isLinkMode) {
      final redirectURL = ReownCoreUtils.getLinkModeURL(
        appLink!,
        topic,
        message,
      );
      await ReownCoreUtils.openURL(redirectURL);
      // Send Event through Events SDK
      core.events.recordEvent(LinkModeResponseEvent(
        direction: 'sent',
        correlationId: resultId,
        method: method,
        isRejected: _isSessionAuthRejectedError(method, error),
      ));
      core.logger.d(
        '[$runtimeType] sendError linkMode ($appLink), '
        'id: $id topic: $topic, method: $method, error: $error',
      );
    } else {
      final fallbackMethod = MethodConstants.UNREGISTERED_METHOD;
      final methodOpts = MethodConstants.RPC_OPTS[method];
      final fallbackMethodOpts = MethodConstants.RPC_OPTS[fallbackMethod]!;
      final relayOpts = methodOpts ?? fallbackMethodOpts;
      final fallbackOpts = relayOpts['reject'] ?? relayOpts['res']!;
      final ttl = (rpcOptions ?? fallbackOpts).ttl;
      final tag = (rpcOptions ?? fallbackOpts).tag;
      //
      await core.relayClient.publish(
        topic: topic,
        message: message,
        options: PublishOptions(
          ttl: ttl,
          tag: tag,
          correlationId: resultId,
          // tvf data is sent only on tvfMethods methods
          tvf: _shouldSendTVF(tag) ? tvf?.toJson(includeAll: true) : null,
        ),
      );
      core.logger.d(
        '[$runtimeType] sendError relayClient, '
        'id: $id topic: $topic, method: $method, error: $error',
      );
    }
  }

  /// ---- Private Helpers ---- ///

  Future<void> _resubscribeAll() async {
    // If the relay is not active, stop here
    if (!core.relayClient.isConnected) {
      return;
    }

    // Resubscribe to all active pairings
    for (final PairingInfo pairing in pairings.getAll()) {
      core.logger.i('[$runtimeType] Resubscribe to pairing: ${pairing.topic}');
      await core.relayClient.subscribe(
        options: SubscribeOptions(
          topic: pairing.topic,
          transportType: TransportType.relay,
        ),
      );
    }
  }

  Future<void> _deletePairing(String topic, bool expirerHasDeleted) async {
    core.logger.d('[$runtimeType] _deletePairing $topic, $expirerHasDeleted');
    await core.relayClient.unsubscribe(topic: topic);
    await pairings.delete(topic);
    await core.crypto.deleteSymKey(topic);
    if (expirerHasDeleted) {
      await core.expirer.delete(topic);
    }
  }

  Future<void> _cleanup() async {
    core.logger.d('[$runtimeType] _cleanup');
    final List<PairingInfo> expiredPairings = getPairings()
        .where(
          (PairingInfo info) => ReownCoreUtils.isExpired(info.expiry),
        )
        .toList();
    for (final PairingInfo pairing in expiredPairings) {
      // print('deleting expired pairing: ${pairing.topic}');
      await _deletePairing(pairing.topic, true);
    }

    // Cleanup all history records
    final List<JsonRpcRecord> expiredHistory = history
        .getAll()
        .where(
          (record) => ReownCoreUtils.isExpired(record.expiry ?? -1),
        )
        .toList();
    // Loop through the expired records and delete them
    for (final JsonRpcRecord record in expiredHistory) {
      // print('deleting expired history record: ${record.id}');
      await history.delete(record.id.toString());
    }

    // Cleanup all of the expired receiver public keys
    final List<ReceiverPublicKey> expiredReceiverPublicKeys =
        topicToReceiverPublicKey
            .getAll()
            .where((receiver) => ReownCoreUtils.isExpired(receiver.expiry))
            .toList();
    // Loop through the expired receiver public keys and delete them
    for (final ReceiverPublicKey receiver in expiredReceiverPublicKeys) {
      // print('deleting expired receiver public key: $receiver');
      await topicToReceiverPublicKey.delete(receiver.topic);
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  /// ---- Relay Event Router ---- ///

  Map<String, RegisteredFunction> routerMapRequest = {};

  void _registerRelayEvents() {
    core.relayClient.onRelayClientConnect.subscribe(_onRelayConnectEvent);
    core.relayClient.onRelayClientMessage.subscribe(_onRelayMessageEvent);
    core.relayClient.onLinkModeMessage.subscribe(_onLinkModeMessageEvent);

    register(
      method: MethodConstants.WC_PAIRING_PING,
      function: _onPairingPingRequest,
      type: ProtocolType.pair,
    );
    register(
      method: MethodConstants.WC_PAIRING_DELETE,
      function: _onPairingDeleteRequest,
      type: ProtocolType.pair,
    );
  }

  Future<void> _onRelayConnectEvent(EventArgs? args) async {
    // print('Pairing: Relay connected');
    await _resubscribeAll();
  }

  void _onLinkModeMessageEvent(MessageEvent? event) async {
    if (event == null) {
      return;
    }

    _processEvent(event, isLinkMode: true);
  }

  void _onRelayMessageEvent(MessageEvent? event) async {
    if (event == null) {
      return;
    }

    _processEvent(event, isLinkMode: false);
  }

  void _processEvent(MessageEvent event, {bool isLinkMode = false}) async {
    // If we have a reciever public key for the topic, use it
    ReceiverPublicKey? receiverPublicKey = topicToReceiverPublicKey.get(
      event.topic,
    );
    isLinkMode
        ? core.logger.d(
            '[$runtimeType] '
            '_onLinkModeMessageEvent, receiverPublicKey: $receiverPublicKey',
          )
        : core.logger.d(
            '[$runtimeType] '
            '_onRelayMessageEvent, receiverPublicKey: $receiverPublicKey',
          );
    // If there was a public key, delete it. One use.
    if (receiverPublicKey != null) {
      await topicToReceiverPublicKey.delete(event.topic);
    }

    // Decode the message
    String? payloadString = await core.crypto.decode(
      event.topic,
      event.message,
      options: DecodeOptions(
        receiverPublicKey: receiverPublicKey?.publicKey,
      ),
    );

    isLinkMode
        ? core.logger.d(
            '[$runtimeType] '
            '_onLinkModeMessageEvent, payloadString: $payloadString',
          )
        : core.logger.d(
            '[$runtimeType] '
            '_onRelayMessageEvent, payloadString: $payloadString',
          );

    if (payloadString == null) {
      return;
    }

    Map<String, dynamic> data = jsonDecode(payloadString);

    // If it's an rpc request, handle it
    if (data.containsKey('method')) {
      final request = JsonRpcRequest.fromJson(data);

      if (routerMapRequest.containsKey(request.method)) {
        routerMapRequest[request.method]!.function(
          event.topic,
          request,
          event.transportType,
        );
      } else {
        _onUnkownRpcMethodRequest(event.topic, request);
      }

      if (isLinkMode) {
        // Send Event through Events SDK
        core.events.recordEvent(LinkModeRequestEvent(
          direction: 'received',
          correlationId: request.id,
          method: request.method,
        ));
      }
      // Otherwise handle it as a response
    } else {
      final response = JsonRpcResponse.fromJson(data);

      if (pendingRequests.containsKey(response.id)) {
        final pendingRequest = pendingRequests[response.id]!;
        if (response.error != null) {
          pendingRequest.error = response.error;
          pendingRequest.completer.completeError(response.error!);
        } else {
          pendingRequest.response = response.result;
          pendingRequest.completer.complete(response.result);
        }

        if (isLinkMode) {
          // Send Event through Events SDK
          core.events.recordEvent(LinkModeResponseEvent(
            direction: 'received',
            correlationId: response.id,
            method: pendingRequest.method,
            isRejected: _isSessionAuthRejectedError(
              pendingRequest.method,
              response.error,
            ),
          ));
        }
      }
    }
  }

  bool _isSessionAuthRejectedError(String method, JsonRpcError? error) {
    final errorCode = error?.code ?? 0;
    final sessionRejected = method == MethodConstants.WC_SESSION_AUTHENTICATE &&
        (errorCode == 12001 || (errorCode >= 5000 && errorCode <= 5003));
    return sessionRejected;
  }

  Future<void> _onPairingPingRequest(
    String topic,
    JsonRpcRequest request, [
    _,
  ]) async {
    final int id = request.id;
    try {
      // print('ping req');
      await _isValidPing(topic);
      await sendResult(
        id,
        topic,
        request.method,
        true,
      );
      onPairingPing.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } on JsonRpcError catch (e) {
      // print(e);
      await sendError(
        id,
        topic,
        request.method,
        e,
      );
    }
  }

  Future<void> _onPairingDeleteRequest(
    String topic,
    JsonRpcRequest request, [
    _,
  ]) async {
    core.logger.d(
      '[$runtimeType] _onPairingDeleteRequest $topic, ${request.toJson()}',
    );
    final int id = request.id;
    try {
      await _isValidDisconnect(topic);
      await sendResult(
        id,
        topic,
        request.method,
        true,
      );
      await pairings.delete(topic);
      onPairingDelete.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } on JsonRpcError catch (e) {
      await sendError(
        id,
        topic,
        request.method,
        e,
      );
    }
  }

  Future<void> _onUnkownRpcMethodRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    final int id = request.id;
    final String method = request.method;
    try {
      if (routerMapRequest.containsKey(method)) {
        return;
      }
      final String message = Errors.getSdkError(
        Errors.WC_METHOD_UNSUPPORTED,
        context: method,
      ).message;
      await sendError(
        id,
        topic,
        request.method,
        JsonRpcError.methodNotFound(message),
      );
    } on JsonRpcError catch (e) {
      await sendError(id, topic, request.method, e);
    }
  }

  /// ---- Expirer Events ---- ///

  void _registerExpirerEvents() {
    core.expirer.onExpire.subscribe(_onExpired);
  }

  void _registerheartbeatSubscription() {
    core.heartbeat.onPulse.subscribe(_heartbeatSubscription);
  }

  Future<void> _onExpired(ExpirationEvent? event) async {
    if (event == null) {
      return;
    }
    core.logger.d('[$runtimeType] _onExpired, ${event.toString()}');

    if (pairings.has(event.target)) {
      // Clean up the pairing
      await _deletePairing(event.target, true);
      onPairingExpire.broadcast(
        PairingEvent(
          topic: event.target,
        ),
      );
    }
  }

  void _heartbeatSubscription(EventArgs? args) async {
    await checkAndExpire();
  }

  /// ---- Validators ---- ///

  Future<void> _isValidPing(String topic) async {
    await isValidPairingTopic(topic: topic);
  }

  Future<void> _isValidDisconnect(String topic) async {
    await isValidPairingTopic(topic: topic);
  }

  @override
  void dispatchEnvelope({
    required String topic,
    required String envelope,
  }) async {
    core.logger.d(
      '[$runtimeType] dispatchEnvelope, topic: $topic, envelope: $envelope',
    );

    final message = Uri.decodeComponent(envelope);
    await core.relayClient.handleLinkModeMessage(topic, message);
  }

  bool _shouldSendTVF(int tag) {
    final sessionRequest = MethodConstants.WC_SESSION_REQUEST;
    final reqOpt = MethodConstants.RPC_OPTS[sessionRequest]!['req']!;
    final resOpt = MethodConstants.RPC_OPTS[sessionRequest]!['res']!;
    core.logger.d(
      '[$runtimeType] should send TVF, tag: $tag (${reqOpt.tag}, ${resOpt.tag})',
    );
    // check if tag is either 1108 or 1109, otherwise no tvf data is collected
    if (tag != reqOpt.tag && tag != resOpt.tag) return false;

    return true;
  }
}
