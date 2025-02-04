//! Borsh

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'src/converters/codec.dart';
import 'src/mixins/codec_fixed_sized.dart';
import 'src/utils/types.dart';
import 'codecs.dart';
import 'models.dart';

/// Borsh
/// ------------------------------------------------------------------------------------------------

/// Borsh serializer.
const Borsh borsh = Borsh._();

/// Borsh serializer.
class Borsh {
  /// Creates codecs to serialize/deserialize data types.
  ///
  /// {@template Borsh.codec}
  /// A codec can encode/decode data types to/from byte arrays `Iterable<u8>` and `Buffer`s.
  /// {@endtemplate}
  const Borsh._();

  /// Encodes [input] using [schema].
  Iterable<int> encode(
    final BorshSchema schema,
    final Map<String, dynamic> input,
  ) =>
      struct(schema).encode(input);

  /// Decodes [input] using [schema].
  Map<String, dynamic> decode(
    final BorshSchema schema,
    final Iterable<int> input,
  ) =>
      struct(schema).decode(input);

  /// Encodes [input] using [schema] and writes the result to [buffer].
  void pack(
    final BorshSchema schema,
    final BufferWriter buffer,
    final Map<String, dynamic> input,
  ) =>
      struct(schema).pack(buffer, input);

  /// Decodes [buffer] using [schema].
  Map<String, dynamic> unpack(
    final BorshSchema schema,
    final BufferReader buffer,
  ) =>
      struct(schema).unpack(buffer);

  /// Returns `true` if the borsh serializable [input] defines a `schema` and `toJson()` mapping
  /// that contain the same keys.
  bool _debugSerialize<T extends BorshObjectMixin>(final T input) {
    final BorshSchema schema = input.borshSchema;
    final Map<String, dynamic> json = input.toJson();
    return schema.length == json.length &&
        json.keys.every((key) => schema.keys.contains(key));
  }

  /// Encodes [input] using [BorshObjectMixin.borshSchema].
  Iterable<int> serialize<T extends BorshObjectMixin>(
    final T input,
  ) {
    assert(
      _debugSerialize(input),
      'Keys found in `schema` do not match the keys found in `toJson()` for $input.',
    );
    return encode(input.borshSchema, input.toJson());
  }

  /// Decodes [input] using [schema] and applies [decoder] to the result.
  T deserialize<T extends BorshObjectMixin>(
    final BorshSchema schema,
    final Iterable<int> input,
    final T Function(Map<String, dynamic>) decoder,
  ) {
    final Map<String, dynamic> json = decode(schema, input);
    return decoder(json);
  }

  /// Creates a `struct` codec.
  ///
  /// {@macro Borsh.codec}
  BorshStructCodec call(
    final BorshSchema schema,
  ) =>
      BorshStructCodec(schema);

  /// Creates a `struct` codec for fixed size data types.
  ///
  /// {@macro Borsh.codec}
  BorshStructSizedCodec structSized(
    final BorshSchemaSized schema,
  ) =>
      BorshStructSizedCodec(schema);

  /// Creates a `struct` codec.
  ///
  /// {@macro Borsh.codec}
  BorshStructCodec struct(
    final BorshSchema schema,
  ) =>
      BorshStructCodec(schema);

  /// Creates an `tuple` codec for fixed size data types.
  ///
  /// {@macro Borsh.codec}
  BorshTupleSizedCodec tupleSized(
    final List<BorshCodecFixedSized> fields,
  ) =>
      BorshTupleSizedCodec(fields);

  /// Creates an `tuple` codec.
  ///
  /// {@macro Borsh.codec}
  BorshTupleCodec tuple(
    final List<BorshCodec> fields,
  ) =>
      BorshTupleCodec(fields);

  /// Creates a `bool` codec.
  ///
  /// {@macro Borsh.codec}
  BorshBoolCodec get boolean => const BorshBoolCodec();

  /// Creates an `enum` codec.
  ///
  /// {@macro Borsh.codec}
  BorshEnumCodec<T> enumeration<T extends Enum>(
    final List<T> values, [
    final int? byteLength,
  ]) =>
      BorshEnumCodec(values, byteLength);

  /// Creates an `enum` codec for Rust style enums (tuple or struct constructors) for fixed size
  /// data types.
  ///
  /// {@macro Borsh.codec}
  BorshRustEnumSizedCodec<T> rustEnumerationSized<T>(
    final List<BorshCodecFixedSized<T>?> variants,
  ) =>
      BorshRustEnumSizedCodec(variants);

  /// Creates an `enum` codec for Rust style enums (tuple or struct constructors).
  ///
  /// {@macro Borsh.codec}
  BorshRustEnumCodec<T> rustEnumeration<T>(
    final List<BorshCodec<T>?> variants,
  ) =>
      BorshRustEnumCodec(variants);

