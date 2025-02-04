/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentAndMinContextSlotConfig;

/// Get Stake Activation Config
/// ------------------------------------------------------------------------------------------------

class GetStakeActivationConfig extends CommitmentAndMinContextSlotConfig {
  /// JSON RPC configurations for `getStakeActivation` methods.
  const GetStakeActivationConfig({
    super.commitment,
    this.epoch,
    super.minContextSlot,
  }) : assert(minContextSlot == null || minContextSlot >= 0);

  /// The epoch for which to calculate activation details. If omitted, defaults to current epoch.
  final u64? epoch;

  @override
  Map<String, dynamic> toJson() => {
        'commitment': commitment?.name,
        'epoch': epoch,
        'minContextSlot': minContextSlot,
      };
}
