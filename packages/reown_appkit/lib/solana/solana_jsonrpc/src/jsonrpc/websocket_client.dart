/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:reown_appkit/solana/solana_common/validators.dart';
// ignore: depend_on_referenced_packages
import 'package:synchronized/synchronized.dart';
// ignore: depend_on_referenced_packages
import 'package:web_socket_channel/web_socket_channel.dart';
import '../converters/json_to_bytes_codec.dart';
import 'client.dart';
import 'exception.dart';
import 'client_config.dart';
import 'response.dart';

/// Types
/// ------------------------------------------------------------------------------------------------

/// The `onConnect` callback handler.
typedef JsonRpcWebsocketClientOnConnect<R> = void Function();

/// The `onDisconnect` callback handler.
typedef JsonRpcWebsocketClientOnDisconnect = void Function();

/// The `onData` callback handler.
///
/// The [data] value will be a [Map] (Single Method Request), [List] of [Map]s (Bulk Method
/// Request) or Empty [R] (Ping Frame).
typedef JsonRpcWebsocketClientOnData<R> = void Function(dynamic data);

/// The `onError` callback handler.
typedef JsonRpcWebsocketClientOnError = void Function(Object error,
    [StackTrace? stackTrace]);

/// The `onPing` callback handler.
typedef JsonRpcWebsocketClientOnPing<R> = void Function(R data);

/// The `isPing` callback handler.
typedef JsonRpcWebsocketClientIsPing<R> = bool Function(R data);

/// JSON RPC Websocket Client
/// ------------------------------------------------------------------------------------------------

/// Manages a single websocket connection to [uri].
///
/// The [protocols] property specifies the subprotocols the client is willing to speak.
///
/// A connection fails after [maxAttempts] or [timeLimit] (whichever occurs first). The delay
/// before each connection attempt can be configured by defining a [backoffSchedule] in
/// milliseconds. If [backoffSchedule] length is less that [maxAttempts], the final value in
/// [backoffSchedule] is applied to all remaining attempts.
///
/// ```
/// final socket = JsonRpcWebsocketClient(
///   Uri.parse('wss://example_server'),
///   maxAttempts: 3,                    // Attempt to establish a connect up to 3 times.
///   backoffSchedule: [0, 1000],        // Trigger the first connection attempt immediately (0)
/// );                                   // & each remaining attempt after a 1 second delay (1000).
///
/// await socket.send('Hello');
/// ```
class JsonRpcWebsocketClient<R> extends Client<R> {
  /// Creates a JSON RPC Client for Websocket methods.
  JsonRpcWebsocketClient(
    super.uri, {
    super.timeLimit,
    final int? maxAttempts,
    final List<int>? backoffSchedule,
    this.protocols,
    this.onConnect,
    this.onDisconnect,
    this.onData,
    this.onError,
    this.onPing,
    required this.isPing,
    final JsonRpcClientEncoder? encoder,
    required super.decoder,
  })  : maxAttempts = maxAttempts ?? 1,
        backoffSchedule = backoffSchedule ?? const [],
        super(encoder: encoder ?? const JsonToBytesEncoder());

  /// Creates a JSON RPC Client for Websocket methods that return [String] data.
  static JsonRpcWebsocketClient<String> withStringDecoder(
    final Uri uri, {
    final Duration? timeLimit,
    final int? maxAttempts,
    final List<int>? backoffSchedule,
    final List<String>? protocols,
    final JsonRpcWebsocketClientOnConnect<String>? onConnect,
    final JsonRpcWebsocketClientOnDisconnect? onDisconnect,
    final JsonRpcWebsocketClientOnData<String>? onData,
    final JsonRpcWebsocketClientOnError? onError,
    final JsonRpcWebsocketClientOnPing? onPing,
  }) =>
      JsonRpcWebsocketClient(
        uri,
        timeLimit: timeLimit,
        maxAttempts: maxAttempts,
        backoffSchedule: backoffSchedule,
        protocols: protocols,
        onConnect: onConnect,
        onDisconnect: onDisconnect,
        onData: onData,
        onError: onError,
        onPing: onPing,
        isPing: (data) => data.isEmpty,
        decoder: const JsonDecoder(),
      );

  /// Creates a JSON RPC Client for Websocket methods that return byte data.
  static JsonRpcWebsocketClient<List<int>> withByteDecoder(
    final Uri uri, {
    final Duration? timeLimit,
    final int? maxAttempts,
    final List<int>? backoffSchedule,
    final List<String>? protocols,
    final JsonRpcWebsocketClientOnConnect<List<int>>? onConnect,
    final JsonRpcWebsocketClientOnDisconnect? onDisconnect,
    final JsonRpcWebsocketClientOnData<List<int>>? onData,
    final JsonRpcWebsocketClientOnError? onError,
    final JsonRpcWebsocketClientOnPing<List<int>>? onPing,
  }) =>
      JsonRpcWebsocketClient(
        uri,
        timeLimit: timeLimit,
        maxAttempts: maxAttempts,
        backoffSchedule: backoffSchedule,
        protocols: protocols,
        onConnect: onConnect,
        onDisconnect: onDisconnect,
        onData: onData,
        onError: onError,
        onPing: onPing,
        isPing: (data) => data.isEmpty,
        decoder: const JsonToBytesDecoder(),
      );

