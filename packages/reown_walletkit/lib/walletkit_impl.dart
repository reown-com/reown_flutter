import 'package:event/event.dart';
import 'package:reown_core/relay_client/websocket/http_client.dart';
import 'package:reown_core/relay_client/websocket/i_http_client.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_core/store/i_generic_store.dart';
import 'package:reown_sign/reown_sign.dart';
import 'package:reown_walletkit/i_walletkit_impl.dart';

class ReownWalletKit implements IReownWalletKit {
  bool _initialized = false;

  static Future<ReownWalletKit> createInstance({
    required String projectId,
    String relayUrl = ReownConstants.DEFAULT_RELAY_URL,
    String pushUrl = ReownConstants.DEFAULT_PUSH_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
    LogLevel logLevel = LogLevel.nothing,
    IHttpClient httpClient = const HttpWrapper(),
  }) async {
    final walletKit = ReownWalletKit(
      core: ReownCore(
        projectId: projectId,
        relayUrl: relayUrl,
        pushUrl: pushUrl,
        memoryStore: memoryStore,
        logLevel: logLevel,
        httpClient: httpClient,
      ),
      metadata: metadata,
    );
    await walletKit.init();

    return walletKit;
  }

  ///---------- GENERIC ----------///

  @override
  final String protocol = 'wc';

  @override
  final int version = 2;

  @override
  final IReownCore core;

  @override
  final PairingMetadata metadata;

  ReownWalletKit({
    required this.core,
    required this.metadata,
  }) {
    reOwnSign = ReownSign(
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
      authKeys: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_AUTH_KEYS,
        version: StoreVersions.VERSION_AUTH_KEYS,
        fromJson: (dynamic value) {
          return AuthPublicKey.fromJson(value);
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
    await reOwnSign.init();

    _initialized = true;
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    try {
      return await reOwnSign.pair(uri: uri);
    } catch (e) {
      rethrow;
    }
  }

  ///---------- SIGN ENGINE ----------///

  @override
  late IReownSign reOwnSign;

  @override
  Event<SessionConnect> get onSessionConnect => reOwnSign.onSessionConnect;

  @override
  Event<SessionDelete> get onSessionDelete => reOwnSign.onSessionDelete;

  @override
  Event<SessionExpire> get onSessionExpire => reOwnSign.onSessionExpire;

  @override
  Event<SessionProposalEvent> get onSessionProposal =>
      reOwnSign.onSessionProposal;

  @override
  Event<SessionProposalErrorEvent> get onSessionProposalError =>
      reOwnSign.onSessionProposalError;

  @override
  Event<SessionProposalEvent> get onProposalExpire =>
      reOwnSign.onProposalExpire;

  @override
  Event<SessionRequestEvent> get onSessionRequest => reOwnSign.onSessionRequest;

  @override
  Event<SessionPing> get onSessionPing => reOwnSign.onSessionPing;

  @override
  IGenericStore<ProposalData> get proposals => reOwnSign.proposals;

  @override
  ISessions get sessions => reOwnSign.sessions;

  @override
  IGenericStore<SessionRequest> get pendingRequests =>
      reOwnSign.pendingRequests;

  @override
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    try {
      return await reOwnSign.approveSession(
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
  Future<void> rejectSession({
    required int id,
    required ReownSignError reason,
  }) async {
    try {
      return await reOwnSign.rejectSession(
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
      return await reOwnSign.updateSession(
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
      return await reOwnSign.extendSession(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  }) {
    try {
      return reOwnSign.registerRequestHandler(
        chainId: chainId,
        method: method,
        handler: handler,
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
      return reOwnSign.respondSessionRequest(
        topic: topic,
        response: response,
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
      return reOwnSign.registerEventEmitter(
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
      return reOwnSign.registerAccount(
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
      return await reOwnSign.emitSessionEvent(
        topic: topic,
        chainId: chainId,
        event: event,
      );
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
      return await reOwnSign.disconnectSession(
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
      return reOwnSign.find(requiredNamespaces: requiredNamespaces);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    try {
      return reOwnSign.getActiveSessions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    try {
      return reOwnSign.getSessionsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    try {
      return reOwnSign.getPendingSessionProposals();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    try {
      return reOwnSign.getPendingSessionRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> dispatchEnvelope(String url) async {
    try {
      return await reOwnSign.dispatchEnvelope(url);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> redirectToDapp({
    required String topic,
    required Redirect? redirect,
  }) {
    return reOwnSign.redirectToDapp(
      topic: topic,
      redirect: redirect,
    );
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  @override
  IGenericStore<PendingSessionAuthRequest> get sessionAuthRequests =>
      reOwnSign.sessionAuthRequests;

  @override
  Event<SessionAuthRequest> get onSessionAuthRequest =>
      reOwnSign.onSessionAuthRequest;

  @override
  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  }) {
    try {
      return reOwnSign.approveSessionAuthenticate(
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
      return reOwnSign.rejectSessionAuthenticate(
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
      return reOwnSign.getPendingSessionAuthRequests();
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
      return reOwnSign.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  }) {
    try {
      return reOwnSign.validateSignedCacao(
        cacao: cacao,
        projectId: projectId,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  IGenericStore<AuthPublicKey> get authKeys => reOwnSign.authKeys;

  @override
  IGenericStore<String> get pairingTopics => reOwnSign.pairingTopics;
}
