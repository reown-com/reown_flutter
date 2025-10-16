/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../converters/codec.dart';

/// String Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for string data types.
class BorshStringCodec extends BorshCodec<String> {
  /// Creates a codec for string data types.
  const BorshStringCodec({
    final int? lengthPadding,
    final BufferEncoding? encoding,
  }) : lengthPadding = lengthPadding ?? 0,
       encoding = encoding ?? BufferEncoding.utf8;

  /// The number of zeros added to the end of the encoded length.
  final int lengthPadding;

  /// The encoding.
  final BufferEncoding encoding;

  @override
  BorshStringEncoder get encoder =>
      BorshStringEncoder(lengthPadding: lengthPadding, encoding: encoding);

  @override
  BorshStringDecoder get decoder =>
      BorshStringDecoder(lengthPadding: lengthPadding, encoding: encoding);

  @override
  int size(final String input) {
    return ByteLength.u32 +
        lengthPadding // length span + extra padding
        +
        Buffer.fromString(input, encoding).length; // encoded string length
  }
}

/// String Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for string data types.
class BorshStringEncoder extends BorshEncoder<String> {
  /// Creates an encoder for string data types.
  const BorshStringEncoder({
    this.lengthPadding = 0,
    this.encoding = BufferEncoding.utf8,
  });

  /// The number of zeros added to the end of the encoded length.
  final int lengthPadding;

  /// The encoding.
  final BufferEncoding encoding;

  @override
  void pack(final BufferWriter buffer, final String input) {
    final Buffer encoded = Buffer.fromString(input, encoding);
    buffer.setUint32(encoded.length);
    buffer.setBuffer(Buffer(lengthPadding));
    buffer.setBuffer(encoded);
  }
}

/// String Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for string data types.
class BorshStringDecoder extends BorshDecoder<String> {
  /// Creates a decoder for string data types.
  const BorshStringDecoder({
    this.lengthPadding = 0,
    this.encoding = BufferEncoding.utf8,
  });

  /// The number of zeros added to the end of the encoded length.
  final int lengthPadding;

  /// The encoding.
  final BufferEncoding encoding;

  @override
  String unpack(final BufferReader buffer) {
    final int encodedLength = buffer.getUint32();
    buffer.advance(lengthPadding);
    return buffer.getString(encodedLength, encoding);
  }
}
