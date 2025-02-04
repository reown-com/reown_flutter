/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';

/// Uint Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for unsigned integers.
class BorshUintCodec extends BorshCodec<int> with BorshCodecFixedSized {
  /// Creates a codec for unsigned integers.
  const BorshUintCodec(this.byteLength);

  @override
  final int byteLength;

  @override
  BorshEncoder<int> get encoder => BorshUintEncoder(byteLength);

  @override
  BorshDecoder<int> get decoder => BorshUintDecoder(byteLength);

  @override
  int size(final int input) => byteLength;
}

/// Uint Encoder
/// ------------------------------------------------------------------------------------------------

/// A encoder for unsigned integers.
class BorshUintEncoder extends BorshEncoder<int> with BorshEncoderFixedSized {
  /// Creates an encoder for unsigned integers.
  const BorshUintEncoder(this.byteLength);

  @override
  final int byteLength;

  @override
  void pack(final BufferWriter buffer, final int input) =>
      buffer.setUint(input, byteLength);
}

/// Uint Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for unsigned integers.
class BorshUintDecoder extends BorshDecoder<int> {
  /// Creates a decoder for unsigned integers.
  const BorshUintDecoder(this.byteLength);

  /// The encoded byte length.
  final int byteLength;

  @override
  int unpack(final BufferReader buffer) => buffer.getUint(byteLength);
}

/// Uint8 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for unsigned 8-bit integers.
class BorshUint8Codec extends BorshUintCodec {
  /// Creates a codec for unsigned 8-bit integers.
  const BorshUint8Codec() : super(ByteLength.u8);
}

/// Uint16 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for unsigned 16-bit integers.
class BorshUint16Codec extends BorshUintCodec {
  /// Creates a codec for unsigned 16-bit integers.
  const BorshUint16Codec() : super(ByteLength.u16);
}

/// Uint32 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for unsigned 32-bit integers.
class BorshUint32Codec extends BorshUintCodec {
  /// Creates a codec for unsigned 32-bit integers.
  const BorshUint32Codec() : super(ByteLength.u32);
}
