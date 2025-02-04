/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../models/rust_enum.dart';

/// Rust Enum Typed Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for complex Rust style enums (tuple or struct constructors).
abstract class BorshRustEnumTypedCodec<T, U extends BorshCodec<T>>
    extends BorshCodec<RustEnum<T>> {
  /// Creates a codec for complex Rust style enums (tuple or struct constructors).
  const BorshRustEnumTypedCodec(this.variants);

  /// The enum variants codecs.
  final List<U?> variants;

  @override
  BorshRustEnumTypedEncoder<T, U> get encoder =>
      BorshRustEnumTypedEncoder(variants);

  @override
  BorshRustEnumTypedDecoder<T, U> get decoder =>
      BorshRustEnumTypedDecoder(variants);

  @override
  int size(final RustEnum input) {
    assert(input.index < variants.length);
    final BorshCodec<T>? variant = variants[input.index];
    return ByteLength.u8 + (variant?.size(input.values) ?? 0);
  }
}

/// Rust Enum Typed Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for complex Rust style enums (tuple or struct constructors).
class BorshRustEnumTypedEncoder<T, U extends BorshCodec<T>>
    extends BorshEncoder<RustEnum<T>> {
  /// Creates an encoder for complex Rust style enums (tuple or struct constructors).
  const BorshRustEnumTypedEncoder(this.variants);

  /// The enum variants codecs.
  final List<U?> variants;

  @override
  void pack(final BufferWriter buffer, final RustEnum input) {
    assert(input.index < variants.length);
    buffer.setUint8(input.index);
    final U? codec = variants[input.index];
    codec?.encoder.pack(buffer, input.values);
  }
}

/// Rust Enum Typed Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for complex Rust style enums (tuple or struct constructors).
class BorshRustEnumTypedDecoder<T, U extends BorshCodec<T>>
    extends BorshDecoder<RustEnum<T>> {
  /// Creates a decoder for complex Rust style enums (tuple or struct constructors).
  const BorshRustEnumTypedDecoder(this.variants);

  /// The enum variants codecs.
  final List<U?> variants;

  @override
  RustEnum<T> unpack(final BufferReader buffer) {
    final int index = buffer.getUint8();
    assert(index < variants.length);
    final U? codec = variants[index];
    return RustEnum(index, codec?.decoder.unpack(buffer));
  }
}
