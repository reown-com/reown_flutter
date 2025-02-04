/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';

/// Nonce with Min Context Slot
/// ------------------------------------------------------------------------------------------------

class NonceWithMinContextSlot {
  /// A strategy for confirming transactions that uses the last valid block height for a given
  /// blockhash to check for transaction expiration.
  const NonceWithMinContextSlot({
    this.minContextSlot,
    required this.nonceAccount,
    required this.nonce,
  });

  /// The lowest slot at which to fetch the nonce value from the nonce account. This should be no
  /// lower than the slot at which the last-known value of the nonce was fetched.
  final int? minContextSlot;

  /// The account where the current value of the nonce is stored.
  final Pubkey nonceAccount;

  /// The nonce value that was used to sign the transaction for which confirmation is being sought.
  final String nonce;
}
