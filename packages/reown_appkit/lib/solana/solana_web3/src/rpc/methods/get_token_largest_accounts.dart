/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../configs/get_token_largest_accounts_config.dart';
import '../interfaces/json_rpc_list_context_method.dart';
import '../models/token_amount.dart';

/// Get Token Largest Accounts
/// ------------------------------------------------------------------------------------------------

/// A codec for `getTokenLargestAccounts` JSON RPC methods.
class GetTokenLargestAccounts
    extends JsonRpcListContextMethod<Map<String, dynamic>, TokenAmount> {
  /// Creates a codec for `getTokenLargestAccounts` JSON RPC methods.
  GetTokenLargestAccounts(
    final Pubkey mint, {
    final GetTokenLargestAccountsConfig? config,
  }) : super(
          'getTokenLargestAccounts',
          values: [mint.toBase58()],
          config: config ?? const GetTokenLargestAccountsConfig(),
        );

  @override
  TokenAmount itemDecoder(
    final Map<String, dynamic> item,
  ) =>
      TokenAmount.fromJson(item);
}
