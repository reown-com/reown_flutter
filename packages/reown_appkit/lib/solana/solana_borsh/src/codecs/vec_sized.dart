/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../codecs/vec_typed.dart';
import '../mixins/codec_fixed_sized.dart';

/// Vec Sized Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for dynamically sized arrays with sized data types.
class BorshVecSizedCodec<T>
    extends BorshVecTypedCodec<T, BorshCodecFixedSized<T>>
    with BorshCodecFixedSized {
  /// Creates a codec for dynamically sized arrays with sized data types.
  const BorshVecSizedCodec(super.subtype, this.capacity);

  /// The maximum length.
  final int capacity;

  @override
  int get byteLength => subtype.byteLength * capacity;

  @override
  BorshVecSizedEncoder<T> get encoder => BorshVecSizedEncoder(subtype);

  @override
  BorshVecSizedDecoder<T> get decoder => BorshVecSizedDecoder(subtype);
}

/// Vec Sized Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for dynamically sized arrays with sized data types.
class BorshVecSizedEncoder<T>
    extends BorshVecTypedEncoder<T, BorshCodecFixedSized<T>>
/// Not using [BorshEncoderFixedSized] as the encoded list is variable in length.
{
  /// Creates an encoder for dynamically sized arrays with sized data types.
  const BorshVecSizedEncoder(super.subtype);
}

/// Vec Sized Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for dynamically sized arrays with sized data types.
class BorshVecSizedDecoder<T>
    extends BorshVecTypedDecoder<T, BorshCodecFixedSized<T>> {
  /// Creates a decoder for dynamically sized arrays with sized data types.
  const BorshVecSizedDecoder(super.subtype);
}
