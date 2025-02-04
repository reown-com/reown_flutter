/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';

/// Enum Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for enum data types.
class BorshEnumCodec<T extends Enum> extends BorshCodec<T>
    with BorshCodecFixedSized {
  /// Creates a codec for enum data types.
  const BorshEnumCodec(
    this.values, [
    final int? byteLength,
  ]) : byteLength = byteLength ?? ByteLength.u8;

  /// The enum's variants.
  final List<T> values;

  @override
  final int byteLength;

  @override
  BorshEncoder<T> get encoder => BorshEnumEncoder(byteLength);

  @override
  BorshDecoder<T> get decoder => BorshEnumDecoder(values, byteLength);

  @override
  int size(final T input) => byteLength;
}

/// Enum Encoder
/// ------------------------------------------------------------------------------------------------

/// A encoder for enum data types.
class BorshEnumEncoder<T extends Enum> extends BorshEncoder<T>
    with BorshEncoderFixedSized {
  /// Creates an encoder for enum data types.
  const BorshEnumEncoder([
    final int? byteLength,
  ]) : byteLength = byteLength ?? ByteLength.u8;

  @override
  final int byteLength;

  @override
  void pack(final BufferWriter buffer, final T input) =>
      buffer.setUint(input.index, byteLength);
}

/// Enum Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for enum data types.
class BorshEnumDecoder<T extends Enum> extends BorshDecoder<T> {
  /// Creates a decoder for enum data types.
  const BorshEnumDecoder(
    this.values, [
    this.byteLength = ByteLength.u8,
  ]);

  /// The enum's variants.
  final List<T> values;

  /// The encoded byte length.
  final int byteLength;

  @override
  T unpack(final BufferReader buffer) {
    final int index = buffer.getUint(byteLength);
    return values[index];
  }
}
