/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Enum
/// ------------------------------------------------------------------------------------------------

/// An annotation for enum data types.
///
/// ```
/// @BorshEnum(MyEnum.values)
/// final MyEnum property;
/// ```
class BorshEnum<T extends Enum> extends BorshAnnotationSized<T> {
  /// Creates an annotation for an enum data type.
  const BorshEnum(this.values, [this.byteLength]);

  /// The enum's variants.
  final List<T> values;

  /// The encoded byte length.
  final int? byteLength;
}
