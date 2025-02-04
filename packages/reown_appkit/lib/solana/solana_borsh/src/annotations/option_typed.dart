/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../models/option_type.dart';
import 'annotation.dart';

/// Option Typed
/// ------------------------------------------------------------------------------------------------

/// An interface for `option` annotations.
abstract class BorshOptionTyped<T, U extends BorshAnnotation<T?>>
    extends BorshAnnotation<T?> {
  /// Creates an annotation for an optional value.
  const BorshOptionTyped(
    this.subtype, [
    this.type,
  ]);

  /// The data type's annotation.
  final U subtype;

  /// The option type (default: [BorshOptionType.rust]).
  final BorshOptionType? type;
}
