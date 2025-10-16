/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../configs/get_account_info_config.dart';
import '../interfaces/json_rpc_context_method.dart';
import '../models/account_info.dart';

/// Get Account Info
/// ------------------------------------------------------------------------------------------------

/// A method handler for `getAccountInfo`.
class GetAccountInfo<T>
    extends JsonRpcContextMethod<Map<String, dynamic>?, AccountInfo<T>?> {
  /// Creates a method handler for `getAccountInfo`.
  GetAccountInfo(final Pubkey pubkey, {final GetAccountInfoConfig? config})
    : super(
        'getAccountInfo',
        values: [pubkey.toBase58()],
        config: config ?? GetAccountInfoConfig(),
      );

  @override
  AccountInfo<T>? valueDecoder(final Map<String, dynamic>? value) =>
      value != null ? AccountInfo.fromJson(value) : null;
}
