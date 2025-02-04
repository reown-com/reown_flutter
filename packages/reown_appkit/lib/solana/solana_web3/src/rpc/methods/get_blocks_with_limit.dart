/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_blocks_with_limit_config.dart';
import '../interfaces/json_rpc_list_type_method.dart';

/// Get Blocks With Limit
/// ------------------------------------------------------------------------------------------------

/// A codec for `getBlocksWithLimit` JSON RPC methods.
class GetBlocksWithLimit extends JsonRpcListTypeMethod<u64> {
  /// Creates a codec for `getBlocksWithLimit` JSON RPC methods.
  GetBlocksWithLimit(
    final u64 startSlot, {
    required final u64 limit,
    final GetBlocksWithLimitConfig? config,
  }) : super(
          'getBlocksWithLimit',
          values: [startSlot, limit],
          config: config ?? GetBlocksWithLimitConfig(),
        );
}
