/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../annotations/annotation.dart';

/// List
/// ------------------------------------------------------------------------------------------------

/// An annotation for dynamically sized arrays.
///
/// ```
/// @BorshList(BorshInt64())
/// final List<int> property;
/// ```
class BorshList<T> extends BorshAnnotation<List<T>> {
  /// Creates an annotation for a dynamically sized array.
  const BorshList(this.subtype);

  /// The data type's annotation.
  final BorshAnnotation<T> subtype;
}
