/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../interfaces/json_rpc_type_method.dart';

/// Minimum Ledger Slot
/// ------------------------------------------------------------------------------------------------

/// A codec for `minimumLedgerSlot` JSON RPC methods.
class MinimumLedgerSlot extends JsonRpcTypeMethod<u64> {
  /// Creates a codec for `minimumLedgerSlot` JSON RPC methods.
  MinimumLedgerSlot() : super('minimumLedgerSlot');
}
