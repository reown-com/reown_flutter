/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'array_typed.dart';
import '../converters/codec.dart';

/// Array Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for fixed-length arrays.
class BorshArrayCodec<T> extends BorshArrayTypedCodec<T, BorshCodec<T>> {
  /// Creates a codec for fixed-length arrays.
  const BorshArrayCodec(super.subtype, super.length);

  @override
  BorshArrayEncoder<T> get encoder => BorshArrayEncoder(subtype, length);

  @override
  BorshArrayDecoder<T> get decoder => BorshArrayDecoder(subtype, length);
}

/// Array Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for fixed-length arrays.
class BorshArrayEncoder<T> extends BorshArrayTypedEncoder<T, BorshCodec<T>> {
  /// Creates an encoder for fixed-length arrays.
  const BorshArrayEncoder(super.subtype, super.length);
}

/// Array Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for fixed-length arrays.
class BorshArrayDecoder<T> extends BorshArrayTypedDecoder<T, BorshCodec<T>> {
  /// Creates a decoder for fixed-length arrays.
  const BorshArrayDecoder(super.subtype, super.length);
}
