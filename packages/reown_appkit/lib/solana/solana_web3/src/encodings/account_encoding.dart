/// Account Encodings
/// ------------------------------------------------------------------------------------------------
library;

enum AccountEncoding {
  base58('base58'),
  base64('base64'),
  base64Zstd('base64+zstd'),
  jsonParsed('jsonParsed'),
  ;

  /// Stores the encoding's [_name] as a property of the enum variant.
  const AccountEncoding(this._name);

  /// The variant's string value.
  final String _name;

  /// @override [EnumName.name] to return [_name];
  String get name => _name;

  /// If true, the value is valid for encoding binary data (`base58`, `base64` or `base64Zstd`).
  bool get isBinary {
    return this == AccountEncoding.base58 ||
        this == AccountEncoding.base64 ||
        this == AccountEncoding.base64Zstd;
  }

  /// If true, the value is valid for encoding JSON data (`json` or `jsonParsed`).
  bool get isJson {
    return this == AccountEncoding.jsonParsed;
  }

  /// Returns the enum variant where [AccountEncoding.name] is equal to [name].
  ///
  /// Throws a [StateError] if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// AccountEncoding.fromJson('base58');
  /// ```
  factory AccountEncoding.fromJson(final String name) {
    return values
        .firstWhere((final AccountEncoding property) => property._name == name);
  }

  /// Returns the enum variant where [AccountEncoding.name] is equal to [name].
  ///
  /// Returns `null` if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// AccountEncoding.tryFromJson('base58');
  /// ```
  static AccountEncoding? tryFromJson(final String? name) {
    return name != null ? AccountEncoding.fromJson(name) : null;
  }

  /// {@macro solana_common.Serializable.toJson}
  String toJson() => _name;
}
