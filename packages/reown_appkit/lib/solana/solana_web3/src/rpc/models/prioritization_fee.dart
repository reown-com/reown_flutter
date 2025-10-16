/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;

/// Prioritization Fee
/// ------------------------------------------------------------------------------------------------

class PrioritizationFee extends Serializable {
  /// A prioritization fees from recent blocks.
  const PrioritizationFee({required this.slot, required this.prioritizationFee})
    : assert(slot >= 0);

  /// The slot in which the fee was observed.
  final u64 slot;

  /// The per-compute-unit fee paid by at least one successfully landed transaction, specified in
  /// increments of 0.000001 lamports.
  final u64 prioritizationFee;

  /// {@macro solana_common.Serializable.fromJson}
  factory PrioritizationFee.fromJson(final Map<String, dynamic> json) =>
      PrioritizationFee(
        slot: json['slot'],
        prioritizationFee: json['prioritizationFee'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static PrioritizationFee? tryFromJson(final Map<String, dynamic>? json) =>
      json == null ? null : PrioritizationFee.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'slot': slot,
    'prioritizationFee': prioritizationFee,
  };
}
