/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../converters/codec.dart';

/// List Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for dynamically sized arrays.
class BorshListCodec<T> extends BorshCodec<List<T>> {
  /// Creates a codec for dynamically sized arrays.
  const BorshListCodec(
    this.subtype,
  );

  /// The subtype's codec.
  final BorshCodec<T> subtype;

  @override
  BorshListEncoder<T> get encoder => BorshListEncoder(subtype);

  @override
  BorshListDecoder<T> get decoder => BorshListDecoder(subtype);

  @override
  int size(final List<T> input) {
    return input.fold(
        ByteLength.u32, (total, item) => total + subtype.size(item));
  }
}

/// List Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for dynamically sized arrays.
class BorshListEncoder<T> extends BorshEncoder<List<T>> {
  /// Creates an encoder for  dynamically sized arrays.
  const BorshListEncoder(
    this.subtype,
  );

  /// The subtype's codec.
  final BorshCodec<T> subtype;

  @override
  void pack(final BufferWriter buffer, final Iterable<T> input) {
    buffer.setUint32(input.length);
    final BorshEncoder<T> encoder = subtype.encoder;
    for (final T item in input) {
      encoder.pack(buffer, item);
    }
  }
}

/// List Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for dynamically sized arrays.
class BorshListDecoder<T> extends BorshDecoder<List<T>> {
  /// Creates a decoder for  dynamically sized arrays.
  const BorshListDecoder(
    this.subtype,
  );

  /// The subtype's codec.
  final BorshCodec<T> subtype;

  @override
  List<T> unpack(final BufferReader buffer) {
    final List<T> output = [];
    final int length = buffer.getUint32();
    final BorshDecoder<T> decoder = subtype.decoder;
    for (int i = 0; i < length; ++i) {
      output.add(decoder.unpack(buffer));
    }
    return output;
  }
}
