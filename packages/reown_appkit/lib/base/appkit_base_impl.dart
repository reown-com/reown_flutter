import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_core/relay_client/websocket/http_client.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_core/store/i_generic_store.dart';

/// Base class that containes Core and SIgn used dapps developers to create UI-less interaction with WalletConnect protocol
class ReownAppKit implements IReownAppKit {
  ///
  static const List<List<String>> DEFAULT_METHODS = [
    [
      MethodConstants.WC_SESSION_PROPOSE,
      MethodConstants.WC_SESSION_REQUEST,
    ],
    // [
    //   // Deprecated method but still supported for retrocompatibility
    //   MethodConstants.WC_AUTH_REQUEST,
    // ]
  ];

  bool _initialized = false;

  /// Creates a instance of ReownAppKit to be used alone or to pass to ReownAppKitModal
  static Future<ReownAppKit> createInstance({
    required String projectId,
    String relayUrl = ReownConstants.DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
    LogLevel logLevel = LogLevel.nothing,
    HttpWrapper httpClient = const HttpWrapper(),
  }) async {
    final client = ReownAppKit(
      core: ReownCore(
        projectId: projectId,
        relayUrl: relayUrl,
        memoryStore: memoryStore,
        logLevel: logLevel,
        httpClient: httpClient,
      ),
      metadata: metadata,
    );
    await client.init();

    return client;
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

  ///
  ReownAppKit({
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

  ///---------- SIGN ENGINE ----------///

  @override
  late IReownSign reOwnSign;

  @override
  Event<SessionConnect> get onSessionConnect => reOwnSign.onSessionConnect;

  @override
  Event<SessionEvent> get onSessionEvent => reOwnSign.onSessionEvent;

  @override
  Event<SessionExpire> get onSessionExpire => reOwnSign.onSessionExpire;

  @override
  Event<SessionProposalEvent> get onProposalExpire =>
      reOwnSign.onProposalExpire;

  @override
  Event<SessionExtend> get onSessionExtend => reOwnSign.onSessionExtend;

  @override
  Event<SessionPing> get onSessionPing => reOwnSign.onSessionPing;

  @override
  Event<SessionUpdate> get onSessionUpdate => reOwnSign.onSessionUpdate;

  @override
  Event<SessionDelete> get onSessionDelete => reOwnSign.onSessionDelete;

  @override
  IGenericStore<ProposalData> get proposals => reOwnSign.proposals;

  @override
  ISessions get sessions => reOwnSign.sessions;

  @override
  IGenericStore<SessionRequest> get pendingRequests =>
      reOwnSign.pendingRequests;

  @override
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods = DEFAULT_METHODS,
  }) async {
    try {
      return await reOwnSign.connect(
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
  Future<dynamic> request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    try {
      return await reOwnSign.request(
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
      return await reOwnSign.requestReadContract(
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
    String? method,
    List parameters = const [],
  }) async {
    try {
      return await reOwnSign.requestWriteContract(
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
  void registerEventHandler({
    required String chainId,
    required String event,
    void Function(String, dynamic)? handler,
  }) {
    try {
      return reOwnSign.registerEventHandler(
        chainId: chainId,
        event: event,
        handler: handler,
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
      return await reOwnSign.ping(topic: topic);
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
  Future<void> dispatchEnvelope(String url) async {
    try {
      return await reOwnSign.dispatchEnvelope(url);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> redirectToWallet({
    required String topic,
    required Redirect? redirect,
  }) {
    return reOwnSign.redirectToWallet(
      topic: topic,
      redirect: redirect,
    );
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  @override
  Event<SessionAuthResponse> get onSessionAuthResponse =>
      reOwnSign.onSessionAuthResponse;

  @override
  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? pairingTopic,
    String? walletUniversalLink,
    List<List<String>>? methods = const [
      [MethodConstants.WC_SESSION_AUTHENTICATE]
    ],
  }) async {
    try {
      return reOwnSign.authenticate(
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
  IGenericStore<AuthPublicKey> get authKeys => reOwnSign.authKeys;

  @override
  IGenericStore<String> get pairingTopics => reOwnSign.pairingTopics;
}
