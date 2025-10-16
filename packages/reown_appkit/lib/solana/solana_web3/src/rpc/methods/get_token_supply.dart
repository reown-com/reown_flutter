/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../configs/get_token_supply_config.dart';
import '../interfaces/json_rpc_context_method.dart';
import '../models/token_amount.dart';

/// Get Token Supply
/// ------------------------------------------------------------------------------------------------

/// A codec for `getTokenSupply` JSON RPC methods.
class GetTokenSupply
    extends JsonRpcContextMethod<Map<String, dynamic>, TokenAmount> {
  /// Creates a codec for `getTokenSupply` JSON RPC methods.
  GetTokenSupply(final Pubkey mint, {final GetTokenSupplyConfig? config})
    : super(
        'getTokenSupply',
        values: [mint.toBase58()],
        config: config ?? const GetTokenSupplyConfig(),
      );

  @override
  TokenAmount valueDecoder(final Map<String, dynamic> value) =>
      TokenAmount.fromJson(value);
}
