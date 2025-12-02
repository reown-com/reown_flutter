// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';
import 'package:stream_channel/stream_channel.dart';

import 'exception.dart';
import 'utils.dart';

/// A callback for logging messages from the JSON-RPC client.
typedef JsonRpcLogCallback =
    void Function(
      String level,
      String message, [
      Object? error,
      StackTrace? stackTrace,
    ]);

/// A JSON-RPC 2.0 client.
///
/// A client calls methods on a server and handles the server's responses to
/// those method calls. Methods can be called with [sendRequest], or with
/// [sendNotification] if no response is expected.
class Client {
  final StreamChannel<dynamic> _channel;
  final Set<StreamSubscription<dynamic>> _activeSubscriptions = {};
  late final Stream<dynamic> _messageStream;

  // Debug identifier for logging purposes (used in log messages)
  final String _debugId = _generateDebugId();

  /// Optional logging callback for propagating logs to parent classes
  final JsonRpcLogCallback? _logCallback;

  /// The next request id.
  var _id = 0;

  /// The current batch of requests to be sent together.
  ///
  /// Each element is a JSON RPC spec compliant message.
  List<Map<String, dynamic>>? _batch;

  /// The map of request ids to pending requests.
  final _pendingRequests = <int, _Request>{};

  final _done = Completer<dynamic>();

  /// Returns a [Future] that completes when the underlying connection is
  /// closed.
  ///
  /// This is the same future that's returned by [listen] and [close]. It may
  /// complete before [close] is called if the remote endpoint closes the
  /// connection.
  Future<dynamic> get done => _done.future;

  /// Whether the underlying connection is closed.
  ///
  /// Note that this will be `true` before [close] is called if the remote
  /// endpoint closes the connection.
  bool get isClosed => _done.isCompleted;

  /// Creates a [Client] that communicates over [channel].
  ///
  /// Note that the client won't begin listening to [responses] until
  /// [Client.listen] is called.
  factory Client(
    StreamChannel<String> channel, {
    JsonRpcLogCallback? logCallback,
  }) {
    return Client.withoutJson(
      jsonDocument.bind(channel).transformStream(ignoreFormatExceptions),
      logCallback: logCallback,
    );
  }

  /// Creates a [Client] that communicates using decoded messages over
  /// [channel].
  ///
  /// Unlike [Client], this doesn't read or write JSON strings. Instead, it
  /// reads and writes decoded maps or lists.
  ///
  /// Note that the client won't begin listening to [responses] until
  /// [Client.listen] is called.
  Client.withoutJson(this._channel, {JsonRpcLogCallback? logCallback})
    : _logCallback = logCallback {
    _messageStream = _channel.stream;
    _logDebug('Client initialized');

    done
        .whenComplete(() {
          _logDebug(
            'Client completed, cleaning up ${_pendingRequests.length} pending requests',
          );
          for (var request in _pendingRequests.values) {
            request.completer.completeError(
              StateError(
                'The client closed with pending request "${request.method}".',
              ),
            );
          }
          _pendingRequests.clear();
        })
        .catchError((error) {
          _logError('Error during client completion', error);
          // Avoid an unhandled error.
        });
  }

  /// Starts listening to the underlying stream.
  ///
  /// Returns a [Future] that will complete when the connection is closed or
  /// when it has an error. This is the same as [done].
  ///
  /// [listen] may only be called once.
  Future<dynamic> listen() {
    _logDebug('Starting to listen for responses');

    late final StreamSubscription<dynamic> subscription;
    subscription = _messageStream.listen(
      _handleResponse,
      onError: (error, stackTrace) {
        _logError('Stream error occurred', error, stackTrace);
        _done.completeError(error, stackTrace);
        _channel.sink.close();
      },
      onDone: () {
        _logDebug('Stream completed');
        if (!_done.isCompleted) {
          _done.complete();
        }
        _removeSubscription(subscription);
        close();
      },
    );
    _activeSubscriptions.add(subscription);
    return done;
  }

  /// Closes the underlying connection.
  ///
  /// Returns a [Future] that completes when all resources have been released.
  /// This is the same as [done].
  Future<dynamic> close() {
    _logDebug(
      'Closing client, cleaning up ${_activeSubscriptions.length} subscriptions',
    );
    _channel.sink.close();
    if (!_done.isCompleted) _done.complete();
    _cleanupAllSubscriptions();
    return done;
  }

  /// Sends a JSON-RPC 2 request to invoke the given [method].
  ///
  /// If passed, [parameters] is the parameters for the method. This must be
  /// either an [Iterable] (to pass parameters by position) or a [Map] with
  /// [String] keys (to pass parameters by name). Either way, it must be
  /// JSON-serializable.
  ///
  /// If the request succeeds, this returns the response result as a decoded
  /// JSON-serializable object. If it fails, it throws an [RpcException]
  /// describing the failure.
  ///
  /// Throws a [StateError] if the client is closed while the request is in
  /// flight, or if the client is closed when this method is called.
  Future<dynamic> sendRequest(String method, [parameters, int? id]) {
    if (isClosed) {
      throw StateError('Cannot send request on closed client');
    }

    var idAct = id ?? _id++;
    _logDebug('Sending request: $method (ID: $idAct)');

    _send(method, parameters, idAct);

    var completer = Completer<dynamic>.sync();
    _pendingRequests[idAct] = _Request(method, completer, Chain.current());
    return completer.future;
  }

