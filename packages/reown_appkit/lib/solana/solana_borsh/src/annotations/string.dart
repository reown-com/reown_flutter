/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart'
    show BufferEncoding;
import 'annotation.dart';

/// String
/// ------------------------------------------------------------------------------------------------

/// An annotation for strings.
///
/// ```
/// @BorshString()
/// final String property;
/// ```
class BorshString extends BorshAnnotation<String> {
  /// Creates an annotation for a string.
  const BorshString({
    this.lengthPadding,
    this.encoding,
  });

  /// The zero padding added to the end of the encoded length.
  final int? lengthPadding;

  /// The serialization encoding.
  final BufferEncoding? encoding;
}
