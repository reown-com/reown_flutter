/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_fee_for_message_config.dart';
import '../interfaces/json_rpc_type_context_method.dart';

/// Get Fee For Message
/// ------------------------------------------------------------------------------------------------

/// A codec for `getFeeForMessage` JSON RPC methods.
class GetFeeForMessage extends JsonRpcTypeContextMethod<u64?> {
  /// Creates a codec for `getFeeForMessage` JSON RPC methods.
  GetFeeForMessage(final String message, {final GetFeeForMessageConfig? config})
    : super(
        'getFeeForMessage',
        values: [message],
        config: config ?? const GetFeeForMessageConfig(),
      );
}
