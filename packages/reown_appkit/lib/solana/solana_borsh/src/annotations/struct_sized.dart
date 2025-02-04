/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';
import 'struct_typed.dart';

/// Struct Sized
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
class BorshStructSized extends BorshStructTyped<BorshAnnotationSized>
    implements BorshAnnotationSized<Map<String, dynamic>> {
  /// Creates an annotation for borsh serializable objects.
  const BorshStructSized(
    super.schema,
  );
}
