/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../../types.dart' show Blockhash;

/// Blockhash With Expiry Block Height
/// ------------------------------------------------------------------------------------------------

class BlockhashWithExpiryBlockHeight extends Serializable {
  /// A confirmed transaction block.
  const BlockhashWithExpiryBlockHeight({
    required this.blockhash,
    required this.lastValidBlockHeight,
  });

  /// A unique base-58 encoded hash that identifies a record (block).
  final Blockhash blockhash;

  /// The last block height at which the blockhash will be valid.
  final u64 lastValidBlockHeight;

  /// {@macro solana_common.Serializable.fromJson}
  factory BlockhashWithExpiryBlockHeight.fromJson(
          final Map<String, dynamic> json) =>
      BlockhashWithExpiryBlockHeight(
        blockhash: json['blockhash'],
        lastValidBlockHeight: json['lastValidBlockHeight'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static BlockhashWithExpiryBlockHeight? tryFromJson(
          final Map<String, dynamic>? json) =>
      json != null ? BlockhashWithExpiryBlockHeight.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'blockhash': blockhash,
        'lastValidBlockHeight': lastValidBlockHeight,
      };
}
