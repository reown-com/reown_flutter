import 'package:reown_yttrium/clients/chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/i_chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/i_sui_client.dart';
import 'package:reown_yttrium/clients/sui_client.dart';
export 'utils/signature_utils.dart';

class ReownYttrium {
  IChainAbstractionClient get chainAbstractionClient =>
      ChainAbstractionClient();
  ISuiClient get suiClient => SuiClient();
}
