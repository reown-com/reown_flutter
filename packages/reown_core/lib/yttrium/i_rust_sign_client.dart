import 'package:event/event.dart';
import 'package:reown_core/pairing/utils/pairing_models.dart';
import 'package:reown_core/yttrium/models/events.dart';
import 'package:reown_yttrium/models/rust_sign_client.dart';

abstract class IRustSignClient {
  abstract final Event<YttriumSessionPropose> onYttriumSessionPropose;

  Future<void> init();

  Future<PairingInfo> pair({required Uri uri});

  Future<ApproveResultFfi> approve({
    required SessionProposalFfi proposal,
    required Map<String, Map<String, dynamic>> approvedNamespaces,
    required Map<String, dynamic> selfMetadata,
  });
}
