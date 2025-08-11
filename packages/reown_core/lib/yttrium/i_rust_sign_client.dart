import 'package:event/event.dart';
import 'package:reown_core/models/rust_sign_client_models.dart';
import 'package:reown_core/reown_core.dart';

abstract class IRustSignClient {
  abstract final Event<YttriumSessionPropose> onYttriumSessionPropose;

  Future<void> init();

  Future<SessionProposal> pair({required Uri uri});

  Future<ApproveResult> approve({
    required SessionProposalFfi proposal,
    required Map<String, Map<String, dynamic>> approvedNamespaces,
    required Map<String, dynamic> selfMetadata,
  });
}
