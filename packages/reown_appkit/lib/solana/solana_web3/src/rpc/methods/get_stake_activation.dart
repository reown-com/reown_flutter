/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../configs/get_stake_activation_config.dart';
import '../interfaces/json_rpc_method.dart';
import '../models/stake_activation.dart';

/// Get Stake Activation
/// ------------------------------------------------------------------------------------------------

/// A codec for `getStakeActivation` JSON RPC methods.
class GetStakeActivation
    extends JsonRpcMethod<Map<String, dynamic>, StakeActivation> {
  /// Creates a codec for `getStakeActivation` JSON RPC methods.
  GetStakeActivation(
    final Pubkey account, {
    final GetStakeActivationConfig? config,
  }) : super(
          'getStakeActivation',
          values: [account.toBase58()],
          config: config ?? const GetStakeActivationConfig(),
        );

  @override
  StakeActivation decoder(
    final Map<String, dynamic> value,
  ) =>
      StakeActivation.fromJson(value);
}
