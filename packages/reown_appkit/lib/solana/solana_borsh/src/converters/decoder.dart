/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show Converter;
import 'package:reown_appkit/solana/solana_buffer/buffer.dart'
    show BufferReader;

/// Decoder
/// ------------------------------------------------------------------------------------------------

/// An interface for Borsh decoders.
abstract class BorshDecoder<T> extends Converter<Iterable<int>, T> {
  /// Creates a decoder for [T] data types.
  const BorshDecoder();

  /// Decodes [T] from [input].
  @override
  T convert(final Iterable<int> input) => unpack(BufferReader.fromList(input));

  /// Reads [T] from [buffer].
  T unpack(final BufferReader buffer);
}
