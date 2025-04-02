// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoreEventPropertiesImpl _$$CoreEventPropertiesImplFromJson(
        Map<String, dynamic> json) =>
    _$CoreEventPropertiesImpl(
      message: json['message'] as String?,
      name: json['name'] as String?,
      method: json['method'] as String?,
      connected: json['connected'] as bool?,
      network: json['network'] as String?,
      explorer_id: json['explorer_id'] as String?,
      provider: json['provider'] as String?,
      platform: json['platform'] as String?,
      trace:
          (json['trace'] as List<dynamic>?)?.map((e) => e as String).toList(),
      topic: json['topic'] as String?,
      correlation_id: (json['correlation_id'] as num?)?.toInt(),
      client_id: json['client_id'] as String?,
      direction: json['direction'] as String?,
      userAgent: json['userAgent'] as String?,
      sendToken: json['sendToken'] as String?,
      sendAmount: json['sendAmount'] as String?,
    );

Map<String, dynamic> _$$CoreEventPropertiesImplToJson(
        _$CoreEventPropertiesImpl instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
      if (instance.name case final value?) 'name': value,
      if (instance.method case final value?) 'method': value,
      if (instance.connected case final value?) 'connected': value,
      if (instance.network case final value?) 'network': value,
      if (instance.explorer_id case final value?) 'explorer_id': value,
      if (instance.provider case final value?) 'provider': value,
      if (instance.platform case final value?) 'platform': value,
      if (instance.trace case final value?) 'trace': value,
      if (instance.topic case final value?) 'topic': value,
      if (instance.correlation_id case final value?) 'correlation_id': value,
      if (instance.client_id case final value?) 'client_id': value,
      if (instance.direction case final value?) 'direction': value,
      if (instance.userAgent case final value?) 'userAgent': value,
      if (instance.sendToken case final value?) 'sendToken': value,
      if (instance.sendAmount case final value?) 'sendAmount': value,
    };
