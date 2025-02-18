/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Uint
/// ------------------------------------------------------------------------------------------------

/// An interface for unsigned integer annotations.
abstract class BorshUint extends BorshAnnotationSized<int> {
  /// Creates an annotation for unsigned integers.
  const BorshUint();
}

/// Uint8
/// ------------------------------------------------------------------------------------------------

/// An annotation for unsigned 8-bit integers.
///
/// ```
/// @BorshUint8()
/// final int property;
/// ```
class BorshUint8 extends BorshUint {
  /// Creates an annotation for an unsigned 8-bit integer.
  const BorshUint8();
}

/// Uint16
/// ------------------------------------------------------------------------------------------------

/// An annotation for unsigned 16-bit integers.
///
/// ```
/// @BorshUint16()
/// final int property;
/// ```
class BorshUint16 extends BorshUint {
  /// Creates an annotation for an unsigned 16-bit integer.
  const BorshUint16();
}

/// Uint32
/// ------------------------------------------------------------------------------------------------

/// An annotation for unsigned 32-bit integers.
///
/// ```
/// @BorshUint32()
/// final int property;
/// ```
class BorshUint32 extends BorshUint {
  /// Creates an annotation for an unsigned 32-bit integer.
  const BorshUint32();
}
