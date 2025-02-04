/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation.dart';
import 'rust_enum_typed.dart';

/// Rust Enum
/// ------------------------------------------------------------------------------------------------

/// An annotation for complex Rust style enums (tuple or struct constructors).
///
/// ```
/// @BorshRustEnum([                            // enum RustEnum {
///   null,                                     //   Simple,
///   BorshTuple([BorshInt64(), BorshBool()]),  //   Tuple(i64, bool),
///   BorshStruct({ 'x': BorshString() })       //   Object { x: String }
/// ])                                          // }
/// final RustEnum property;
/// ```
class BorshRustEnum<T> extends BorshRustEnumTyped<T, BorshAnnotation> {
  /// Creates an annotation for complex Rust style enums (tuple or struct constructors).
  const BorshRustEnum(
    super.variants,
  );
}
