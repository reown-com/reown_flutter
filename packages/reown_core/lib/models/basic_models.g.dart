// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReownCoreError _$ReownCoreErrorFromJson(Map<String, dynamic> json) =>
    _ReownCoreError(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ReownCoreErrorToJson(_ReownCoreError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': ?instance.data,
    };

_PublishOptions _$PublishOptionsFromJson(Map<String, dynamic> json) =>
    _PublishOptions(
      ttl: (json['ttl'] as num?)?.toInt(),
      tag: (json['tag'] as num?)?.toInt(),
      correlationId: (json['correlationId'] as num?)?.toInt(),
      tvf: json['tvf'] as Map<String, dynamic>?,
      publishMethod: json['publishMethod'] as String?,
    );

Map<String, dynamic> _$PublishOptionsToJson(_PublishOptions instance) =>
    <String, dynamic>{
      'ttl': ?instance.ttl,
      'tag': ?instance.tag,
      'correlationId': ?instance.correlationId,
      'tvf': ?instance.tvf,
      'publishMethod': ?instance.publishMethod,
    };

_SubscribeOptions _$SubscribeOptionsFromJson(Map<String, dynamic> json) =>
    _SubscribeOptions(
      topic: json['topic'] as String,
      transportType:
          $enumDecodeNullable(_$TransportTypeEnumMap, json['transportType']) ??
          TransportType.relay,
      skipSubscribe: json['skipSubscribe'] as bool? ?? false,
    );

Map<String, dynamic> _$SubscribeOptionsToJson(_SubscribeOptions instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'transportType': _$TransportTypeEnumMap[instance.transportType]!,
      'skipSubscribe': instance.skipSubscribe,
    };

const _$TransportTypeEnumMap = {
  TransportType.relay: 'relay',
  TransportType.linkMode: 'linkMode',
};
