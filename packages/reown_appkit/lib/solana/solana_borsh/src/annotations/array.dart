/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation.dart';
import 'array_typed.dart';

/// Array
/// ------------------------------------------------------------------------------------------------

/// An annotation for fixed-length arrays.
///
/// ```
/// @BorshArray(BorshUint8(), 10)
/// final List<int> property;
/// ```
class BorshArray<T> extends BorshArrayTyped<T, BorshAnnotation<T>> {
  /// Creates an annotation for a fixed-length array.
  const BorshArray(
    super.subtype,
    super.length,
  );
}
