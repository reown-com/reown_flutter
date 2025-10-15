/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../../crypto/pubkey.dart';

/// Large Account
/// ------------------------------------------------------------------------------------------------

class LargeAccount extends Serializable {
  /// A large account (by lamport balance).
  const LargeAccount({required this.address, required this.lamports});

  /// The address of the account.
  final Pubkey address;

  /// The number of lamports in the account.
  final u64? lamports;

  /// {@macro solana_common.Serializable.fromJson}
  factory LargeAccount.fromJson(final Map<String, dynamic> json) =>
      LargeAccount(
        address: Pubkey.fromBase58(json['address']),
        lamports: json['lamports'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static LargeAccount? tryFromJson(final Map<String, dynamic>? json) =>
      json == null ? null : LargeAccount.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {'address': address, 'lamports': lamports};
}
