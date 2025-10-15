import 'package:reown_yttrium/clients/chain_abstraction_client.dart';
import 'package:reown_yttrium/clients/ton_client.dart';

export 'models/chain_abstraction.dart';
export 'models/shared.dart';
export 'models/ton.dart';

export 'utils/signature_utils.dart';

class ReownYttrium {

  static final chainAbstractionClient = ChainAbstractionClient();

  static final tonClient = TonClient();

}
