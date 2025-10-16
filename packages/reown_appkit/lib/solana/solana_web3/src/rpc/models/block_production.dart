/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'slot_range.dart';

/// Block Production
/// ------------------------------------------------------------------------------------------------

class BlockProduction extends Serializable {
  /// Block production information.
  const BlockProduction({required this.byIdentity, required this.range});

  // ***********************************************************************************************
  // ** Do not change the type to Map<String, List<int>>, a bug in dart throws an error when you  **
  // ** try to print this property.                                                               **
  // **                                                                                           **
  // ** final BlockProduction p = BlockProduction.fromJson(...);                                  **
  // ** print(p.byIdentity) // 'List<dynamic>' is not a subtype of type 'List<int>' in type cast  **
  // ***********************************************************************************************
  /// A dictionary of validator identities, as base-58 encoded strings. The values are a two element
  /// array, containing the number of leader slots and the number of blocks produced.
  final Map<String, List> byIdentity;

  /// The block production slot range.
  final SlotRange range;

  /// {@macro solana_common.Serializable.fromJson}
  factory BlockProduction.fromJson(final Map<String, dynamic> json) =>
      BlockProduction(
        byIdentity: Map.castFrom(json['byIdentity']),
        range: SlotRange.fromJson(json['range']),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static BlockProduction? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? BlockProduction.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
    'byIdentity': byIdentity,
    'range': range.toJson(),
  };
}
