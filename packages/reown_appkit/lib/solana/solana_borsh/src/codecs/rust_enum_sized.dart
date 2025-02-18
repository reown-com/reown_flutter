/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:math' show max;
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../codecs/rust_enum_typed.dart';
import '../mixins/codec_fixed_sized.dart';

/// Rust Enum Sized Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for complex Rust style enums with sized data types (tuple or struct constructors).
class BorshRustEnumSizedCodec<T>
    extends BorshRustEnumTypedCodec<T, BorshCodecFixedSized<T>>
    with BorshCodecFixedSized {
  /// Creates a codec for complex Rust style enums with sized data types (tuple or struct
  /// constructors).
  const BorshRustEnumSizedCodec(super.variants);

  @override
  int get byteLength {
    int size = 0;
    for (final BorshCodecFixedSized? variant in variants) {
      if (variant != null) {
        size = max(size, variant.byteLength);
      }
    }
    return ByteLength.u8 + size;
  }

  @override
  BorshRustEnumSizedEncoder<T> get encoder =>
      BorshRustEnumSizedEncoder(variants);

  @override
  BorshRustEnumSizedDecoder<T> get decoder =>
      BorshRustEnumSizedDecoder(variants);
}

/// Rust Enum Sized Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for complex Rust style enums with sized data types (tuple or struct
/// constructors).
class BorshRustEnumSizedEncoder<T>
    extends BorshRustEnumTypedEncoder<T, BorshCodecFixedSized<T>>

/// Not using [BorshEncoderFixedSized] to prevent `0` padding.
{
  /// Creates an encoder for complex Rust style enums with sized data types (tuple or struct
  /// constructors).
  const BorshRustEnumSizedEncoder(super.variants);
}

/// Rust Enum Sized Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for complex Rust style enums with sized data types (tuple or struct
/// constructors).
class BorshRustEnumSizedDecoder<T>
    extends BorshRustEnumTypedDecoder<T, BorshCodecFixedSized<T>> {
  /// Creates a decoder for complex Rust style enums with sized data types (tuple or struct
  /// constructors).
  const BorshRustEnumSizedDecoder(super.variants);
}
