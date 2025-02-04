/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'account_info.dart';

/// ProgramAccount
/// ------------------------------------------------------------------------------------------------

class ProgramAccount extends Serializable {
  /// The ProgramAccount public key for a node.
  const ProgramAccount({
    required this.pubkey,
    required this.account,
  });

  /// the account Pubkey as a base-58 encoded string.
  final String pubkey;

  /// The account information.
  final AccountInfo account;

  /// {@macro solana_common.Serializable.fromJson}
  factory ProgramAccount.fromJson(final Map<String, dynamic> json) =>
      ProgramAccount(
        pubkey: json['pubkey'],
        account: AccountInfo.fromJson(json['account']),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static ProgramAccount? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? ProgramAccount.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
        'pubkey': pubkey,
        'account': account.toJson(),
      };
}
