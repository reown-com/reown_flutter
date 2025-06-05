import 'package:reown_yttrium/clients/chain_abstraction.dart';
import 'package:reown_yttrium/clients/i_chain_abstraction.dart';
export 'utils/signature_utils.dart';

class ReownYttrium {
  IChainAbstractionClient get chainAbstractionClient =>
      ChainAbstractionClient();
}
