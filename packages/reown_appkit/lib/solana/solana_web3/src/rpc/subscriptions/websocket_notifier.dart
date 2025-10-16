/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:async' show Timer;
import 'package:reown_appkit/solana/solana_jsonrpc/types.dart'
    show SubscriptionId;
import 'types.dart';
import 'websocket_listener.dart';
import 'websocket_subscription.dart';

/// Websocket Notifier
/// ------------------------------------------------------------------------------------------------

/// A notification dispatcher.
class WebsocketNotifier<T> {
  /// Creates a notification dispatcher.
  WebsocketNotifier(
    this.subscribeMethod, {
    required this.subscriptionId,
    required this.autoUnsubscribes,
    required this.cancelOnError,
    required this.decoder,
    required final Duration? timeLimit,
    required void Function()? onTimeout,
  }) : assert(timeLimit == null || onTimeout != null),
       _timer = timeLimit != null && onTimeout != null
           ? Timer(timeLimit, onTimeout)
           : null;

  /// The notification listeners.
  final List<WebsocketListener<T>> _listeners = [];

  /// The timeout countdown.
  final Timer? _timer;

  /// The JSON RPC `subscribe` method name.
  final String subscribeMethod;

  /// The JSON RPC subscription id.
  final SubscriptionId subscriptionId;

  /// Whether the [subscribeMethod] automatically unsubscribes after sending a notification.
  final bool autoUnsubscribes;

  /// Whether the dispatcher should be closed when an error is received.
  final bool cancelOnError;

  /// The notification's result decoder.
  final JsonRpcNotificationDecoder<T> decoder;

  /// Whether the dispatcher has any listeners.
  bool get hasListeners => _listeners.isNotEmpty;

  /// Copies [_listeners].
  List<WebsocketListener<T>> get _copyListeners =>
      List.from(_listeners, growable: false);

  /// Adds a websocket subscription handler to the dispatcher.
  WebsocketSubscription<T> addListener({
    final WebsocketOnDataHandler<T>? onData,
    final WebsocketOnErrorHandler? onError,
    final WebsocketOnDoneHandler? onDone,
  }) {
    final WebsocketListener<T> listener = WebsocketListener(
      subscriptionId,
      onData: onData,
      onError: onError,
      onDone: onDone,
    );
    _listeners.add(listener);
    return listener;
  }

  /// Removes a websocket subscription handler from the dispatcher.
  bool removeListener(final WebsocketSubscription<T> listener) =>
      _listeners.remove(listener);

  /// Notifies all listeners of [data] received by the websocket.
  void notifyData(final Map<String, dynamic> data) {
    _timer?.cancel();
    final T decoded = decoder(data);
    final List<WebsocketListener<T>> listeners = _copyListeners;
    for (final WebsocketListener<T> listener in listeners) {
      listener.onData?.call(decoded);
    }
  }

  /// Notifies all listeners of an [error] received by the websocket.
  void notifyError(final Object error, [final StackTrace? stackTrace]) {
    _timer?.cancel();
    final List<WebsocketListener<T>> listeners = _copyListeners;
    for (final WebsocketListener<T> listener in listeners) {
      listener.onError?.call(error, stackTrace);
    }
  }

  /// Notifies all listeners that the dispatcher has been closed.
  void close() {
    _timer?.cancel();
    final List<WebsocketListener<T>> listeners = _copyListeners;
    _listeners.clear();
    for (final WebsocketListener<T> listener in listeners) {
      listener.onDone?.call();
    }
  }
}
