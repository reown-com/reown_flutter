/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../annotations/annotation.dart';

/// Array Typed
/// ------------------------------------------------------------------------------------------------

/// An interface for `array` annotations.
abstract class BorshArrayTyped<T, U extends BorshAnnotation<T>>
    extends BorshAnnotation<T> {
  /// Creates an annotation for a fixed-length array.
  const BorshArrayTyped(this.subtype, this.length);

  /// The subtype's codec.
  final U subtype;

  /// The number of items in the array.
  final int length;
}
