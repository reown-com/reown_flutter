/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show Converter;
import 'package:reown_appkit/solana/solana_buffer/buffer.dart'
    show BufferWriter;

/// Encoder
/// ------------------------------------------------------------------------------------------------

/// An interface for Borsh encoders.
abstract class BorshEncoder<T> extends Converter<T, Iterable<int>> {
  /// Creates a encoder for [T] data types.
  const BorshEncoder();

  /// Encodes [input] to byte data.
  @override
  Iterable<int> convert(final T input) {
    final BufferWriter writer = BufferWriter.mutable();
    pack(writer, input);
    return writer.toBuffer(slice: true);
  }

  /// Writes [input] to [buffer].
  void pack(final BufferWriter buffer, final T input);
}
