/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../utils/assert.dart' show assertLength;

/// Struct Typed Codec
/// ------------------------------------------------------------------------------------------------

/// An interface for `struct` codecs.
abstract class BorshStructTypedCodec<U extends BorshCodec>
    extends BorshCodec<Map<String, dynamic>> {
  /// Creates a codec for borsh serializable objects.
  const BorshStructTypedCodec(this.schema);

  /// The ordered field codecs.
  final Map<String, U> schema;

  @override
  BorshStructTypedEncoder<U> get encoder => BorshStructTypedEncoder(schema);

  @override
  BorshStructTypedDecoder<U> get decoder => BorshStructTypedDecoder(schema);

  @override
  int size(final Map<String, dynamic> input) {
    assertLength(schema.length, input.length);
    int size = 0;
    for (final MapEntry<String, BorshCodec> entry in schema.entries) {
      final dynamic value = input[entry.key];
      size += entry.value.size(value);
    }
    return size;
  }
}

/// Struct Typed Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for borsh serializable objects.
class BorshStructTypedEncoder<U extends BorshCodec>
    extends BorshEncoder<Map<String, dynamic>> {
  /// Creates a codec for borsh serializable objects.
  const BorshStructTypedEncoder(this.schema);

  /// The ordered field codecs.
  final Map<String, U> schema;

  @override
  void pack(final BufferWriter buffer, final Map<String, dynamic> input) {
    for (final MapEntry<String, U> entry in schema.entries) {
      final dynamic value = input[entry.key];
      entry.value.pack(buffer, value);
    }
  }
}

/// Struct Typed Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for borsh serializable objects.
class BorshStructTypedDecoder<U extends BorshCodec>
    extends BorshDecoder<Map<String, dynamic>> {
  /// Creates a decoder for borsh serializable objects.
  const BorshStructTypedDecoder(this.schema);

  /// The ordered field codecs.
  final Map<String, U> schema;

  @override
  Map<String, dynamic> unpack(final BufferReader buffer) {
    final Map<String, dynamic> output = {};
    for (final MapEntry<String, U> entry in schema.entries) {
      output[entry.key] = entry.value.unpack(buffer);
    }
    return output;
  }
}
