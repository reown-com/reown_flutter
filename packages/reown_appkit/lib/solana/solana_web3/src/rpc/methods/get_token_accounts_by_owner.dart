/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../configs/get_token_accounts_by_owner_config.dart';
import '../interfaces/json_rpc_list_context_method.dart';
import '../models/token_account.dart';
import '../models/token_accounts_filter.dart';

/// Get Token Accounts By Owner
/// ------------------------------------------------------------------------------------------------

/// A codec for `getTokenAccountsByOwner` JSON RPC methods.
class GetTokenAccountsByOwner
    extends JsonRpcListContextMethod<Map<String, dynamic>, TokenAccount> {
  /// Creates a codec for `getTokenAccountsByOwner` JSON RPC methods.
  GetTokenAccountsByOwner(
    final Pubkey pubkey, {
    required final TokenAccountsFilter filter,
    final GetTokenAccountsByOwnerConfig? config,
  }) : super(
          'getTokenAccountsByOwner',
          values: [pubkey.toBase58(), filter.toJson()],
          config: config ?? GetTokenAccountsByOwnerConfig(),
        );

  @override
  TokenAccount itemDecoder(
    final Map<String, dynamic> item,
  ) =>
      TokenAccount.fromJson(item);
}
