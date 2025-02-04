/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../interfaces/json_rpc_method.dart';
import '../models/epoch_schedule.dart';

/// Get Epoch Schedule
/// ------------------------------------------------------------------------------------------------

/// A codec for `getEpochSchedule` JSON RPC methods.
class GetEpochSchedule
    extends JsonRpcMethod<Map<String, dynamic>, EpochSchedule> {
  /// Creates a codec for `getEpochSchedule` JSON RPC methods.
  GetEpochSchedule() : super('getEpochSchedule');

  @override
  EpochSchedule decoder(final Map<String, dynamic> value) =>
      EpochSchedule.fromJson(value);
}
