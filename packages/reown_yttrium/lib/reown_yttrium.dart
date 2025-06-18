import 'package:reown_yttrium/clients/chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/i_chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/i_stacks_client.dart';
import 'package:reown_yttrium/clients/stacks_client.dart';
export 'utils/signature_utils.dart';

class ReownYttrium {
  IChainAbstractionClient get chainAbstractionClient =>
      ChainAbstractionClient();

  IStacksClient get stacksClient => StacksClient();
}
