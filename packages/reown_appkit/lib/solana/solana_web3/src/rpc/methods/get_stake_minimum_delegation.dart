/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_stake_minimum_delegation_config.dart';
import '../interfaces/json_rpc_type_context_method.dart';

/// Get Stake Minimum Delegation
/// ------------------------------------------------------------------------------------------------

/// A codec for `getStakeMinimumDelegation` JSON RPC methods.
class GetStakeMinimumDelegation extends JsonRpcTypeContextMethod<u64> {
  /// Creates a codec for `getStakeMinimumDelegation` JSON RPC methods.
  GetStakeMinimumDelegation({final GetStakeMinimumDelegationConfig? config})
    : super(
        'getStakeMinimumDelegation',
        config: config ?? const GetStakeMinimumDelegationConfig(),
      );
}
