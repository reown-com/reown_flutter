import 'package:reown_yttrium_utils/clients/chain_abstraction_client.dart';
import 'package:reown_yttrium_utils/clients/stacks_client.dart';
import 'package:reown_yttrium_utils/clients/sui_client.dart';
import 'package:reown_yttrium_utils/clients/ton_client.dart';

export 'models/chain_abstraction.dart';
export 'models/shared.dart';
export 'models/ton.dart';
export 'models/stacks.dart';

export 'utils/signature_utils.dart';

class ReownYttriumUtils {
  static final chainAbstractionClient = ChainAbstractionClient();
  static final tonClient = TonClient();
  static final stacksClient = StacksClient();
  static final suiClient = SuiClient();
}
