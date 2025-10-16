/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../interfaces/json_rpc_method.dart';
import '../models/inflation_rate.dart';

/// Get Inflation Rate
/// ------------------------------------------------------------------------------------------------

/// A codec for `getInflationRate` JSON RPC methods.
class GetInflationRate
    extends JsonRpcMethod<Map<String, dynamic>, InflationRate> {
  /// Creates a codec for `getInflationRate` JSON RPC methods.
  GetInflationRate() : super('getInflationRate');

  @override
  InflationRate decoder(final Map<String, dynamic> value) =>
      InflationRate.fromJson(value);
}