  /// Websocket client.
  WebSocketChannel? _client;

  /// The websocket client's stream subscription.
  StreamSubscription<R>? _subscription;

  /// The maximum number of connection attempts per `connect()` call.
  final int maxAttempts;

  /// The pre-connect backoff schedule.
  final List<int> backoffSchedule;

  /// The subprotocols.
  final List<String>? protocols;

  /// Guards the connect and disconnect method calls.
  final Lock _lock = Lock();

  /// The callback triggered each time a connection is started.
  final JsonRpcWebsocketClientOnConnect<R>? onConnect;

  /// The callback triggered when the connection disconnects.
  final JsonRpcWebsocketClientOnDisconnect? onDisconnect;

  /// The websocket stream's data handler.
  final JsonRpcWebsocketClientOnData<R>? onData;

  /// The websocket stream's error handler.
  final JsonRpcWebsocketClientOnError? onError;

  /// The websocket stream's ping message handler.
  final JsonRpcWebsocketClientOnPing<R>? onPing;

  /// Returns true if the received data is a PING message
  final JsonRpcWebsocketClientIsPing<R> isPing;

  /// The pending requests.
  final Map<int, Completer> _pending = {};

  /// True if [dispose] has been called.
  bool _disposed = false;

  /// The message sent when the websocket has been closed.
  String get _closeMessage => 'Websocket closed.';

  /// The request id for a key exchange method.
  static const int _handshakeId = -1;

  /// True if a [handshake] request is pending.
  bool get _isHandshakePending => _pending.containsKey(_handshakeId);

  /// True if the socket is open.
  bool get isConnected {
    final WebSocketChannel? client = _client;
    return client != null && client.closeCode == null;
  }

  /// Returns the current date and time.
  DateTime _now() => DateTime.now();

  /// Returns the remaining duration of [timeLimit] relative to [start] date and time.
  Duration? _remaining(
    final DateTime start, {
    required final Duration? timeLimit,
  }) {
    final Duration? limit = timeLimit ?? this.timeLimit;
    assert(limit == null || !limit.isNegative);
    return limit != null ? limit - (_now().difference(start)) : null;
  }

  /// Returns a future that completes after `schedule[i]` milliseconds. If [i] is out of range, the
  /// future completes in [schedule.last] milliseconds or immediately when [schedule] is empty.
  ///
  /// Throws a [TimeoutException] if `schedule[i]` has exceeded [timeLimit].
  FutureOr<Duration> _backoff(
    final int i, {
    required final List<int> schedule,
    required final Duration? timeLimit,
  }) async {
    final Duration? limit = timeLimit ?? this.timeLimit;
    final int ms = i < schedule.length
        ? schedule[i]
        : (schedule.isEmpty ? 0 : schedule.last);
    final Duration delay = Duration(milliseconds: ms);
    if (limit != null && delay > limit) {
      return Future.error(TimeoutException('Connection timed out.'));
    } else if (delay.inMilliseconds > 0) {
      await Future.delayed(delay);
    }
    return delay;
  }

  /// Establishes a websocket connection to [uri].
  ///
  /// This method can be called multiple times and will always result in a single connection.
  Future<void> connect({
    final Duration? timeLimit,
  }) {
    final DateTime start = _now();
    return _lock.synchronized(
      timeout: timeLimit,
      () => _connect(timeLimit: _remaining(start, timeLimit: timeLimit)),
    );
  }

  /// Establishes a websocket connection to [uri].
  ///
  /// This method must be called within [Lock.synchronized].
  Future<void> _connect({
    final Duration? timeLimit,
  }) async {
    assert(!_disposed);
    assert(_lock.locked);

    // Ignore the call if the socket is already connected.
    if (isConnected) {
      return;
    }

    // Track timeout.
    final DateTime start = _now();

    for (int i = 0; i < maxAttempts && !_disposed; ++i) {
      try {
        final Duration? remaining = _remaining(start, timeLimit: timeLimit);
        final Duration delay =
            await _backoff(i, schedule: backoffSchedule, timeLimit: remaining);
        final WebSocketChannel client =
            WebSocketChannel.connect(uri, protocols: protocols);
        _subscribe(client.stream.cast<R>());
        await timeout(
            client.ready, remaining != null ? remaining - delay : null);
        _client = client;
        onConnect?.call();
        return;
      } on TimeoutException catch (error, stackTrace) {
        return Future.error(error, stackTrace);
      } catch (error) {
        if (_disposed) {
          return Future.error(WebSocketException(_closeMessage));
        }

        /// Try again...
      }
    }

    return Future.error(const WebSocketException('Connection failed.'));
  }

