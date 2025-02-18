// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcException _$JsonRpcExceptionFromJson(Map<String, dynamic> json) =>
    JsonRpcException(
      json['message'] as String,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'],
    );

Map<String, dynamic> _$JsonRpcExceptionToJson(JsonRpcException instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
