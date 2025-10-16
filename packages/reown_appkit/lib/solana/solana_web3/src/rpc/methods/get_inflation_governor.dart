/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_inflation_governor_config.dart';
import '../interfaces/json_rpc_method.dart';
import '../models/inflation_governor.dart';

/// Get Inflation Governor
/// ------------------------------------------------------------------------------------------------

/// A codec for `getInflationGovernor` JSON RPC methods.
class GetInflationGovernor
    extends JsonRpcMethod<Map<String, dynamic>, InflationGovernor> {
  /// Creates a codec for `getInflationGovernor` JSON RPC methods.
  GetInflationGovernor({final GetInflationGovernorConfig? config})
    : super(
        'getInflationGovernor',
        config: config ?? const GetInflationGovernorConfig(),
      );

  @override
  InflationGovernor decoder(final Map<String, dynamic> value) =>
      InflationGovernor.fromJson(value);
}
