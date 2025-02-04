/// Rust Enum
/// ------------------------------------------------------------------------------------------------
library;

/// A Rust style enum (tuple or struct constructor).
class RustEnum<T> {
  /// Creates a Rust style enum (tuple or struct constructor).
  const RustEnum(
    this.index, [
    this.values,
  ]) : assert(values == null || values is List || values is Map);

  /// The enum variant's index position.
  final int index;

  /// The enum variant's constructor parameters.
  final T? values;

  @override
  String toString() => '$runtimeType ($index, $values)';
}
