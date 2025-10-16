/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentConfig;

/// Get Inflation Reward Config
/// ------------------------------------------------------------------------------------------------

class GetInflationRewardConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getInflationReward` methods.
  const GetInflationRewardConfig({
    super.commitment,
    this.epoch,
    this.minContextSlot,
  }) : assert(minContextSlot == null || minContextSlot >= 0);

  /// The epoch for which the reward occurs. If omitted, the previous epoch will be used.
  final u64? epoch;

  /// The minimum slot that the request can be evaluated at.
  final u64? minContextSlot;

  @override
  Map<String, dynamic> toJson() => {
    'commitment': commitment?.name,
    'epoch': epoch,
    'minContextSlot': minContextSlot,
  };
}
