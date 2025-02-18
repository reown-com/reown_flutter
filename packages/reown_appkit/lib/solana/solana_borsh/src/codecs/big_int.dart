/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../converters/string_big_int.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';

/// Big Int Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed big-integers.
class BorshBigIntCodec extends BorshCodec<BigInt> with BorshCodecFixedSized {
  /// Creates a codec for signed big-integers.
  const BorshBigIntCodec(this.byteLength);

  @override
  final int byteLength;

  @override
  BorshEncoder<BigInt> get encoder => BorshBigIntEncoder(byteLength);

  @override
  BorshDecoder<BigInt> get decoder => BorshBigIntDecoder(byteLength);

  @override
  int size(final BigInt input) => byteLength;

  /// Creates a new codec that parses a [BigInt] string.
  BorshCodecFixedSized<String> string() => BorshStringBigInt(this);
}

/// Big Int Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for signed big-integers.
class BorshBigIntEncoder extends BorshEncoder<BigInt>
    with BorshEncoderFixedSized {
  /// Creates an encoder for signed big-integers.
  const BorshBigIntEncoder(this.byteLength);

  @override
  final int byteLength;

  @override
  void pack(final BufferWriter buffer, final BigInt input) =>
      buffer.setBigInt(input, byteLength);
}

/// Big Int Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for signed big-integers.
class BorshBigIntDecoder extends BorshDecoder<BigInt> {
  /// Creates a decoder for signed big-integers.
  const BorshBigIntDecoder(this.byteLength);

  /// The encoded byte length.
  final int byteLength;

  @override
  BigInt unpack(final BufferReader buffer) => buffer.getBigInt(byteLength);
}

/// Int128 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed 128-bit big-integers.
class BorshInt128Codec extends BorshBigIntCodec {
  /// Creates a codec for signed 128-bit big-integers.
  const BorshInt128Codec() : super(ByteLength.i128);
}
