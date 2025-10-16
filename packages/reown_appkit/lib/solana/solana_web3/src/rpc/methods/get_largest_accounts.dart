/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_largest_accounts_config.dart';
import '../interfaces/json_rpc_list_context_method.dart';
import '../models/large_account.dart';

/// Get Largest Accounts
/// ------------------------------------------------------------------------------------------------

/// A codec for `getLargestAccounts` JSON RPC methods.
class GetLargestAccounts
    extends JsonRpcListContextMethod<Map<String, dynamic>, LargeAccount> {
  /// Creates a codec for `getLargestAccounts` JSON RPC methods.
  GetLargestAccounts({final GetLargestAccountsConfig? config})
    : super(
        'getLargestAccounts',
        config: config ?? const GetLargestAccountsConfig(),
      );

  @override
  LargeAccount itemDecoder(final Map<String, dynamic> item) =>
      LargeAccount.fromJson(item);
}
