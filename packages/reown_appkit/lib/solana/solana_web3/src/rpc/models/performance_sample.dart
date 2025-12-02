/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u16, u64;

/// Performance Sample
/// ------------------------------------------------------------------------------------------------

class PerformanceSample extends Serializable {
  /// Performance Sample.
  const PerformanceSample({
    required this.slot,
    required this.numTransactions,
    required this.numSlots,
    required this.samplePeriodSecs,
  });

  /// Slot in which sample was taken at.
  final u64 slot;

  /// Number of transactions in sample.
  final u64 numTransactions;

  /// Number of slots in sample.
  final u64 numSlots;

  /// Number of seconds in a sample window.
  final u16 samplePeriodSecs;

  /// {@macro solana_common.Serializable.fromJson}
  factory PerformanceSample.fromJson(final Map<String, dynamic> json) =>
      PerformanceSample(
        slot: json['slot'],
        numTransactions: json['numTransactions'],
        numSlots: json['numSlots'],
        samplePeriodSecs: json['samplePeriodSecs'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static PerformanceSample? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? PerformanceSample.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'slot': slot,
    'numTransactions': numTransactions,
    'numSlots': numSlots,
    'samplePeriodSecs': samplePeriodSecs,
  };
}
