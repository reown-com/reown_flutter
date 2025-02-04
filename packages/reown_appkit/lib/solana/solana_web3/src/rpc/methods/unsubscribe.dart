/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/types.dart'
    show SubscriptionId;
import '../interfaces/json_rpc_type_method.dart';

/// Unsubscribe
/// ------------------------------------------------------------------------------------------------

/// A method handler for subscription cancellations.
class Unsubscribe extends JsonRpcTypeMethod<bool> {
  /// Creates a method handler for subscription cancellations.
  Unsubscribe(
    super.method,
    final SubscriptionId id,
  ) : super(
          values: [id],
        );
}
