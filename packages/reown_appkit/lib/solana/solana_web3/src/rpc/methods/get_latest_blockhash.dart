/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_latest_blockhash_config.dart';
import '../interfaces/json_rpc_context_method.dart';
import '../models/blockhash_with_expiry_block_height.dart';

/// Get Latest Blockhash
/// ------------------------------------------------------------------------------------------------

/// A method handler for `getLatestBlockhash`.
class GetLatestBlockhash
    extends
        JsonRpcContextMethod<
          Map<String, dynamic>,
          BlockhashWithExpiryBlockHeight
        > {
  /// Creates a method handler for `getLatestBlockhash`.
  GetLatestBlockhash({final GetLatestBlockhashConfig? config})
    : super(
        'getLatestBlockhash',
        config: config ?? const GetLatestBlockhashConfig(),
      );

  @override
  BlockhashWithExpiryBlockHeight valueDecoder(
    final Map<String, dynamic> value,
  ) => BlockhashWithExpiryBlockHeight.fromJson(value);
}
