/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Date Time
/// ------------------------------------------------------------------------------------------------

/// An annotation for date time data types.
///
/// ```
/// @BorshDateTime()
/// final DateTime property;
/// ```
class BorshDateTime extends BorshAnnotationSized<DateTime> {
  /// Creates an annotation for a date time data type.
  const BorshDateTime();
}
