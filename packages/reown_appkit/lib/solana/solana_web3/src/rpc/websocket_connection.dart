/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:async' show TimeoutException;
import 'package:flutter/foundation.dart' show protected;
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart';
import 'package:reown_appkit/solana/solana_jsonrpc/types.dart';
import '../crypto/pubkey.dart';
import 'configs/index.dart';
import 'methods/account_subscribe.dart';
import 'methods/logs_subscribe.dart';
import 'methods/program_subscribe.dart';
import 'methods/slot_subscribe.dart';
import 'models/index.dart';
import 'methods/signature_subscribe.dart';
import 'methods/unsubscribe.dart';
import 'subscriptions/types.dart';
import 'subscriptions/websocket_notifier.dart';
import 'subscriptions/websocket_subscription.dart';

/// Websocket Connection
/// ------------------------------------------------------------------------------------------------

/// The Websocket JSON RPC method calls.
mixin WebsocketConnection {
  /// Websocket client.
  JsonRpcWebsocketClient get websocketClient;

  /// Websocket client request configurations.
  JsonRpcClientConfig? get websocketClientConfig => null;

  /// The default commitment level applied to all methods that query bank state.
  Commitment? get commitment;

  /// The notification dispatchers.
  final Map<SubscriptionId, WebsocketNotifier> _notifiers = {};

  /// Returns a copy of the notification dispatchers - debugging only.
  @protected
  Map<SubscriptionId, WebsocketNotifier> get debugNotifiers =>
      Map.from(_notifiers);

  /// Closes all notification dispatchers - debugging only.
  @protected
  void debugClose() {
    for (final WebsocketNotifier notifier in _notifiers.values) {
      notifier.close();
    }
  }

  /// The websocket's connect handler.
  @protected
  void onWebsocketConnect() {}

  /// The websocket's disconnect handler.
  ///
  /// Closes all notification dispatchers.
  @protected
  void onWebsocketDisconnect() {
    final List<WebsocketNotifier> notifiers =
        _notifiers.values.toList(growable: false);
    _notifiers.clear();
    for (final WebsocketNotifier notifier in notifiers) {
      notifier.close();
    }
  }

  /// The websocket's [data] handler.
  ///
  /// Forwards incoming notifications to their dispatchers.
  @protected
  void onWebsocketData(final dynamic data) {
    try {
      final response = JsonRpcNotificationResponse.fromJson(data);
      final SubscriptionId subscriptionId = response.params.subscription;
      final WebsocketNotifier? notifier = _notifiers[subscriptionId];
      if (notifier != null) {
        notifier.notifyData(response.params.result);
        if (notifier.autoUnsubscribes) {
          _close(subscriptionId);
        }
      } else {
        final String method = response.method;
        _unsubscribe(method, subscriptionId).ignore();
      }
    } catch (error) {
      // print('Notification data $data');
      // print('Notification error $error');
    }
  }

  /// The websocket's [error] handler.
  ///
  /// Forwards stream errors to the notification dispatchers.
  @protected
  void onWebsocketError(final Object error, [final StackTrace? stackTrace]) {
    final List<WebsocketNotifier> notifiers =
        _notifiers.values.toList(growable: false);
    for (final WebsocketNotifier notifier in notifiers) {
      _onNotifyError(notifier, error, stackTrace);
    }
  }

  /// Calls [notifier]'s [WebsocketNotifier.notifyError] handler with [error] and cancels the
  /// subscription if [WebsocketNotifier.cancelOnError] is true.
  void _onNotifyError(
    final WebsocketNotifier notifier,
    final Object error, [
    final StackTrace? stackTrace,
  ]) {
    notifier.notifyError(error, stackTrace);
    if (notifier.cancelOnError) {
      _unsubscribe(notifier.subscribeMethod, notifier.subscriptionId).ignore();
    }
  }

  /// Calls the [subscriptionId]'s [WebsocketNotifier.notifyError] handler with a [TimeoutException]
  /// and cancels the subscription if [WebsocketNotifier.cancelOnError] is true.
  void _onTimeout(final SubscriptionId subscriptionId) {
    final WebsocketNotifier? notifier = _notifiers[subscriptionId];
    if (notifier != null) {
      _onNotifyError(notifier, TimeoutException('Subscription timed out.'));
    }
  }

  /// Removes and closes [subscriptionId]'s notifier.
  void _close(final SubscriptionId subscriptionId) =>
      _notifiers.remove(subscriptionId)?.close();

  // /// Generates a hash that uniquely identifies this request's method invocation.
  // ///
  // /// The hash is derived by JSON encoding the request's `method` and `params`. Two
  // /// [JsonRpcRequest]s will produce the same hash if they contain the same `method` and
  // /// `ordered params`.
  // ///
  // /// ```
  // /// final p0 = ['Gr54...5Fd5', { 'encoding': 'base64', 'commitment': 'finalized' }];
  // /// final r0 = JsonRpcRequest(Method.getAccountInfo, params: p0);
  // ///
  // /// final p1 = ['Gr54...5Fd5', { 'encoding': 'base64', 'commitment': 'finalized' }];
  // /// final r1 = JsonRpcRequest(Method.getAccountInfo, params: p1);
  // ///
  // /// final p2 = ['Gr54...5Fd5', { 'commitment': 'finalized', 'encoding': 'base64' }];
  // /// final r2 = JsonRpcRequest(Method.getAccountInfo, params: p2);
  // ///
  // /// assert(r0.hash() == r1.hash()); // true
  // /// assert(r1.hash() == r2.hash()); // false, the configuration values are ordered differently.
  // ///
  // /// TODO: Sort by keys, then hash.
  // /// ```
  // String _hash(final JsonRpcRequest request) => json.encode([request.method, request.params]);

  /// Subscribes to the JSON RPC websocket notification of [method].
  ///
  /// The notification's `result` is mapped to type [T] by the decoder and forwarded to all
  /// notification listeners.
  ///
  /// if [cancelOnError] the subscription will be cancelled if the websocket stream emits any error
  /// or the subscription times out.
  Future<WebsocketSubscription<T>> subscribe<T>(
    final JsonRpcSubscribeMethod method,
    final JsonRpcNotificationDecoder<T> decoder, {
    final WebsocketOnDataHandler<T>? onData,
    final WebsocketOnErrorHandler? onError,
    final WebsocketOnDoneHandler? onDone,
    final bool cancelOnError = false,
    final bool autoUnsubscribes = false,
    final Duration? timeLimit,
  }) async {
    /// Subscribe to the JSON RPC notifications.
    final JsonRpcSubscribeResponse response = await websocketClient.send(
      method.request(commitment),
      method.response,
      config: websocketClientConfig,
    );

    /// Get the subscription id.
    final SubscriptionId subscriptionId = response.result!;

    /// Get or create a notification dispatcher for the subscription.
    final WebsocketNotifier<T> notifier =
        (_notifiers[subscriptionId] ??= WebsocketNotifier<T>(
      method.method,
      subscriptionId: subscriptionId,
      cancelOnError: cancelOnError,
      autoUnsubscribes: autoUnsubscribes,
      decoder: decoder,
      timeLimit: timeLimit,
      onTimeout: () => _onTimeout(subscriptionId),
    )) as WebsocketNotifier<T>;

    /// Add a listener to the dispatcher's queue.
    return notifier.addListener(
      onData: onData,
      onError: onError,
      onDone: onDone,
    );
  }

  /// Cancels a websocket notification [subscription] and unsubscribes from the JSON RPC method if
  /// the subscription contains no more listeners.
  Future<bool> unsubscribe(final WebsocketSubscription subscription) async {
    final SubscriptionId subscriptionId = subscription.subscriptionId;
    final WebsocketNotifier? notifier = _notifiers[subscription.subscriptionId];
    if (notifier != null) {
      notifier.removeListener(subscription);
      if (!notifier.hasListeners) {
        return _unsubscribe(notifier.subscribeMethod, subscriptionId);
      }
    }
    return false;
  }

  /// Unsubscribes a JSON RPC notification [method].
  Future<bool> _unsubscribe(
      final String method, final SubscriptionId subscriptionId) async {
    _close(subscriptionId);
    final RegExp suffixRegexp =
        RegExp(r'(Subscribe|Unsubscribe|Notification)$');
    assert(suffixRegexp.hasMatch(method));
    final String unsubscribeMethod =
        method.replaceFirst(suffixRegexp, 'Unsubscribe');
    final rpc = Unsubscribe(unsubscribeMethod, subscriptionId);
    try {
      return (await websocketClient.send(rpc.request(commitment), rpc.response))
          .result!;
    } on JsonRpcException catch (error) {
      return error.code == JsonRpcExceptionCode.invalidParams
          ? Future.value(false)
          : Future.error(error);
    }
  }

  // /// Subscribes to receive JSON RPC notifications for [rpc.method].
  // ///
  // /// Notifications are mapped to type [T] using the [decoder].
  // ///
  // /// If [timeLimit] is provided the stream will send [TimeoutException]s to the [onError] handler
  // /// each time [timeLimit] elapses without receving any data. The handler is responsible for
  // /// closing the stream.
  // Future<WebsocketSubscription<T>> _subscribe<T>(
  //   final JsonRpcSubscribeMethod rpc,
  //   final JsonRpcNotificationDecoder<T> decoder, {
  //   final WebsocketOnDataHandler<T>? onData,
  //   final WebsocketOnErrorHandler? onError,
  //   final WebsocketOnDoneHandler? onDone,
  //   final Duration? timeLimit,
  // }) async {

  //   /// Create the JSON RPC subscribe request.
  //   final JsonRpcRequest request = rpc.request(commitment);

  //   /// The subscription method name.
  //   final String method = rpc.method;

  //   /// Generate the hash that uniquely identifies this subscription.
  //   final String hash = _hash(request);

  //   /// The subscription id.
  //   SubscriptionId? subscriptionId;

  //   try {

  //     /// Get the subscription (existing or make a new request).
  //     JsonRpcSubscribeResponse response = await (_subscriptions[hash]
  //       ??= websocketClient.send(request, rpc.response, config: websocketClientConfig));

  //     /// Get the subscription id from the response.
  //     subscriptionId = response.result!;

  //     /// Check that the subscription response is still valid. It's possible (but not likely) that
  //     /// the OS time-sliced between waiting for an existing response and an unsubscribe call.
  //     check(_subscriptions.containsKey(hash));

  //     /// Get or create a stream controller to broadcast notifications.
  //     final WebsocketNotifier<T> notifier = (_notifiers[subscriptionId]
  //       ??= WebsocketNotifier<T>(subscribeMethod: method, hash: hash, decoder: decoder)
  //     ) as WebsocketNotifier<T>;

  //     /// Get the stream.
  //     final Stream<T> stream = timeLimit != null
  //       ? notifier.controller.stream.timeout(timeLimit)
  //       : notifier.controller.stream;

  //     /// Create a subscription.
  //     return WebsocketSubscription<T>(
  //       subscriptionId,
  //       streamSubscription: stream.listen(
  //         onData,
  //         onError: onError,
  //         onDone: _onDoneHandler(subscriptionId, onDone),
  //       ),
  //     );

  //   } catch (error) {
  //     return _subscribeError(error, hash: hash, subscriptionId: subscriptionId);
  //   }
  // }

  // /// Creates an onDone handler to unsubscribe a closed stream.
  // WebsocketOnDoneHandler _onDoneHandler(
  //   final SubscriptionId subscriptionId,
  //   final WebsocketOnDoneHandler? onDone,
  // ) => () async {
  //   await _unsubscribe(subscriptionId);
  //   onDone?.call();
  // };

  // /// Cleans up a `_subscribe` error.
  // Future<T> _subscribeError<T>(
  //   final Object error, {
  //   required final MethodHash hash,
  //   required final SubscriptionId? subscriptionId,
  // }) {
  //   if (subscriptionId != null) {
  //     _unsubscribe(subscriptionId).ignore();
  //   } else {
  //     _subscriptions.remove(hash);
  //   }
  //   return Future.error(error);
  // }

  // /// {@macro solana_web3.Connection.subscribeCompleter}
  // ///
  // /// If [timeLimit] is omitted a default duration of `60 seconds` is applied.
  // Future<T> _subscribeOnce<T>(
  //   final JsonRpcSubscribeMethod rpc,
  //   final JsonRpcNotificationDecoder<T> decoder, {
  //   final Duration? timeLimit,
  //   final bool unsubscribe = true,
  // }) async {
  //   final SafeCompleter<T> completer = SafeCompleter.sync();
  //   final WebsocketSubscription<T> subscription = await _subscribeCompleter(
  //     completer,
  //     rpc: rpc,
  //     decoder: decoder,
  //     timeLimit: timeLimit ?? const Duration(seconds: 60),
  //   );
  //   return _subscribeHandler(
  //     subscription,
  //     completer,
  //     unsubscribe: unsubscribe,
  //   );
  // }

  // /// {@macro solana_web3.Connection.subscribeCompleter}
  // ///
  // /// {@template solana_web3.Connection.subscribeController}
  // /// The pending subscription can be cancelled by calling [WebsocketSubscriptionController.cancel].
  // /// {@endtemplate}
  // Future<WebsocketSubscriptionController<T>> _subscribeController<T>(
  //   final JsonRpcSubscribeMethod rpc,
  //   final JsonRpcNotificationDecoder<T> decoder, {
  //   final Duration? timeLimit,
  //   final bool unsubscribe = true,
  // }) async {
  //   final SafeCompleter<T> completer = SafeCompleter.sync();
  //   final WebsocketSubscription<T> subscription = await _subscribeCompleter(
  //     completer,
  //     rpc: rpc,
  //     decoder: decoder,
  //     timeLimit: timeLimit,
  //   );
  //   return WebsocketSubscriptionController(
  //     _subscribeHandler(
  //       subscription,
  //       completer,
  //       unsubscribe: unsubscribe,
  //     ),
  //     cancel: () => completer.completeError(
  //       const WebSocketException('Subscription cancelled.'),
  //     ),
  //   );
  // }

  // /// {@template solana_web3.Connection.subscribeCompleter}
  // /// The subscription returns the first result or a [TimeoutException] if [timeLimit] elapses
  // /// before receiving any data. The subscription is automatically cancelled when the future
  // /// completes.
  // /// {@endtemplate}
  // Future<WebsocketSubscription<T>> _subscribeCompleter<T>(
  //   final SafeCompleter<T> completer, {
  //   required final JsonRpcSubscribeMethod rpc,
  //   required final JsonRpcNotificationDecoder<T> decoder,
  //   required final Duration? timeLimit,
  // }) => _subscribe(
  //     rpc,
  //     decoder,
  //     onData: completer.complete,
  //     onError: completer.completeError,
  //     onDone: () => completer.completeError(const WebSocketException('Subscription closed.')),
  //     timeLimit: timeLimit,
  //   );

  // /// Waits for [completer] to finish and cleans up the subscription. If [unsubscribe] is true, the
  // /// JSON RPC websocket subscription is cancelled.
  // Future<T> _subscribeHandler<T>(
  //   final WebsocketSubscription<T> subscription,
  //   final SafeCompleter completer, {
  //   final bool unsubscribe = true,
  // }) async {
  //   try {
  //     return await completer.future;
  //   } finally {
  //     if (unsubscribe || completer.isCompletedError) {
  //       await unsubscribe(subscription);
  //     } else {
  //       final SubscriptionId subscriptionId = subscription.subscriptionId;
  //       final WebsocketNotifier? notifier = _notifiers.remove(subscriptionId);
  //       notifier?.controller.close().ignore();
  //       _subscriptions.remove(notifier?.hash);
  //     }
  //   }
  // }

  // /// Cancels a websocket stream subscription and unsubscribes the JSON RPC notification.
  // Future<bool> unsubscribe(
  //   final WebsocketSubscription subscription,
  // ) async {
  //   await subscription.cancel(); // ignore: invalid_use_of_protected_member
  //   return _unsubscribe(subscription.subscriptionId);
  // }

  // /// Checks the state of a subscription and will close the stream and unsubscribe the JSON RPC
  // /// notification if the event has no more listeners.
  // ///
  // /// Returns whether or not the operation was completed successfully.
  // Future<bool> _unsubscribe(
  //   final SubscriptionId subscriptionId,
  // ) async {

  //   // Get the notifier for [subscriptionId]
  //   final WebsocketNotifier? notifier = _notifiers[subscriptionId];

  //   // Get the notifier's stream controller.
  //   final StreamController? controller = notifier?.controller;

  //   // Check if the stream has no more listeners.
  //   final bool isEmpty = controller == null || !controller.hasListener;

  //   // Close the stream.
  //   if (controller != null && isEmpty) {
  //     _notifiers.remove(subscriptionId);
  //     if (!controller.isClosed) {
  //       assert(controller.stream.isBroadcast);
  //       await controller.close();
  //     }
  //   }

  //   // Unsubscribe the method.
  //   if (notifier != null && isEmpty) {
  //     final FutureOr? subscription = _subscriptions.remove(notifier.hash);
  //     if (subscription != null) {
  //       final rpc = Unsubscribe(notifier.unsubscribeMethod, subscriptionId);
  //       return (await websocketClient.send(rpc.request(commitment), rpc.response)).result!;
  //     }
  //   }

  //   // Default response.
  //   return true;
  // }

  /// Decodes a response-context notification.
  T Function(Map<String, dynamic>) _contextDecoder<T>(
    final T Function(Map<String, dynamic>) decoder,
  ) =>
      (json) => JsonRpcResponseContext.decode(json, decoder).value!;

  /// {@template solana_web3.Connection.accountSubscribe}
  /// Subscribe to an account to receive notifications when the lamports or data for a given account
  /// [pubkey] changes.
  /// {@endtemplate}
  Future<WebsocketSubscription<AccountInfo>> accountSubscribe(
    final Pubkey pubkey, {
    final WebsocketOnDataHandler<AccountInfo>? onData,
    final WebsocketOnErrorHandler? onError,
    final WebsocketOnDoneHandler? onDone,
    final bool cancelOnError = false,
    final Duration? timeLimit,
    final AccountSubscribeConfig? config,
  }) =>
      subscribe(
        AccountSubscribe(pubkey, config: config),
        _contextDecoder(AccountInfo.fromJson),
        onData: onData,
        onError: onError,
        onDone: onDone,
        timeLimit: timeLimit,
        cancelOnError: cancelOnError,
      );

  /// Unsubscribes from account change notifications.
  Future<bool> accountUnsubscribe(
    final WebsocketSubscription<AccountInfo> subscription,
  ) =>
      unsubscribe(subscription);

  /// {@template solana_web3.Connection.logsSubscribe}
  /// Subscribes to transaction logging.
  /// {@endtemplate}
  Future<WebsocketSubscription<LogsNotification>> logsSubscribe(
    final LogsFilter<Object> filter, {
    final WebsocketOnDataHandler<LogsNotification>? onData,
    final WebsocketOnErrorHandler? onError,
    final WebsocketOnDoneHandler? onDone,
    final bool cancelOnError = false,
    final Duration? timeLimit,
    final LogsSubscribeConfig? config,
  }) =>
      subscribe(
        LogsSubscribe(filter, config: config),
        _contextDecoder(LogsNotification.fromJson),
        onData: onData,
        onError: onError,
        onDone: onDone,
        timeLimit: timeLimit,
        cancelOnError: cancelOnError,
      );

  /// Unsubscribes from transaction logging.
  Future<bool> logsUnsubscribe(
    final WebsocketSubscription<LogsNotification> subscription,
  ) =>
      unsubscribe(subscription);

  /// {@template solana_web3.Connection.programSubscribe}
  /// Subscribes to a program to receive notifications when the lamports or data for an account
  /// owned by the given program changes.
  /// {@endtemplate}
  Future<WebsocketSubscription<ProgramAccount>> programSubscribe(
    final Pubkey programId, {
    final WebsocketOnDataHandler<ProgramAccount>? onData,
    final WebsocketOnErrorHandler? onError,
    final WebsocketOnDoneHandler? onDone,
    final bool cancelOnError = false,
    final Duration? timeLimit,
    final ProgramSubscribeConfig? config,
  }) =>
      subscribe(
        ProgramSubscribe(programId, config: config),
        _contextDecoder(ProgramAccount.fromJson),
        onData: onData,
        onError: onError,
        onDone: onDone,
        timeLimit: timeLimit,
        cancelOnError: cancelOnError,
      );

  /// Unsubscribes from program-owned account change notifications.
  Future<bool> programUnsubscribe(
    final WebsocketSubscription<ProgramAccount> subscription,
  ) =>
      unsubscribe(subscription);

  /// {@template solana_web3.Connection.signatureSubscribe}
  /// Subscribes to a transaction signature to receive a notification when the given transaction
  /// [signature] is committed.
  /// {@endtemplate}
  Future<WebsocketSubscription<SignatureNotification>> signatureSubscribe(
    final String signature, {
    final WebsocketOnDataHandler<SignatureNotification>? onData,
    final WebsocketOnErrorHandler? onError,
    final WebsocketOnDoneHandler? onDone,
    final bool cancelOnError = true,
    final Duration? timeLimit,
    final SignatureSubscribeConfig? config,
  }) =>
      subscribe(
        SignatureSubscribe(signature, config: config),
        _contextDecoder(SignatureNotification.fromJson),
        onData: onData,
        onError: onError,
        onDone: onDone,
        timeLimit: timeLimit,
        cancelOnError: cancelOnError,
        autoUnsubscribes: true,
      );

  /// Unsubscribes from signature confirmation notifications.
  Future<bool> signatureUnsubscribe(
    final WebsocketSubscription<SignatureNotification> subscription,
  ) =>
      unsubscribe(subscription);

  /// {@template solana_web3.Connection.slotSubscribe}
  /// Subscribes to receive notification anytime a slot is processed by the validator.
  /// {@endtemplate}
  Future<WebsocketSubscription<SlotNotification>> slotSubscribe(
    final String signature, {
    final WebsocketOnDataHandler<SlotNotification>? onData,
    final WebsocketOnErrorHandler? onError,
    final WebsocketOnDoneHandler? onDone,
    final bool cancelOnError = false,
    final Duration? timeLimit,
  }) =>
      subscribe(
        const SlotSubscribe(),
        SlotNotification.fromJson,
        onData: onData,
        onError: onError,
        onDone: onDone,
        timeLimit: timeLimit,
        cancelOnError: cancelOnError,
      );

  /// Unsubscribes from slot notifications.
  Future<bool> slotUnsubscribe(
    final WebsocketSubscription<SlotNotification> subscription,
  ) =>
      unsubscribe(subscription);
}
