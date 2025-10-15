/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/is_blockhash_valid_config.dart';
import '../interfaces/json_rpc_type_context_method.dart';

/// Is Blockhash Valid
/// ------------------------------------------------------------------------------------------------

/// A codec for `isBlockhashValid` JSON RPC methods.
class IsBlockhashValid extends JsonRpcTypeContextMethod<bool> {
  /// Creates a codec for `isBlockhashValid` JSON RPC methods.
  IsBlockhashValid(
    final String blockhash, {
    final IsBlockhashValidConfig? config,
  }) : super(
         'isBlockhashValid',
         values: [blockhash],
         config: config ?? const IsBlockhashValidConfig(),
       );
}
