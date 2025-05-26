import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:event/event.dart';
import 'package:reown_core/models/tvf_data.dart';
import 'package:reown_core/pairing/utils/json_rpc_utils.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/i_generic_store.dart';

import 'package:reown_sign/reown_sign.dart';
import 'package:reown_sign/utils/sign_api_validator_utils.dart';

import 'package:reown_sign/utils/recaps_utils.dart';
import 'package:reown_sign/utils/constants.dart';

class ReownSign implements IReownSign {
  static const List<List<String>> DEFAULT_METHODS = [
    [
      MethodConstants.WC_SESSION_PROPOSE,
      MethodConstants.WC_SESSION_REQUEST,
    ],
  ];

  bool _initialized = false;

  @override
  final Event<SessionConnect> onSessionConnect = Event<SessionConnect>();
  @override
  final Event<SessionProposalEvent> onSessionProposal =
      Event<SessionProposalEvent>();
  @override
  final Event<SessionProposalErrorEvent> onSessionProposalError =
      Event<SessionProposalErrorEvent>();
  @override
  final Event<SessionProposalEvent> onProposalExpire =
      Event<SessionProposalEvent>();
  @override
  final Event<SessionUpdate> onSessionUpdate = Event<SessionUpdate>();
  @override
  final Event<SessionExtend> onSessionExtend = Event<SessionExtend>();
  @override
  final Event<SessionExpire> onSessionExpire = Event<SessionExpire>();
  @override
  final Event<SessionRequestEvent> onSessionRequest =
      Event<SessionRequestEvent>();
  @override
  final Event<SessionEvent> onSessionEvent = Event<SessionEvent>();
  @override
  final Event<SessionPing> onSessionPing = Event<SessionPing>();
  @override
  final Event<SessionDelete> onSessionDelete = Event<SessionDelete>();

  @override
  final IReownCore core;
  @override
  final PairingMetadata metadata;
  @override
  final IGenericStore<ProposalData> proposals;
  @override
  final ISessions sessions;
  @override
  final IGenericStore<SessionRequest> pendingRequests;

  List<SessionProposalCompleter> pendingProposals = [];

  Map<int, TVFData> pendingTVFRequests = {};

  @override
  late IGenericStore<AuthPublicKey> authKeys;

  @override
  late IGenericStore<String> pairingTopics;

  // NEW 1-CA METHOD
  @override
  late IGenericStore<PendingSessionAuthRequest> sessionAuthRequests;
  @override
  final Event<SessionAuthRequest> onSessionAuthRequest =
      Event<SessionAuthRequest>();
  @override
  final Event<SessionAuthResponse> onSessionAuthResponse =
      Event<SessionAuthResponse>();

  List<SessionAuthenticateCompleter> pendingSessionAuthRequests = [];

