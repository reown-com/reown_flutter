/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import '../../crypto/pubkey.dart';

///  Token Accounts Filter
/// ------------------------------------------------------------------------------------------------

class TokenAccountsFilter extends Serializable {
  /// JSON RPC parameters for `getTokenAccountsBy` methods.
  TokenAccountsFilter._({
    required this.key,
    required this.address,
  });

  /// The public key of the specific token Mint to limit accounts to.
  factory TokenAccountsFilter.mint(final Pubkey mint) => TokenAccountsFilter._(
        key: 'mint',
        address: mint,
      );

  /// The public key of the Token program that owns the accounts.
  factory TokenAccountsFilter.programId(final Pubkey programId) =>
      TokenAccountsFilter._(
        key: 'programId',
        address: programId,
      );

  /// The public key to filter the account by.
  final Pubkey address;

  /// The key that corresponds to the address ('mint' or 'programId').
  final String key;

  @override
  Map<String, dynamic> toJson() => {key: address.toBase58()};
}
