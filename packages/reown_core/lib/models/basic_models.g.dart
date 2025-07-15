// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublishOptions _$PublishOptionsFromJson(Map<String, dynamic> json) =>
    PublishOptions(
      ttl: (json['ttl'] as num?)?.toInt(),
      tag: (json['tag'] as num?)?.toInt(),
      correlationId: (json['correlationId'] as num?)?.toInt(),
      tvf: json['tvf'] as Map<String, dynamic>?,
      publishMethod: json['publishMethod'] as String?,
    );

Map<String, dynamic> _$PublishOptionsToJson(PublishOptions instance) =>
    <String, dynamic>{
      'ttl': instance.ttl,
      'tag': instance.tag,
      'correlationId': instance.correlationId,
      'tvf': instance.tvf,
      'publishMethod': instance.publishMethod,
    };

SubscribeOptions _$SubscribeOptionsFromJson(Map<String, dynamic> json) =>
    SubscribeOptions(
      topic: json['topic'] as String,
      transportType: $enumDecode(_$TransportTypeEnumMap, json['transportType']),
      skipSubscribe: json['skipSubscribe'] as bool? ?? false,
    );

Map<String, dynamic> _$SubscribeOptionsToJson(SubscribeOptions instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'transportType': _$TransportTypeEnumMap[instance.transportType]!,
      'skipSubscribe': instance.skipSubscribe,
    };

const _$TransportTypeEnumMap = {
  TransportType.relay: 'relay',
  TransportType.linkMode: 'linkMode',
};

_$ReownCoreErrorImpl _$$ReownCoreErrorImplFromJson(Map<String, dynamic> json) =>
    _$ReownCoreErrorImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$$ReownCoreErrorImplToJson(
        _$ReownCoreErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      if (instance.data case final value?) 'data': value,
    };
