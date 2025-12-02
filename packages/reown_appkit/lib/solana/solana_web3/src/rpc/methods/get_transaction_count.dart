/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_transaction_count_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Get Transaction Count
/// ------------------------------------------------------------------------------------------------

/// A codec for `getTransactionCount` JSON RPC methods.
class GetTransactionCount extends JsonRpcTypeMethod<u64> {
  /// Creates a codec for `getTransactionCount` JSON RPC methods.
  GetTransactionCount({final GetTransactionCountConfig? config})
    : super(
        'getTransactionCount',
        config: config ?? const GetTransactionCountConfig(),
      );
}
