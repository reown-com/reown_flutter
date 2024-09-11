import 'package:event/event.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/i_generic_store.dart';
import 'package:reown_sign/reown_sign.dart';

abstract class IReownSignClient {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IReownSign engine;

  // Common
  abstract final Event<SessionConnect> onSessionConnect;
  abstract final Event<SessionDelete> onSessionDelete;
  abstract final Event<SessionExpire> onSessionExpire;
  abstract final Event<SessionPing> onSessionPing;
  abstract final Event<SessionProposalEvent> onProposalExpire;

  abstract final IReownCore core;
  abstract final PairingMetadata metadata;
  abstract final IGenericStore<ProposalData> proposals;
  abstract final ISessions sessions;
  abstract final IGenericStore<SessionRequest> pendingRequests;

  abstract final IGenericStore<AuthPublicKey> authKeys;
  abstract final IGenericStore<String> pairingTopics;

  // Wallet
  abstract final Event<SessionProposalEvent> onSessionProposal;
  abstract final Event<SessionProposalErrorEvent> onSessionProposalError;
  abstract final Event<SessionRequestEvent> onSessionRequest;
  abstract final Event<SessionAuthRequest> onSessionAuthRequest;
  abstract final IGenericStore<PendingSessionAuthRequest> sessionAuthRequests;

  // App
  abstract final Event<SessionUpdate> onSessionUpdate;
  abstract final Event<SessionExtend> onSessionExtend;
  abstract final Event<SessionEvent> onSessionEvent;
  abstract final Event<SessionAuthResponse> onSessionAuthResponse;

  Future<void> init();
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods,
  });
  Future<PairingInfo> pair({
    required Uri uri,
  });
  Future<ApproveResponse> approve({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  });
  Future<void> reject({
    required int id,
    required ReownSignError reason,
  });
  Future<void> update({
    required String topic,
    required Map<String, Namespace> namespaces,
  });
  Future<void> extend({
    required String topic,
  });
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  });
  Future<void> respond({
    required String topic,
    required JsonRpcResponse response,
  });
  Future<void> emit({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  });
  Future<dynamic> request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  });
  Future<List<dynamic>> requestReadContract({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    EthereumAddress? sender,
    List<dynamic> parameters = const [],
  });
  Future<dynamic> requestWriteContract({
    required String topic,
    required String chainId,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    String? method,
    List<dynamic> parameters = const [],
  });

  void registerEventHandler({
    required String chainId,
    required String event,
    required dynamic Function(String, dynamic)? handler,
  });
  Future<void> ping({
    required String topic,
  });
  Future<void> disconnect({
    required String topic,
    required ReownSignError reason,
  });
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  });
  Map<String, SessionData> getActiveSessions();
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  });
  Map<String, ProposalData> getPendingSessionProposals();
  Map<String, SessionRequest> getPendingSessionRequests();
  abstract final IPairingStore pairings;

  /// Register event emitters for a given namespace or chainId
  /// Used to construct the Namespaces map for the session proposal
  void registerEventEmitter({
    required String chainId,
    required String event,
  });

  /// Register accounts for a given namespace or chainId.
  /// Used to construct the Namespaces map for the session proposal.
  /// Each account must follow the namespace:chainId:address format or this will throw an error.
  void registerAccount({
    required String chainId,
    required String accountAddress,
  });

  // FORMER AUTH ENGINE COMMON METHODS

  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  });

  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  });

  Future<void> rejectSessionAuthenticate({
    required int id,
    required ReownSignError reason,
  });

  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests();

  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? walletUniversalLink,
    String? pairingTopic,
    List<List<String>>? methods,
  });

  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  });

  Future<void> dispatchEnvelope(String url);

  Future<bool> redirectToDapp({
    required String topic,
    required Redirect? redirect,
  });

  Future<bool> redirectToWallet({
    required String topic,
    required Redirect? redirect,
  });
}
