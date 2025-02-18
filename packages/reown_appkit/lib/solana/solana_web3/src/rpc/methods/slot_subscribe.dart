/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/types.dart'
    show SubscriptionId;
import '../interfaces/json_rpc_type_method.dart';

/// Slot Subscribe
/// ------------------------------------------------------------------------------------------------

/// A method handler for `slotSubscribe`.
class SlotSubscribe extends JsonRpcTypeMethod<SubscriptionId> {
  /// Creates a method handler for `slotSubscribe`.
  const SlotSubscribe() : super('slotSubscribe');
}
