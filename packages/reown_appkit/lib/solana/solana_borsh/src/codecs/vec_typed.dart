/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';

/// Vec Typed Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for dynamically sized arrays.
abstract class BorshVecTypedCodec<T, U extends BorshCodec<T>>
    extends BorshCodec<List<T>> {
  /// Creates a codec for dynamically sized arrays.
  const BorshVecTypedCodec(this.subtype);

  /// The subtype's codec.
  final U subtype;

  @override
  BorshVecTypedEncoder<T, U> get encoder => BorshVecTypedEncoder(subtype);

  @override
  BorshVecTypedDecoder<T, U> get decoder => BorshVecTypedDecoder(subtype);

  @override
  int size(final List<T> input) =>
      input.fold(ByteLength.u32, (total, item) => total + subtype.size(item));
}

/// Vec Typed Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for dynamically sized arrays.
class BorshVecTypedEncoder<T, U extends BorshCodec<T>>
    extends BorshEncoder<List<T>> {
  /// Creates an encoder for dynamically sized arrays.
  const BorshVecTypedEncoder(this.subtype);

  /// The subtype's codec.
  final U subtype;

  @override
  void pack(final BufferWriter buffer, final Iterable<T> input) {
    buffer.setUint32(input.length);
    for (final T item in input) {
      subtype.pack(buffer, item);
    }
  }
}

/// Vec Typed Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for dynamically sized arrays.
class BorshVecTypedDecoder<T, U extends BorshCodec<T>>
    extends BorshDecoder<List<T>> {
  /// Creates a decoder for dynamically sized arrays.
  const BorshVecTypedDecoder(this.subtype);

  /// The subtype's codec.
  final U subtype;

  @override
  List<T> unpack(final BufferReader buffer) {
    final List<T> output = [];
    final int length = buffer.getUint32();
    for (int i = 0; i < length; ++i) {
      output.add(subtype.unpack(buffer));
    }
    return output;
  }
}
