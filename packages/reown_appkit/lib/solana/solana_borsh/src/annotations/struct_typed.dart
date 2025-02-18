/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation.dart';

/// Struct Typed
/// ------------------------------------------------------------------------------------------------

/// An interface for `struct` annotations.
abstract class BorshStructTyped<U extends BorshAnnotation>
    extends BorshAnnotation<Map<String, dynamic>> {
  /// Creates an annotation for borsh serializable objects.
  const BorshStructTyped(
    this.schema,
  );

  /// The ordered field annotations.
  final Map<String, U> schema;
}
