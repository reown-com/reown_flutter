/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../codecs/tuple_typed.dart';
import '../mixins/codec_fixed_sized.dart';
import '../utils/assert.dart' show assertLength;

/// Tuple Sized Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for fixed-length arrays with multiple sized data types.
class BorshTupleSizedCodec extends BorshTupleTypedCodec<BorshCodecFixedSized>
    with BorshCodecFixedSized {
  /// Creates a codec for fixed-length arrays with multiple sized data types.
  const BorshTupleSizedCodec(super.fields);

  @override
  int get byteLength =>
      fields.fold(0, (total, subtype) => total + subtype.byteLength);

  @override
  BorshTupleSizedEncoder get encoder => BorshTupleSizedEncoder(fields);

  @override
  BorshTupleSizedDecoder get decoder => BorshTupleSizedDecoder(fields);

  @override
  int size(final List input) {
    assertLength(fields.length, input.length);
    return byteLength;
  }
}

/// Tuple Sized Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for fixed-length arrays with multiple sized data types.
class BorshTupleSizedEncoder<T>
    extends BorshTupleTypedEncoder<BorshCodecFixedSized>
/// Not using [BorshEncoderFixedSized] to prevent `0` padding.
{
  /// Creates an encoder for fixed-length arrays with multiple sized data types.
  const BorshTupleSizedEncoder(super.fields);
}

/// Tuple Sized Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for fixed-length arrays with multiple sized data types.
class BorshTupleSizedDecoder
    extends BorshTupleTypedDecoder<BorshCodecFixedSized> {
  /// Creates a decoder for fixed-length arrays with multiple sized data types.
  const BorshTupleSizedDecoder(super.fields);
}
