/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show i64, u64;
import '../interfaces/json_rpc_type_method.dart';

/// Get Block Time
/// ------------------------------------------------------------------------------------------------

/// A codec for `getBlockTime` JSON RPC methods.
class GetBlockTime extends JsonRpcTypeMethod<i64?> {
  /// Creates a codec for `getBlockTime` JSON RPC methods.
  GetBlockTime(
    final u64 block,
  ) : super(
          'getBlockTime',
          values: [block],
        );
}
