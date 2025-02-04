/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../interfaces/json_rpc_list_type_method.dart';

/// Get Slot Leaders
/// ------------------------------------------------------------------------------------------------

/// A codec for `getSlotLeaders` JSON RPC methods.
class GetSlotLeaders extends JsonRpcListTypeMethod<String> {
  /// Creates a codec for `getSlotLeaders` JSON RPC methods.
  GetSlotLeaders(
    final u64 startSlot, {
    required final u64 limit,
  })  : assert(limit > 0 && limit <= 5000,
            '[GetSlotLeaders.limit] range 1 to 5000'),
        super(
          'getSlotLeaders',
          values: [startSlot, limit],
        );
}
