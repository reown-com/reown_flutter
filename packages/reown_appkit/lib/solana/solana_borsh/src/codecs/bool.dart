/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';

/// Bool Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for boolean data types.
class BorshBoolCodec extends BorshCodec<bool> with BorshCodecFixedSized {
  /// Creates a codec for boolean data types.
  const BorshBoolCodec();

  @override
  int get byteLength => ByteLength.u8;

  @override
  BorshEncoder<bool> get encoder => const BorshBoolEncoder();

  @override
  BorshDecoder<bool> get decoder => const BorshBoolDecoder();

  @override
  int size(final bool input) => byteLength;
}

/// Bool Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for boolean data types.
class BorshBoolEncoder extends BorshEncoder<bool> with BorshEncoderFixedSized {
  /// Creates an encoder for boolean data types.
  const BorshBoolEncoder();

  @override
  int get byteLength => ByteLength.u8;

  @override
  void pack(final BufferWriter buffer, final bool input) =>
      buffer.setBool(input);
}

/// Bool Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for boolean data types.
class BorshBoolDecoder extends BorshDecoder<bool> {
  /// Creates a decoder for boolean data types.
  const BorshBoolDecoder();

  @override
  bool unpack(final BufferReader buffer) => buffer.getBool();
}
