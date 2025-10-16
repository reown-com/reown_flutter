/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:flutter/foundation.dart';
import 'commitment.dart';
import 'context_method.dart';
import 'error_response.dart';
import 'exception.dart';
import 'request.dart';
import 'response.dart';
import 'success_response.dart';

/// Types
/// ------------------------------------------------------------------------------------------------

/// A [JsonRpcMethod] for subscribe methods.
typedef JsonRpcSubscribeMethod = JsonRpcMethod<int, int>;

/// A [JsonRpcMethod] for unsubscribe methods.
typedef JsonRpcUnsubscribeMethod = JsonRpcMethod<bool, bool>;

/// JSON RPC Method
/// ------------------------------------------------------------------------------------------------

/// An interface for JSON RPC methods.
///
/// Defines a [JsonRpcMethod] to invoke [method] with [params] (See [JsonRpcContextMethod] for
/// response-context methods).
///
/// Use [request] to generate a new JSON RPC request and [response] to handle the result.
///
/// The [decoder] defines how the `result` property of a successful JSON RPC response is mapped from
/// [S] to [T].
///
/// ## Example
/// ```
/// class GetBlockHeight extends JsonRpcMethod<int, int> {
///   GetBlockHeight(): super('getBlockHeight');
///   @override int decoder(final int value) => value;
///   @override Object? params([Commitment? commitment]) => null;
/// }
///
/// final client = JsonRpcHttpClient(Cluster.devnet.uri);
/// final method = GetBlockHeight();
/// final response = await client.send(method.request(), method.response);
/// print(jsonEncode(response)); // {"jsonrpc":"2.0", "result":197469478, "id":1}
/// ```
abstract class JsonRpcMethod<S, T> {
  /// Creates a handler to invoke [method] with [params].
  const JsonRpcMethod(this.method);

  /// Auto increment id.
  static int _id = 0;

  /// The JSON RPC method name,
  final String method;

  /// Returns the JSON RPC request's `params` property value.
  Object? params([final Commitment? commitment]);

  /// Decodes the `result` property of a successful JSON RPC response.
  ///
  /// ```
  /// final response = {"jsonrpc":"2.0", "result":197469478, "id":1}
  /// decoder(response["result"])
  /// ```
  @protected
  T decoder(final S value);

  /// Creates a [JsonRpcRequest] to invoke [method] with [params]. The [commitment] level is
  /// provided as a default value to all methods that query bank state.
  JsonRpcRequest request([final Commitment? commitment]) =>
      JsonRpcRequest(id: ++_id, method: method, params: params(commitment));

  /// Parses the [json] RPC response and returns the result.
  JsonRpcResponse<T> response(final Map<String, dynamic> json) {
    // Success responses contain a 'result' key.
    if (json.containsKey(JsonRpcSuccessResponse.resultKey)) {
      final S result = json[JsonRpcSuccessResponse.resultKey];
      json[JsonRpcSuccessResponse.resultKey] = decoder(result);
      return JsonRpcSuccessResponse<T>.fromJson(json);
    }

    // Error responses contain an 'error' key.
    if (json.containsKey(JsonRpcErrorResponse.errorKey)) {
      final Map<String, dynamic> error = json[JsonRpcErrorResponse.errorKey];
      json[JsonRpcErrorResponse.errorKey] = JsonRpcException.fromJson(error);
      return JsonRpcErrorResponse<T>.fromJson(json);
    }

    // A valid JSON RPC 2.0 response object must contain a 'result' or 'error', but not both.
    // https://www.jsonrpc.org/specification#response_object
    return const JsonRpcErrorResponse(
      jsonrpc: JsonRpcRequest.version,
      error: JsonRpcException('Unexpected response format.'),
    );
  }
}
