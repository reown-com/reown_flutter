import 'package:event/event.dart';
import 'package:reown_core/reown_core.dart';

class YttriumSessionPropose extends EventArgs {
  String pairingTopic;
  SessionProposalFfi proposal;

  YttriumSessionPropose(
    this.pairingTopic,
    this.proposal,
  );
}
