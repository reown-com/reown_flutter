/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../codecs/struct_typed.dart';
import '../mixins/codec_fixed_sized.dart';

/// Struct Sized Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for borsh serializable objects with sized fields.
class BorshStructSizedCodec extends BorshStructTypedCodec<BorshCodecFixedSized>
    with BorshCodecFixedSized {
  /// Creates a codec for borsh serializable objects with sized fields.
  const BorshStructSizedCodec(super.schema);

  @override
  int get byteLength =>
      schema.values.fold(0, (total, field) => total + field.byteLength);

  @override
  BorshStructSizedEncoder get encoder => BorshStructSizedEncoder(schema);

  @override
  BorshStructSizedDecoder get decoder => BorshStructSizedDecoder(schema);
}

/// Struct Sized Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for borsh serializable objects with sized fields.
class BorshStructSizedEncoder
    extends BorshStructTypedEncoder<BorshCodecFixedSized>
/// Not using [BorshEncoderFixedSized] to prevent `0` padding.
{
  /// Creates an encoder for borsh serializable objects with sized fields.
  const BorshStructSizedEncoder(super.schema);
}

/// Struct Sized Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for borsh serializable objects with sized fields.
class BorshStructSizedDecoder
    extends BorshStructTypedDecoder<BorshCodecFixedSized> {
  /// Creates a decoder for borsh serializable objects with sized fields.
  const BorshStructSizedDecoder(super.schema);
}
