/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';
import 'array_typed.dart';

/// Array Sized
/// ------------------------------------------------------------------------------------------------

/// An annotation for fixed-length arrays with sized data types.
///
/// ```
/// @BorshArraySized(BorshInt64(), 10)
/// final List<int> property;
/// ```
class BorshArraySized<T> extends BorshArrayTyped<T, BorshAnnotationSized<T>>
    implements BorshAnnotationSized<T> {
  /// Creates an annotation for a fixed-length array with sized data types.
  const BorshArraySized(super.subtype, super.length);
}
