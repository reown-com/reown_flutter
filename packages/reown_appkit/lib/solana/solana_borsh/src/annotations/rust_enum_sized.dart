/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../models/rust_enum.dart';
import 'annotation_sized.dart';
import 'rust_enum_typed.dart';

/// Rust Enum Sized
/// ------------------------------------------------------------------------------------------------

/// An annotation for Rust style enums with sized data types (tuple or struct constructors).
///
/// ```
/// @BorshRustEnumSized([                             // enum RustEnum {
///   null,                                           //   Simple,
///   BorshTupleSized([BorshInt64(), BorshBool()]),   //   Tuple(i64, bool),
///   BorshStructSized({ 'x': BorshStringSized(10) }) //   Object { x: String }
/// ])                                                // }
/// final RustEnum property;
/// ```
class BorshRustEnumSized<T> extends BorshRustEnumTyped<T, BorshAnnotationSized>
    implements BorshAnnotationSized<RustEnum<T>> {
  /// Creates an annotation for Rust style enums with sized data types (tuple or struct
  /// constructors).
  const BorshRustEnumSized(super.variants);
}
