/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../models/rust_enum.dart';
import 'annotation.dart';

/// Rust Enum Typed
/// ------------------------------------------------------------------------------------------------

/// An interface for `rust enum` annotations.
abstract class BorshRustEnumTyped<T, U extends BorshAnnotation>
    extends BorshAnnotation<RustEnum<T>> {
  /// Creates an annotation for complex Rust style enums (tuple or struct constructors).
  const BorshRustEnumTyped(this.variants);

  /// The enum variants constructor parameters.
  final List<U?> variants;
}
