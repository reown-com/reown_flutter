/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../utils/types.dart';
import 'annotation_sized.dart';
import 'tuple_typed.dart';

/// Tuple Sized
/// ------------------------------------------------------------------------------------------------

/// An annotation for fixed-length arrays with multiple sized data types.
///
/// ```
/// @BorshTupleSized([BorshUint8(), BorshFloat64(), BorshBool()])
/// final List property; // [1, 2.0, true]
/// ```
class BorshTupleSized extends BorshTupleTyped<BorshAnnotationSized>
    implements BorshAnnotationSized<Tuple> {
  /// Creates an annotation for a fixed-length array with multiple sized data types.
  const BorshTupleSized(
    super.fields,
  );
}
