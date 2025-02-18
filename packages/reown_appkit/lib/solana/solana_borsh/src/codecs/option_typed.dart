/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_borsh/models.dart'
    show BorshOptionType;
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';

/// Option Typed Codec
/// ------------------------------------------------------------------------------------------------

/// An interface for `option` codecs.
abstract class BorshOptionTypedCodec<T, U extends BorshCodec<T>>
    extends BorshCodec<T?> {
  /// Creates a codec for optional values.
  const BorshOptionTypedCodec(
    this.subtype, [
    final BorshOptionType? type,
  ]) : type = type ?? BorshOptionType.rust;

  /// The data type's codec.
  final U subtype;

  /// The option flag's byte length (default: [BorshOptionType.rust]).
  final BorshOptionType type;
}

/// Option Typed Encoder
/// ------------------------------------------------------------------------------------------------

/// An interface for `option` encoders.
abstract class BorshOptionTypedEncoder<T, U extends BorshCodec<T>>
    extends BorshEncoder<T?> {
  /// Creates an encoder for optional values.
  const BorshOptionTypedEncoder(
    this.subtype, [
    final BorshOptionType? type,
  ]) : type = type ?? BorshOptionType.rust;

  /// The data type's codec.
  final U subtype;

  /// The option flag's byte length (default: [BorshOptionType.rust]).
  final BorshOptionType type;

  @override
  void pack(final BufferWriter buffer, final T? input) {
    if (input != null) {
      buffer.setUint(1, type.byteLength);
      subtype.pack(buffer, input);
    } else {
      buffer.setUint(0, type.byteLength);
    }
  }
}

/// Option Typed Decoder
/// ------------------------------------------------------------------------------------------------

/// An interface for `option` decoders.
abstract class BorshOptionTypedDecoder<T, U extends BorshCodec<T>>
    extends BorshDecoder<T?> {
  /// Creates a decoder for optional values.
  const BorshOptionTypedDecoder(
    this.subtype, [
    final BorshOptionType? type,
  ]) : type = type ?? BorshOptionType.rust;

  /// The data type's codec.
  final U subtype;

  /// The option flag's byte length (default: [BorshOptionType.rust]).
  final BorshOptionType type;

  @override
  T? unpack(final BufferReader buffer) {
    final int flag = buffer.getUint(type.byteLength);
    final BorshDecoder<T> decoder = subtype.decoder;
    return flag != 0 ? decoder.unpack(buffer) : null;
  }
}
