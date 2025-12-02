/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_block_config.dart';
import '../interfaces/json_rpc_method.dart';
import '../models/block.dart';

/// Get Block
/// ------------------------------------------------------------------------------------------------

/// A method handler for `getBlock`.
class GetBlock extends JsonRpcMethod<Map<String, dynamic>?, Block?> {
  /// Creates a method handler for `getBlock`.
  GetBlock(final u64 slot, {final GetBlockConfig? config})
    : super('getBlock', values: [slot], config: config ?? GetBlockConfig());

  @override
  Block? decoder(final Map<String, dynamic>? value) =>
      value != null ? Block.fromJson(value) : null;
}
