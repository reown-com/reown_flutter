import 'package:reown_yttrium/clients/chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/i_chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/i_rust_sign_client.dart';
import 'package:reown_yttrium/clients/rust_sign_client.dart';

export 'utils/signature_utils.dart';
export 'clients/models/chain_abstraction.dart';
export 'clients/models/rust_sign_client.dart';
export 'clients/models/shared.dart';

class ReownYttrium {
  ReownYttrium._internal();

  static final _instance = ReownYttrium._internal();
  factory ReownYttrium() => _instance;

  // TODO remove CA
  final _chainAbstractionClient = ChainAbstractionClient();
  IChainAbstractionClient get chainAbstractionClient => _chainAbstractionClient;

  final _signClient = SignClient();
  ISignClient get signClient => _signClient;
}