  @override
  Future<void> dispose() {
    _disposed = true;
    return _lock.synchronized(_dispose);
  }

  /// Attaches event handlers to the websocket [stream].
  Future<void> _subscribe(final Stream<R> stream) async {
    await _unsubscribe();
    _subscription = stream.listen(_onData, onError: _onError, onDone: _onDone);
  }

  /// Cancels the websocket stream subscription.
  Future<void> _unsubscribe() async => _subscription?.cancel();

  /// Disconnects the websocket connection.
  ///
  /// This method must be called within [Lock.synchronized].
  Future<void> _dispose([final int? code, final String? reason]) async {
    assert(_lock.locked);
    _cancelAll(_closeMessage);
    await _client?.sink.close(code, _closeMessage);
    _client = null;
    _unsubscribe();
  }

  /// Returns the request id (if any) found in a decoded JSON RPC [response].
  int? _responseId(final dynamic response) {
    const String key = JsonRpcResponse.idKey;
    return response is List
        ? (response.isEmpty ? null : response.first[key])
        : response[key];
  }

  /// The [WebSocketChannel.stream]'s data handler.
  void _onData(final R data) async {
    // print('[JsonRpcWebsocketClient] Data $data');
    if (isPing(data)) {
      onPing?.call(data);
    } else if (_isHandshakePending) {
      _complete(_handshakeId, data);
    } else {
      final dynamic decoded =
          await decoder.convert(data); // Map or List<Map> or Empty List (PING).
      assert(decoded is List || decoded is Map);
      final int? id = _responseId(decoded);
      _pending.containsKey(id) ? _complete(id, decoded) : onData?.call(decoded);
    }
  }

  /// The `on error` handler.
  void _onError(final Object error, [final StackTrace? stackTrace]) {
    // print('[JsonRpcWebsocketClient] Error $error');
    onError?.call(error, stackTrace);
  }

  /// The `completion` handler.
  void _onDone() {
    // print('[JsonRpcWebsocketClient] Done.');
    _cancelAll(_closeMessage);
    onDisconnect?.call();
  }

  /// Adds a pending request.
  void _add<T>(final int id, final Completer<T> completer) {
    assert(!_pending.containsKey(id));
    _pending[id] = completer;
  }

  /// Completes a pending request with [data].
  void _complete<T>(final int? id, final T data) {
    final Completer? pending = _pending.remove(id);
    pending?.complete(data);
  }

  /// Cancels a pending request with [error].
  void _cancel(final int? id, final Object error,
      [final StackTrace? stackTrace]) {
    final Completer? pending = _pending.remove(id);
    pending?.completeError(error, stackTrace);
  }

  /// Cancels all pending requests.
  void _cancelAll(final Object error, [final StackTrace? stackTrace]) {
    final List<Completer> pending = _pending.values.toList(growable: false);
    _pending.clear();
    for (final Completer completer in pending) {
      completer.completeError(error, stackTrace);
    }
  }

  /// Sends a raw [data] request to establish an encrypted session.
  Future<R> handshake(
    final List<int> data, {
    final JsonRpcClientConfig? config,
  }) async {
    check(_pending.isEmpty);
    return _handler<R>(data, config: config, id: _handshakeId);
  }

  @override
  Future<T> handler<T>(
    final List<int> encoded, {
    final JsonRpcClientConfig? config,
    final int? id,
  }) =>
      _handler<T>(encoded, config: config, id: id);

  Future<T> _handler<T>(
    final List<int> encoded, {
    final JsonRpcClientConfig? config,
    final int? id,
  }) async {
    try {
      check(!_isHandshakePending, 'Handshake request in progress.');

      if (id == null) {
        throw const JsonRpcException(
            'Websocket requests must define a unique `id`.');
      }

      if (!isConnected) {
        await connect(timeLimit: config?.timeLimit);
      }

      final Completer<T>? pending = _pending[id] as Completer<T>?;
      if (pending != null) {
        return pending.future;
      }

      final Completer<T> completer = Completer.sync();
      _add<T>(id, completer);

      final WebSocketChannel? client = _client;
      check(client != null, _closeMessage);

      /// Send data as a [Uint8List] to enforce byte-data (required on web).
      client?.sink.add(Uint8List.fromList(encoded));
      return await timeout(completer.future, config?.timeLimit);
    } catch (error, stackTrace) {
      _cancel(id, error, stackTrace);
      return Future.error(error, stackTrace);
    }
  }
}
