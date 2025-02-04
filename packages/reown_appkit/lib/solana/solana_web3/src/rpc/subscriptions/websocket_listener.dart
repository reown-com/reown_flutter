/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'types.dart';
import 'websocket_subscription.dart';

/// Websocket Listener
/// ------------------------------------------------------------------------------------------------

/// A [WebsocketSubscription] with notification handlers.
class WebsocketListener<T> extends WebsocketSubscription<T> {
  /// Creates a notification listeners.
  const WebsocketListener(
    super.subscriptionId, {
    required this.onData,
    required this.onError,
    required this.onDone,
  });

  /// The websocket's `on data` handler.
  final WebsocketOnDataHandler<T>? onData;

  /// The websocket's `on error` handler.
  final WebsocketOnErrorHandler? onError;

  /// The websocket's `on done` handler.
  final WebsocketOnDoneHandler? onDone;
}
