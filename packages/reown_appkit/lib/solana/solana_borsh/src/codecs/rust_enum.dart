/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../converters/codec.dart';
import 'rust_enum_typed.dart';

/// Rust Enum Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for fixed-length arrays with multiple data types.
class BorshRustEnumCodec<T> extends BorshRustEnumTypedCodec<T, BorshCodec<T>> {
  /// Creates a codec for fixed-length arrays with multiple data types.
  const BorshRustEnumCodec(super.variants);

  @override
  BorshRustEnumEncoder<T> get encoder => BorshRustEnumEncoder(variants);

  @override
  BorshRustEnumDecoder<T> get decoder => BorshRustEnumDecoder(variants);
}

/// Rust Enum Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for fixed-length arrays with multiple data types.
class BorshRustEnumEncoder<T>
    extends BorshRustEnumTypedEncoder<T, BorshCodec<T>> {
  /// Creates an encoder for fixed-length arrays with multiple data types.
  const BorshRustEnumEncoder(super.variants);
}

/// Rust Enum Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for fixed-length arrays with multiple data types.
class BorshRustEnumDecoder<T>
    extends BorshRustEnumTypedDecoder<T, BorshCodec<T>> {
  /// Creates a decoder for fixed-length arrays with multiple data types.
  const BorshRustEnumDecoder(super.variants);
}
