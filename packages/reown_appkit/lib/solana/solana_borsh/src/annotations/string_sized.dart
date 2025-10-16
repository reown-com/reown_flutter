/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart'
    show BufferEncoding;
import 'annotation_sized.dart';

/// String Sized
/// ------------------------------------------------------------------------------------------------

/// An annotation for fixed-length strings.
///
/// ```
/// @BorshStringSized(10)
/// final String property;
/// ```
class BorshStringSized extends BorshAnnotationSized<String> {
  /// Creates an annotation for a fixed-length string.
  const BorshStringSized(this.byteLength, [this.encoding]);

  /// The encoded byte length.
  final int byteLength;

  /// The encoding.
  final BufferEncoding? encoding;
}
