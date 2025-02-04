/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;

/// Block Commitment
/// ------------------------------------------------------------------------------------------------

class BlockCommitment extends Serializable {
  /// The block commitment for a particular block.
  const BlockCommitment({
    required this.commitment,
    required this.totalStake,
  });

  /// An array of u64 integers logging the amount of cluster stake in lamports that has voted on the
  /// block at each depth from 0 to MAX_LOCKOUT_HISTORY + 1.
  final List<u64>? commitment;

  /// The total active stake in lamports of the current epoch.
  final u64 totalStake;

  /// {@macro solana_common.Serializable.fromJson}
  factory BlockCommitment.fromJson(final Map<String, dynamic> json) =>
      BlockCommitment(
        commitment: json['commitment'],
        totalStake: json['totalStake'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static BlockCommitment? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? BlockCommitment.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'commitment': commitment,
        'totalStake': totalStake,
      };
}
