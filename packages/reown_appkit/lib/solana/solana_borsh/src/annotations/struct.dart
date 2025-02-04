/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation.dart';
import 'struct_typed.dart';

/// Struct
/// ------------------------------------------------------------------------------------------------

/// An annotation for borsh serializable objects with sized properties.
///
/// `The fields must be given in class property order`.
///
/// ```
/// @BorshSerializable()
/// class AClass {
///   const AClass(this.x, this.y);
///   final int x;
///   final int y;
/// }
///
/// @BorshSerializable()
/// class BClass {
///   const BClass(this.property);
///   @BorshStructSized({
///     'x': BorshInt64(),
///     'y': BorshInt64(),
///   })
///   final AClass property;
/// }
/// ```
class BorshStruct extends BorshStructTyped<BorshAnnotation> {
  /// Creates an annotation for borsh serializable objects.
  const BorshStruct(
    super.schema,
  );
}
