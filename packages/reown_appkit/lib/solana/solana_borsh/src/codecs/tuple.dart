/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../converters/codec.dart';
import 'tuple_typed.dart';

/// Tuple Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for fixed-length arrays with multiple data types.
class BorshTupleCodec extends BorshTupleTypedCodec<BorshCodec> {
  /// Creates a codec for fixed-length arrays with multiple data types.
  const BorshTupleCodec(super.fields);

  @override
  BorshTupleEncoder get encoder => BorshTupleEncoder(fields);

  @override
  BorshTupleDecoder get decoder => BorshTupleDecoder(fields);
}

/// Tuple Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for fixed-length arrays with multiple data types.
class BorshTupleEncoder extends BorshTupleTypedEncoder<BorshCodec> {
  /// Creates an encoder for fixed-length arrays with multiple data types.
  const BorshTupleEncoder(super.fields);
}

/// Tuple Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for fixed-length arrays with multiple data types.
class BorshTupleDecoder extends BorshTupleTypedDecoder<BorshCodec> {
  /// Creates a decoder for fixed-length arrays with multiple data types.
  const BorshTupleDecoder(super.fields);
}
