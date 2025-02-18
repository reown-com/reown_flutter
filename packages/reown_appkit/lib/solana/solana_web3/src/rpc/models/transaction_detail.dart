/// Transaction Details
/// ------------------------------------------------------------------------------------------------
library;

enum TransactionDetail {
  full,
  signatures,
  none;

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Throws an [ArgumentError] if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// TransactionDetail.fromJson('full');
  /// ```
  factory TransactionDetail.fromJson(final String name) => values.byName(name);

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Returns `null` if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// TransactionDetail.tryFromJson('full');
  /// ```
  static TransactionDetail? tryFromJson(final String? name) {
    return name != null ? TransactionDetail.fromJson(name) : null;
  }
}
