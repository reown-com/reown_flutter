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

/// Big Uint Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for unsigned big-integers.
class BorshBigUintCodec extends BorshCodec<BigInt> with BorshCodecFixedSized {
  /// Creates a codec for unsigned big-integers.
  const BorshBigUintCodec(this.byteLength);

  @override
  final int byteLength;

  @override
  BorshEncoder<BigInt> get encoder => BorshBigUintEncoder(byteLength);

  @override
  BorshDecoder<BigInt> get decoder => BorshBigUintDecoder(byteLength);

  @override
  int size(final BigInt input) => byteLength;

  /// Creates a new codec that parses a [BigInt] string.
  BorshCodecFixedSized<String> string() => BorshStringBigInt(this);
}

/// Big Uint Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for unsigned big-integers.
class BorshBigUintEncoder extends BorshEncoder<BigInt>
    with BorshEncoderFixedSized {
  /// Creates an encoder for unsigned big-integers.
  const BorshBigUintEncoder(this.byteLength);

  @override
  final int byteLength;

  @override
  void pack(final BufferWriter buffer, final BigInt input) =>
      buffer.setBigUint(input, byteLength);
}

/// Big Uint Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for unsigned big-integers.
class BorshBigUintDecoder extends BorshDecoder<BigInt> {
  /// Creates decoder for unsigned big-integers.
  const BorshBigUintDecoder(this.byteLength);

  /// The encoded byte length.
  final int byteLength;

  @override
  BigInt unpack(final BufferReader buffer) => buffer.getBigUint(byteLength);
}

/// Uint64 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed 64-bit big-integers.
class BorshUint64Codec extends BorshBigUintCodec {
  /// Creates a codec for signed 64-bit big-integers.
  const BorshUint64Codec() : super(ByteLength.u64);
}

/// Uint128 Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for signed 128-bit big-integers.
class BorshUint128Codec extends BorshBigUintCodec {
  /// Creates a codec for signed 128-bit big-integers.
  const BorshUint128Codec() : super(ByteLength.u128);
}
