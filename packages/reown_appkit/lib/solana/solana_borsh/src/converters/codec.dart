/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show Codec;
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'decoder.dart';
import 'encoder.dart';

/// Codec
/// ------------------------------------------------------------------------------------------------

/// An interface for Borsh codecs.
abstract class BorshCodec<T> extends Codec<T, Iterable<int>> {
  /// Creates a codec for [T] data types.
  const BorshCodec();

  @override
  BorshEncoder<T> get encoder;

  @override
  BorshDecoder<T> get decoder;

  /// Writes [input] to [buffer].
  void pack(final BufferWriter buffer, final T input) =>
      encoder.pack(buffer, input);

  /// Reads [T] from [buffer].
  T unpack(final BufferReader buffer) => decoder.unpack(buffer);

  /// Returns the serialized byte length of [input].
  int size(final T input);
}
