/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u8, u64;

/// Inflation Reward
/// ------------------------------------------------------------------------------------------------

class InflationReward extends Serializable {
  /// Inflation / staking reward.
  const InflationReward({
    required this.epoch,
    required this.effectiveSlot,
    required this.amount,
    required this.postBalance,
    required this.commission,
  });

  /// The epoch for which the reward occured.
  final u64 epoch;

  /// The slot in which the rewards are effective.
  final u64 effectiveSlot;

  /// The reward amount in lamports.
  final u64 amount;

  /// The balance of the account in lamports, post the reward.
  final u64 postBalance;

  /// The vote account commission when the reward was credited.
  final u8? commission;

  /// {@macro solana_common.Serializable.fromJson}
  factory InflationReward.fromJson(final Map<String, dynamic> json) =>
      InflationReward(
        epoch: json['epoch'],
        effectiveSlot: json['effectiveSlot'],
        amount: json['amount'],
        postBalance: json['postBalance'],
        commission: json['commission'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static InflationReward? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? InflationReward.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'epoch': epoch,
    'effectiveSlot': effectiveSlot,
    'amount': amount,
    'postBalance': postBalance,
    'commission': commission,
  };
}
