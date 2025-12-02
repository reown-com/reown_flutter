/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart' show ByteLength;

/// Option Type
/// ------------------------------------------------------------------------------------------------

/// An option type determines how many bytes are used to store the option flag.
enum BorshOptionType {
  /// A 1-byte option flag.
  rust(ByteLength.u8),

  /// A 4-byte option flag.
  c(ByteLength.u32);

  /// Creates a [BorshOptionType] with [byteLength].
  const BorshOptionType(this.byteLength);

  /// The option flag's byte length.
  final int byteLength;
}
