/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation.dart';
import 'option_typed.dart';

/// Option
/// ------------------------------------------------------------------------------------------------

/// An annotation for optional values.
///
/// ```
/// @BorshOption(BorshInt64())
/// final int? property;
/// ```
class BorshOption<T> extends BorshOptionTyped<T, BorshAnnotation<T>> {
  /// Creates an annotation for an optional value.
  const BorshOption(
    super.subtype, [
    super.type,
  ]);
}
