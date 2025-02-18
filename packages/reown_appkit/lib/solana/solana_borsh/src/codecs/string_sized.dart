/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';
import '../utils/assert.dart';

/// String Sized Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for fixed-length string data types.
class BorshStringSizedCodec extends BorshCodec<String>
    with BorshCodecFixedSized {
  /// Creates a codec for fixed-length string data types.
  const BorshStringSizedCodec(
    this.byteLength, {
    final BufferEncoding? encoding,
  }) : encoding = encoding ?? BufferEncoding.utf8;

  @override
  final int byteLength;

  /// The encoding.
  final BufferEncoding encoding;

  @override
  BorshStringSizedEncoder get encoder => BorshStringSizedEncoder(
        byteLength,
        encoding: encoding,
      );

  @override
  BorshStringSizedDecoder get decoder => BorshStringSizedDecoder(
        byteLength,
        encoding: encoding,
      );

  @override
  int size(final String input) => byteLength;
}

/// String Sized Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for fixed-length string data types.
class BorshStringSizedEncoder extends BorshEncoder<String>
    with BorshEncoderFixedSized {
  /// Creates an encoder for fixed-length string data types.
  const BorshStringSizedEncoder(
    this.byteLength, {
    final BufferEncoding? encoding,
  }) : encoding = encoding ?? BufferEncoding.utf8;

  @override
  final int byteLength;

  /// The encoding.
  final BufferEncoding encoding;

  @override
  void pack(final BufferWriter buffer, final String input) {
    assertEncodedMaxLength(input, encoding, byteLength);
    buffer.setString(input, encoding);
  }
}

/// String Sized Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for fixed-length string data types.
class BorshStringSizedDecoder extends BorshDecoder<String> {
  /// Creates a decoder for fixed-length string data types.
  const BorshStringSizedDecoder(
    this.byteLength, {
    final BufferEncoding? encoding,
  }) : encoding = encoding ?? BufferEncoding.utf8;

  /// The encoded byte length.
  final int byteLength;

  /// The encoding.
  final BufferEncoding encoding;

  @override
  String unpack(final BufferReader buffer) {
    return buffer.getString(byteLength, encoding);
  }
}
