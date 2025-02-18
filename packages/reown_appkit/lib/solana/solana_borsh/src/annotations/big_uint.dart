/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Big Uint
/// ------------------------------------------------------------------------------------------------

/// An interface for unsigned big-integer annotations.
abstract class BorshBigUint extends BorshAnnotationSized<BigInt> {
  /// Creates an annotation for unsigned big-integers.
  const BorshBigUint();
}

/// Uint64
/// ------------------------------------------------------------------------------------------------

/// An annotation for unsigned 64-bit big-integers.
///
/// ```
/// @BorshUint64()
/// final BigInt property;
/// ```
class BorshUint64 extends BorshBigUint {
  /// Creates an annotation for a unsigned 64-bit big-integer.
  const BorshUint64();
}

/// Uint128
/// ------------------------------------------------------------------------------------------------

/// An annotation for unsigned 128-bit big-integers.
///
/// ```
/// @BorshUint128()
/// final BigInt property;
/// ```
class BorshUint128 extends BorshBigUint {
  /// Creates an annotation for a unsigned 128-bit big-integer.
  const BorshUint128();
}
