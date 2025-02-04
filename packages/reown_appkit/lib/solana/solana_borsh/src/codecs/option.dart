/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../converters/codec.dart';
import 'option_typed.dart';

/// Option Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for optional values.
class BorshOptionCodec<T> extends BorshOptionTypedCodec<T, BorshCodec<T>> {
  /// Creates a codec for optional values.
  const BorshOptionCodec(super.subtype, super.type);

  @override
  BorshOptionEncoder<T> get encoder => BorshOptionEncoder(subtype, type);

  @override
  BorshOptionDecoder<T> get decoder => BorshOptionDecoder(subtype, type);

  @override
  int size(final T? input) =>
      type.byteLength + (input != null ? subtype.size(input) : 0);
}

/// Option Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for optional values.
class BorshOptionEncoder<T> extends BorshOptionTypedEncoder<T, BorshCodec<T>> {
  /// Creates an encoder for optional values.
  const BorshOptionEncoder(super.subtype, super.type);
}

/// Option Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for optional values.
class BorshOptionDecoder<T> extends BorshOptionTypedDecoder<T, BorshCodec<T>> {
  /// Creates a decoder for optional values.
  const BorshOptionDecoder(super.subtype, super.type);
}
