// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JsonRpcErrorImpl _$$JsonRpcErrorImplFromJson(Map<String, dynamic> json) =>
    _$JsonRpcErrorImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$JsonRpcErrorImplToJson(_$JsonRpcErrorImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('message', instance.message);
  return val;
}

_$JsonRpcRequestImpl _$$JsonRpcRequestImplFromJson(Map<String, dynamic> json) =>
    _$JsonRpcRequestImpl(
      id: (json['id'] as num).toInt(),
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      method: json['method'] as String,
      params: json['params'],
    );

Map<String, dynamic> _$$JsonRpcRequestImplToJson(
        _$JsonRpcRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params,
    };

_$JsonRpcResponseImpl<T> _$$JsonRpcResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$JsonRpcResponseImpl<T>(
      id: (json['id'] as num).toInt(),
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      error: json['error'] == null
          ? null
          : JsonRpcError.fromJson(json['error'] as Map<String, dynamic>),
      result: _$nullableGenericFromJson(json['result'], fromJsonT),
    );

Map<String, dynamic> _$$JsonRpcResponseImplToJson<T>(
  _$JsonRpcResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'error': instance.error?.toJson(),
      'result': _$nullableGenericToJson(instance.result, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
