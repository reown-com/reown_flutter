/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';

/// Int Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed integers.
class BorshIntCodec extends BorshCodec<int> with BorshCodecFixedSized {
  /// Creates a codec for signed integers.
  const BorshIntCodec(this.byteLength);

  @override
  final int byteLength;

  @override
  BorshEncoder<int> get encoder => BorshIntEncoder(byteLength);

  @override
  BorshDecoder<int> get decoder => BorshIntDecoder(byteLength);

  @override
  int size(final int input) => byteLength;
}

/// Int Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for signed integers.
class BorshIntEncoder extends BorshEncoder<int> with BorshEncoderFixedSized {
  /// Creates an encoder for signed integers.
  const BorshIntEncoder(this.byteLength);

  @override
  final int byteLength;

  @override
  void pack(final BufferWriter buffer, final int input) =>
      buffer.setInt(input, byteLength);
}

/// Int Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for signed integers.
class BorshIntDecoder extends BorshDecoder<int> {
  /// Creates a decoder for signed integers.
  const BorshIntDecoder(this.byteLength);

  /// The encoded byte length.
  final int byteLength;

  @override
  int unpack(final BufferReader buffer) => buffer.getInt(byteLength);
}

/// Int8 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed 8-bit integers.
class BorshInt8Codec extends BorshIntCodec {
  /// Creates a codec for signed 8-bit integers.
  const BorshInt8Codec() : super(ByteLength.i8);
}

/// Int16 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed 16-bit integers.
class BorshInt16Codec extends BorshIntCodec {
  /// Creates a codec for signed 16-bit integers.
  const BorshInt16Codec() : super(ByteLength.i16);
}

/// Int32 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed 32-bit integers.
class BorshInt32Codec extends BorshIntCodec {
  /// Creates a codec for signed 32-bit integers.
  const BorshInt32Codec() : super(ByteLength.i32);
}

/// Int64 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed 64-bit integers.
class BorshInt64Codec extends BorshIntCodec {
  /// Creates a codec for signed 64-bit integers.
  const BorshInt64Codec() : super(ByteLength.i64);
}
