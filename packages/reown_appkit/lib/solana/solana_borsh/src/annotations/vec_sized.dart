/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';
import 'vec_typed.dart';

/// Vec Sized
/// ------------------------------------------------------------------------------------------------

/// An annotation for dynamically sized arrays with sized data types.
///
/// ```
/// @BorshVecSized(BorshInt64())
/// final List<int> property;
/// ```
class BorshVecSized<T> extends BorshVecTyped<T, BorshAnnotationSized<T>>
    implements BorshAnnotationSized<List<T>> {
  /// Creates an annotation for a dynamically sized array with sized data types.
  const BorshVecSized(
    super.subtype,
    this.capacity,
  );

  /// The maximum length.
  final int capacity;
}
