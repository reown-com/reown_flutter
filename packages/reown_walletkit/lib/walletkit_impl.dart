import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:reown_sign/utils/sign_api_validator_utils.dart';
import 'package:reown_walletkit/models/platform_models.dart';

import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/reown_walletkit_platform_interface.dart';
import 'package:reown_walletkit/utils/walletkit_utils.dart';

class ReownWalletKit with WidgetsBindingObserver implements IReownWalletKit {
  //implements IReownWalletKit
  bool _initialized = false;

  // static Future<ReownWalletKit> createInstance({
  //   required String projectId,
  //   String relayUrl = ReownConstants.DEFAULT_RELAY_URL,
  //   String pushUrl = ReownConstants.DEFAULT_PUSH_URL,
  //   required PairingMetadata metadata,
  //   bool memoryStore = false,
  //   LogLevel logLevel = LogLevel.nothing,
  //   IHttpClient httpClient = const HttpWrapper(),
  // }) async {
  //   final walletKit = ReownWalletKit(
  //     core: ReownCore(
  //       projectId: projectId,
  //       relayUrl: relayUrl,
  //       pushUrl: pushUrl,
  //       memoryStore: memoryStore,
  //       logLevel: logLevel,
  //       httpClient: httpClient,
  //     ),
  //     metadata: metadata,
  //   );
  //   await walletKit.init();

  //   return walletKit;
  // }

  ///---------- GENERIC ----------///

  @override
  final String protocol = 'wc';

  @override
  final int version = 2;

  // @override
  // final IReownCore core;

  @override
  final PairingMetadata metadata;

  @override
  final String projectId;

  final _platformWalletKit = ReownWalletkitPlatform.instance;

  ReownWalletKit({required this.projectId, required this.metadata});
  // {
  // reOwnSign = ReownSign(
  //   core: core,
  //   metadata: metadata,
  //   proposals: GenericStore(
  //     storage: core.storage,
  //     context: StoreVersions.CONTEXT_PROPOSALS,
  //     version: StoreVersions.VERSION_PROPOSALS,
  //     fromJson: (dynamic value) {
  //       return ProposalData.fromJson(value);
  //     },
  //   ),
  //   sessions: Sessions(
  //     storage: core.storage,
  //     context: StoreVersions.CONTEXT_SESSIONS,
  //     version: StoreVersions.VERSION_SESSIONS,
  //     fromJson: (dynamic value) {
  //       return SessionData.fromJson(value);
  //     },
  //   ),
  //   pendingRequests: GenericStore(
  //     storage: core.storage,
  //     context: StoreVersions.CONTEXT_PENDING_REQUESTS,
  //     version: StoreVersions.VERSION_PENDING_REQUESTS,
  //     fromJson: (dynamic value) {
  //       return SessionRequest.fromJson(value);
  //     },
  //   ),
  //   authKeys: GenericStore(
  //     storage: core.storage,
  //     context: StoreVersions.CONTEXT_AUTH_KEYS,
  //     version: StoreVersions.VERSION_AUTH_KEYS,
  //     fromJson: (dynamic value) {
  //       return AuthPublicKey.fromJson(value);
  //     },
  //   ),
  //   pairingTopics: GenericStore(
  //     storage: core.storage,
  //     context: StoreVersions.CONTEXT_PAIRING_TOPICS,
  //     version: StoreVersions.VERSION_PAIRING_TOPICS,
  //     fromJson: (dynamic value) {
  //       return value;
  //     },
  //   ),
  //   sessionAuthRequests: GenericStore(
  //     storage: core.storage,
  //     context: StoreVersions.CONTEXT_AUTH_REQUESTS,
  //     version: StoreVersions.VERSION_AUTH_REQUESTS,
  //     fromJson: (dynamic value) {
  //       return PendingSessionAuthRequest.fromJson(value);
  //     },
  //   ),
  // );
  // }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    // await core.start();
    // await reOwnSign.init();
    _initialized = await _platformWalletKit.initialize(
      projectId: projectId,
      metadata: metadata.toJson(),
    );
    _platformWalletKit.initEventChannel();
    _platformWalletKit.eventStream.listen(_onPlatformEvent);

    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _onPlatformEvent(dynamic event) async {
    debugPrint('[$runtimeType] onPlatformEvent ${jsonEncode(event)}');
    try {
      final parsedEvent = WalletKitUtils.handlePlatformResult(event);
      final eventMap = parsedEvent as Map<String, dynamic>;
      if (eventMap.containsKey('event')) {
        final eventName = eventMap['event'].toString();
        switch (eventName) {
          case 'on_session_proposal':
            final data = PlatformSessionProposal.fromJson(eventMap['data']);
            // data.proposerPublicKey
            final verifyContext = eventMap['verifyContext'];
            final id = verifyContext['id'] as int;
            onSessionProposal.broadcast(
              SessionProposalEvent(
                id,
                data.toProposalData(id, _accounts, _eventEmitters, _methods),
                VerifyContext.fromJson(verifyContext),
              ),
            );
            break;
          case 'on_session_settle_response':
            final data = PlatformSessionSettle.fromJson(eventMap['data']);
            final pendingProposals = await getPendingSessionProposals();
            debugPrint(
              '[$runtimeType] pending proposal: ${jsonEncode(pendingProposals.values.first.toJson())}',
            );
            // onSessionConnect.broadcast(sessionData);
            break;
          default:
        }
      }
    } catch (e, s) {
      debugPrint('[$runtimeType] onPlatformEvent error: $e');
      debugPrint('[$runtimeType] onPlatformEvent error: $s');
    }
  }

