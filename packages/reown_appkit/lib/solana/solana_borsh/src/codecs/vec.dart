/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../converters/codec.dart';
import 'vec_typed.dart';

/// Vec Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for dynamically arrays.
class BorshVecCodec<T> extends BorshVecTypedCodec<T, BorshCodec<T>> {
  /// Creates a codec for dynamically arrays.
  const BorshVecCodec(super.subtype);

  @override
  BorshVecEncoder<T> get encoder => BorshVecEncoder(subtype);

  @override
  BorshVecDecoder<T> get decoder => BorshVecDecoder(subtype);
}

/// Vec Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for dynamically arrays.
class BorshVecEncoder<T> extends BorshVecTypedEncoder<T, BorshCodec<T>> {
  /// Creates an encoder for dynamically arrays.
  const BorshVecEncoder(super.subtype);
}

/// Vec Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for dynamically arrays.
class BorshVecDecoder<T> extends BorshVecTypedDecoder<T, BorshCodec<T>> {
  /// Creates a decoder for dynamically arrays.
  const BorshVecDecoder(super.subtype);
}
