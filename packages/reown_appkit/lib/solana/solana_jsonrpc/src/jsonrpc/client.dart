/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:async' show FutureOr, TimeoutException;
import 'dart:convert';
import 'package:flutter/foundation.dart' show protected;
import 'exception.dart';
import 'error_response.dart';
import 'client_config.dart';
import 'request.dart';
import 'response.dart';
import 'success_response.dart';

/// Types
/// ------------------------------------------------------------------------------------------------

/// Converts a JSON RPC request to byte data.
typedef JsonRpcClientEncoder = Converter<Object, FutureOr<List<int>>>;

/// Converts a JSON RPC response of type T to JSON.
typedef JsonRpcClientDecoder<T> = Converter<T, FutureOr<dynamic>>;

/// Converts a JSON object to type T, where T is a [JsonRpcResponse] or list of [JsonRpcResponse]s.
typedef JsonRpcResponseDecoder<S, T> = T Function(S input);

/// JSON RPC Client
/// ------------------------------------------------------------------------------------------------

/// JSON RPC client interface.
abstract class Client<R> {
  /// Creates a JSON RPC client.
  const Client(
    this.uri, {
    this.timeLimit,
    required this.encoder,
    required this.decoder,
  });

  /// The connecting endpoint.
  final Uri uri;

  /// The default timeout duration applied to each request.
  final Duration? timeLimit;

  /// Converts the outgoing requests to byte data.
  final JsonRpcClientEncoder encoder;

  /// Converts the incoming responses of type [R] to JSON.
  final JsonRpcClientDecoder<R> decoder;

  /// Closes the client and disposes of all acquired resources.
  FutureOr<void> dispose();

  /// Creates a [TimeoutException].
  FutureOr<T> onTimeout<T>() =>
      Future.error(TimeoutException('The request has timed out.'));

  /// Creates a new [Future] that completes with the result of [request] or a [TimeoutException] if
  /// [timeLimit] elapses (default: [Client.timeLimit]).
  Future<T> timeout<T>(final Future<T> request, final Duration? timeLimit) {
    final Duration? limit = timeLimit ?? this.timeLimit;
    return limit != null
        ? request.timeout(limit, onTimeout: onTimeout)
        : request;
  }

  /// Sends an [encoded] JSON RPC request to [uri] and returns the `decoded` JSON response (Map or
  /// List of Maps).
  ///
  /// The [config] object can be used to configure the request.
  @protected
  Future<T> handler<T>(
    final List<int> encoded, {
    final JsonRpcClientConfig? config,
    final int? id,
  });

  /// Sends a JSON RPC request to [uri] and returns its response.
  ///
  /// The [decode] method is used to convert the JSON response to a [JsonRpcResponse].
  ///
  /// The [config] object can be used to configure the request.
  Future<JsonRpcSuccessResponse<T>> send<T>(
    final JsonRpcRequest request,
    final JsonRpcResponseDecoder<Map<String, dynamic>, JsonRpcResponse<T>>
        decode, {
    final JsonRpcClientConfig? config,
  }) async {
    final List<int> body = await encoder.convert(request);
    final Map<String, dynamic> json =
        await handler(body, config: config, id: request.id);
    final JsonRpcResponse<T> response = decode(json);
    return response is JsonRpcErrorResponse<T>
        ? Future.error(response.error) // [JsonRpcException]
        : Future.value(response as JsonRpcSuccessResponse<T>);
  }

  /// Sends a batch JSON RPC request to [uri] and returns its response.
  ///
  /// The [decode] method is used to convert the JSON response to a [JsonRpcResponse].
  ///
  /// The [config] object can be used to configure the request.
  ///
  /// Set [eagerError] to complete the future with a call to [Future.error] containing the first
  /// error ([JsonRpcException]) found in the response.
  Future<List<JsonRpcResponse<T>>> sendAll<T>(
    final List<JsonRpcRequest> request,
    final JsonRpcResponseDecoder<List<Map<String, dynamic>>,
            List<JsonRpcResponse<T>>>
        decode, {
    final JsonRpcClientConfig? config,
    final bool eagerError = false,
  }) async {
    if (request.isEmpty) return const [];
    final List<int> body = await encoder.convert(request);
    final List result =
        await handler(body, config: config, id: request.first.id);
    final List<Map<String, dynamic>> json = result.cast<Map<String, dynamic>>();
    final List<JsonRpcResponse<T>> response = decode(json);
    return eagerError ? _errorOrValue(response) : Future.value(response);
  }

  /// Returns a completed [Future] that resolves to an error if [value] contains a
  /// [JsonRpcErrorResponse].
  Future<List<JsonRpcResponse<T>>> _errorOrValue<T>(
    final List<JsonRpcResponse<T>> value,
  ) {
    for (final JsonRpcResponse response in value) {
      if (response is JsonRpcErrorResponse) {
        return Future.error(response.error);
      }
    }
    return Future.value(value);
  }
}