  /// Creates a `date time` codec.
  ///
  /// {@macro Borsh.codec}
  BorshDateTimeCodec get dateTime => const BorshDateTimeCodec();

  /// Creates a `utf-8 string` codec for a fixed length strings
  ///
  /// {@macro Borsh.codec}
  BorshStringSizedCodec stringSized(
    final int length, {
    final BufferEncoding? encoding,
  }) =>
      BorshStringSizedCodec(length, encoding: encoding);

  /// Creates a `string` codec.
  ///
  /// {@macro Borsh.codec}
  BorshStringCodec string({
    final int? lengthPadding,
    final BufferEncoding? encoding,
  }) =>
      BorshStringCodec(lengthPadding: lengthPadding, encoding: encoding);

  /// Creates a `string` codec for Rust string types.
  ///
  /// {@macro Borsh.codec}
  BorshStringCodec rustString({
    final int lengthPadding = ByteLength.u32,
    final BufferEncoding? encoding,
  }) =>
      string(lengthPadding: lengthPadding, encoding: encoding);

  /// Creates an `i8` codec.
  ///
  /// {@macro Borsh.codec}
  BorshInt8Codec get i8 => const BorshInt8Codec();

  /// Creates an `i16` codec.
  ///
  /// {@macro Borsh.codec}
  BorshInt16Codec get i16 => const BorshInt16Codec();

  /// Creates an `i32` codec.
  ///
  /// {@macro Borsh.codec}
  BorshInt32Codec get i32 => const BorshInt32Codec();

  /// Creates an `i64` codec.
  ///
  /// {@macro Borsh.codec}
  BorshInt64Codec get i64 => const BorshInt64Codec();

  /// Creates an `i128` codec.
  ///
  /// {@macro Borsh.codec}
  BorshInt128Codec get i128 => const BorshInt128Codec();

  /// Creates a `u8` codec.
  ///
  /// {@macro Borsh.codec}
  BorshUint8Codec get u8 => const BorshUint8Codec();

  /// Creates a `u16` codec.
  ///
  /// {@macro Borsh.codec}
  BorshUint16Codec get u16 => const BorshUint16Codec();

  /// Creates a `u32` codec.
  ///
  /// {@macro Borsh.codec}
  BorshUint32Codec get u32 => const BorshUint32Codec();

  /// Creates a `u64` codec.
  ///
  /// {@macro Borsh.codec}
  BorshUint64Codec get u64 => const BorshUint64Codec();

  /// Creates a `u128` codec.
  ///
  /// {@macro Borsh.codec}
  BorshUint128Codec get u128 => const BorshUint128Codec();

  /// Creates an `f32` codec.
  ///
  /// {@macro Borsh.codec}
  BorshFloat32Codec get f32 => const BorshFloat32Codec();

  /// Creates an `f64` codec.
  ///
  /// {@macro Borsh.codec}
  BorshFloat64Codec get f64 => const BorshFloat64Codec();

  /// Creates an `buffer` codec.
  ///
  /// {@macro Borsh.codec}
  BorshBufferCodec buffer(
    final int length,
  ) =>
      BorshBufferCodec(length);

  /// Creates a base-58 `public key` codec.
  ///
  /// {@macro Borsh.codec}
  BorshStringSizedCodec get pubkey => const BorshStringSizedCodec(
        32,
        encoding: BufferEncoding.base58,
      );

  /// Creates an `array` codec.
  ///
  /// {@macro Borsh.codec}
  BorshArraySizedCodec<T> arraySized<T>(
    final BorshCodecFixedSized<T> subtype,
    final int length,
  ) =>
      BorshArraySizedCodec(subtype, length);

  /// Creates an `array` codec.
  ///
  /// {@macro Borsh.codec}
  BorshArrayCodec<T> array<T>(
    final BorshCodec<T> subtype,
    final int length,
  ) =>
      BorshArrayCodec(subtype, length);

  /// Creates an `array` codec.
  ///
  /// {@macro Borsh.codec}
  BorshListCodec<T> list<T>(
    final BorshCodec<T> subtype,
    final int length,
  ) =>
      BorshListCodec(subtype);

  /// Creates an `vec` codec.
  ///
  /// {@macro Borsh.codec}
  BorshVecSizedCodec<T> vecSized<T>(
    final BorshCodecFixedSized<T> subtype,
    final int capacity,
  ) =>
      BorshVecSizedCodec(subtype, capacity);

  /// Creates an `vec` codec.
  ///
  /// {@macro Borsh.codec}
  BorshVecCodec<T> vec<T>(
    final BorshCodec<T> codec,
  ) =>
      BorshVecCodec(codec);

  /// Creates an `map` codec.
  ///
  /// {@macro Borsh.codec}
  BorshMapCodec<K, V> map<K, V>(
    final BorshCodec<K> keyCodec,
    final BorshCodec<V> valueCodec,
  ) =>
      BorshMapCodec(keyCodec, valueCodec);
}
