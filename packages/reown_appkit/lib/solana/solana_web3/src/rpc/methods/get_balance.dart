/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../../crypto/pubkey.dart';
import '../configs/get_balance_config.dart';
import '../interfaces/json_rpc_type_context_method.dart';

/// Get Balance
/// ------------------------------------------------------------------------------------------------

/// A method handler for `getBalance`.
class GetBalance extends JsonRpcTypeContextMethod<u64> {
  /// Creates a method handler for `GetBalance`.
  GetBalance(final Pubkey pubkey, {final GetBalanceConfig? config})
    : super(
        'getBalance',
        values: [pubkey.toBase58()],
        config: config ?? const GetBalanceConfig(),
      );
}
