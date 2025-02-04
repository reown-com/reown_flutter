/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../converters/codec.dart';
import 'struct_typed.dart';

/// Struct Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for borsh serializable objects.
class BorshStructCodec extends BorshStructTypedCodec<BorshCodec> {
  /// Creates a codec for borsh serializable objects.
  const BorshStructCodec(super.schema);

  @override
  BorshStructEncoder get encoder => BorshStructEncoder(schema);

  @override
  BorshStructDecoder get decoder => BorshStructDecoder(schema);
}

/// Struct Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for borsh serializable objects.
class BorshStructEncoder<T> extends BorshStructTypedEncoder<BorshCodec> {
  /// Creates an encoder for borsh serializable objects.
  const BorshStructEncoder(super.schema);
}

/// Struct Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for borsh serializable objects.
class BorshStructDecoder<T> extends BorshStructTypedDecoder<BorshCodec> {
  /// Creates a decoder for borsh serializable objects.
  const BorshStructDecoder(super.schema);
}
