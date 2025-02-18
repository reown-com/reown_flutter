/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';

/// Float Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for floating point numbers.
abstract class BorshFloatCodec extends BorshCodec<double>
    with BorshCodecFixedSized {
  /// Creates a codec for floating point numbers.
  const BorshFloatCodec();

  @override
  BorshEncoder<double> get encoder;

  @override
  BorshDecoder<double> get decoder;

  @override
  int size(final double input) => byteLength;
}

/// Float Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for floating point numbers.
abstract class BorshFloatEncoder extends BorshEncoder<double>
    with BorshEncoderFixedSized {
  /// Creates an encoder for floating point numbers.
  const BorshFloatEncoder(this.byteLength);

  @override
  final int byteLength;
}

/// Float Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for floating point numbers.
abstract class BorshFloatDecoder extends BorshDecoder<double> {
  /// Creates decoder for floating point numbers.
  const BorshFloatDecoder();
}

/// Float32 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for 32-bit floating point numbers.
class BorshFloat32Codec extends BorshFloatCodec {
  /// Creates a codec for 32-bit floating point numbers.
  const BorshFloat32Codec();

  @override
  int get byteLength => ByteLength.f32;

  @override
  BorshFloat32Encoder get encoder => const BorshFloat32Encoder();

  @override
  BorshFloat32Decoder get decoder => const BorshFloat32Decoder();
}

/// Float32 Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for 32-bit floating point numbers.
class BorshFloat32Encoder extends BorshFloatEncoder {
  /// Creates an encoder for 32-bit floating point numbers.
  const BorshFloat32Encoder() : super(ByteLength.f32);

  @override
  void pack(final BufferWriter buffer, final double input) =>
      buffer.setFloat32(input);
}

/// Float32 Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for 32-bit floating point numbers.
class BorshFloat32Decoder extends BorshFloatDecoder {
  /// Creates decoder for 32-bit floating point numbers.
  const BorshFloat32Decoder();

  @override
  double unpack(final BufferReader buffer) => buffer.getFloat32();
}

/// Float64 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for 64-bit floating point numbers.
class BorshFloat64Codec extends BorshFloatCodec {
  /// Creates a codec for 64-bit floating point numbers.
  const BorshFloat64Codec();

  @override
  int get byteLength => ByteLength.f64;

  @override
  BorshFloat64Encoder get encoder => const BorshFloat64Encoder();

  @override
  BorshFloat64Decoder get decoder => const BorshFloat64Decoder();
}

/// Float64 Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for 64-bit floating point numbers.
class BorshFloat64Encoder extends BorshFloatEncoder {
  /// Creates an encoder for 64-bit floating point numbers.
  const BorshFloat64Encoder() : super(ByteLength.f64);

  @override
  void pack(final BufferWriter buffer, final double input) =>
      buffer.setFloat64(input);
}

/// Float64 Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for 64-bit floating point numbers.
class BorshFloat64Decoder extends BorshFloatDecoder {
  /// Creates decoder for 64-bit floating point numbers.
  const BorshFloat64Decoder();

  @override
  double unpack(final BufferReader buffer) => buffer.getFloat64();
}
