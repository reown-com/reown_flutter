/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../configs/get_token_account_balance_config.dart';
import '../interfaces/json_rpc_context_method.dart';
import '../models/token_amount.dart';

/// Get Token Account Balance
/// ------------------------------------------------------------------------------------------------

/// A codec for `getTokenAccountBalance` JSON RPC methods.
class GetTokenAccountBalance
    extends JsonRpcContextMethod<Map<String, dynamic>, TokenAmount> {
  /// Creates a codec for `getTokenAccountBalance` JSON RPC methods.
  GetTokenAccountBalance(
    final Pubkey account, {
    final GetTokenAccountBalanceConfig? config,
  }) : super(
         'getTokenAccountBalance',
         values: [account.toBase58()],
         config: config ?? const GetTokenAccountBalanceConfig(),
       );

  @override
  TokenAmount valueDecoder(final Map<String, dynamic> value) =>
      TokenAmount.fromJson(value);
}
