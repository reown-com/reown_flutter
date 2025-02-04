/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../interfaces/json_rpc_type_method.dart';

/// Get Max Shred Insert Slot
/// ------------------------------------------------------------------------------------------------

/// A codec for `getMaxShredInsertSlot` JSON RPC methods.
class GetMaxShredInsertSlot extends JsonRpcTypeMethod<u64> {
  /// Creates a codec for `getMaxShredInsertSlot` JSON RPC methods.
  GetMaxShredInsertSlot() : super('getMaxShredInsertSlot');
}
