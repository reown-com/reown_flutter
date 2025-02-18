/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64, usize;
import '../configs/get_minimum_balance_for_rent_exemption_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Get Minimum Balance For Rent Exemption
/// ------------------------------------------------------------------------------------------------

/// A codec for `getMinimumBalanceForRentExemption` JSON RPC methods.
class GetMinimumBalanceForRentExemption extends JsonRpcTypeMethod<u64> {
  /// Creates a codec for `getMinimumBalanceForRentExemption` JSON RPC methods.
  GetMinimumBalanceForRentExemption(
    final usize length, {
    final GetMinimumBalanceForRentExemptionConfig? config,
  }) : super(
          'getMinimumBalanceForRentExemption',
          values: [length],
          config: config ?? const GetMinimumBalanceForRentExemptionConfig(),
        );
}
