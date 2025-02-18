/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Int
/// ------------------------------------------------------------------------------------------------

/// An interface for signed integer annotations.
abstract class BorshInt extends BorshAnnotationSized<int> {
  /// Creates an annotation for signed integers.
  const BorshInt();
}

/// Int8
/// ------------------------------------------------------------------------------------------------

/// An annotation for signed 8-bit integers.
///
/// ```
/// @BorshInt8()
/// final int property;
/// ```
class BorshInt8 extends BorshInt {
  /// Creates an annotation for a signed 8-bit integer.
  const BorshInt8();
}

/// Int16
/// ------------------------------------------------------------------------------------------------

/// An annotation for signed 16-bit integers.
///
/// ```
/// @BorshInt16()
/// final int property;
/// ```
class BorshInt16 extends BorshInt {
  /// Creates an annotation for a signed 16-bit integer.
  const BorshInt16();
}

/// Int32
/// ------------------------------------------------------------------------------------------------

/// An annotation for signed 32-bit integers.
///
/// ```
/// @BorshInt32()
/// final int property;
/// ```
class BorshInt32 extends BorshInt {
  /// Creates an annotation for a signed 32-bit integer.
  const BorshInt32();
}

/// Int64
/// ------------------------------------------------------------------------------------------------

/// An annotation for signed 64-bit integers.
///
/// ```
/// @BorshInt64()
/// final int property;
/// ```
class BorshInt64 extends BorshInt {
  /// Creates an annotation for a signed 64-bit integer.
  const BorshInt64();
}
