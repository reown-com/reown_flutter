/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation.dart';

/// Vec Typed
/// ------------------------------------------------------------------------------------------------

/// An interface for `vec` annotations.
abstract class BorshVecTyped<T, U extends BorshAnnotation<T>>
    extends BorshAnnotation<List<T>> {
  /// Creates an annotation for a dynamically sized array.
  const BorshVecTyped(this.subtype);

  /// The data type's annotation.
  final U subtype;
}
