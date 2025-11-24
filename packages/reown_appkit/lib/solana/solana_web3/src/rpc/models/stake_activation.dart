/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import 'stake_activation_state.dart';

/// Stake Activation
/// ------------------------------------------------------------------------------------------------

class StakeActivation extends Serializable {
  /// Epoch activation information for a stake account.
  const StakeActivation({
    required this.state,
    required this.active,
    required this.inactive,
  });

  /// The stake account's activation state.
  final StakeActivationState state;

  /// The stake active during the epoch.
  final u64 active;

  /// The stake inactive during the epoch.
  final u64 inactive;

  /// {@macro solana_common.Serializable.fromJson}
  factory StakeActivation.fromJson(final Map<String, dynamic> json) =>
      StakeActivation(
        state: StakeActivationState.fromJson(json['state']),
        active: json['active'],
        inactive: json['inactive'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static StakeActivation? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? StakeActivation.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'state': state.name,
    'active': active,
    'inactive': inactive,
  };
}
