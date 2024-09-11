import 'package:freezed_annotation/freezed_annotation.dart';

part 'json_rpc_models.g.dart';
part 'json_rpc_models.freezed.dart';

@freezed
class RpcOptions with _$RpcOptions {
  // @JsonSerializable()
  const factory RpcOptions({
    required int ttl,
    required bool prompt,
    required int tag,
  }) = _RpcOptions;
}

@freezed
class JsonRpcError with _$JsonRpcError {
  @JsonSerializable(includeIfNull: false)
  const factory JsonRpcError({
    int? code,
    String? message,
  }) = _JsonRpcError;

  factory JsonRpcError.serverError(String message) =>
      JsonRpcError(code: -32000, message: message);
  factory JsonRpcError.invalidParams(String message) =>
      JsonRpcError(code: -32602, message: message);
  factory JsonRpcError.invalidRequest(String message) =>
      JsonRpcError(code: -32600, message: message);
  factory JsonRpcError.parseError(String message) =>
      JsonRpcError(code: -32700, message: message);
  factory JsonRpcError.methodNotFound(String message) =>
      JsonRpcError(code: -32601, message: message);

  factory JsonRpcError.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcErrorFromJson(json);
}

@freezed
class JsonRpcRequest with _$JsonRpcRequest {
  @JsonSerializable()
  const factory JsonRpcRequest({
    required int id,
    @Default('2.0') String jsonrpc,
    required String method,
    dynamic params,
  }) = _JsonRpcRequest;

  factory JsonRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcRequestFromJson(json);
}

@Freezed(genericArgumentFactories: true)
class JsonRpcResponse<T> with _$JsonRpcResponse<T> {
  // @JsonSerializable(genericArgumentFactories: true)
  const factory JsonRpcResponse({
    required int id,
    @Default('2.0') String jsonrpc,
    JsonRpcError? error,
    T? result,
  }) = _JsonRpcResponse<T>;

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcResponseFromJson(json, (object) => object as T);
}
