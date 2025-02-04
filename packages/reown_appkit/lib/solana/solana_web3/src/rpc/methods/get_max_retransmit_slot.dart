/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../interfaces/json_rpc_type_method.dart';

/// Get Max Retransmit Slot
/// ------------------------------------------------------------------------------------------------

/// A codec for `getMaxRetransmitSlot` JSON RPC methods.
class GetMaxRetransmitSlot extends JsonRpcTypeMethod<u64> {
  /// Creates a codec for `getMaxRetransmitSlot` JSON RPC methods.
  GetMaxRetransmitSlot() : super('getMaxRetransmitSlot');
}
