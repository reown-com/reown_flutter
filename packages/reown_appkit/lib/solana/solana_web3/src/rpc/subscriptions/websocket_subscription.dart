/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/types.dart'
    show SubscriptionId;

/// Websocket Subscription
/// ------------------------------------------------------------------------------------------------

/// A websocket notification subscription.
abstract class WebsocketSubscription<T> {
  /// Creates a websocket notification subscription.
  const WebsocketSubscription(this.subscriptionId);

  /// The JSON RPC subscription id.
  final SubscriptionId subscriptionId;
}
