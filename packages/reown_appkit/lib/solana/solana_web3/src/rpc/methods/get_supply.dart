/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_supply_config.dart';
import '../interfaces/json_rpc_context_method.dart';
import '../models/supply.dart';

/// Get Supply
/// ------------------------------------------------------------------------------------------------

/// A codec for `getSupply` JSON RPC methods.
class GetSupply extends JsonRpcContextMethod<Map<String, dynamic>, Supply> {
  /// Creates a codec for `getSupply` JSON RPC methods.
  GetSupply({final GetSupplyConfig? config})
    : super('getSupply', config: config ?? const GetSupplyConfig());

  @override
  Supply valueDecoder(final Map<String, dynamic> value) =>
      Supply.fromJson(value);
}
