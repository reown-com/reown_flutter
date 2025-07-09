import 'package:event/event.dart';
import 'package:reown_core/relay_client/websocket/http_client.dart';
import 'package:reown_core/relay_client/websocket/i_http_client.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/i_generic_store.dart';
import 'package:reown_sign/reown_sign.dart';

class SignClientTestWrapper implements IReownSign {
  bool _initialized = false;

  @override
  Event<SessionDelete> get onSessionDelete => client.onSessionDelete;
  @override
  Event<SessionConnect> get onSessionConnect => client.onSessionConnect;
  @override
  Event<SessionEvent> get onSessionEvent => client.onSessionEvent;
  @override
  Event<SessionExpire> get onSessionExpire => client.onSessionExpire;
  @override
  Event<SessionExtend> get onSessionExtend => client.onSessionExtend;
  @override
  Event<SessionPing> get onSessionPing => client.onSessionPing;
  @override
  Event<SessionProposalEvent> get onSessionProposal => client.onSessionProposal;
  @override
  Event<SessionProposalErrorEvent> get onSessionProposalError =>
      client.onSessionProposalError;
  @override
  Event<SessionProposalEvent> get onProposalExpire => client.onProposalExpire;
  @override
  Event<SessionRequestEvent> get onSessionRequest => client.onSessionRequest;
  @override
  Event<SessionUpdate> get onSessionUpdate => client.onSessionUpdate;

  @override
  IReownCore get core => client.core;
  @override
  PairingMetadata get metadata => client.metadata;
  @override
  IGenericStore<ProposalData> get proposals => client.proposals;
  @override
  ISessions get sessions => client.sessions;
  @override
  IGenericStore<SessionRequest> get pendingRequests => client.pendingRequests;

  late IReownSignClient client;

  static Future<SignClientTestWrapper> createInstance({
    required String projectId,
    String relayUrl = ReownConstants.DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
    LogLevel logLevel = LogLevel.nothing,
    IHttpClient httpClient = const HttpWrapper(),
  }) async {
    final client = SignClientTestWrapper(
      core: ReownCore(
        projectId: projectId,
        relayUrl: relayUrl,
        memoryStore: memoryStore,
        httpClient: httpClient,
      ),
      metadata: metadata,
    );
    await client.init();

    return client;
  }

  SignClientTestWrapper({
    required IReownCore core,
    required PairingMetadata metadata,
  }) {
    client = ReownSignClient(
      core: core,
      metadata: metadata,
    );
  }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.start();
    await client.init();

    _initialized = true;
  }

  @override
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    Map<String, dynamic>? scopedProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods = ReownSign.DEFAULT_METHODS,
  }) async {
    try {
      return await client.connect(
        requiredNamespaces: requiredNamespaces,
        optionalNamespaces: optionalNamespaces,
        sessionProperties: sessionProperties,
        pairingTopic: pairingTopic,
        relays: relays,
        methods: methods,
      );
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    try {
      return await client.pair(uri: uri);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    Map<String, dynamic>? scopedProperties,
    String? relayProtocol,
  }) async {
    try {
      return await client.approve(
        id: id,
        namespaces: namespaces,
        relayProtocol: relayProtocol,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> rejectSession({
    required int id,
    required ReownSignError reason,
  }) async {
    try {
      return await client.reject(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    try {
      return await client.update(
        topic: topic,
        namespaces: namespaces,
      );
    } catch (e) {
      // final error = e as WCError;
      rethrow;
    }
  }

  @override
  Future<void> extendSession({
    required String topic,
  }) async {
    try {
      return await client.extend(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    void Function(String, dynamic)? handler,
  }) {
    try {
      return client.registerRequestHandler(
        chainId: chainId,
        method: method,
        handler: handler,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> request({
    int? requestId,
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    try {
      return await client.request(
        topic: topic,
        chainId: chainId,
        request: request,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  }) {
    try {
      return client.respond(
        topic: topic,
        response: response,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  }) {
    try {
      return client.registerEventHandler(
        chainId: chainId,
        event: event,
        handler: handler,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerEventEmitter({
    required String chainId,
    required String event,
  }) {
    try {
      return client.registerEventEmitter(
        chainId: chainId,
        event: event,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerAccount({
    required String chainId,
    required String accountAddress,
  }) {
    try {
      return client.registerAccount(
        chainId: chainId,
        accountAddress: accountAddress,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    try {
      return await client.emit(
        topic: topic,
        chainId: chainId,
        event: event,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> ping({
    required String topic,
  }) async {
    try {
      return await client.ping(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> disconnectSession({
    required String topic,
    required ReownSignError reason,
  }) async {
    try {
      return await client.disconnect(
        topic: topic,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    try {
      return client.find(requiredNamespaces: requiredNamespaces);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    try {
      return client.getActiveSessions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    try {
      return client.getSessionsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    try {
      return client.getPendingSessionProposals();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    try {
      return client.getPendingSessionRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> dispatchEnvelope(String url) {
    try {
      return client.dispatchEnvelope(url);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> redirectToDapp({
    required String topic,
    required Redirect? redirect,
  }) {
    return client.redirectToDapp(
      topic: topic,
      redirect: redirect,
    );
  }

  @override
  Future<bool> redirectToWallet({
    required String topic,
    required Redirect? redirect,
  }) {
    return client.redirectToWallet(
      topic: topic,
      redirect: redirect,
    );
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  @override
  Future<void> checkAndExpire() async {
    for (var session in sessions.getAll()) {
      await core.expirer.checkAndExpire(session.topic);
    }
  }

  @override
  IGenericStore<AuthPublicKey> get authKeys => client.authKeys;

  @override
  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  }) {
    try {
      return client.validateSignedCacao(
        cacao: cacao,
        projectId: projectId,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  }) {
    try {
      return client.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Event<SessionAuthResponse> get onSessionAuthResponse =>
      client.onSessionAuthResponse;

  @override
  IGenericStore<String> get pairingTopics => client.pairingTopics;

  @override
  IGenericStore<PendingSessionAuthRequest> get sessionAuthRequests =>
      client.sessionAuthRequests;

  @override
  Event<SessionAuthRequest> get onSessionAuthRequest =>
      client.onSessionAuthRequest;

  @override
  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? walletUniversalLink,
    String? pairingTopic,
    List<List<String>>? methods,
  }) async {
    try {
      return await client.authenticate(
        params: params,
        walletUniversalLink: walletUniversalLink,
        pairingTopic: pairingTopic,
        methods: methods,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  }) async {
    try {
      return await client.approveSessionAuthenticate(
        id: id,
        auths: auths,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> rejectSessionAuthenticate({
    required int id,
    required ReownSignError reason,
  }) async {
    try {
      return await client.rejectSessionAuthenticate(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests() {
    try {
      return client.getPendingSessionAuthRequests();
    } catch (e) {
      rethrow;
    }
  }
}
