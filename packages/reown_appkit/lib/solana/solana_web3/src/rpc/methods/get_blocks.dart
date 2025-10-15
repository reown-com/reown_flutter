/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_blocks_config.dart';
import '../interfaces/json_rpc_list_type_method.dart';

/// Get Blocks
/// ------------------------------------------------------------------------------------------------

/// A codec for `getBlocks` JSON RPC methods.
class GetBlocks extends JsonRpcListTypeMethod<u64> {
  /// Creates a codec for `getBlocks` JSON RPC methods.
  GetBlocks(
    final u64 startSlot, {
    final u64? endSlot,
    final GetBlocksConfig? config,
  }) : assert(endSlot == null || (endSlot - startSlot) <= 500000),
       super(
         'getBlocks',
         values: endSlot != null ? [startSlot, endSlot] : [startSlot],
         config: config ?? const GetBlocksConfig(),
       );
}
