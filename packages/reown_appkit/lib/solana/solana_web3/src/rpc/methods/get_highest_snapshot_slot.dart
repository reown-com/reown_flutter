/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../interfaces/json_rpc_method.dart';
import '../models/highest_snapshot_slot.dart';

/// Get Highest Snapshot Slot
/// ------------------------------------------------------------------------------------------------

/// A codec for `getHighestSnapshotSlot` JSON RPC methods.
class GetHighestSnapshotSlot
    extends JsonRpcMethod<Map<String, dynamic>, HighestSnapshotSlot> {
  /// Creates a codec for `getHighestSnapshotSlot` JSON RPC methods.
  GetHighestSnapshotSlot() : super('getHighestSnapshotSlot');

  @override
  HighestSnapshotSlot decoder(
    final Map<String, dynamic> value,
  ) =>
      HighestSnapshotSlot.fromJson(value);
}
