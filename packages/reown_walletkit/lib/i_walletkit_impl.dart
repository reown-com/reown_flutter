import 'package:reown_walletkit/reown_walletkit.dart';

abstract class IReownSignCommon {
  // abstract final Event<SessionConnect> onSessionConnect;
  // abstract final Event<SessionDelete> onSessionDelete;
  // abstract final Event<SessionExpire> onSessionExpire;
  // abstract final Event<SessionPing> onSessionPing;
  // abstract final Event<SessionProposalEvent> onProposalExpire;

  // abstract final IReownCore core;
  abstract final PairingMetadata metadata;
  // abstract final IGenericStore<ProposalData> proposals;
  // abstract final ISessions sessions;
  // abstract final IGenericStore<SessionRequest> pendingRequests;

  // abstract final IGenericStore<AuthPublicKey> authKeys;
  // abstract final IPairingStore pairings;
  // abstract final IGenericStore<String> pairingTopics;

  abstract final String projectId;

  Future<void> init();
  Future<void> disconnectSession({
    required String topic,
    required ReownSignError reason,
  });
  Future<Map<String, SessionData>> getActiveSessions();
  Future<Map<String, SessionData>> getSessionsForPairing({
    required String pairingTopic,
  });
  Future<Map<String, ProposalData>> getPendingSessionProposals();

  Future<String> formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  });

  // Future<bool> validateSignedCacao({
  //   required Cacao cacao,
  //   required String projectId,
  // });

  Future<void> dispatchEnvelope(String url);
}

abstract class IReownSignWallet extends IReownSignCommon {
  // abstract final Event<SessionProposalEvent> onSessionProposal;
  // abstract final Event<SessionProposalErrorEvent> onSessionProposalError;
  // abstract final Event<SessionRequestEvent> onSessionRequest;

  // abstract final Event<SessionAuthRequest> onSessionAuthRequest;
  // abstract final IGenericStore<PendingSessionAuthRequest> sessionAuthRequests;

  Future<PairingInfo> pair({required Uri uri});
  Future<bool> approveSession({
    required String proposalPublicKey,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    Map<String, String>? scopedProperties,
  });
  Future<bool> rejectSession({
    required String proposalPublicKey,
    required ReownSignError reason,
  });
  Future<void> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  });
  Future<void> extendSession({required String topic});
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  });
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  });
  Future<void> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  });
  // SessionData? find({
  //   required Map<String, RequiredNamespace> requiredNamespaces,
  // });
  Future<Map<String, SessionRequest>> getPendingSessionRequests({
    required String topic,
  });

  /// Register event emitters for a given namespace or chainId
  /// Used to construct the Namespaces map for the session proposal
  void registerEventEmitter({required String chainId, required String event});

  /// Register accounts for a given namespace or chainId.
  /// Used to construct the Namespaces map for the session proposal.
  /// Each account must follow the namespace:chainId:address format or this will throw an error.
  void registerAccount({
    required String chainId,
    required String accountAddress,
  });

  Future<bool> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  });

  Future<void> rejectSessionAuthenticate({
    required int id,
    required ReownSignError reason,
  });

  // Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests();

  // Future<bool> redirectToDapp({
  //   required String topic,
  //   required Redirect? redirect,
  // });
}

abstract class IReownWalletKit implements IReownSignWallet {
  final String protocol = 'wc';
  final int version = 2;

  // abstract final IReownSign reOwnSign;

  Future<Map<String, SessionData>> getActiveSessionByTopic({
    required String sessionTopic,
  });
}
