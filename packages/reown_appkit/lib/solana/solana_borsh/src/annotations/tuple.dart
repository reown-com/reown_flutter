/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation.dart';
import 'tuple_typed.dart';

/// Tuple
/// ------------------------------------------------------------------------------------------------

/// An annotation for fixed-length arrays with multiple data types.
///
/// ```
/// @BorshTuple([BorshUint8(), BorshFloat64(), BorshBool()])
/// final List property; // [1, 2.0, true]
/// ```
class BorshTuple extends BorshTupleTyped<BorshAnnotation> {
  /// Creates an annotation for a fixed-length array with multiple data types.
  const BorshTuple(
    super.fields,
  );
}
