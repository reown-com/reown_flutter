/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'vote_account.dart';

/// Vote Account Status
/// ------------------------------------------------------------------------------------------------

class VoteAccountStatus extends Serializable {
  /// Current and delinquent vote accounts.
  const VoteAccountStatus({
    required this.current,
    required this.delinquent,
  });

  /// The current vote accounts.
  final List<VoteAccount> current;

  /// The delinquent vote accounts.
  final List<VoteAccount> delinquent;

  /// {@macro solana_common.Serializable.fromJson}
  factory VoteAccountStatus.fromJson(final Map<String, dynamic> json) =>
      VoteAccountStatus(
        current: IterableSerializable.fromJson(
            json['current'], VoteAccount.fromJson),
        delinquent: IterableSerializable.fromJson(
            json['delinquent'], VoteAccount.fromJson),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static VoteAccountStatus? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? VoteAccountStatus.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
        'current': current.toJson(),
        'delinquent': delinquent.toJson(),
      };
}
