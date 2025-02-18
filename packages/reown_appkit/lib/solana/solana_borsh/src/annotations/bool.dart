/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Bool
/// ------------------------------------------------------------------------------------------------

/// An annotation for boolean data types.
///
/// ```
/// @BorshBool()
/// final bool property;
/// ```
class BorshBool extends BorshAnnotationSized<bool> {
  /// Creates an annotation for a boolean data type.
  const BorshBool();
}
