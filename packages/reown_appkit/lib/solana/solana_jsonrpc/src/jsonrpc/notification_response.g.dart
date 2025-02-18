// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcNotificationResponse<T> _$JsonRpcNotificationResponseFromJson<T>(
        Map<String, dynamic> json) =>
    JsonRpcNotificationResponse<T>(
      jsonrpc: json['jsonrpc'] as String? ?? JsonRpcRequest.version,
      method: json['method'] as String,
      params: JsonRpcNotification<T>.fromJson(
          json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonRpcNotificationResponseToJson<T>(
        JsonRpcNotificationResponse<T> instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params.toJson(),
    };
