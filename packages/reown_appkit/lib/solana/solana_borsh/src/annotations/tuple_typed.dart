/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../utils/types.dart' show Tuple;
import 'annotation.dart';

/// Tuple Typed
/// ------------------------------------------------------------------------------------------------

/// An interface for `tuple` annotations.
class BorshTupleTyped<U extends BorshAnnotation>
    extends BorshAnnotation<Tuple> {
  /// Creates a fixed-length array with multiple data types.
  const BorshTupleTyped(this.fields);

  /// The field type annotations.
  final List<U> fields;

  /// The number of items in the tuple.
  int get length => fields.length;
}
