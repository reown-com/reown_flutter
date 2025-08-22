// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'package:stream_channel/stream_channel.dart';

import 'client.dart';
import 'parameters.dart';
import 'server.dart';
import 'utils.dart';

/// A callback for logging messages from the JSON-RPC peer.
typedef JsonRpcLogCallback = void Function(String level, String message,
    [Object? error, StackTrace? stackTrace]);

/// A JSON-RPC 2.0 client *and* server.
///
/// This supports bidirectional peer-to-peer communication with another JSON-RPC
/// 2.0 endpoint. It sends both requests and responses across the same
/// communication channel and expects to connect to a peer that does the same.
class Peer implements Client, Server {
  final StreamChannel<dynamic> _channel;
  final Queue<StreamSubscription<dynamic>> _subscriptionRegistry = Queue();
  late final Stream<dynamic> _communicationStream;

  // Debug identifier for logging purposes (used in log messages)
  final String _debugId = _generateDebugId();

  /// Optional logging callback for propagating logs to parent classes
  final JsonRpcLogCallback? _logCallback;

  /// The underlying client that handles request-sending and response-receiving
  /// logic.
  late final Client _client;

  /// The underlying server that handles request-receiving and response-sending
  /// logic.
  late final Server _server;

  /// A stream controller that forwards incoming messages to [_server] if
  /// they're requests.
  final _serverIncomingForwarder = StreamController(sync: true);

  /// A stream controller that forwards incoming messages to [_client] if
  /// they're responses.
  final _clientIncomingForwarder = StreamController(sync: true);

  @override
  late final Future<dynamic> done = Future.wait([_client.done, _server.done]);

  @override
  bool get isClosed => _client.isClosed || _server.isClosed;

  @override
  ErrorCallback? get onUnhandledError => _server.onUnhandledError;

  @override
  bool get strictProtocolChecks => _server.strictProtocolChecks;

  /// Creates a [Peer] that communicates over [channel].
  ///
  /// Note that the peer won't begin listening to [channel] until [Peer.listen]
  /// is called.
  ///
  /// Unhandled exceptions in callbacks will be forwarded to [onUnhandledError].
  /// If this is not provided, unhandled exceptions will be swallowed.
  ///
  /// If [strictProtocolChecks] is false, the underlying [Server] will accept
  /// some requests which are not conformant with the JSON-RPC 2.0
  /// specification. In particular, requests missing the `jsonrpc` parameter
  /// will be accepted.
  factory Peer(
    StreamChannel<String> channel, {
    ErrorCallback? onUnhandledError,
    bool strictProtocolChecks = true,
    JsonRpcLogCallback? logCallback,
  }) {
    return Peer.withoutJson(
      jsonDocument.bind(channel).transform(respondToFormatExceptions),
      onUnhandledError: onUnhandledError,
      strictProtocolChecks: strictProtocolChecks,
      logCallback: logCallback,
    );
  }

  /// Creates a [Peer] that communicates using decoded messages over [channel].
  ///
  /// Unlike [Peer], this doesn't read or write JSON strings. Instead, it
  /// reads and writes decoded maps or lists.
  ///
  /// Note that the peer won't begin listening to [channel] until
  /// [Peer.listen] is called.
  ///
  /// Unhandled exceptions in callbacks will be forwarded to [onUnhandledError].
  /// If this is not provided, unhandled exceptions will be swallowed.
  ///
  /// If [strictProtocolChecks] is false, the underlying [Server] will accept
  /// some requests which are not conformant with the JSON-RPC 2.0
  /// specification. In particular, requests missing the `jsonrpc` parameter
  /// will be accepted.
  Peer.withoutJson(
    this._channel, {
    ErrorCallback? onUnhandledError,
    bool strictProtocolChecks = true,
    JsonRpcLogCallback? logCallback,
  }) : _logCallback = logCallback {
    _communicationStream = _channel.stream;
    _logDebug(
        'Peer initialized with ${strictProtocolChecks ? 'strict' : 'lenient'} protocol checks');

    _server = Server.withoutJson(
      StreamChannel(
        _serverIncomingForwarder.stream,
        _channel.sink,
      ),
      onUnhandledError: onUnhandledError,
      strictProtocolChecks: strictProtocolChecks,
      logCallback: logCallback,
    );
    _client = Client.withoutJson(
      StreamChannel(_clientIncomingForwarder.stream, _channel.sink),
      logCallback: logCallback,
    );

    _logDebug('Client and server components initialized');
  }

