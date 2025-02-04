/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import '../../crypto/pubkey.dart';
import '../configs/get_inflation_reward_config.dart';
import '../interfaces/json_rpc_list_method.dart';
import '../models/inflation_reward.dart';

/// Get Inflation Reward
/// ------------------------------------------------------------------------------------------------

/// A codec for `getInflationReward` JSON RPC methods.
class GetInflationReward
    extends JsonRpcListMethod<Map<String, dynamic>?, InflationReward?> {
  /// Creates a codec for `getInflationReward` JSON RPC methods.
  GetInflationReward(
    final List<String> addresses, {
    final GetInflationRewardConfig? config,
  }) : super(
          'getInflationReward',
          values: [addresses],
          config: config ?? const GetInflationRewardConfig(),
        );

  factory GetInflationReward.map(
    final Iterable<Pubkey> addresses, {
    final GetInflationRewardConfig? config,
  }) =>
      GetInflationReward(
        addresses.toJson(),
        config: config,
      );

  @override
  InflationReward? itemDecoder(
    final Map<String, dynamic>? item,
  ) =>
      item != null ? InflationReward.fromJson(item) : null;
}
