// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JsonRpcError _$JsonRpcErrorFromJson(Map<String, dynamic> json) =>
    _JsonRpcError(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$JsonRpcErrorToJson(_JsonRpcError instance) =>
    <String, dynamic>{'code': ?instance.code, 'message': ?instance.message};

_JsonRpcRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) =>
    _JsonRpcRequest(
      id: (json['id'] as num).toInt(),
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      method: json['method'] as String,
      params: json['params'],
    );

Map<String, dynamic> _$JsonRpcRequestToJson(_JsonRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params,
    };

_JsonRpcResponse<T> _$JsonRpcResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _JsonRpcResponse<T>(
  id: (json['id'] as num).toInt(),
  jsonrpc: json['jsonrpc'] as String? ?? '2.0',
  error: json['error'] == null
      ? null
      : JsonRpcError.fromJson(json['error'] as Map<String, dynamic>),
  result: _$nullableGenericFromJson(json['result'], fromJsonT),
);

Map<String, dynamic> _$JsonRpcResponseToJson<T>(
  _JsonRpcResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'id': instance.id,
  'jsonrpc': instance.jsonrpc,
  'error': instance.error?.toJson(),
  'result': _$nullableGenericToJson(instance.result, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
