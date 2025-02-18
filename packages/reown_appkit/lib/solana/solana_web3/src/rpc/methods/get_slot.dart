/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../configs/get_slot_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Get Slot
/// ------------------------------------------------------------------------------------------------

/// A codec for `getSlot` JSON RPC methods.
class GetSlot extends JsonRpcTypeMethod<u64> {
  /// Creates a codec for `getSlot` JSON RPC methods.
  GetSlot({
    final GetSlotConfig? config,
  }) : super(
          'getSlot',
          config: config ?? const GetSlotConfig(),
        );
}
