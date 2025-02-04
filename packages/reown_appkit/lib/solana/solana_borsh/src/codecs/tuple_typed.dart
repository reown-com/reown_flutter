/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../utils/assert.dart' show assertLength;
import '../utils/types.dart';

/// Tuple Typed Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for fixed-length arrays with multiple data types.
abstract class BorshTupleTypedCodec<U extends BorshCodec>
    extends BorshCodec<Tuple> {
  /// Creates a codec for fixed-length arrays with multiple data types.
  const BorshTupleTypedCodec(this.fields);

  /// The field type codecs.
  final List<U> fields;

  @override
  BorshTupleTypedEncoder<U> get encoder => BorshTupleTypedEncoder(fields);

  @override
  BorshTupleTypedDecoder<U> get decoder => BorshTupleTypedDecoder(fields);

  @override
  int size(final List input) {
    assertLength(fields.length, input.length);
    int size = 0;
    for (int i = 0; i < input.length; ++i) {
      size += fields[i].size(input[i]);
    }
    return size;
  }
}

/// Tuple Typed Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for fixed-length arrays with multiple data types.
class BorshTupleTypedEncoder<U extends BorshCodec> extends BorshEncoder<Tuple> {
  /// Creates an encoder for fixed-length arrays with multiple data types.
  const BorshTupleTypedEncoder(this.fields);

  /// The field type codecs.
  final List<U> fields;

  @override
  void pack(final BufferWriter buffer, final Tuple input) {
    assertLength(fields.length, input.length);
    for (int i = 0; i < input.length; ++i) {
      fields[i].pack(buffer, input[i]);
    }
  }
}

/// Tuple Typed Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for fixed-length arrays with multiple data types.
class BorshTupleTypedDecoder<U extends BorshCodec> extends BorshDecoder<Tuple> {
  /// Creates a decoder for fixed-length arrays with multiple data types.
  const BorshTupleTypedDecoder(this.fields);

  /// The field type codecs.
  final List<U> fields;

  @override
  List unpack(final BufferReader buffer) {
    final List output = [];
    for (final U field in fields) {
      output.add(field.unpack(buffer));
    }
    return output;
  }
}