  ReownSign({
    required this.core,
    required this.metadata,
    required this.proposals,
    required this.sessions,
    required this.pendingRequests,
    required this.sessionAuthRequests,
    required this.authKeys,
    required this.pairingTopics,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.pairing.init();
    await core.verify.init(verifyUrl: metadata.verifyUrl);
    await proposals.init();
    await sessions.init();
    await pendingRequests.init();
    await sessionAuthRequests.init();
    await authKeys.init();
    await pairingTopics.init();

    _registerInternalEvents();
    _registerRelayClientFunctions();
    await _cleanup();

    await _resubscribeAll();

    _initialized = true;
  }

  @override
  Future<void> checkAndExpire() async {
    for (var session in sessions.getAll()) {
      await core.expirer.checkAndExpire(session.topic);
    }
  }

  @override
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods = DEFAULT_METHODS,
  }) async {
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    await _isValidConnect(
      requiredNamespaces: requiredNamespaces ?? {},
      optionalNamespaces: optionalNamespaces ?? {},
      sessionProperties: sessionProperties,
      pairingTopic: pairingTopic,
      relays: relays,
    );
    String? pTopic = pairingTopic;
    Uri? uri;

    if (pTopic == null) {
      final CreateResponse newTopicAndUri = await core.pairing.create(
        methods: methods,
        transportType: TransportType.relay,
      );
      pTopic = newTopicAndUri.topic;
      uri = newTopicAndUri.uri;
      // print('connect generated topic: $topic');
    } else {
      core.pairing.isValidPairingTopic(topic: pTopic);
    }

    final publicKey = await core.crypto.generateKeyPair();
    final int id = JsonRpcUtils.payloadId();

    final request = WcSessionProposeRequest(
      relays: relays ?? [Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL)],
      requiredNamespaces: requiredNamespaces ?? {},
      optionalNamespaces: optionalNamespaces ?? {},
      proposer: ConnectionMetadata(
        publicKey: publicKey,
        metadata: metadata,
      ),
      sessionProperties: sessionProperties,
    );

    final expiry = ReownCoreUtils.calculateExpiry(
      ReownConstants.FIVE_MINUTES,
    );
    final ProposalData proposal = ProposalData(
      id: id,
      expiry: expiry,
      relays: request.relays,
      proposer: request.proposer,
      requiredNamespaces: request.requiredNamespaces,
      optionalNamespaces: request.optionalNamespaces ?? {},
      sessionProperties: request.sessionProperties,
      pairingTopic: pTopic,
    );
    await _setProposal(
      id,
      proposal,
    );

    Completer<SessionData> completer = Completer();

    pendingProposals.add(
      SessionProposalCompleter(
        id: id,
        selfPublicKey: publicKey,
        pairingTopic: pTopic,
        requiredNamespaces: request.requiredNamespaces,
        optionalNamespaces: request.optionalNamespaces ?? {},
        sessionProperties: request.sessionProperties,
        completer: completer,
      ),
    );
    _connectResponseHandler(
      pTopic,
      request,
      id,
    );

    final ConnectResponse resp = ConnectResponse(
      pairingTopic: pTopic,
      session: completer,
      uri: uri,
    );

    return resp;
  }

  Future<void> _connectResponseHandler(
    String topic,
    WcSessionProposeRequest request,
    int requestId,
  ) async {
    // print("sending proposal for $topic");
    // print('connectResponseHandler requestId: $requestId');
    try {
      final Map<String, dynamic> response = await core.pairing.sendRequest(
        topic,
        MethodConstants.WC_SESSION_PROPOSE,
        request.toJson(),
        id: requestId,
      );
      final String peerPublicKey = response['responderPublicKey'];

      final ProposalData proposal = proposals.get(
        requestId.toString(),
      )!;
      final String sessionTopic = await core.crypto.generateSharedKey(
        proposal.proposer.publicKey,
        peerPublicKey,
      );
      // print('connectResponseHandler session topic: $sessionTopic');

      // Delete the proposal, we are done with it
      await _deleteProposal(requestId);

      await core.relayClient.subscribe(
        topic: sessionTopic,
        transportType: TransportType.relay,
      );
      await core.pairing.activate(topic: topic);
    } catch (e) {
      // Get the completer and finish it with an error
      pendingProposals.removeLast().completer.completeError(e);
    }
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    try {
      return await core.pairing.pair(
        uri: uri,
      );
    } on ReownCoreError catch (e) {
      throw e.toSignError();
    }
  }

  /// Approves a proposal with the id provided in the parameters.
  /// Assumes the proposal is already created.
  @override
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    // print('sign approveSession');
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    await _isValidApprove(
      id: id,
      namespaces: namespaces,
      sessionProperties: sessionProperties,
      relayProtocol: relayProtocol,
    );

    final ProposalData proposal = proposals.get(
      id.toString(),
    )!;

    final String selfPubKey = await core.crypto.generateKeyPair();
    final String peerPubKey = proposal.proposer.publicKey;
    final String sessionTopic = await core.crypto.generateSharedKey(
      selfPubKey,
      peerPubKey,
    );
    // print('approve session topic: $sessionTopic');
    final protocol = relayProtocol ?? ReownConstants.RELAYER_DEFAULT_PROTOCOL;
    final relay = Relay(protocol);

    // Respond to the proposal
    await core.pairing.sendResult(
      id,
      proposal.pairingTopic,
      MethodConstants.WC_SESSION_PROPOSE,
      WcSessionProposeResponse(
        relay: relay,
        responderPublicKey: selfPubKey,
      ),
    );
    await _deleteProposal(id);
    await core.pairing.activate(topic: proposal.pairingTopic);

    await core.pairing.updateMetadata(
      topic: proposal.pairingTopic,
      metadata: proposal.proposer.metadata,
    );

    await core.relayClient.subscribe(
      topic: sessionTopic,
      transportType: TransportType.relay,
    );

    final int expiry = ReownCoreUtils.calculateExpiry(
      ReownConstants.SEVEN_DAYS,
    );

    SessionData session = SessionData(
      topic: sessionTopic,
      pairingTopic: proposal.pairingTopic,
      relay: relay,
      expiry: expiry,
      acknowledged: false,
      controller: selfPubKey,
      namespaces: namespaces,
      self: ConnectionMetadata(
        publicKey: selfPubKey,
        metadata: metadata,
      ),
      peer: proposal.proposer,
      sessionProperties: proposal.sessionProperties,
      transportType: TransportType.relay,
    );

    onSessionConnect.broadcast(SessionConnect(session));

    await sessions.set(sessionTopic, session);
    await _setSessionExpiry(sessionTopic, expiry);

    // `wc_sessionSettle` is not critical throughout the entire session.
    final settleRequest = WcSessionSettleRequest(
      relay: relay,
      namespaces: namespaces,
      sessionProperties: sessionProperties,
      expiry: expiry,
      controller: ConnectionMetadata(
        publicKey: selfPubKey,
        metadata: metadata,
      ),
    );
    bool acknowledged = await core.pairing
        .sendRequest(
          sessionTopic,
          MethodConstants.WC_SESSION_SETTLE,
          settleRequest.toJson(),
        )
        // Sometimes we don't receive any response for a long time,
        // in which case we manually time out to prevent waiting indefinitely.
        .timeout(const Duration(seconds: 15))
        .catchError(
      (_) {
        return false;
      },
    );

    session = session.copyWith(
      acknowledged: acknowledged,
    );

    if (acknowledged && sessions.has(sessionTopic)) {
      // We directly update the latest value.
      await sessions.set(
        sessionTopic,
        session,
      );
    }

    return ApproveResponse(
      topic: sessionTopic,
      session: session,
    );
  }

  @override
  Future<void> rejectSession({
    required int id,
    required ReownSignError reason,
  }) async {
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    await _isValidReject(id, reason);

    ProposalData? proposal = proposals.get(id.toString());
    if (proposal != null) {
      // Attempt to send a response, if the pairing is not active, this will fail
      // but we don't care
      try {
        final method = MethodConstants.WC_SESSION_PROPOSE;
        final rpcOpts = MethodConstants.RPC_OPTS[method];
        await core.pairing.sendError(
          id,
          proposal.pairingTopic,
          method,
          JsonRpcError(code: reason.code, message: reason.message),
          rpcOptions: rpcOpts?['reject'],
        );
      } catch (_) {
        // print('got here');
      }
    }
    await _deleteProposal(id);
  }

  @override
  Future<void> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    await _isValidUpdate(
      topic,
      namespaces,
    );

    await sessions.update(
      topic,
      namespaces: namespaces,
    );

    final updateRequest = WcSessionUpdateRequest(
      namespaces: namespaces,
    );

    await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_UPDATE,
      updateRequest.toJson(),
    );
  }

  @override
  Future<void> extendSession({
    required String topic,
  }) async {
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    await _isValidSessionTopic(topic);

    await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_EXTEND,
      {},
    );

    await _setSessionExpiry(
      topic,
      ReownCoreUtils.calculateExpiry(
        ReownConstants.SEVEN_DAYS,
      ),
    );
  }

  /// Maps a request using chainId:method to its handler
  final Map<String, dynamic Function(String, dynamic)?> _methodHandlers = {};

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  }) {
    _methodHandlers[_getRegisterKey(chainId, method)] = handler;
  }

  @override
  Future<dynamic> request({
    int? requestId,
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    _checkInitialized();
    await _isValidRequest(
      topic,
      chainId,
      request,
    );

    final session = sessions.get(topic);
    final isLinkMode = _isLinkModeRequest(session);
    if (!isLinkMode) {
      _confirmOnlineStateOrThrow();
    }

    final sessionRequest = WcSessionRequestRequest(
      chainId: chainId,
      request: request,
    );

    final id = requestId ?? JsonRpcUtils.payloadId();
    final tvf = _collectRequestTVF(id, sessionRequest);
    core.logger.d('[$runtimeType] _collect Request TVF, id: $id, $tvf');

    return await core.pairing.sendRequest(
      id: id,
      topic,
      MethodConstants.WC_SESSION_REQUEST,
      sessionRequest.toJson(),
      appLink: _getAppLinkIfEnabled(session?.peer.metadata),
      tvf: tvf,
    );
  }

  bool _isLinkModeRequest(SessionData? session) {
    final appLink = (session?.peer.metadata.redirect?.universal ?? '');
    final supportedApps = core.getLinkModeSupportedApps();
    return appLink.isNotEmpty && supportedApps.contains(appLink);
  }

  @override
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  }) async {
    _checkInitialized();
    await _isValidResponse(topic, response);

    final tvf = _collectResponseTVF(response);
    core.logger.d(
      '[$runtimeType] _collect Response TVF, id: ${response.id}, $tvf',
    );

    final session = sessions.get(topic);
    final isLinkModeSession = session?.transportType.isLinkMode ?? false;
    if (!isLinkModeSession) {
      _confirmOnlineStateOrThrow();
    }

    final appLink = _getAppLinkIfEnabled(session?.peer.metadata);

    if (response.result != null) {
      await core.pairing.sendResult(
        response.id,
        topic,
        MethodConstants.WC_SESSION_REQUEST,
        response.result,
        appLink: appLink,
        tvf: tvf,
      );
    } else {
      await core.pairing.sendError(
        response.id,
        topic,
        MethodConstants.WC_SESSION_REQUEST,
        response.error!,
        appLink: appLink,
        tvf: tvf,
      );
    }

    await _deletePendingRequest(response.id);
  }

  /// Maps a request using chainId:event to its handler
  final Map<String, dynamic Function(String, dynamic)?> _eventHandlers = {};

  @override
  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  }) {
    _checkInitialized();
    _eventHandlers[_getRegisterKey(chainId, event)] = handler;
  }

  @override
  Future<void> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    await _isValidEmit(
      topic,
      event,
      chainId,
    );

    final eventRequest = WcSessionEventRequest(
      chainId: chainId,
      event: event,
    );

    await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_EVENT,
      eventRequest.toJson(),
    );
  }

  @override
  Future<void> ping({
    required String topic,
  }) async {
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    await _isValidPing(topic);

    if (sessions.has(topic)) {
      bool _ = await core.pairing.sendRequest(
        topic,
        MethodConstants.WC_SESSION_PING,
        {},
      );
    } else if (core.pairing.getStore().has(topic)) {
      await core.pairing.ping(topic: topic);
    }
  }

  @override
  Future<void> disconnectSession({
    required String topic,
    required ReownSignError reason,
  }) async {
    _checkInitialized();
    _confirmOnlineStateOrThrow();

    try {
      await _isValidDisconnect(topic);

      if (sessions.has(topic)) {
        // Send the request to delete the session, we don't care if it fails
        try {
          final deleteRequest = WcSessionDeleteRequest(
            code: reason.code,
            message: reason.message,
            data: reason.data,
          );
          core.pairing.sendRequest(
            topic,
            MethodConstants.WC_SESSION_DELETE,
            deleteRequest.toJson(),
          );
        } catch (_) {}

        await _deleteSession(topic);
      } else {
        await core.pairing.disconnect(topic: topic);
      }
    } on ReownSignError catch (error, s) {
      core.logger.e(
        '[$runtimeType] disconnectSession()',
        error: error,
        stackTrace: s,
      );
    }
  }

  @override
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    _checkInitialized();
    final compatible = sessions.getAll().where((element) {
      return SignApiValidatorUtils.isSessionCompatible(
        session: element,
        requiredNamespaces: requiredNamespaces,
      );
    });

    return compatible.isNotEmpty ? compatible.first : null;
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    _checkInitialized();

    Map<String, SessionData> activeSessions = {};
    sessions.getAll().forEach((session) {
      activeSessions[session.topic] = session;
    });

    return activeSessions;
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    _checkInitialized();

    Map<String, SessionData> pairingSessions = {};
    sessions
        .getAll()
        .where((session) => session.pairingTopic == pairingTopic)
        .forEach((session) {
      pairingSessions[session.topic] = session;
    });

    return pairingSessions;
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    _checkInitialized();

    Map<String, ProposalData> pendingProposals = {};
    proposals.getAll().forEach((proposal) {
      pendingProposals[proposal.id.toString()] = proposal;
    });

    return pendingProposals;
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    _checkInitialized();

    Map<String, SessionRequest> requests = {};
    pendingRequests.getAll().forEach((r) {
      requests[r.id.toString()] = r;
    });

    return requests;
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  final Set<String> _eventEmitters = {};
  final Set<String> _accounts = {};

  @override
  void registerEventEmitter({
    required String chainId,
    required String event,
  }) {
    final bool isChainId = NamespaceUtils.isValidChainId(chainId);
    if (!isChainId) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context:
            'registerEventEmitter, chain $chainId should conform to "CAIP-2" format',
      ).toSignError();
    }
    final String value = _getRegisterKey(chainId, event);
    SignApiValidatorUtils.isValidAccounts(
      accounts: [value],
      context: 'registerEventEmitter',
    );
    _eventEmitters.add(value);
  }

  @override
  void registerAccount({
    required String chainId,
    required String accountAddress,
  }) {
    final bool isChainId = NamespaceUtils.isValidChainId(chainId);
    if (!isChainId) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context:
            'registerAccount, chain $chainId should conform to "CAIP-2" format',
      ).toSignError();
    }
    final String value = _getRegisterKey(chainId, accountAddress);
    SignApiValidatorUtils.isValidAccounts(
      accounts: [value],
      context: 'registerAccount',
    );
    _accounts.add(value);
  }

  /// ---- PRIVATE HELPERS ---- ////

  Future<void> _resubscribeAll() async {
    // If the relay is not connected, stop here
    if (!core.relayClient.isConnected) {
      return;
    }

    // Subscribe to all the sessions
    for (final SessionData session in sessions.getAll()) {
      core.logger.i('[$runtimeType] Resubscribe to session: ${session.topic}');
      await core.relayClient.subscribe(
        topic: session.topic,
        transportType: session.transportType,
      );
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED).toSignError();
    }
  }

  void _confirmOnlineStateOrThrow() {
    core.confirmOnlineStateOrThrow();
  }

  String _getRegisterKey(String chainId, String value) {
    return '$chainId:$value';
  }

  Future<void> _deleteSession(
    String topic, {
    bool expirerHasDeleted = false,
  }) async {
    // print('deleting session: $topic, expirerHasDeleted: $expirerHasDeleted');
    final SessionData? session = sessions.get(topic);
    if (session == null) {
      return;
    }
    await core.relayClient.unsubscribe(topic: topic);

    await sessions.delete(topic);
    await core.crypto.deleteKeyPair(session.self.publicKey);
    await core.crypto.deleteSymKey(topic);
    if (expirerHasDeleted) {
      await core.expirer.delete(topic);
    }

    onSessionDelete.broadcast(
      SessionDelete(
        topic,
      ),
    );
  }

  Future<void> _deleteProposal(
    int id, {
    bool expirerHasDeleted = false,
  }) async {
    await proposals.delete(id.toString());
    if (expirerHasDeleted) {
      await core.expirer.delete(id.toString());
    }
  }

  Future<void> _deletePendingRequest(
    int id, {
    bool expirerHasDeleted = false,
  }) async {
    await pendingRequests.delete(id.toString());
    if (expirerHasDeleted) {
      await core.expirer.delete(id.toString());
    }
  }

  Future<void> _setSessionExpiry(String topic, int expiry) async {
    if (sessions.has(topic)) {
      await sessions.update(
        topic,
        expiry: expiry,
      );
    }
    await core.expirer.set(topic, expiry);
  }

  Future<void> _setProposal(int id, ProposalData proposal) async {
    await proposals.set(id.toString(), proposal);
    core.expirer.set(id.toString(), proposal.expiry);
  }

  Future<void> _setPendingRequest(int id, SessionRequest request) async {
    await pendingRequests.set(
      id.toString(),
      request,
    );
    core.expirer.set(
      id.toString(),
      ReownCoreUtils.calculateExpiry(
        ReownConstants.FIVE_MINUTES,
      ),
    );
  }

  Future<void> _cleanup() async {
    final List<String> sessionTopics = [];
    final List<int> proposalIds = [];

    for (final SessionData session in sessions.getAll()) {
      if (ReownCoreUtils.isExpired(session.expiry)) {
        sessionTopics.add(session.topic);
      }
    }
    for (final ProposalData proposal in proposals.getAll()) {
      if (ReownCoreUtils.isExpired(proposal.expiry)) {
        proposalIds.add(proposal.id);
      }
    }

    sessionTopics.map((topic) async {
      // print('deleting expired session $topic');
      await _deleteSession(topic);
    });
    proposalIds.map((id) async => await _deleteProposal(id));
  }

  /// ---- Relay Events ---- ///

  void _registerRelayClientFunctions() {
    core.pairing.register(
      method: MethodConstants.WC_SESSION_PROPOSE,
      function: _onSessionProposeRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_SETTLE,
      function: _onSessionSettleRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_UPDATE,
      function: _onSessionUpdateRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_EXTEND,
      function: _onSessionExtendRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_PING,
      function: _onSessionPingRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_DELETE,
      function: _onSessionDeleteRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_REQUEST,
      function: _onSessionRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_EVENT,
      function: _onSessionEventRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_AUTHENTICATE,
      function: _onSessionAuthenticateRequest,
      type: ProtocolType.sign,
    );
    // Deprecated method but still supported for retrocompatibility
    // core.pairing.register(
    //   method: MethodConstants.WC_AUTH_REQUEST,
    //   function: _onAuthRequest,
    //   type: ProtocolType.sign,
    // );
  }

  bool _shouldIgnoreSessionPropose(String topic) {
    final PairingInfo? pairingInfo = core.pairing.getPairing(topic: topic);
    final implementSessionAuth = onSessionAuthRequest.subscriberCount > 0;
    final method = MethodConstants.WC_SESSION_AUTHENTICATE;
    final containsMethod = (pairingInfo?.methods ?? []).contains(method);

    return implementSessionAuth && containsMethod;
  }

  Future<void> _onSessionProposeRequest(
    String topic,
    JsonRpcRequest payload, [
    _,
  ]) async {
    if (_shouldIgnoreSessionPropose(topic)) {
      core.logger.i(
        'Session Propose ignored. Session Authenticate will be used instead',
      );
      return;
    }
    try {
      core.logger.d(
        '_onSessionProposeRequest, topic: $topic, payload: $payload',
      );
      final proposeRequest = WcSessionProposeRequest.fromJson(payload.params);
      await _isValidConnect(
        requiredNamespaces: proposeRequest.requiredNamespaces,
        optionalNamespaces: proposeRequest.optionalNamespaces,
        sessionProperties: proposeRequest.sessionProperties,
        pairingTopic: topic,
        relays: proposeRequest.relays,
      );

      // If there are accounts and event emitters, then handle the Namespace generate automatically
      Map<String, Namespace>? namespaces;
      if (_accounts.isNotEmpty || _eventEmitters.isNotEmpty) {
        namespaces = NamespaceUtils.constructNamespaces(
          availableAccounts: _accounts,
          availableMethods: _methodHandlers.keys.toSet(),
          availableEvents: _eventEmitters,
          requiredNamespaces: proposeRequest.requiredNamespaces,
          optionalNamespaces: proposeRequest.optionalNamespaces,
        );

        // Check that the namespaces are conforming
        try {
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: proposeRequest.requiredNamespaces,
            namespaces: namespaces,
            context: 'onSessionProposeRequest',
          );
        } on ReownSignError catch (err) {
          // If they aren't, send an error
          core.logger.e(
            '_onSessionProposeRequest ReownSignError: $err',
          );
          final rpcOpts = MethodConstants.RPC_OPTS[payload.method];
          await core.pairing.sendError(
            payload.id,
            topic,
            payload.method,
            JsonRpcError(code: err.code, message: err.message),
            rpcOptions: rpcOpts?['autoReject'],
          );

          // Broadcast that a session proposal error has occurred
          onSessionProposalError.broadcast(
            SessionProposalErrorEvent(
              payload.id,
              proposeRequest.requiredNamespaces,
              namespaces,
              err,
            ),
          );
          return;
        }
      }

      final expiry = ReownCoreUtils.calculateExpiry(
        ReownConstants.FIVE_MINUTES,
      );
      final ProposalData proposal = ProposalData(
        id: payload.id,
        expiry: expiry,
        relays: proposeRequest.relays,
        proposer: proposeRequest.proposer,
        requiredNamespaces: proposeRequest.requiredNamespaces,
        optionalNamespaces: proposeRequest.optionalNamespaces ?? {},
        sessionProperties: proposeRequest.sessionProperties,
        pairingTopic: topic,
        generatedNamespaces: namespaces,
      );

      await _setProposal(payload.id, proposal);

      final verifyContext = await _getVerifyContext(
        payload,
        proposal.proposer.metadata,
        TransportType.relay,
      );

      onSessionProposal.broadcast(
        SessionProposalEvent(
          payload.id,
          proposal,
          verifyContext,
        ),
      );
    } on ReownSignError catch (err) {
      core.logger.e('_onSessionProposeRequest Error: $err');
      final rpcOpts = MethodConstants.RPC_OPTS[payload.method];
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError(code: err.code, message: err.message),
        rpcOptions: rpcOpts?['autoReject'],
      );
    }
  }

  Future<void> _onSessionSettleRequest(
    String topic,
    JsonRpcRequest payload, [
    _,
  ]) async {
    core.logger.d(
      '_onSessionSettleRequest, topic: $topic, payload: $payload',
    );
    final request = WcSessionSettleRequest.fromJson(payload.params);
    try {
      await _isValidSessionSettleRequest(request.namespaces, request.expiry);

      final SessionProposalCompleter sProposalCompleter =
          pendingProposals.removeLast();
      // print(sProposalCompleter);

      // Create the session
      final SessionData session = SessionData(
        topic: topic,
        pairingTopic: sProposalCompleter.pairingTopic,
        relay: request.relay,
        expiry: request.expiry,
        acknowledged: true,
        controller: request.controller.publicKey,
        namespaces: request.namespaces,
        sessionProperties: request.sessionProperties,
        self: ConnectionMetadata(
          publicKey: sProposalCompleter.selfPublicKey,
          metadata: metadata,
        ),
        peer: request.controller,
        transportType: TransportType.relay,
      );

      // Update all the things: session, expiry, metadata, pairing
      sessions.set(topic, session);
      _setSessionExpiry(topic, session.expiry);
      await core.pairing.updateMetadata(
        topic: sProposalCompleter.pairingTopic,
        metadata: session.peer.metadata,
      );
      final pairing = core.pairing.getPairing(topic: topic);
      if (pairing != null && !pairing.active) {
        await core.pairing.activate(topic: topic);
      }

      // Send the session back to the completer
      sProposalCompleter.completer.complete(session);

      // Send back a success!
      // print('responding to session settle: acknolwedged');
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_SETTLE,
        true,
      );
      onSessionConnect.broadcast(
        SessionConnect(session),
      );
    } on ReownSignError catch (err) {
      core.logger.e('_onSessionSettleRequest Error: $err');
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionUpdateRequest(
    String topic,
    JsonRpcRequest payload, [
    _,
  ]) async {
    try {
      // print(payload.params);
      final request = WcSessionUpdateRequest.fromJson(payload.params);
      await _isValidUpdate(topic, request.namespaces);
      await sessions.update(
        topic,
        namespaces: request.namespaces,
      );
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_UPDATE,
        true,
      );
      onSessionUpdate.broadcast(
        SessionUpdate(
          payload.id,
          topic,
          request.namespaces,
        ),
      );
    } on ReownSignError catch (err) {
      core.logger.e('_onSessionUpdateRequest Error: $err');
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionExtendRequest(
    String topic,
    JsonRpcRequest payload, [
    _,
  ]) async {
    try {
      final _ = WcSessionExtendRequest.fromJson(payload.params);
      await _isValidSessionTopic(topic);
      await _setSessionExpiry(
        topic,
        ReownCoreUtils.calculateExpiry(
          ReownConstants.SEVEN_DAYS,
        ),
      );
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_EXTEND,
        true,
      );
      onSessionExtend.broadcast(
        SessionExtend(
          payload.id,
          topic,
        ),
      );
    } on ReownSignError catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionPingRequest(
    String topic,
    JsonRpcRequest payload, [
    _,
  ]) async {
    try {
      final _ = WcSessionPingRequest.fromJson(payload.params);
      await _isValidPing(topic);
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_PING,
        true,
      );
      onSessionPing.broadcast(
        SessionPing(
          payload.id,
          topic,
        ),
      );
    } on ReownSignError catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionDeleteRequest(
    String topic,
    JsonRpcRequest payload, [
    _,
  ]) async {
    try {
      final _ = WcSessionDeleteRequest.fromJson(payload.params);
      await _isValidDisconnect(topic);
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_DELETE,
        true,
      );
      await _deleteSession(topic);
    } on ReownSignError catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  /// Called when a session request (method) is received by the wallet
  /// Will attempt to find a handler for the request, if it doesn't,
  /// it will throw an error.
  Future<void> _onSessionRequest(
    String topic,
    JsonRpcRequest payload, [
    TransportType transportType = TransportType.relay,
  ]) async {
    try {
      final request = WcSessionRequestRequest.fromJson(payload.params);
      await _isValidRequest(
        topic,
        request.chainId,
        request.request,
      );

      final tvf = _collectRequestTVF(payload.id, request);
      core.logger.d(
        '[$runtimeType] _collect Request TVF, id: ${payload.id}, $tvf',
      );

      final session = sessions.get(topic)!;
      final verifyContext = await _getVerifyContext(
        payload,
        session.peer.metadata,
        transportType,
      );

      final sessionRequest = SessionRequest(
        id: payload.id,
        topic: topic,
        method: request.request.method,
        chainId: request.chainId,
        params: request.request.params,
        verifyContext: verifyContext,
        transportType: transportType,
      );

      // print('payload id: ${payload.id}');
      await _setPendingRequest(
        payload.id,
        sessionRequest,
      );

      final appLink = (session.peer.metadata.redirect?.universal ?? '');
      if (session.transportType.isLinkMode && appLink.isNotEmpty) {
        // save app as supported for link mode
        final success = await core.addLinkModeSupportedApp(appLink);
        core.logger.d('[$runtimeType] addLinkModeSupportedApp, $success');
      }

      final methodKey = _getRegisterKey(
        request.chainId,
        request.request.method,
      );
      final handler = _methodHandlers[methodKey];
      // If a method handler has been set using registerRequestHandler we use it to process the request
      if (handler != null) {
        try {
          await handler(topic, request.request.params);
        } on ReownSignError catch (e) {
          await core.pairing.sendError(
            payload.id,
            topic,
            payload.method,
            JsonRpcError.fromJson(
              e.toJson(),
            ),
            tvf: tvf,
          );
          await _deletePendingRequest(payload.id);
        } on ReownSignErrorSilent catch (_) {
          // Do nothing on silent error
          await _deletePendingRequest(payload.id);
        } catch (err) {
          await core.pairing.sendError(
            payload.id,
            topic,
            payload.method,
            JsonRpcError.invalidParams(
              err.toString(),
            ),
            tvf: tvf,
          );
          await _deletePendingRequest(payload.id);
        }
      } else {
        // Otherwise we send onSessionRequest event
        onSessionRequest.broadcast(
          SessionRequestEvent.fromSessionRequest(
            sessionRequest,
          ),
        );
      }
    } on ReownSignError catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  /// Called when a session event is received by the wallet
  Future<void> _onSessionEventRequest(
    String topic,
    JsonRpcRequest payload, [
    _,
  ]) async {
    try {
      final request = WcSessionEventRequest.fromJson(payload.params);
      final SessionEventParams event = request.event;
      await _isValidEmit(
        topic,
        event,
        request.chainId,
      );

      final String eventKey = _getRegisterKey(
        request.chainId,
        request.event.name,
      );
      if (_eventHandlers.containsKey(eventKey)) {
        final handler = _methodHandlers[eventKey];
        if (handler != null) {
          final handler = _eventHandlers[eventKey]!;
          try {
            await handler(
              topic,
              event.data,
            );
          } catch (err) {
            await core.pairing.sendError(
              payload.id,
              topic,
              payload.method,
              JsonRpcError.invalidParams(
                err.toString(),
              ),
            );
          }
        }

        await core.pairing.sendResult(
          payload.id,
          topic,
          MethodConstants.WC_SESSION_REQUEST,
          true,
        );

        onSessionEvent.broadcast(
          SessionEvent(
            payload.id,
            topic,
            event.name,
            request.chainId,
            event.data,
          ),
        );
      } else {
        await core.pairing.sendError(
          payload.id,
          topic,
          payload.method,
          JsonRpcError.methodNotFound(
            'No handler found for chainId:event -> $eventKey',
          ),
        );
      }
    } on ReownSignError catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  /// ---- Event Registers ---- ///

  void _registerInternalEvents() {
    core.relayClient.onRelayClientConnect.subscribe(_onRelayConnect);
    core.expirer.onExpire.subscribe(_onExpired);
    core.pairing.onPairingDelete.subscribe(_onPairingDelete);
    core.pairing.onPairingExpire.subscribe(_onPairingDelete);
    core.heartbeat.onPulse.subscribe(_heartbeatSubscription);
  }

  Future<void> _onRelayConnect(EventArgs? args) async {
    // print('Session: relay connected');
    await _resubscribeAll();
  }

  Future<void> _onPairingDelete(PairingEvent? event) async {
    core.logger.i('[$runtimeType] onPairingDelete ${event.toString()}');
    // Delete all the sessions associated with the pairing
    if (event == null) {
      return;
    }

    // Delete the proposals
    final List<ProposalData> proposalsToDelete = proposals
        .getAll()
        .where((proposal) => proposal.pairingTopic == event.topic)
        .toList();

    for (final proposal in proposalsToDelete) {
      await _deleteProposal(
        proposal.id,
      );
    }

    // Delete the sessions
    final List<SessionData> sessionsToDelete = sessions
        .getAll()
        .where((session) => session.pairingTopic == event.topic)
        .toList();

    for (final session in sessionsToDelete) {
      await _deleteSession(
        session.topic,
      );
    }
  }

  Future<void> _onExpired(ExpirationEvent? event) async {
    if (event == null) {
      return;
    }

    if (sessions.has(event.target)) {
      await _deleteSession(
        event.target,
        expirerHasDeleted: true,
      );
      onSessionExpire.broadcast(
        SessionExpire(
          event.target,
        ),
      );
    } else if (proposals.has(event.target)) {
      ProposalData proposal = proposals.get(event.target)!;
      await _deleteProposal(
        int.parse(event.target),
        expirerHasDeleted: true,
      );
      onProposalExpire.broadcast(
        SessionProposalEvent(
          int.parse(event.target),
          proposal,
        ),
      );
    } else if (pendingRequests.has(event.target)) {
      await _deletePendingRequest(
        int.parse(event.target),
        expirerHasDeleted: true,
      );
      return;
    }
  }

  void _heartbeatSubscription(EventArgs? args) async {
    await checkAndExpire();
  }

  /// ---- Validation Helpers ---- ///

  Future<bool> _isValidSessionTopic(String topic) async {
    if (!sessions.has(topic)) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "session topic doesn't exist: $topic",
      ).toSignError();
    }

    if (await core.expirer.checkAndExpire(topic)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'session topic: $topic',
      ).toSignError();
    }

    return true;
  }

  Future<bool> _isValidSessionOrPairingTopic(String topic) async {
    if (sessions.has(topic)) {
      await _isValidSessionTopic(topic);
    } else if (core.pairing.getStore().has(topic)) {
      await core.pairing.isValidPairingTopic(topic: topic);
    } else {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "session or pairing topic doesn't exist: $topic",
      ).toSignError();
    }

    return true;
  }

  Future<bool> _isValidProposalId(int id) async {
    if (!proposals.has(id.toString())) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "proposal id doesn't exist: $id",
      ).toSignError();
    }

    if (await core.expirer.checkAndExpire(id.toString())) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'proposal id: $id',
      ).toSignError();
    }

    return true;
  }

  Future<bool> _isValidPendingRequest(int id) async {
    if (!pendingRequests.has(id.toString())) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "proposal id doesn't exist: $id",
      ).toSignError();
    }

    if (await core.expirer.checkAndExpire(id.toString())) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'pending request id: $id',
      ).toSignError();
    }

    return true;
  }

  /// ---- Validations ---- ///

  Future<bool> _isValidConnect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
  }) async {
    // No need to validate sessionProperties. Strict typing enforces Strings are valid
    // No need to see if the relays are a valid array and whatnot. Strict typing enforces that.
    if (pairingTopic != null) {
      try {
        await core.pairing.isValidPairingTopic(
          topic: pairingTopic,
        );
      } on ReownCoreError catch (e) {
        throw e.toSignError();
      }
    }

    if (requiredNamespaces != null) {
      SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: requiredNamespaces,
        context: 'connect() check requiredNamespaces.',
      );
    }

    if (optionalNamespaces != null) {
      SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: optionalNamespaces,
        context: 'connect() check optionalNamespaces.',
      );
    }

    return true;
  }

  Future<bool> _isValidApprove({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    // No need to validate sessionProperties. Strict typing enforces Strings are valid
    await _isValidProposalId(id);
    final ProposalData proposal = proposals.get(id.toString())!;

    // Validate the namespaces
    SignApiValidatorUtils.isValidNamespaces(
      namespaces: namespaces,
      context: 'approve()',
    );

    // Validate the required and optional namespaces
    SignApiValidatorUtils.isValidRequiredNamespaces(
      requiredNamespaces: proposal.requiredNamespaces,
      context: 'approve() check requiredNamespaces.',
    );
    SignApiValidatorUtils.isValidRequiredNamespaces(
      requiredNamespaces: proposal.optionalNamespaces,
      context: 'approve() check optionalNamespaces.',
    );

    // Make sure the provided namespaces conforms with the required
    SignApiValidatorUtils.isConformingNamespaces(
      requiredNamespaces: proposal.requiredNamespaces,
      namespaces: namespaces,
      context: 'approve()',
    );

    return true;
  }

  Future<bool> _isValidReject(int id, ReownSignError reason) async {
    // No need to validate reason. Strict typing enforces ErrorResponse is valid
    await _isValidProposalId(id);
    return true;
  }

  Future<bool> _isValidSessionSettleRequest(
    Map<String, Namespace> namespaces,
    int expiry,
  ) async {
    SignApiValidatorUtils.isValidNamespaces(
      namespaces: namespaces,
      context: 'onSessionSettleRequest()',
    );

    if (ReownCoreUtils.isExpired(expiry)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'onSessionSettleRequest()',
      ).toSignError();
    }

    return true;
  }

  Future<bool> _isValidUpdate(
    String topic,
    Map<String, Namespace> namespaces,
  ) async {
    await _isValidSessionTopic(topic);
    SignApiValidatorUtils.isValidNamespaces(
      namespaces: namespaces,
      context: 'update()',
    );
    final SessionData session = sessions.get(topic)!;

    SignApiValidatorUtils.isConformingNamespaces(
      requiredNamespaces: session.requiredNamespaces ?? {},
      namespaces: namespaces,
      context: 'update()',
    );

    return true;
  }

  Future<bool> _isValidRequest(
    String topic,
    String chainId,
    SessionRequestParams request,
  ) async {
    await _isValidSessionTopic(topic);
    final SessionData session = sessions.get(topic)!;
    SignApiValidatorUtils.isValidNamespacesChainId(
      namespaces: session.namespaces,
      chainId: chainId,
    );
    SignApiValidatorUtils.isValidNamespacesRequest(
      namespaces: session.namespaces,
      chainId: chainId,
      method: request.method,
    );

    return true;
  }

  Future<bool> _isValidResponse(
    String topic,
    JsonRpcResponse response,
  ) async {
    await _isValidSessionTopic(topic);

    if (response.result == null && response.error == null) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'JSON-RPC response and error cannot both be null',
      ).toSignError();
    }

    await _isValidPendingRequest(response.id);

    return true;
  }

  Future<bool> _isValidPing(
    String topic,
  ) async {
    await _isValidSessionOrPairingTopic(topic);

    return true;
  }

  Future<bool> _isValidEmit(
    String topic,
    SessionEventParams event,
    String chainId,
  ) async {
    await _isValidSessionTopic(topic);
    final SessionData session = sessions.get(topic)!;
    SignApiValidatorUtils.isValidNamespacesChainId(
      namespaces: session.namespaces,
      chainId: chainId,
    );
    SignApiValidatorUtils.isValidNamespacesEvent(
      namespaces: session.namespaces,
      chainId: chainId,
      eventName: event.name,
    );

    return true;
  }

  Future<bool> _isValidDisconnect(String topic) async {
    await _isValidSessionOrPairingTopic(topic);

    return true;
  }

  Future<VerifyContext> _getVerifyContext(
    JsonRpcRequest payload,
    PairingMetadata proposerMetada,
    TransportType transportType,
  ) async {
    if (transportType.isLinkMode) {
      return await _getVerifyContextLinkMode(payload, proposerMetada);
    }

    final defaultVerifyUrl = ReownConstants.VERIFY_SERVER;
    final verifyUrl = proposerMetada.verifyUrl ?? defaultVerifyUrl;

    try {
      final metadataUri = Uri.tryParse(proposerMetada.url);

      final jsonStringify = jsonEncode(payload.toJson());
      final hash = core.crypto.getUtils().hashMessage(jsonStringify);
      final attestation = await core.verify.resolve(attestationId: hash);
      final validation = core.verify.getValidation(
        attestation,
        metadataUri,
      );
      final origin = attestation?.origin;
      return VerifyContext(
        origin: (origin ?? metadataUri?.origin) ?? proposerMetada.url,
        verifyUrl: verifyUrl,
        validation: validation,
        isScam: validation == Validation.SCAM,
      );
    } catch (e, s) {
      core.logger.e(
        '[$runtimeType] VerifyContext error ${e.runtimeType}: $e',
        stackTrace: s,
      );
      return VerifyContext(
        origin: proposerMetada.url,
        verifyUrl: verifyUrl,
        validation: Validation.UNKNOWN,
      );
    }
  }

  Future<VerifyContext> _getVerifyContextLinkMode(
    JsonRpcRequest payload,
    PairingMetadata requesterMetadata,
  ) async {
    final universalLink = requesterMetadata.redirect?.universal ?? '';
    final domainUrl = requesterMetadata.url;

    if (universalLink.isEmpty || domainUrl.isEmpty) {
      return VerifyContext(
        origin: requesterMetadata.url,
        verifyUrl: ReownConstants.VERIFY_SERVER,
        validation: Validation.INVALID,
      );
    }

    final universalHost = Uri.parse(universalLink).host;
    final domainHost = Uri.parse(domainUrl).host;

    final matches =
        universalHost == domainHost || universalHost.endsWith('.$domainHost');
    if (matches) {
      return VerifyContext(
        origin: domainHost,
        verifyUrl: ReownConstants.VERIFY_SERVER,
        validation: Validation.VALID,
      );
    }

    return VerifyContext(
      origin: domainHost,
      verifyUrl: ReownConstants.VERIFY_SERVER,
      validation: Validation.INVALID,
    );
  }

  // NEW 1-CA METHOD (Should this be private?)

  @override
  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  }) async {
    final CacaoSignature signature = cacao.s;
    final CacaoPayload payload = cacao.p;

    final reconstructed = formatAuthMessage(
      iss: payload.iss,
      cacaoPayload: CacaoRequestPayload.fromCacaoPayload(payload),
    );

    final walletAddress = AddressUtils.getDidAddress(payload.iss);
    final chainId = AddressUtils.getDidChainId(payload.iss);

    final isValid = await AuthSignature.verifySignature(
      walletAddress.toEIP55(),
      reconstructed,
      signature,
      chainId,
      projectId,
    );

    return isValid;
  }

  // FORMER AUTH ENGINE PROPERTY
  @override
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  }) {
    final header =
        '${cacaoPayload.domain} wants you to sign in with your Ethereum account:';
    final walletAddress = AddressUtils.getDidAddress(iss);

    if (cacaoPayload.aud.isEmpty) {
      throw ReownSignError(code: -1, message: 'aud is required');
    }

    String statement = cacaoPayload.statement ?? '';
    final uri = 'URI: ${cacaoPayload.aud}';
    final version = 'Version: ${cacaoPayload.version}';
    final chainId = 'Chain ID: ${AddressUtils.getDidChainId(iss)}';
    final nonce = 'Nonce: ${cacaoPayload.nonce}';
    final issuedAt = 'Issued At: ${cacaoPayload.iat}';
    final expirationTime = (cacaoPayload.exp != null)
        ? 'Expiration Time: ${cacaoPayload.exp}'
        : null;
    final notBefore =
        (cacaoPayload.nbf != null) ? 'Not Before: ${cacaoPayload.nbf}' : null;
    final requestId = (cacaoPayload.requestId != null)
        ? 'Request ID: ${cacaoPayload.requestId}'
        : null;
    final resources = cacaoPayload.resources != null &&
            cacaoPayload.resources!.isNotEmpty
        ? 'Resources:\n${cacaoPayload.resources!.map((resource) => '- $resource').join('\n')}'
        : null;
    final recap = ReCapsUtils.getRecapFromResources(
      resources: cacaoPayload.resources,
    );
    if (recap != null) {
      final decoded = ReCapsUtils.decodeRecap(recap);
      statement = ReCapsUtils.formatStatementFromRecap(
        statement: statement,
        recap: decoded,
      );
    }

    final message = [
      header,
      walletAddress.toEIP55(),
      '',
      statement,
      '',
      uri,
      version,
      chainId,
      nonce,
      issuedAt,
      expirationTime,
      notBefore,
      requestId,
      resources,
    ].where((element) => element != null).join('\n');

    return message;
  }

  @override
  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests() {
    Map<int, PendingSessionAuthRequest> pendingSessionAuthRequests = {};
    sessionAuthRequests.getAll().forEach((key) {
      pendingSessionAuthRequests[key.id] = key;
    });
    return pendingSessionAuthRequests;
  }

  bool _isLinkModeAuthenticate(String? walletLink) {
    final selfLinkMode = metadata.redirect?.linkMode == true;
    final selfLink = (metadata.redirect?.universal ?? '');
    final walletUniversalLink = (walletLink ?? '');
    final linkModeApps = core.getLinkModeSupportedApps();
    final containsLink = linkModeApps.contains(walletLink);
    final isLinkMode = selfLinkMode &&
        selfLink.isNotEmpty &&
        walletUniversalLink.isNotEmpty &&
        containsLink;
    core.logger.d(
      '[$runtimeType] _isLinkModeAuthenticate: $isLinkMode, selfLinkMode: $selfLinkMode, '
      'selfLink: $selfLink, walletUniversalLink: $walletUniversalLink '
      'linkModeApps: $linkModeApps, containsLink: $containsLink',
    );
    return isLinkMode;
  }

  @override
  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? walletUniversalLink,
    String? pairingTopic,
    List<List<String>>? methods = const [
      [MethodConstants.WC_SESSION_AUTHENTICATE]
    ],
  }) async {
    _checkInitialized();
    AuthApiValidators.isValidAuthenticate(params);

    final isLinkMode = _isLinkModeAuthenticate(walletUniversalLink);
    final transportType =
        isLinkMode ? TransportType.linkMode : TransportType.relay;
    if (!transportType.isLinkMode) {
      _confirmOnlineStateOrThrow();
    }

    final chains = params.chains;
    final resources = params.resources ?? [];
    final requestMethods = params.methods ?? [];

    String? pTopic = pairingTopic;
    Uri? connectionUri;

    if (pTopic == null) {
      final CreateResponse pairing = await core.pairing.create(
        methods: methods,
        transportType: transportType,
      );
      pTopic = pairing.topic;
      connectionUri = pairing.uri;
    } else {
      core.pairing.isValidPairingTopic(topic: pTopic);
    }

    final publicKey = await core.crypto.generateKeyPair();
    final responseTopic = core.crypto.getUtils().hashKey(publicKey);

    await Future.wait([
      authKeys.set(
        StringConstants.OCAUTH_CLIENT_PUBLIC_KEY_NAME,
        AuthPublicKey(publicKey: publicKey),
      ),
      pairingTopics.set(responseTopic, pTopic),
    ]);

    if (requestMethods.isNotEmpty) {
      final namespace = NamespaceUtils.getNamespaceFromChain(chains.first);
      String recap = ReCapsUtils.createEncodedRecap(
        namespace,
        'request',
        requestMethods,
      );
      final existingRecap = ReCapsUtils.getRecapFromResources(
        resources: resources,
      );
      if (existingRecap != null) {
        // per Recaps spec, recap must occupy the last position in the resources array
        // using .removeLast() to remove the element given we already checked it's a recap and will replace it
        recap = ReCapsUtils.mergeEncodedRecaps(recap, resources.removeLast());
      }
      resources.add(recap);
    }

    // Subscribe to the responseTopic because we expect the response to use this topic
    await core.relayClient.subscribe(
      topic: responseTopic,
      transportType: transportType,
    );

    final id = JsonRpcUtils.payloadId();
    final fallbackId = JsonRpcUtils.payloadId();

    // Ensure the expiry is greater than the minimum required for the request - currently 1h
    final method = MethodConstants.WC_SESSION_AUTHENTICATE;
    final opts = MethodConstants.RPC_OPTS[method]!['req']!;
    final ttl = max((params.expiry ?? 0), opts.ttl);

    final currentDateTime = DateTime.now();
    final expiryTimestamp = currentDateTime.add(Duration(seconds: ttl));

    final request = WcSessionAuthRequestParams(
      authPayload: SessionAuthPayload.fromRequestParams(params).copyWith(
        resources: resources,
      ),
      requester: ConnectionMetadata(
        publicKey: publicKey,
        metadata: metadata,
      ),
      expiryTimestamp: expiryTimestamp.millisecondsSinceEpoch,
    );

    // Set the one time use receiver public key for decoding the Type 1 envelope
    await core.pairing.setReceiverPublicKey(
      topic: responseTopic,
      publicKey: publicKey,
      expiry: ttl,
    );

    Completer<SessionAuthResponse> completer = Completer();

    // ----- build fallback session proposal request ----- //

    final fallbackMethod = MethodConstants.WC_SESSION_PROPOSE;
    final fallbackOpts = MethodConstants.RPC_OPTS[fallbackMethod]!['req']!;
    final fallbackExpiryTimestamp = DateTime.now().add(
      Duration(seconds: fallbackOpts.ttl),
    );
    final proposalData = ProposalData(
      id: fallbackId,
      requiredNamespaces: {},
      optionalNamespaces: {
        'eip155': RequiredNamespace(
          chains: chains,
          methods: {'personal_sign', ...requestMethods}.toList(),
          events: EventsConstants.requiredEvents,
        ),
      },
      relays: [Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL)],
      expiry: fallbackExpiryTimestamp.millisecondsSinceEpoch,
      proposer: ConnectionMetadata(
        publicKey: publicKey,
        metadata: metadata,
      ),
      pairingTopic: pTopic,
    );
    final proposeRequest = WcSessionProposeRequest(
      relays: proposalData.relays,
      requiredNamespaces: proposalData.requiredNamespaces,
      optionalNamespaces: proposalData.optionalNamespaces,
      proposer: proposalData.proposer,
    );
    await _setProposal(proposalData.id, proposalData);

    Completer<SessionData> completerFallback = Completer();

    pendingProposals.add(
      SessionProposalCompleter(
        id: fallbackId,
        selfPublicKey: proposalData.proposer.publicKey,
        pairingTopic: proposalData.pairingTopic,
        requiredNamespaces: proposalData.requiredNamespaces,
        optionalNamespaces: proposalData.optionalNamespaces,
        completer: completerFallback,
      ),
    );

    // ------------------------------------------------------- //
    late final Uri linkModeUri;
    if (isLinkMode) {
      final payload = JsonRpcUtils.formatJsonRpcRequest(
        method,
        request.toJson(),
        id: id,
      );
      final message = await core.crypto.encode(
        pTopic,
        payload,
        options: EncodeOptions(type: EncodeOptions.TYPE_2),
      );
      linkModeUri = ReownCoreUtils.getLinkModeURL(
        walletUniversalLink!,
        pTopic,
        message!,
      ).toLinkMode;
    } else {
      // Send Session Proposal request (Only when on Relay mode)
      _connectResponseHandler(
        pTopic,
        proposeRequest,
        fallbackId,
      );
    }

    // Send One-Click Auth request (When on Relay and LinkMode)
    _sessionAuthResponseHandler(
      id: id,
      pairingTopic: pTopic,
      responseTopic: responseTopic,
      walletUniversalLink: walletUniversalLink,
      isLinkMode: isLinkMode,
      request: request,
      ttl: ttl,
      completer: completer,
    );

    return SessionAuthRequestResponse(
      id: id,
      pairingTopic: pTopic,
      // linkModeUri is sent in the response so the host app can trigger it
      uri: isLinkMode ? linkModeUri : connectionUri,
      completer: completer,
    );
  }

  Future<void> _sessionAuthResponseHandler({
    required int id,
    required String pairingTopic,
    required String responseTopic,
    required String? walletUniversalLink,
    required bool isLinkMode,
    required int ttl,
    required WcSessionAuthRequestParams request,
    required Completer<SessionAuthResponse> completer,
  }) async {
    //
    late WcSessionAuthRequestResult result;
    try {
      final Map<String, dynamic> response = await core.pairing.sendRequest(
        pairingTopic,
        MethodConstants.WC_SESSION_AUTHENTICATE,
        request.toJson(),
        id: id,
        ttl: ttl,
        appLink: isLinkMode ? walletUniversalLink : null,
        // We don't want to open the appLink in this case as it will be opened by the host app
        openUrl: false,
      );
      result = WcSessionAuthRequestResult.fromJson(response);
    } catch (error) {
      final response = SessionAuthResponse(
        id: id,
        topic: responseTopic,
        jsonRpcError: (error is JsonRpcError) ? error : null,
        error: (error is! JsonRpcError)
            ? ReownSignError(code: -1, message: '$error')
            : null,
      );
      onSessionAuthResponse.broadcast(response);
      completer.complete(response);
      return;
    }

    await core.pairing.activate(topic: pairingTopic);

    final List<Cacao> cacaos = result.cacaos;
    final ConnectionMetadata responder = result.responder;

    final approvedMethods = <String>{};
    final approvedAccounts = <String>{};

    try {
      for (final Cacao cacao in cacaos) {
        final isValid = await validateSignedCacao(
          cacao: cacao,
          projectId: core.projectId,
        );
        if (!isValid) {
          throw Errors.getSdkError(
            Errors.SIGNATURE_VERIFICATION_FAILED,
            context: 'Invalid signature',
          ).toSignError();
        }

        // This is used on Auth request, would it be needed on 1-CA?
        // await completeRequests.set(
        //   id.toString(),
        //   StoredCacao.fromCacao(
        //     id: id,
        //     pairingTopic: pairingTopic,
        //     cacao: cacao,
        //   ),
        // );

        final CacaoPayload payload = cacao.p;
        final chainId = AddressUtils.getDidChainId(payload.iss);
        final approvedChains = ['eip155:$chainId'];

        final recap = ReCapsUtils.getRecapFromResources(
          resources: payload.resources,
        );
        if (recap != null) {
          final methodsfromRecap = ReCapsUtils.getMethodsFromRecap(recap);
          final chainsFromRecap = ReCapsUtils.getChainsFromRecap(recap);
          approvedMethods.addAll(methodsfromRecap);
          approvedChains.addAll(chainsFromRecap);
        }

        final parsedAddress = AddressUtils.getDidAddress(payload.iss);
        for (var chain in approvedChains.toSet()) {
          approvedAccounts.add('$chain:${parsedAddress.toEIP55()}');
        }
      }
    } on ReownSignError catch (e) {
      final resp = SessionAuthResponse(
        id: id,
        topic: responseTopic,
        error: ReownSignError(
          code: e.code,
          message: e.message,
        ),
      );
      onSessionAuthResponse.broadcast(resp);
      completer.complete(resp);
      // disconnectSession(topic: topic, reason: reason) // TODO
      return;
    }

    final sessionTopic = await core.crypto.generateSharedKey(
      request.requester.publicKey,
      responder.publicKey,
    );

    SessionData? session;
    if (approvedMethods.isNotEmpty) {
      session = SessionData(
        topic: sessionTopic,
        acknowledged: true,
        self: ConnectionMetadata(
          publicKey: request.requester.publicKey,
          metadata: metadata,
        ),
        peer: responder,
        controller: request.requester.publicKey,
        expiry: ReownCoreUtils.calculateExpiry(
          ReownConstants.SEVEN_DAYS,
        ),
        relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
        pairingTopic: pairingTopic,
        namespaces: NamespaceUtils.buildNamespacesFromAuth(
          accounts: approvedAccounts,
          methods: approvedMethods,
        ),
        authentication: cacaos,
        transportType:
            isLinkMode ? TransportType.linkMode : TransportType.relay,
      );

      await core.relayClient.subscribe(
        topic: sessionTopic,
        transportType:
            isLinkMode ? TransportType.linkMode : TransportType.relay,
      );
      await sessions.set(sessionTopic, session);
      await core.pairing.updateMetadata(
        topic: pairingTopic,
        metadata: responder.metadata,
      );

      session = sessions.get(sessionTopic);
    }

    await _addLinkModeSupportedApp(
      responder,
      sessionTopic,
      walletUniversalLink,
    );

    final resp = SessionAuthResponse(
      id: id,
      topic: responseTopic,
      auths: cacaos,
      session: session,
    );
    onSessionAuthResponse.broadcast(resp);
    completer.complete(resp);
  }

  Future<void> _addLinkModeSupportedApp(
    ConnectionMetadata responder,
    String sessionTopic,
    String? walletUniversalLink,
  ) async {
    final selfLinkMode = metadata.redirect?.linkMode == true;
    final responderLinkMode = responder.metadata.redirect?.linkMode == true;
    final walletLink = (walletUniversalLink ?? '');
    final matchesLink = walletLink == responder.metadata.redirect?.universal;
    if (selfLinkMode && responderLinkMode) {
      if (walletLink.isNotEmpty && matchesLink) {
        // save wallet link in array of apps that support linkMode
        final success = await core.addLinkModeSupportedApp(walletLink);
        if (success) {
          await sessions.update(
            sessionTopic,
            transportType: TransportType.linkMode,
          );
        }
      }
      if (!matchesLink) {
        core.logger.i(
          '[$runtimeType] universal link set in redirect metadata object does not match wallet\'s universal link',
        );
      }
    }
  }

  @override
  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  }) async {
    _checkInitialized();

    final pendingSessionAuthRequests = getPendingSessionAuthRequests();

    if (!pendingSessionAuthRequests.containsKey(id)) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'approveSessionAuthenticate() '
            'Could not find pending auth request with id $id',
      ).toSignError();
    }

    AuthApiValidators.isValidRespondAuthenticate(
      id: id,
      pendingRequests: pendingSessionAuthRequests,
      auths: auths,
    );

    final pendingRequest = pendingSessionAuthRequests[id]!;
    if (!pendingRequest.transportType.isLinkMode) {
      _confirmOnlineStateOrThrow();
    }

    final receiverPublicKey = pendingRequest.requester.publicKey;
    final senderPublicKey = await core.crypto.generateKeyPair();
    final responseTopic = core.crypto.getUtils().hashKey(receiverPublicKey);

    final encodeOpts = EncodeOptions(
      type: EncodeOptions.TYPE_1,
      receiverPublicKey: receiverPublicKey,
      senderPublicKey: senderPublicKey,
    );

    final approvedMethods = <String>{};
    final approvedAccounts = <String>{};
    for (final Cacao cacao in auths!) {
      final isValid = await validateSignedCacao(
        cacao: cacao,
        projectId: core.projectId,
      );
      if (!isValid) {
        final error = Errors.getSdkError(
          Errors.SIGNATURE_VERIFICATION_FAILED,
          context: 'Signature verification failed',
        ).toSignError();
        await core.pairing.sendError(
          id,
          responseTopic,
          MethodConstants.WC_SESSION_AUTHENTICATE,
          JsonRpcError(code: error.code, message: error.message),
          encodeOptions: encodeOpts,
        );
        throw error;
      }

      final CacaoPayload payload = cacao.p;
      final chainId = AddressUtils.getDidChainId(payload.iss);
      final approvedChains = ['eip155:$chainId'];

      final recap = ReCapsUtils.getRecapFromResources(
        resources: payload.resources,
      );
      if (recap != null) {
        final methodsfromRecap = ReCapsUtils.getMethodsFromRecap(recap);
        final chainsFromRecap = ReCapsUtils.getChainsFromRecap(recap);
        approvedMethods.addAll(methodsfromRecap);
        approvedChains.addAll(chainsFromRecap);
      }

      final parsedAddress = AddressUtils.getDidAddress(payload.iss);
      for (var chain in approvedChains.toSet()) {
        approvedAccounts.add('$chain:${parsedAddress.toEIP55()}');
      }
    }

    final sessionTopic = await core.crypto.generateSharedKey(
      senderPublicKey,
      receiverPublicKey,
    );

    SessionData? session;
    if (approvedMethods.isNotEmpty) {
      session = SessionData(
        topic: sessionTopic,
        acknowledged: true,
        self: ConnectionMetadata(
          publicKey: senderPublicKey,
          metadata: metadata,
        ),
        peer: pendingRequest.requester,
        controller: receiverPublicKey,
        expiry: ReownCoreUtils.calculateExpiry(
          ReownConstants.SEVEN_DAYS,
        ),
        relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
        pairingTopic: pendingRequest.pairingTopic,
        namespaces: NamespaceUtils.buildNamespacesFromAuth(
          accounts: approvedAccounts,
          methods: approvedMethods,
        ),
        authentication: auths,
        transportType: pendingRequest.transportType,
      );

      await core.relayClient.subscribe(
        topic: sessionTopic,
        transportType: pendingRequest.transportType,
      );
      await sessions.set(sessionTopic, session);
      await core.pairing.updateMetadata(
        topic: pendingRequest.pairingTopic,
        metadata: pendingRequest.requester.metadata,
      );
    }

    await sessionAuthRequests.delete(id.toString());
    await core.pairing.activate(topic: pendingRequest.pairingTopic);

    final result = WcSessionAuthRequestResult(
      cacaos: auths,
      responder: ConnectionMetadata(
        publicKey: senderPublicKey,
        metadata: metadata,
      ),
    );
    await core.pairing.sendResult(
      id,
      responseTopic,
      MethodConstants.WC_SESSION_AUTHENTICATE,
      result.toJson(),
      encodeOptions: encodeOpts,
      appLink: _getAppLinkIfEnabled(pendingRequest.requester.metadata),
    );

    return ApproveResponse(
      topic: sessionTopic,
      session: session,
    );
  }

  @override
  Future<void> rejectSessionAuthenticate({
    required int id,
    required ReownSignError reason,
  }) async {
    _checkInitialized();

    final pendingSessionAuthRequests = getPendingSessionAuthRequests();

    if (!pendingSessionAuthRequests.containsKey(id)) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'rejectSessionAuthenticate() '
            'Could not find pending auth request with id $id',
      ).toSignError();
    }

    final pendingRequest = pendingSessionAuthRequests[id]!;
    if (!pendingRequest.transportType.isLinkMode) {
      _confirmOnlineStateOrThrow();
    }

    final receiverPublicKey = pendingRequest.requester.publicKey;
    final senderPublicKey = await core.crypto.generateKeyPair();
    final responseTopic = core.crypto.getUtils().hashKey(receiverPublicKey);

    final encodeOpts = EncodeOptions(
      type: EncodeOptions.TYPE_1,
      receiverPublicKey: receiverPublicKey,
      senderPublicKey: senderPublicKey,
    );

    final method = MethodConstants.WC_SESSION_AUTHENTICATE;
    final rpcOpts = MethodConstants.RPC_OPTS[method];
    await core.pairing.sendError(
      id,
      responseTopic,
      method,
      JsonRpcError(code: reason.code, message: reason.message),
      encodeOptions: encodeOpts,
      rpcOptions: rpcOpts?['reject'],
      appLink: _getAppLinkIfEnabled(pendingRequest.requester.metadata),
    );

    await sessionAuthRequests.delete(id.toString());
    await _deleteProposal(id);
  }

  // Deprecated method but still supported for retrocompatibility
  // void _onAuthRequest(String topic, JsonRpcRequest payload, [_]) async {
  //   await core.pairing.sendError(
  //     payload.id,
  //     topic,
  //     payload.method,
  //     JsonRpcError.invalidRequest(
  //       '${payload.method} is deprecated, use wc_sessionAuthenticate',
  //     ),
  //   );
  // }

  void _onSessionAuthenticateRequest(
    String topic,
    JsonRpcRequest payload, [
    TransportType transportType = TransportType.relay,
  ]) async {
    core.logger.d(
      '_onSessionAuthenticateRequest, topic: $topic, payload: $payload',
    );

    if (transportType.isLinkMode && !sessions.has(topic)) {
      final pairingInfo = PairingInfo(
        topic: topic,
        expiry: ReownCoreUtils.calculateExpiry(
          ReownConstants.SEVEN_DAYS,
        ),
        relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
        // Will be activated during approveSessionAuthenticate()
        // or deleted during rejectSessionAuthenticate()
        active: false,
      );

      await pairings.set(topic, pairingInfo);
      core.logger.d(
        '[$runtimeType] _onSessionAuthenticateRequest pairingInfo $pairingInfo',
      );
    }

    final saRequest = WcSessionAuthRequestParams.fromJson(payload.params);
    try {
      final cacaoPayload = CacaoRequestPayload.fromSessionAuthPayload(
        saRequest.authPayload,
      );

      final verifyContext = await _getVerifyContext(
        payload,
        saRequest.requester.metadata,
        transportType,
      );

      sessionAuthRequests.set(
        payload.id.toString(),
        PendingSessionAuthRequest(
          id: payload.id,
          pairingTopic: topic,
          requester: saRequest.requester,
          authPayload: cacaoPayload,
          expiryTimestamp: saRequest.expiryTimestamp,
          verifyContext: verifyContext,
          transportType: transportType,
        ),
      );

      final appLink = (saRequest.requester.metadata.redirect?.universal ?? '');
      if (transportType.isLinkMode && appLink.isNotEmpty) {
        // save app as supported for link mode
        await core.addLinkModeSupportedApp(appLink);
      }

      onSessionAuthRequest.broadcast(
        SessionAuthRequest(
          id: payload.id,
          topic: topic,
          requester: saRequest.requester,
          authPayload: saRequest.authPayload,
          verifyContext: verifyContext,
          transportType: transportType,
        ),
      );
    } on ReownSignError catch (err) {
      final receiverPublicKey = saRequest.requester.publicKey;
      final senderPublicKey = await core.crypto.generateKeyPair();

      final encodeOpts = EncodeOptions(
        type: EncodeOptions.TYPE_1,
        receiverPublicKey: receiverPublicKey,
        senderPublicKey: senderPublicKey,
      );
      final rpcOpts = MethodConstants.RPC_OPTS[payload.method];
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(err.message),
        encodeOptions: encodeOpts,
        rpcOptions: rpcOpts?['autoReject'],
      );
    }
  }

  @override
  Future<void> dispatchEnvelope(String url) async {
    final topic = ReownCoreUtils.getSearchParamFromURL(url, 'topic');
    final envelope = ReownCoreUtils.getSearchParamFromURL(url, 'wc_ev');
    core.logger.d('[$runtimeType] dispatchEnvelope $url');

    if (envelope.isEmpty) {
      throw ReownSignError(code: 0, message: 'Envelope not found');
    }
    if (topic.isEmpty) {
      throw ReownSignError(code: 0, message: 'Topic not found');
    }

    final session = sessions.get(topic);
    if (session != null) {
      core.logger.d('[$runtimeType] sessions.update $topic to linkMode');
      await sessions.update(
        session.topic,
        transportType: TransportType.linkMode,
      );
    }

    core.pairing.dispatchEnvelope(
      topic: topic,
      envelope: envelope,
    );
  }

  bool _isLinkModeEnabled(PairingMetadata? peerMetadata) {
    if (peerMetadata == null) return false;

    final selfLink = (metadata.redirect?.universal ?? '');
    final selfLinkMode = metadata.redirect?.linkMode == true;
    final peerLink = (peerMetadata.redirect?.universal ?? '');
    final peerLinkMode = peerMetadata.redirect?.linkMode == true;
    return selfLinkMode &&
        selfLink.isNotEmpty &&
        peerLinkMode &&
        peerLink.isNotEmpty &&
        core.getLinkModeSupportedApps().contains(peerLink);
  }

  String? _getAppLinkIfEnabled(PairingMetadata? peerMetadata) {
    final isLinkMode = _isLinkModeEnabled(peerMetadata);
    return isLinkMode ? peerMetadata?.redirect?.universal : null;
  }

  @override
  Future<bool> redirectToDapp({
    required String topic,
    required Redirect? redirect,
  }) {
    return _callRedirect(topic, redirect);
  }

  @override
  Future<bool> redirectToWallet({
    required String topic,
    required Redirect? redirect,
  }) {
    return _callRedirect(topic, redirect);
  }

  Future<bool> _callRedirect(String topic, Redirect? redirect) async {
    final hasSession = topic.isNotEmpty && sessions.has(topic);
    if (hasSession) {
      final session = sessions.get(topic)!;
      final isLinkMode = session.transportType.isLinkMode;
      final isEnabled = _isLinkModeEnabled(session.peer.metadata);
      core.logger.d(
        '[$runtimeType] callRedirect, isLinkMode: $isLinkMode, isEnabled: $isEnabled',
      );
      if (isLinkMode && isEnabled) {
        // linkMode redirection is already handled in the requests
        return false;
      }
    }

    final scheme = redirect?.native;
    try {
      if (scheme == null) {
        throw ReownSignError(
          code: 0,
          message: 'scheme `$scheme` is invalid',
        );
      }
      final success = await ReownCoreUtils.openURL(scheme);
      if (!success) {
        throw ReownSignError(
          code: 0,
          message: 'Can not open $scheme',
        );
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// ******* TVF *********** ///
  /// collection during request from dapp
  ///
  TVFData? _collectRequestTVF(int id, WcSessionRequestRequest request) {
    // check if the rpc request is on the tvf supported methods list
    final method = request.request.method;
    if (!TVFData.tvfRequestMethods.contains(method)) {
      return null;
    }
    final params = request.request.params;

    // params to collect
    final rpcMethods = List<String>.from([method]);
    final chainId = request.chainId;
    List<String>? contractAddresses;

    final contractAddress = _collectContractAddressIfNeeded(chainId, params);
    if (contractAddress != null) {
      contractAddresses = [contractAddress];
    }

    final tvfData = TVFData(
      rpcMethods: rpcMethods,
      chainId: chainId,
      contractAddresses: contractAddresses,
    );

    // pendingTVFRequests is useful for WalletKit _onSessionRequest method
    pendingTVFRequests[id] = tvfData;

    // return is useful for AppKit's request() method
    return tvfData;
  }

  String? _collectContractAddressIfNeeded(String chainId, dynamic params) {
    // only EVM request could have `data` parameter for contract call
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    if (namespace == 'eip155') {
      final paramsMap = (params as List).first as Map<String, dynamic>;
      try {
        final input = (paramsMap['input'] ?? paramsMap['data'])!;
        if (ReownCoreUtils.isValidContractData(input)) {
          final contractAddress = paramsMap['to'] as String;
          return contractAddress;
        }
      } catch (e) {
        core.logger.d('[$runtimeType] invalid contract data');
      }
    }
    return null;
  }

  ///
  /// ******* TVF *********** ///
  /// collection during response from wallet
  ///
  TVFData? _collectResponseTVF(JsonRpcResponse payload) {
    final id = payload.id;
    if (pendingTVFRequests.containsKey(id)) {
      final chainId = pendingTVFRequests[id]!.chainId!;
      final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
      final tvfData = pendingTVFRequests[id]!.copytWith(
        txHashes: _collectHashes(namespace, payload),
      );
      pendingTVFRequests.remove(id);
      return tvfData;
    }

    return null;
  }

  List<String>? _collectHashes(String namespace, JsonRpcResponse response) {
    if (response.result == null || response.error != null) {
      return null;
    }

    try {
      final result = (response.result as Map<String, dynamic>);
      switch (namespace) {
        case 'solana':
          if (result.containsKey('signature')) {
            return List<String>.from([result['signature']]);
          }
          if (result.containsKey('transactions')) {
            // Decode transactions and extract signature to send as TVF data
            final transactions = result['transactions'] as List;
            final signatures = transactions.map((encodedTx) {
              return ReownCoreUtils.extractSolanaSignature(encodedTx);
            }).toList();
            return signatures;
          }
          return null;
        case 'hedera':
          final transactionId = ReownCoreUtils.recursiveSearchForMapKey(
            result,
            'transactionId',
          );
          if (transactionId != null) {
            return List<String>.from([transactionId]);
          }
          return null;
        default:
          return List<String>.from([response.result]);
      }
    } catch (e) {
      core.logger.d('[$runtimeType] _collectHashes $e');
      return null;
    }
  }
}
