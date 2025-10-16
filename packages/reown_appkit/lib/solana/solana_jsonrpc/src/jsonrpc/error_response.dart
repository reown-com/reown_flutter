/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'exception.dart';
import 'response.dart';

/// JSON RPC Error Response
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC error response.
class JsonRpcErrorResponse<T> extends JsonRpcResponse<T> {
  /// Creates a JSON RPC `error` response.
  const JsonRpcErrorResponse({
    required super.jsonrpc,
    required this.error,
    super.id,
  });

  /// The error response object.
  final JsonRpcException error;

  /// The JSON response's error key.
  static const String errorKey = 'error';

  /// {@macro solana_common.Serializable.fromJson}
  factory JsonRpcErrorResponse.fromJson(final Map<String, dynamic> json) =>
      JsonRpcErrorResponse(
        jsonrpc: json[JsonRpcResponse.jsonrpcKey],
        error: json[JsonRpcErrorResponse.errorKey],
        id: json[JsonRpcResponse.idKey],
      );

  @override
  Map<String, dynamic> toJson() => {
    JsonRpcResponse.jsonrpcKey: jsonrpc,
    JsonRpcErrorResponse.errorKey: error,
    JsonRpcResponse.idKey: id,
  };
}
