/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../configs/get_token_accounts_by_delegate_config.dart';
import '../interfaces/json_rpc_list_context_method.dart';
import '../models/token_account.dart';
import '../models/token_accounts_filter.dart';

/// Get Token Accounts By Delegate
/// ------------------------------------------------------------------------------------------------

/// A codec for `getTokenAccountsByDelegate` JSON RPC methods.
class GetTokenAccountsByDelegate
    extends JsonRpcListContextMethod<Map<String, dynamic>, TokenAccount> {
  /// Creates a codec for `getTokenAccountsByDelegate` JSON RPC methods.
  GetTokenAccountsByDelegate(
    final Pubkey pubkey, {
    required final TokenAccountsFilter filter,
    final GetTokenAccountsByDelegateConfig? config,
  }) : super(
          'getTokenAccountsByDelegate',
          values: [pubkey.toBase58(), filter.toJson()],
          config: config ?? GetTokenAccountsByDelegateConfig(),
        );

  @override
  TokenAccount itemDecoder(
    final Map<String, dynamic> item,
  ) =>
      TokenAccount.fromJson(item);
}
