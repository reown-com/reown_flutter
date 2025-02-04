/// Num Extension
/// ------------------------------------------------------------------------------------------------
library;

extension NumToBigInt on num {
  /// Creates a [BigInt] from `this` number value.
  BigInt toBigInt() => BigInt.from(this);
}
