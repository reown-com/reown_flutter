/// Rewards Types
/// ------------------------------------------------------------------------------------------------
library;

enum RewardType {
  fee,
  rent,
  voting,
  staking,
  ;

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Throws an [ArgumentError] if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// RewardType.fromJson('fee');
  /// ```
  factory RewardType.fromJson(final String name) => values.byName(name);

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Returns `null` if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// RewardType.tryFromJson('fee');
  /// ```
  static RewardType? tryFromJson(final String? name) =>
      name != null ? RewardType.fromJson(name.toLowerCase()) : null;

  /// {@macro solana_common.Serializable.toJson}
  String toJson() => name;
}
