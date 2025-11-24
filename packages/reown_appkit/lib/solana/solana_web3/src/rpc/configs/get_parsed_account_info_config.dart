/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../encodings/account_encoding.dart';
import 'get_account_info_config.dart';

/// Get Parsed Account Info Config
/// ------------------------------------------------------------------------------------------------

class GetParsedAccountInfoConfig extends GetAccountInfoConfig {
  /// JSON RPC configurations for `getParsedAccountInfo` methods.
  GetParsedAccountInfoConfig({super.commitment, super.minContextSlot})
    : super(encoding: AccountEncoding.jsonParsed);
}
