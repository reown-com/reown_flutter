/// Transaction Encodings
/// ------------------------------------------------------------------------------------------------
library;

enum TransactionEncoding {
  base58,
  base64,
  json,
  jsonParsed,
  ;

  /// Returns the enum variant where [TransactionEncoding.name] is equal to [name].
  ///
  /// Throws a [StateError] if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// TransactionEncoding.fromJson('base58');
  /// ```
  factory TransactionEncoding.fromJson(final String name) =>
      values.byName(name);

  /// Returns the enum variant where [TransactionEncoding.name] is equal to [name].
  ///
  /// Returns `null` if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// TransactionEncoding.tryFromJson('base58');
  /// ```
  static TransactionEncoding? tryFromJson(final String? name) =>
      name != null ? TransactionEncoding.fromJson(name) : null;

  /// {@macro solana_common.Serializable.toJson}
  String toJson() => name;
}