  @override
  Future<PairingInfo> pair({required Uri uri}) async {
    try {
      final result = await _platformWalletKit.pair(uri: uri.toString());
      final parsedUri = WalletKitUtils.parseUri(Uri.parse(result));
      final pairingInfo = PairingInfo(
        topic: parsedUri.topic,
        expiry: parsedUri.expiry,
        relay: parsedUri.v2Data!.relay,
        active: false,
        methods: parsedUri.v2Data!.methods,
      );
      return pairingInfo;
    } catch (e) {
      rethrow;
    }
  }

  ///---------- SIGN ENGINE ----------///

  // @override
  // late final IReownSign reOwnSign;

  @override
  final onSessionConnect = Event<SessionConnect>();

  // @override
  // Event<SessionDelete> get onSessionDelete => reOwnSign.onSessionDelete;

  // @override
  // Event<SessionExpire> get onSessionExpire => reOwnSign.onSessionExpire;

  @override
  final onSessionProposal = Event<SessionProposalEvent>();

  // @override
  // Event<SessionProposalErrorEvent> get onSessionProposalError =>
  //     reOwnSign.onSessionProposalError;

  // @override
  // Event<SessionProposalEvent> get onProposalExpire =>
  //     reOwnSign.onProposalExpire;

  // @override
  // Event<SessionRequestEvent> get onSessionRequest => reOwnSign.onSessionRequest;

  // @override
  // Event<SessionPing> get onSessionPing => reOwnSign.onSessionPing;

  // @override
  // IGenericStore<ProposalData> get proposals => reOwnSign.proposals;

  // @override
  // ISessions get sessions => reOwnSign.sessions;

  // @override
  // IGenericStore<SessionRequest> get pendingRequests =>
  //     reOwnSign.pendingRequests;

  @override
  Future<bool> approveSession({
    required String proposalPublicKey,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    Map<String, String>? scopedProperties,
  }) async {
    return await _platformWalletKit.approveSession(
      proposalPublicKey: proposalPublicKey,
      namespaces: namespaces.map((key, value) => MapEntry(key, value.toJson())),
      sessionProperties: sessionProperties,
      scopedProperties: scopedProperties,
    );
  }

