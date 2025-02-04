/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation.dart';
import 'vec_typed.dart';

/// Vec
/// ------------------------------------------------------------------------------------------------

/// An annotation for dynamically sized arrays.
///
/// ```
/// @BorshVec(BorshInt64())
/// final List<int> property;
/// ```
class BorshVec<T> extends BorshVecTyped<T, BorshAnnotation<T>> {
  /// Creates an annotation for a dynamically sized array.
  const BorshVec(
    super.subtype,
  );
}