  /// Sends a JSON-RPC 2 request to invoke the given [method] without expecting
  /// a response.
  ///
  /// If passed, [parameters] is the parameters for the method. This must be
  /// either an [Iterable] (to pass parameters by position) or a [Map] with
  /// [String] keys (to pass parameters by name). Either way, it must be
  /// JSON-serializable.
  ///
  /// Since this is just a notification to which the server isn't expected to
  /// send a response, it has no return value.
  ///
  /// Throws a [StateError] if the client is closed when this method is called.
  void sendNotification(String method, [parameters]) {
    if (isClosed) {
      throw StateError('Cannot send notification on closed client');
    }

    _logDebug('Sending notification: $method');
    _send(method, parameters);
  }

  /// A helper method for [sendRequest] and [sendNotification].
  ///
  /// Sends a request to invoke [method] with [parameters]. If [id] is given,
  /// the request uses that id.
  void _send(String method, parameters, [int? id]) {
    if (parameters is Iterable) parameters = parameters.toList();
    if (parameters is! Map && parameters is! List && parameters != null) {
      throw ArgumentError(
        'Only maps and lists may be used as JSON-RPC '
        'parameters, was "$parameters".',
      );
    }

    var message = <String, dynamic>{'jsonrpc': '2.0', 'method': method};
    if (id != null) message['id'] = id;
    if (parameters != null) message['params'] = parameters;

    if (_batch != null) {
      _batch!.add(message);
      _logDebug('Added to batch: $method');
    } else {
      _channel.sink.add(message);
      _logDebug('Sent immediately: $method');
    }
  }

  /// Runs [callback] and batches any requests sent until it returns.
  ///
  /// A batch of requests is sent in a single message on the underlying stream,
  /// and the responses are likewise sent back in a single message.
  ///
  /// [callback] may be synchronous or asynchronous. If it returns a [Future],
  /// requests will be batched until that Future returns; otherwise, requests
  /// will only be batched while synchronously executing [callback].
  ///
  /// If this is called in the context of another [withBatch] call, it just
  /// invokes [callback] without creating another batch. This means that
  /// responses are batched until the first batch ends.
  void withBatch(Function() callback) {
    if (_batch != null) {
      callback();
      return;
    }

    _logDebug('Starting new batch');
    _batch = [];
    return tryFinally(callback, () {
      _logDebug('Sending batch of ${_batch!.length} requests');
      _channel.sink.add(_batch);
      _batch = null;
    });
  }

  /// Handles a decoded response from the server.
  void _handleResponse(response) {
    if (response is List) {
      _logDebug('Handling batch response with ${response.length} items');
      response.forEach(_handleSingleResponse);
    } else {
      _logDebug('Handling single response');
      _handleSingleResponse(response);
    }
  }

  /// Handles a decoded response from the server after batches have been
  /// resolved.
  void _handleSingleResponse(response) {
    if (!_isResponseValid(response)) {
      _logError('Invalid response received', response);
      return;
    }

    var id = response['id'];
    id = (id is String) ? int.parse(id) : id;

    var request = _pendingRequests.remove(id);
    if (request == null) {
      _logError('Response for unknown request ID: $id', response);
      return;
    }

    if (response.containsKey('result')) {
      _logDebug('Completing request: ${request.method} (ID: $id)');
      request.completer.complete(response['result']);
    } else {
      _logError(
        'Request failed: ${request.method} (ID: $id)',
        response['error'],
      );
      request.completer.completeError(
        RpcException(
          response['error']['code'],
          response['error']['message'],
          data: response['error']['data'],
        ),
        request.chain,
      );
    }
  }

  /// Determines whether the server's response is valid per the spec.
  bool _isResponseValid(response) {
    if (response is! Map) return false;
    if (response['jsonrpc'] != '2.0') return false;
    var id = response['id'];
    id = (id is String) ? int.parse(id) : id;
    if (!_pendingRequests.containsKey(id)) return false;
    if (response.containsKey('result')) return true;

    if (!response.containsKey('error')) return false;
    var error = response['error'];
    if (error is! Map) return false;
    if (error['code'] is! int) return false;
    if (error['message'] is! String) return false;
    return true;
  }

  /// Removes a specific subscription from tracking.
  void _removeSubscription(StreamSubscription<dynamic> subscription) {
    _activeSubscriptions.remove(subscription);
    _logDebug('Removed subscription, ${_activeSubscriptions.length} remaining');
  }

  /// Cleans up all active subscriptions.
  void _cleanupAllSubscriptions() {
    final count = _activeSubscriptions.length;
    for (final subscription in _activeSubscriptions.toList()) {
      _activeSubscriptions.remove(subscription);
      subscription.cancel();
    }
    _logDebug('Cleaned up $count subscriptions');
  }

  /// Logs debug information if debug mode is enabled.
  void _logDebug(String message) {
    _logCallback?.call('debug', '[$_debugId] $message');
  }

  /// Logs error information.
  void _logError(String message, [Object? error, StackTrace? stackTrace]) {
    _logCallback?.call(
      'error',
      '[$_debugId] ERROR: $message',
      error,
      stackTrace,
    );
  }

  /// Generates a unique debug identifier for this client instance.
  static String _generateDebugId() {
    return 'Client_${DateTime.now().millisecondsSinceEpoch % 10000}';
  }
}

/// A pending request to the server.
class _Request {
  /// The method that was sent.
  final String method;

  /// The completer to use to complete the response future.
  final Completer<dynamic> completer;

  /// The stack chain from where the request was made.
  final Chain chain;

  _Request(this.method, this.completer, this.chain);
}
