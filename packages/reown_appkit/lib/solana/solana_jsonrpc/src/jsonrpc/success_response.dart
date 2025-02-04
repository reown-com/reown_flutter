/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'response.dart';
import 'response_context.dart';

/// Types
/// ------------------------------------------------------------------------------------------------

/// A [JsonRpcSuccessResponse] for context methods.
typedef JsonRpcContextResponse<T>
    = JsonRpcSuccessResponse<JsonRpcResponseContext<T>>;

/// A [JsonRpcSuccessResponse] subscribe methods.
typedef JsonRpcSubscribeResponse = JsonRpcSuccessResponse<int>;

/// A [JsonRpcSuccessResponse] unsubscribe methods.
typedef JsonRpcUnsubscribeResponse = JsonRpcSuccessResponse<bool>;

/// JSON RPC Success Response
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC `success` response.
class JsonRpcSuccessResponse<T> extends JsonRpcResponse<T> {
  /// Creates a JSON RPC `success` response.
  const JsonRpcSuccessResponse({
    required super.jsonrpc,
    required this.result,
    super.id,
  });

  /// The requested data or success confirmation (array|number|object|string).
  final T? result;

  /// The response data's result key.
  static const String resultKey = 'result';

  /// {@macro solana_common.Serializable.fromJson}
  factory JsonRpcSuccessResponse.fromJson(
    final Map<String, dynamic> json,
  ) =>
      JsonRpcSuccessResponse<T>(
        jsonrpc: json[JsonRpcResponse.jsonrpcKey],
        result: json[JsonRpcSuccessResponse.resultKey],
        id: json[JsonRpcResponse.idKey],
      );

  @override
  Map<String, dynamic> toJson() => {
        JsonRpcResponse.jsonrpcKey: jsonrpc,
        JsonRpcSuccessResponse.resultKey: result,
        JsonRpcResponse.idKey: id,
      };
}
