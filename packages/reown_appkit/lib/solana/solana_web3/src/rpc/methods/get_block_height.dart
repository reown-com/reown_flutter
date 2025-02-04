/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_block_height_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Get Block Height
/// ------------------------------------------------------------------------------------------------

/// A method handler for `getBlockHeight`.
class GetBlockHeight extends JsonRpcTypeMethod<u64> {
  /// Creates a method handler for `getBlockHeight`.
  GetBlockHeight({
    final GetBlockHeightConfig? config,
  }) : super(
          'getBlockHeight',
          config: config ?? const GetBlockHeightConfig(),
        );
}
