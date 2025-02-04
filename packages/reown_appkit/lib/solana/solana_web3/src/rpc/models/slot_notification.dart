/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;

/// Slot Notification
/// ------------------------------------------------------------------------------------------------

class SlotNotification extends Serializable {
  /// Slot notification.
  const SlotNotification({
    required this.parent,
    required this.root,
    required this.slot,
  });

  /// The parent slot.
  final u64 parent;

  /// The current slot.
  final u64 root;

  /// The newly set slot.
  final u64 slot;

  /// {@macro solana_common.Serializable.fromJson}
  static SlotNotification fromJson(final Map<String, dynamic> json) =>
      SlotNotification(
        parent: json['parent'],
        root: json['root'],
        slot: json['slot'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static SlotNotification? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? SlotNotification.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'parent': parent,
        'root': root,
        'slot': slot,
      };
}
