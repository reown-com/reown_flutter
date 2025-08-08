import 'package:reown_yttrium/clients/chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/i_chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/i_rust_sign_client.dart';
import 'package:reown_yttrium/clients/rust_sign_client.dart';

export 'utils/signature_utils.dart';
export 'models/chain_abstraction.dart';
export 'models/rust_sign_client.dart';
export 'models/shared.dart';

class ReownYttrium {
  IChainAbstractionClient get chainAbstractionClient =>
      ChainAbstractionClient();

  ISignClient get signClient => SignClient();
}
