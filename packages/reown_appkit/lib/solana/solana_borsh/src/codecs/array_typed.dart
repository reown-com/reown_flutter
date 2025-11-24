/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../utils/assert.dart' show assertLength;

/// Array Typed Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for fixed-length arrays.
abstract class BorshArrayTypedCodec<T, U extends BorshCodec<T>>
    extends BorshCodec<List<T>> {
  /// Creates a codec for fixed-length arrays.
  const BorshArrayTypedCodec(this.subtype, this.length);

  /// The subtype's codec.
  final U subtype;

  /// The number of items in the array.
  final int length;

  @override
  int size(final List<T> input) {
    assertLength(length, input.length);
    return input.fold(0, (total, item) => total + subtype.size(item));
  }
}

/// Array Typed Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for fixed-length arrays.
abstract class BorshArrayTypedEncoder<T, U extends BorshCodec<T>>
    extends BorshEncoder<List<T>> {
  /// Creates an encoder for fixed-length arrays.
  const BorshArrayTypedEncoder(this.subtype, this.length);

  /// The data type's annotation.
  final U subtype;

  /// The number of items in the array.
  final int length;

  @override
  void pack(final BufferWriter buffer, final List<T> input) {
    for (final T item in input) {
      subtype.pack(buffer, item);
    }
  }
}

/// Array Typed Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for fixed-length arrays.
abstract class BorshArrayTypedDecoder<T, U extends BorshCodec<T>>
    extends BorshDecoder<List<T>> {
  /// Creates a decoder for fixed-length arrays.
  const BorshArrayTypedDecoder(this.subtype, this.length);

  /// The subtype's codec.
  final U subtype;

  /// The number of items in the array.
  final int length;

  @override
  List<T> unpack(final BufferReader buffer) {
    final List<T> output = [];
    final BorshDecoder<T> decoder = subtype.decoder;
    for (int i = 0; i < length; ++i) {
      output.add(decoder.unpack(buffer));
    }
    return output;
  }
}
