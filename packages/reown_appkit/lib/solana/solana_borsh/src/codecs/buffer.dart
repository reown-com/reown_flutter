/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../converters/codec.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';

/// Buffer Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for byte data.
class BorshBufferCodec extends BorshCodec<Iterable<int>>
    with BorshCodecFixedSized {
  /// Creates a codec for byte data.
  const BorshBufferCodec(this.byteLength);

  @override
  final int byteLength;

  @override
  BorshEncoder<Iterable<int>> get encoder => BorshBufferEncoder(byteLength);

  @override
  BorshDecoder<Iterable<int>> get decoder => BorshBufferDecoder(byteLength);

  @override
  int size(final Iterable<int> input) => byteLength;
}

/// Buffer Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for byte data.
class BorshBufferEncoder extends BorshEncoder<Iterable<int>>
    with BorshEncoderFixedSized {
  /// Creates an encoder for byte data.
  const BorshBufferEncoder(this.byteLength);

  @override
  final int byteLength;

  @override
  void pack(final BufferWriter buffer, final Iterable<int> input) =>
      buffer.setBuffer(input);
}

/// Buffer Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for byte data.
class BorshBufferDecoder extends BorshDecoder<Iterable<int>> {
  /// Creates a decoder for byte data.
  const BorshBufferDecoder(this.byteLength);

  /// The buffer length.
  final int byteLength;

  @override
  Iterable<int> unpack(final BufferReader buffer) =>
      buffer.getBuffer(byteLength);
}
