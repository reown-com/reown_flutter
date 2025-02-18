/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;

/// Slot Range
/// ------------------------------------------------------------------------------------------------

class SlotRange extends Serializable {
  /// Defines the slot range to return block production for.
  const SlotRange({
    required this.firstSlot,
    this.lastSlot,
  }) : assert(firstSlot >= 0 && (lastSlot == null || lastSlot >= 0));

  /// The first slot to return block production information for (inclusive).
  final u64 firstSlot;

  /// The last slot to return block production information for (inclusive). If omitted, it defaults
  /// to the highest slot.
  final u64? lastSlot;

  /// {@macro solana_common.Serializable.fromJson}
  factory SlotRange.fromJson(final Map<String, dynamic> json) => SlotRange(
        firstSlot: json['firstSlot'],
        lastSlot: json['lastSlot'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static SlotRange? tryFromJson(final Map<String, dynamic>? json) =>
      json == null ? null : SlotRange.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'firstSlot': firstSlot,
        'lastSlot': lastSlot,
      };
}
