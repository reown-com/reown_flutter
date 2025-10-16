/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_slot_leader_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Get Slot Leader
/// ------------------------------------------------------------------------------------------------

/// A codec for `getSlotLeader` JSON RPC methods.
class GetSlotLeader extends JsonRpcTypeMethod<String> {
  /// Creates a codec for `getSlotLeader` JSON RPC methods.
  GetSlotLeader({final GetSlotLeaderConfig? config})
    : super('getSlotLeader', config: config ?? const GetSlotLeaderConfig());
}
