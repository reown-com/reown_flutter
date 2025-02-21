import 'package:event/event.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_core/store/i_generic_store.dart';
import 'package:reown_sign/reown_sign.dart';

class ReownSignClient implements IReownSignClient {
  bool _initialized = false;

  @override
  final String protocol = 'wc';
  @override
  final int version = 2;

  @override
  Event<SessionDelete> get onSessionDelete => engine.onSessionDelete;
  @override
  Event<SessionConnect> get onSessionConnect => engine.onSessionConnect;
  @override
  Event<SessionEvent> get onSessionEvent => engine.onSessionEvent;
  @override
  Event<SessionExpire> get onSessionExpire => engine.onSessionExpire;
  @override
  Event<SessionExtend> get onSessionExtend => engine.onSessionExtend;
  @override
  Event<SessionPing> get onSessionPing => engine.onSessionPing;
  @override
  Event<SessionProposalEvent> get onSessionProposal => engine.onSessionProposal;
  @override
  Event<SessionProposalErrorEvent> get onSessionProposalError =>
      engine.onSessionProposalError;
  @override
  Event<SessionProposalEvent> get onProposalExpire => engine.onProposalExpire;
  @override
  Event<SessionRequestEvent> get onSessionRequest => engine.onSessionRequest;
  @override
  Event<SessionUpdate> get onSessionUpdate => engine.onSessionUpdate;

  @override
  IReownCore get core => engine.core;
  @override
  PairingMetadata get metadata => engine.metadata;
  @override
  IGenericStore<ProposalData> get proposals => engine.proposals;
  @override
  ISessions get sessions => engine.sessions;
  @override
  IGenericStore<SessionRequest> get pendingRequests => engine.pendingRequests;

  @override
  late IReownSign engine;

  static Future<ReownSignClient> createInstance({
    required String projectId,
    String relayUrl = ReownConstants.DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
    LogLevel logLevel = LogLevel.nothing,
  }) async {
    final client = ReownSignClient(
      core: ReownCore(
        projectId: projectId,
        relayUrl: relayUrl,
        memoryStore: memoryStore,
        logLevel: logLevel,
      ),
      metadata: metadata,
    );
    await client.init();

    return client;
  }

