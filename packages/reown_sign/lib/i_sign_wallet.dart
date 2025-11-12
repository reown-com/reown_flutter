import 'package:event/event.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/i_sign_common.dart';
import 'package:reown_sign/models/cacao_models.dart';
import 'package:reown_sign/models/basic_models.dart';
import 'package:reown_sign/models/proposal_models.dart';
import 'package:reown_sign/models/session_models.dart';
import 'package:reown_sign/models/sign_client_events.dart';
import 'package:reown_sign/models/sign_client_models.dart';
import 'package:reown_core/store/i_generic_store.dart';

import 'package:reown_sign/models/session_auth_models.dart';
import 'package:reown_sign/models/session_auth_events.dart';

abstract class IReownSignWallet extends IReownSignCommon {
  abstract final Event<SessionProposalEvent> onSessionProposal;
  abstract final Event<SessionProposalErrorEvent> onSessionProposalError;
  abstract final Event<SessionRequestEvent> onSessionRequest;

  abstract final Event<SessionAuthRequest> onSessionAuthRequest;
  abstract final IGenericStore<PendingSessionAuthRequest> sessionAuthRequests;

  Future<PairingInfo> pair({required Uri uri});
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
    ProposalRequestsResponses? proposalRequestsResponses,
  });
  Future<void> rejectSession({required int id, required ReownSignError reason});
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
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  });
  Map<String, SessionRequest> getPendingSessionRequests();

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

  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  });

  Future<void> rejectSessionAuthenticate({
    required int id,
    required ReownSignError reason,
  });

  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests();

  Future<bool> redirectToDapp({
    required String topic,
    required Redirect? redirect,
  });
}
