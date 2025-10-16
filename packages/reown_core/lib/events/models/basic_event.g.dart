// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoreEventProperties _$CoreEventPropertiesFromJson(Map<String, dynamic> json) =>
    _CoreEventProperties(
      message: json['message'] as String?,
      name: json['name'] as String?,
      method: json['method'] as String?,
      connected: json['connected'] as bool?,
      network: json['network'] as String?,
      explorer_id: json['explorer_id'] as String?,
      provider: json['provider'] as String?,
      platform: json['platform'] as String?,
      trace: (json['trace'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      topic: json['topic'] as String?,
      correlation_id: (json['correlation_id'] as num?)?.toInt(),
      client_id: json['client_id'] as String?,
      direction: json['direction'] as String?,
      userAgent: json['userAgent'] as String?,
      sendToken: json['sendToken'] as String?,
      sendAmount: json['sendAmount'] as String?,
      address: json['address'] as String?,
      project_id: json['project_id'] as String?,
      cursor: json['cursor'] as String?,
    );

Map<String, dynamic> _$CoreEventPropertiesToJson(
  _CoreEventProperties instance,
) => <String, dynamic>{
  'message': ?instance.message,
  'name': ?instance.name,
  'method': ?instance.method,
  'connected': ?instance.connected,
  'network': ?instance.network,
  'explorer_id': ?instance.explorer_id,
  'provider': ?instance.provider,
  'platform': ?instance.platform,
  'trace': ?instance.trace,
  'topic': ?instance.topic,
  'correlation_id': ?instance.correlation_id,
  'client_id': ?instance.client_id,
  'direction': ?instance.direction,
  'userAgent': ?instance.userAgent,
  'sendToken': ?instance.sendToken,
  'sendAmount': ?instance.sendAmount,
  'address': ?instance.address,
  'project_id': ?instance.project_id,
  'cursor': ?instance.cursor,
};
