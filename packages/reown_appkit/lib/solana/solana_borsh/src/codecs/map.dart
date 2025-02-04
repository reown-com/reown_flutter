/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../converters/codec.dart';

/// Map Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for map data types.
class BorshMapCodec<K, V> extends BorshCodec<Map<K, V>> {
  /// Creates a codec for map data types.
  const BorshMapCodec(
    this.keySubtype,
    this.valueSubtype,
  );

  /// The key data type's codec.
  final BorshCodec<K> keySubtype;

  /// The value data type's codec.
  final BorshCodec<V> valueSubtype;

  @override
  BorshEncoder<Map<K, V>> get encoder =>
      BorshMapEncoder(keySubtype, valueSubtype);

  @override
  BorshDecoder<Map<K, V>> get decoder =>
      BorshMapDecoder(keySubtype, valueSubtype);

  @override
  int size(final Map<K, V> input) {
    int size = ByteLength.u32;
    for (final MapEntry<K, V> item in input.entries) {
      size += keySubtype.size(item.key) + valueSubtype.size(item.value);
    }
    return size;
  }
}

/// Map Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for map data types.
class BorshMapEncoder<K, V> extends BorshEncoder<Map<K, V>> {
  /// Creates an encoder for map data types.
  const BorshMapEncoder(
    this.keySubtype,
    this.valueSubtype,
  );

  /// The key data type's codec.
  final BorshCodec<K> keySubtype;

  /// The value data type's codec.
  final BorshCodec<V> valueSubtype;

  @override
  void pack(final BufferWriter buffer, final Map<K, V> input) {
    buffer.setUint32(input.length);
    for (final MapEntry<K, V> item in input.entries) {
      keySubtype.pack(buffer, item.key);
      valueSubtype.pack(buffer, item.value);
    }
  }
}

/// Map Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for map data types.
class BorshMapDecoder<K, V> extends BorshDecoder<Map<K, V>> {
  /// Creates a decoder for map data types.
  const BorshMapDecoder(
    this.keySubtype,
    this.valueSubtype,
  );

  /// The key data type's codec.
  final BorshCodec<K> keySubtype;

  /// The value data type's codec.
  final BorshCodec<V> valueSubtype;

  @override
  Map<K, V> unpack(final BufferReader buffer) {
    final Map<K, V> output = {};
    final int length = buffer.getUint32();
    for (int i = 0; i < length; ++i) {
      final K key = keySubtype.unpack(buffer);
      output[key] = valueSubtype.unpack(buffer);
    }
    return output;
  }
}
