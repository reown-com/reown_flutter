/// Import
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart'
    show BufferWriter;
import '../converters/encoder.dart';

/// Encoder Fixed Sized
/// ------------------------------------------------------------------------------------------------

/// Implements [BorshEncoder] for data types with a known max size.
mixin BorshEncoderFixedSized<T> on BorshEncoder<T> {
  /// The fixed number of bytes required to store this data type.
  int get byteLength;

  @override
  Iterable<int> convert(final T input) {
    final BufferWriter writer = BufferWriter(byteLength);
    pack(writer, input);
    return writer.buffer;
  }
}
