/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'get_account_info_config.dart';

/// Get Nonce Account Config
/// ------------------------------------------------------------------------------------------------

/// JSON RPC configurations for `getNonceAccount` methods.
class GetNonceAccountConfig extends GetAccountInfoConfig {
  GetNonceAccountConfig({
    super.commitment,
    super.minContextSlot,
  });
}
