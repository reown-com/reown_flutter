/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../codecs/array_typed.dart';
import '../mixins/codec_fixed_sized.dart';

/// Array Sized Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for fixed-length arrays with fixed size data types.
class BorshArraySizedCodec<T>
    extends BorshArrayTypedCodec<T, BorshCodecFixedSized<T>>
    with BorshCodecFixedSized {
  /// Creates a codec for fixed-length arrays with fixed size data types.
  const BorshArraySizedCodec(super.subtype, super.length);

  @override
  int get byteLength => subtype.byteLength * length;

  @override
  BorshArraySizedEncoder<T> get encoder =>
      BorshArraySizedEncoder(subtype, length);

  @override
  BorshArraySizedDecoder<T> get decoder =>
      BorshArraySizedDecoder(subtype, length);
}

/// Array Sized Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for fixed-length arrays with fixed size data types.
class BorshArraySizedEncoder<T>
    extends BorshArrayTypedEncoder<T, BorshCodecFixedSized<T>>
/// Not using [BorshEncoderFixedSized] to prevent `0` padding.
{
  /// Creates an encoder for fixed-length arrays with fixed size data types.
  const BorshArraySizedEncoder(super.subtype, super.length);
}

/// Array Sized Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for fixed-length arrays with fixed size data types.
class BorshArraySizedDecoder<T>
    extends BorshArrayTypedDecoder<T, BorshCodecFixedSized<T>> {
  /// Creates a decoder for fixed-length arrays with fixed size data types.
  const BorshArraySizedDecoder(super.subtype, super.length);
}
