/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Buffer
/// ------------------------------------------------------------------------------------------------

/// An annotation for fixed-length byte arrays.
///
/// ```
/// @BorshBuffer(10)
/// final List<int> property;
/// ```
class BorshBuffer extends BorshAnnotationSized<Iterable<int>> {
  /// Creates an annotation for a fixed-length byte array.
  const BorshBuffer(this.byteLength);

  /// The buffer length.
  final int byteLength;
}
