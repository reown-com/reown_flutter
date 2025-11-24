/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart'
    show Serializable;
import 'error_response.dart';
import 'exception.dart';
import 'request.dart';
import 'success_response.dart';

/// JSON RPC Response
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC response.
abstract class JsonRpcResponse<T> extends Serializable {
  /// The interface for a JSON RPC response.
  const JsonRpcResponse({required this.jsonrpc, this.id});

  /// The JSON RPC version.
  final String jsonrpc;

  /// The client-generated identifier sent with the request.
  final int? id;

  /// The `jsonrpc` property key.
  static const String jsonrpcKey = 'jsonrpc';

  /// The `id` property key.
  static const String idKey = 'id';

  /// Parses the [json] RPC response and returns the result.
  static JsonRpcResponse<T> deocde<S, T>(
    final Map<String, dynamic> json,
    final T Function(S value) decoder,
  ) {
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
