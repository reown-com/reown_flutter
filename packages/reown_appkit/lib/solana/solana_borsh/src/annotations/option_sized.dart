/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';
import 'option_typed.dart';

/// Option Sized
/// ------------------------------------------------------------------------------------------------

/// An annotation for optional sized values.
///
/// ```
/// @BorshOptionSized(BorshInt64())
/// final int? property;
/// ```
class BorshOptionSized<T> extends BorshOptionTyped<T, BorshAnnotationSized<T>>
    implements BorshAnnotationSized<T?> {
  /// Creates an annotation for an optional sized value.
  const BorshOptionSized(
    super.subtype, [
    super.type,
  ]);
}