  @override
  Future<bool> rejectSession({
    required String proposalPublicKey,
    required ReownSignError reason,
  }) async {
    try {
      return await _platformWalletKit.rejectSession(
        proposalPublicKey: proposalPublicKey,
        rejectionReason: reason.message,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    try {
      return await _platformWalletKit.updateSession(
        topic: topic,
        namespaces: namespaces.map(
          (key, value) => MapEntry(key, value.toJson()),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> extendSession({required String topic}) async {
    try {
      return await _platformWalletKit.extendSession(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // void registerRequestHandler({
  //   required String chainId,
  //   required String method,
  //   dynamic Function(String, dynamic)? handler,
  // }) {
  //   try {
  //     return reOwnSign.registerRequestHandler(
  //       chainId: chainId,
  //       method: method,
  //       handler: handler,
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<bool> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  }) {
    try {
      return _platformWalletKit.respondSessionRequest(
        topic: topic,
        response: {
          'id': response.id,
          'jsonrpc': response.jsonrpc,
          if (response.error != null) 'error': response.error!.toJson(),
          if (response.result != null) 'result': response.result,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // void registerEventEmitter({required String chainId, required String event}) {
  //   try {
  //     return reOwnSign.registerEventEmitter(chainId: chainId, event: event);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // void registerAccount({
  //   required String chainId,
  //   required String accountAddress,
  // }) {
  //   try {
  //     return reOwnSign.registerAccount(
  //       chainId: chainId,
  //       accountAddress: accountAddress,
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<bool> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    try {
      return await _platformWalletKit.emitSessionEvent(
        topic: topic,
        chainId: chainId,
        name: event.name,
        data: event.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> disconnectSession({
    required String topic,
    required ReownSignError reason,
  }) async {
    try {
      return await _platformWalletKit.disconnectSession(
        topic: topic,
        disconnectReason: reason.message,
      );
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // SessionData? find({
  //   required Map<String, RequiredNamespace> requiredNamespaces,
  // }) {
  //   try {
  //     return reOwnSign.find(requiredNamespaces: requiredNamespaces);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // TODO should just return a List of SessionData?
  @override
  Future<Map<String, SessionData>> getActiveSessions() async {
    try {
      final response = await _platformWalletKit.getListOfActiveSessions();
      Map<String, SessionData> pairingSessions = {};
      for (var s in response) {
        final session = SessionData.fromJson(s);
        pairingSessions[session.topic] = session;
      }
      return pairingSessions;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, SessionData>> getActiveSessionByTopic({
    required String sessionTopic,
  }) async {
    try {
      final response = await _platformWalletKit.getActiveSessionByTopic(
        topic: sessionTopic,
      );
      Map<String, SessionData> pairingSessions = {};
      for (var s in response) {
        final session = SessionData.fromJson(s);
        pairingSessions[session.topic] = session;
      }
      return pairingSessions;
    } catch (e) {
      rethrow;
    }
  }

  // TODO should just return a List of SessionData?
  @override
  Future<Map<String, SessionData>> getSessionsForPairing({
    required String pairingTopic,
  }) async {
    try {
      final response = await getActiveSessions();
      Map<String, SessionData> pairingSessions = {};
      for (var session in response.values) {
        // final session = SessionData.fromJson(s);
        if (session.pairingTopic == pairingTopic) {
          pairingSessions[session.topic] = session;
        }
      }
      return pairingSessions;
    } catch (e) {
      rethrow;
    }
  }

  // TODO should just return a List of ProposalData?
  @override
  Future<Map<String, ProposalData>> getPendingSessionProposals() async {
    try {
      final response = await _platformWalletKit.getSessionProposals();
      Map<String, ProposalData> pendingProposals = {};
      for (var p in response) {
        pendingProposals[p['id'].toString()] = ProposalData.fromJson(p);
      }
      return pendingProposals;
    } catch (e) {
      rethrow;
    }
  }

  // TODO should just return a List of SessionRequest?
  @override
  Future<Map<String, SessionRequest>> getPendingSessionRequests({
    required String topic,
  }) async {
    try {
      final response = await _platformWalletKit.getPendingListOfSessionRequests(
        topic: topic,
      );
      Map<String, SessionRequest> requests = {};
      for (var r in response) {
        requests[r['id'].toString()] = SessionRequest.fromJson(r);
      }
      return requests;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> dispatchEnvelope(String url) async {
    try {
      return await _platformWalletKit.dispatchEnvelope(uri: url);
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<bool> redirectToDapp({
  //   required String topic,
  //   required Redirect? redirect,
  // }) {
  //   return reOwnSign.redirectToDapp(topic: topic, redirect: redirect);
  // }

  // @override
  // IPairingStore get pairings => core.pairing.getStore();

  // @override
  // IGenericStore<PendingSessionAuthRequest> get sessionAuthRequests =>
  //     reOwnSign.sessionAuthRequests;

  // @override
  // Event<SessionAuthRequest> get onSessionAuthRequest =>
  //     reOwnSign.onSessionAuthRequest;

  @override
  Future<bool> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  }) {
    try {
      return _platformWalletKit.approveSessionAuthenticate(
        id: id,
        auths: auths?.map((e) => e.toJson()).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> rejectSessionAuthenticate({
    required int id,
    required ReownSignError reason,
  }) {
    try {
      return _platformWalletKit.rejectSessionAuthenticate(
        id: id,
        rejectionReason: reason.message,
      );
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests() {
  //   try {
  //     return reOwnSign.getPendingSessionAuthRequests();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<String> formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  }) async {
    try {
      return await _platformWalletKit.formatAuthMessage(
        issuer: iss,
        cacaoPayload: cacaoPayload.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<bool> validateSignedCacao({
  //   required Cacao cacao,
  //   required String projectId,
  // }) {
  //   try {
  //     return reOwnSign.validateSignedCacao(cacao: cacao, projectId: projectId);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // IGenericStore<AuthPublicKey> get authKeys => reOwnSign.authKeys;

  // @override
  // IGenericStore<String> get pairingTopics => reOwnSign.pairingTopics;

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.resumed) {
  //     if (!core.relayClient.isConnected) {
  //       await core.relayClient.connect();
  //     }
  //   }
  // }

  final Set<String> _accounts = {};

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

  /// Maps a request using chainId:method to its handler
  final Map<String, dynamic Function(String, dynamic)?> _methodHandlers = {};
  Set<String> get _methods => _methodHandlers.keys.toSet();

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  }) {
    _methodHandlers[_getRegisterKey(chainId, method)] = handler;
  }

  final Set<String> _eventEmitters = {};

  @override
  void registerEventEmitter({required String chainId, required String event}) {
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

  String _getRegisterKey(String chainId, String value) {
    return '$chainId:$value';
  }
}
