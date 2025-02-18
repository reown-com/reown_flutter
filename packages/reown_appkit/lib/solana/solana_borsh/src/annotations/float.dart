/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Float
/// ------------------------------------------------------------------------------------------------

/// An interface for floating point number annotations.
abstract class BorshFloat extends BorshAnnotationSized<double> {
  /// Creates an annotation for floating point numbers.
  const BorshFloat();
}

/// Float32
/// ------------------------------------------------------------------------------------------------

/// An annotation for 32-bit floating point numbers.
///
/// ```
/// @BorshFloat32()
/// final double property;
/// ```
class BorshFloat32 extends BorshFloat {
  /// Creates an annotation for a 32-bit floating point number.
  const BorshFloat32();
}

/// Float64
/// ------------------------------------------------------------------------------------------------

/// An annotation for 64-bit floating point numbers.
///
/// ```
/// @BorshFloat64()
/// final double property;
/// ```
class BorshFloat64 extends BorshFloat {
  /// Creates an annotation for a 64-bit floating point number.
  const BorshFloat64();
}
