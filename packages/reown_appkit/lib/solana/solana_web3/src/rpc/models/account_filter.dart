/// Account Filter
/// ------------------------------------------------------------------------------------------------
library;

enum AccountFilter {
  circulating,
  nonCirculating,
  ;

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Throws an [ArgumentError] if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// AccountFilter.fromJson('circulating');
  /// ```
  factory AccountFilter.fromJson(final String name) => values.byName(name);

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Returns `null` if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// AccountFilter.tryFromJson('ok');
  /// ```
  static AccountFilter? tryFromJson(final String? name) =>
      name != null ? AccountFilter.fromJson(name) : null;
}
