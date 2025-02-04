/// Stake Activation States
/// ------------------------------------------------------------------------------------------------
library;

enum StakeActivationState {
  active,
  inactive,
  activating,
  deactivating,
  ;

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Throws an [ArgumentError] if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// StakeActivationState.fromJson('finalized');
  /// ```
  factory StakeActivationState.fromJson(final String name) =>
      values.byName(name);

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Returns `null` if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// StakeActivationState.tryFromJson('finalized');
  /// ```
  static StakeActivationState? tryFromJson(final String? name) =>
      name != null ? StakeActivationState.fromJson(name) : null;
}
