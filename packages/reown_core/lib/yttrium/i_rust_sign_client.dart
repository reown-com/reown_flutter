import 'package:reown_core/models/rust_sign_client_models.dart';
import 'package:reown_core/reown_core.dart';

abstract class IRustSignClient {
  abstract Function(
    String topic,
    JsonRpcRequest payload, [
    TransportType transportType,
  ]) onSessionProposeRequest;

  abstract Function(
    String topic,
    JsonRpcRequest payload, [
    TransportType transportType,
  ]) onSessionRequest;

  Future<void> init();

  Future<SessionProposal> pair({required Uri uri});

  Future<ApproveResult> approve({
    required SessionProposalFfi proposal,
    required Map<String, Map<String, dynamic>> approvedNamespaces,
    required Map<String, dynamic> selfMetadata,
  });

  Future<bool> reject({
    required SessionProposalFfi proposal,
    required ErrorDataFfi error,
  });
}
