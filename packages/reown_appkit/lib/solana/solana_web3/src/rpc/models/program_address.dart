/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';

/// Program Address
/// ------------------------------------------------------------------------------------------------

class ProgramAddress {
  /// Creates a program address ([pubkey] + [bump]).
  const ProgramAddress(this.pubkey, this.bump);

  /// The public key.
  final Pubkey pubkey;

  /// The bump seed.
  final int bump;
}