  ReownSignClient({
    required IReownCore core,
    required PairingMetadata metadata,
  }) {
    engine = ReownSign(
      core: core,
      metadata: metadata,
      proposals: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_PROPOSALS,
        version: StoreVersions.VERSION_PROPOSALS,
        fromJson: (dynamic value) {
          return ProposalData.fromJson(value);
        },
      ),
      sessions: Sessions(
        storage: core.storage,
        context: StoreVersions.CONTEXT_SESSIONS,
        version: StoreVersions.VERSION_SESSIONS,
        fromJson: (dynamic value) {
          return SessionData.fromJson(value);
        },
      ),
      pendingRequests: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_PENDING_REQUESTS,
        version: StoreVersions.VERSION_PENDING_REQUESTS,
        fromJson: (dynamic value) {
          return SessionRequest.fromJson(value);
        },
      ),
      pairingTopics: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_PAIRING_TOPICS,
        version: StoreVersions.VERSION_PAIRING_TOPICS,
        fromJson: (dynamic value) {
          return value;
        },
      ),
      authKeys: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_AUTH_KEYS,
        version: StoreVersions.VERSION_AUTH_KEYS,
        fromJson: (dynamic value) {
          return AuthPublicKey.fromJson(value);
        },
      ),
      sessionAuthRequests: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_AUTH_REQUESTS,
        version: StoreVersions.VERSION_AUTH_REQUESTS,
        fromJson: (dynamic value) {
          return PendingSessionAuthRequest.fromJson(value);
        },
      ),
    );
  }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.start();
    await engine.init();

    _initialized = true;
  }

  @override
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods = ReownSign.DEFAULT_METHODS,
  }) async {
    try {
      return await engine.connect(
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
      return await engine.pair(uri: uri);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApproveResponse> approve({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    try {
      return await engine.approveSession(
        id: id,
        namespaces: namespaces,
        sessionProperties: sessionProperties,
        relayProtocol: relayProtocol,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> reject({
    required int id,
    required ReownSignError reason,
  }) async {
    try {
      return await engine.rejectSession(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    try {
      return await engine.updateSession(
        topic: topic,
        namespaces: namespaces,
      );
    } catch (e) {
      // final error = e as WCError;
      rethrow;
    }
  }

  @override
  Future<void> extend({
    required String topic,
  }) async {
    try {
      return await engine.extendSession(topic: topic);
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
      return engine.registerRequestHandler(
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
      return await engine.request(
        requestId: requestId,
        topic: topic,
        chainId: chainId,
        request: request,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> requestReadContract({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    EthereumAddress? sender,
    List<dynamic> parameters = const [],
  }) async {
    try {
      return await engine.requestReadContract(
        sender: sender,
        deployedContract: deployedContract,
        functionName: functionName,
        rpcUrl: rpcUrl,
        parameters: parameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> requestWriteContract({
    required String topic,
    required String chainId,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    List parameters = const [],
    String? method,
  }) async {
    try {
      return await engine.requestWriteContract(
        topic: topic,
        chainId: chainId,
        deployedContract: deployedContract,
        functionName: functionName,
        transaction: transaction,
        method: method,
        parameters: parameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> respond({
    required String topic,
    required JsonRpcResponse response,
  }) {
    try {
      return engine.respondSessionRequest(
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
      return engine.registerEventHandler(
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
      return engine.registerEventEmitter(
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
      return engine.registerAccount(
        chainId: chainId,
        accountAddress: accountAddress,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> emit({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    try {
      return await engine.emitSessionEvent(
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
      return await engine.ping(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> disconnect({
    required String topic,
    required ReownSignError reason,
  }) async {
    try {
      return await engine.disconnectSession(
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
      return engine.find(requiredNamespaces: requiredNamespaces);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    try {
      return engine.getActiveSessions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    try {
      return engine.getSessionsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    try {
      return engine.getPendingSessionProposals();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    try {
      return engine.getPendingSessionRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  @override
  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests() {
    try {
      return engine.getPendingSessionAuthRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IGenericStore<PendingSessionAuthRequest> get sessionAuthRequests =>
      engine.sessionAuthRequests;

  @override
  Event<SessionAuthResponse> get onSessionAuthResponse =>
      engine.onSessionAuthResponse;

  @override
  Event<SessionAuthRequest> get onSessionAuthRequest =>
      engine.onSessionAuthRequest;

  // NEW ONE-CLICK AUTH METHOD FOR DAPPS
  @override
  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? walletUniversalLink,
    String? pairingTopic,
    List<List<String>>? methods = const [
      [MethodConstants.WC_SESSION_AUTHENTICATE]
    ],
  }) {
    try {
      return engine.authenticate(
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
  }) {
    try {
      return engine.approveSessionAuthenticate(
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
  }) {
    try {
      return engine.rejectSessionAuthenticate(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  IGenericStore<AuthPublicKey> get authKeys => engine.authKeys;

  @override
  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  }) {
    try {
      return engine.validateSignedCacao(
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
      return engine.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> dispatchEnvelope(String url) async {
    return engine.dispatchEnvelope(url);
  }

  @override
  Future<bool> redirectToDapp({
    required String topic,
    required Redirect? redirect,
  }) {
    return engine.redirectToDapp(
      topic: topic,
      redirect: redirect,
    );
  }

  @override
  Future<bool> redirectToWallet({
    required String topic,
    required Redirect? redirect,
  }) {
    return engine.redirectToWallet(
      topic: topic,
      redirect: redirect,
    );
  }

  @override
  IGenericStore<String> get pairingTopics => engine.pairingTopics;
}
