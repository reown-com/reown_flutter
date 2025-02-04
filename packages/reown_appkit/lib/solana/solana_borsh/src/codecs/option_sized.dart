/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../mixins/codec_fixed_sized.dart';
import 'option_typed.dart';

/// Option Sized Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for optional values.
class BorshOptionSizedCodec<T>
    extends BorshOptionTypedCodec<T, BorshCodecFixedSized<T>>
    with BorshCodecFixedSized {
  /// Creates a codec for optional values.
  const BorshOptionSizedCodec(super.subtype, super.type);

  @override
  int get byteLength => subtype.byteLength + type.byteLength;

  @override
  BorshOptionSizedEncoder<T> get encoder =>
      BorshOptionSizedEncoder(subtype, type);

  @override
  BorshOptionSizedDecoder<T> get decoder =>
      BorshOptionSizedDecoder(subtype, type);

  @override
  int size(final T? input) =>
      type.byteLength + (input != null ? subtype.byteLength : 0);
}

/// Option Sized Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for optional values.
class BorshOptionSizedEncoder<T>
    extends BorshOptionTypedEncoder<T, BorshCodecFixedSized<T>>

/// Not using [BorshEncoderFixedSized] to prevent `0` padding.
{
  /// Creates an encoder for optional values.
  const BorshOptionSizedEncoder(super.subtype, super.type);
}

/// Option Sized Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for optional values.
class BorshOptionSizedDecoder<T>
    extends BorshOptionTypedDecoder<T, BorshCodecFixedSized<T>> {
  /// Creates a decoder for optional values.
  const BorshOptionSizedDecoder(super.subtype, super.type);
}
