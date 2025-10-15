/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:math' as math show pow;
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;

/// Epoch Schedule
/// ------------------------------------------------------------------------------------------------

class EpochSchedule extends Serializable {
  /// Epoch schedule information from a cluster's genesis config.
  const EpochSchedule({
    required this.slotsPerEpoch,
    required this.leaderScheduleSlotOffset,
    required this.warmup,
    required this.firstNormalEpoch,
    required this.firstNormalSlot,
  });

  /// The minimum number of slots per epoch.
  static const int minimumSlotPerEpoch = 32;

  /// Returns the number of trailing zeros in the binary representation of [n].
  int _trailingZeros(num n) {
    int trailingZeros = 0;
    while (n > 1) {
      n /= 2;
      ++trailingZeros;
    }
    return trailingZeros;
  }

  /// Returns the smallest power of two greater than or equal to [n].
  int _nextPowerOfTwo(int n) {
    if (n == 0) {
      return 1;
    }
    --n;
    n |= n >> 1;
    n |= n >> 2;
    n |= n >> 4;
    n |= n >> 8;
    n |= n >> 16;
    n |= n >> 32;
    return n + 1;
  }

  /// The maximum number of slots in each epoch.
  final u64 slotsPerEpoch;

  /// The number of slots before beginning an epoch to calculate a leader schedule for that epoch.
  final u64 leaderScheduleSlotOffset;

  /// Whether epochs start short and grow.
  final bool warmup;

  /// The first normal-length epoch, log2(slotsPerEpoch) - log2(MINIMUM_SLOTS_PER_EPOCH).
  final u64 firstNormalEpoch;

  /// MINIMUM_SLOTS_PER_EPOCH * (2.pow(firstNormalEpoch) - 1).
  final u64 firstNormalSlot;

  /// {@macro solana_common.Serializable.fromJson}
  factory EpochSchedule.fromJson(final Map<String, dynamic> json) =>
      EpochSchedule(
        slotsPerEpoch: json['slotsPerEpoch'],
        leaderScheduleSlotOffset: json['leaderScheduleSlotOffset'],
        warmup: json['warmup'],
        firstNormalEpoch: json['firstNormalEpoch'],
        firstNormalSlot: json['firstNormalSlot'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static EpochSchedule? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? EpochSchedule.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
    'slotsPerEpoch': slotsPerEpoch,
    'leaderScheduleSlotOffset': leaderScheduleSlotOffset,
    'warmup': warmup,
    'firstNormalEpoch': firstNormalEpoch,
    'firstNormalSlot': firstNormalSlot,
  };

  u64 getEpoch(final u64 slot) => getEpochAndSlotIndex(slot)[0];

  List<u64> getEpochAndSlotIndex(final u64 slot) {
    if (slot < firstNormalSlot) {
      final epoch =
          _trailingZeros(_nextPowerOfTwo(slot + minimumSlotPerEpoch + 1)) -
          _trailingZeros(minimumSlotPerEpoch) -
          1;
      final epochLen = getSlotsInEpoch(epoch);
      final slotIndex = slot - (epochLen - minimumSlotPerEpoch);
      return [epoch, slotIndex];
    } else {
      final normalSlotIndex = slot - firstNormalSlot;
      final normalEpochIndex = (normalSlotIndex / slotsPerEpoch).floor();
      final epoch = firstNormalEpoch + normalEpochIndex;
      final slotIndex = normalSlotIndex % slotsPerEpoch;
      return [epoch, slotIndex];
    }
  }

  u64 getFirstSlotInEpoch(final u64 epoch) {
    return epoch <= firstNormalEpoch
        ? (math.pow(2, epoch).toInt() - 1) * minimumSlotPerEpoch
        : (epoch - firstNormalEpoch) * slotsPerEpoch + firstNormalSlot;
  }

  u64 getLastSlotInEpoch(final u64 epoch) {
    return getFirstSlotInEpoch(epoch) + getSlotsInEpoch(epoch) - 1;
  }

  u64 getSlotsInEpoch(final u64 epoch) {
    return epoch < firstNormalEpoch
        ? math.pow(2, epoch + _trailingZeros(minimumSlotPerEpoch)).toInt()
        : slotsPerEpoch;
  }
}
