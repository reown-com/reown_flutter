/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_block_production_config.dart';
import '../interfaces/json_rpc_context_method.dart';
import '../models/block_production.dart';

/// Get Block Production
/// ------------------------------------------------------------------------------------------------

/// A codec for `getBlockProduction` JSON RPC methods.
class GetBlockProduction
    extends JsonRpcContextMethod<Map<String, dynamic>, BlockProduction> {
  /// Creates a codec for `getBlockProduction` JSON RPC methods.
  GetBlockProduction({final GetBlockProductionConfig? config})
    : super(
        'getBlockProduction',
        config: config ?? const GetBlockProductionConfig(),
      );

  @override
  BlockProduction valueDecoder(final Map<String, dynamic> value) =>
      BlockProduction.fromJson(value);
}