  // Client methods.

  @override
  Future<dynamic> sendRequest(String method, [parameters, int? id]) {
    _logDebug('Sending request: $method');
    return _client.sendRequest(method, parameters, id);
  }

  @override
  void sendNotification(String method, [parameters]) {
    _logDebug('Sending notification: $method');
    _client.sendNotification(method, parameters);
  }

  @override
  void withBatch(Function() callback) {
    _logDebug('Starting batch operation');
    _client.withBatch(callback);
  }

  // Server methods.

  @override
  void registerMethod(String name, Function callback) {
    _logDebug('Registering method: $name');
    _server.registerMethod(name, callback);
  }

  @override
  void registerFallback(Function(Parameters parameters) callback) {
    _logDebug('Registering fallback method');
    _server.registerFallback(callback);
  }

  // Shared methods.

  @override
  Future<dynamic> listen() {
    _logDebug('Starting peer communication');
    _client.listen();
    _server.listen();

    late final StreamSubscription<dynamic> subscription;
    subscription = _communicationStream.listen((message) {
      _logDebug('Processing incoming message');

      if (message is Map) {
        if (message.containsKey('result') || message.containsKey('error')) {
          _logDebug('Forwarding response to client');
          _clientIncomingForwarder.add(message);
        } else {
          _logDebug('Forwarding request to server');
          _serverIncomingForwarder.add(message);
        }
      } else if (message is List &&
          message.isNotEmpty &&
          message.first is Map) {
        if (message.first.containsKey('result') ||
            message.first.containsKey('error')) {
          _logDebug('Forwarding batch response to client');
          _clientIncomingForwarder.add(message);
        } else {
          _logDebug('Forwarding batch request to server');
          _serverIncomingForwarder.add(message);
        }
      } else {
        // Non-Map and -List messages are ill-formed, so we pass them to the
        // server since it knows how to send error responses.
        _logError('Ill-formed message received, forwarding to server', message);
        _serverIncomingForwarder.add(message);
      }
    }, onError: (error, stackTrace) {
      _logError('Communication stream error', error, stackTrace);
      _serverIncomingForwarder.addError(error, stackTrace);
    }, onDone: () {
      _logDebug('Communication stream completed');
      _deregisterSubscription(subscription);
      close();
    });

    _subscriptionRegistry.add(subscription);
    _logDebug('Peer communication started successfully');
    return done;
  }

  @override
  Future<dynamic> close() {
    _logDebug(
        'Closing peer, cleaning up ${_subscriptionRegistry.length} subscriptions');
    _client.close();
    _server.close();
    _disposeAllSubscriptions();
    return done;
  }

  /// Deregisters a specific subscription from tracking.
  void _deregisterSubscription(StreamSubscription<dynamic> subscription) {
    _subscriptionRegistry.remove(subscription);
    _logDebug(
        'Deregistered subscription, ${_subscriptionRegistry.length} remaining');
  }

  /// Disposes all registered subscriptions.
  void _disposeAllSubscriptions() {
    final count = _subscriptionRegistry.length;
    for (final subscription in _subscriptionRegistry.toList()) {
      _subscriptionRegistry.remove(subscription);
      subscription.cancel();
    }
    _logDebug('Disposed $count subscriptions');
  }

  /// Logs debug information if debug mode is enabled.
  void _logDebug(String message) {
    _logCallback?.call('debug', '[$_debugId] $message');
  }

  /// Logs error information.
  void _logError(String message, [Object? error, StackTrace? stackTrace]) {
    _logCallback?.call(
        'error', '[$_debugId] ERROR: $message', error, stackTrace);
  }

  /// Generates a unique debug identifier for this peer instance.
  static String _generateDebugId() {
    return 'Peer_${DateTime.now().millisecondsSinceEpoch % 10000}';
  }
}
