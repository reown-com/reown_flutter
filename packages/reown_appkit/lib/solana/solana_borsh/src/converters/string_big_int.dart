/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../../converters.dart';
import '../../mixins.dart';

/// String-BigInt
/// ------------------------------------------------------------------------------------------------

/// A codec for for big ints represented as strings.
class BorshStringBigInt extends BorshCodec<String> with BorshCodecFixedSized {
  /// Creates a codec for big ints represented as strings.
  const BorshStringBigInt(this.codec);

  /// The big int codec.
  final BorshCodecFixedSized<BigInt> codec;

  @override
  int get byteLength => codec.byteLength;

  @override
  BorshStringBigIntEncoder get encoder =>
      BorshStringBigIntEncoder(codec.encoder);

  @override
  BorshStringBigIntDecoder get decoder =>
      BorshStringBigIntDecoder(codec.decoder);

  @override
  int size(final String input) => codec.size(BigInt.parse(input));
}

/// String-BigInt Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for big ints represented as strings.
class BorshStringBigIntEncoder extends BorshEncoder<String> {
  /// Creates a encoder to convert big int [String]s.
  const BorshStringBigIntEncoder(this.encoder);

  /// The big int encoder.
  final BorshEncoder<BigInt> encoder;

  @override
  void pack(final BufferWriter buffer, final String input) =>
      encoder.pack(buffer, BigInt.parse(input));
}

/// String-BigInt Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for big ints represented as strings.
class BorshStringBigIntDecoder extends BorshDecoder<String> {
  /// Creates a decoder to convert big int [String]s.
  const BorshStringBigIntDecoder(this.decoder);

  /// The big int decoder.
  final BorshDecoder<BigInt> decoder;

  @override
  String unpack(final BufferReader buffer) => decoder.unpack(buffer).toString();
}
