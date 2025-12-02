/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_leader_schedule_config.dart';
import '../interfaces/json_rpc_method.dart';
import '../models/leader_schedule.dart';

/// Get Leader Schedule
/// ------------------------------------------------------------------------------------------------

/// A codec for `getLeaderSchedule` JSON RPC methods.
class GetLeaderSchedule
    extends JsonRpcMethod<Map<String, dynamic>?, LeaderSchedule?> {
  /// Creates a codec for `getLeaderSchedule` JSON RPC methods.
  GetLeaderSchedule({final u64? slot, final GetLeaderScheduleConfig? config})
    : super(
        'getLeaderSchedule',
        values: [slot],
        config: config ?? const GetLeaderScheduleConfig(),
      );

  @override
  LeaderSchedule? decoder(final Map<String, dynamic>? value) =>
      value != null ? LeaderSchedule.castFrom(value) : null;
}
