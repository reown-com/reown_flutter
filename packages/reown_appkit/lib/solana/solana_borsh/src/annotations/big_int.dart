/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'annotation_sized.dart';

/// Big Int
/// ------------------------------------------------------------------------------------------------

/// An interface for signed big-integer annotations.
abstract class BorshBigInt extends BorshAnnotationSized<BigInt> {
  /// Creates an annotation for signed big-integers.
  const BorshBigInt();
}

/// Int128
/// ------------------------------------------------------------------------------------------------

/// An annotation for signed 128-bit big-integers.
///
/// ```
/// @BorshInt128()
/// final BigInt property;
/// ```
class BorshInt128 extends BorshBigInt {
  /// Creates an annotation for a signed 128-bit big-integer.
  const BorshInt128();
}
