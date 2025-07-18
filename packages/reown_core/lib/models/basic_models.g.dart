// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

_$PublishOptionsImpl _$$PublishOptionsImplFromJson(Map<String, dynamic> json) =>
    _$PublishOptionsImpl(
      ttl: (json['ttl'] as num?)?.toInt(),
      tag: (json['tag'] as num?)?.toInt(),
      correlationId: (json['correlationId'] as num?)?.toInt(),
      tvf: json['tvf'] as Map<String, dynamic>?,
      publishMethod: json['publishMethod'] as String?,
    );

Map<String, dynamic> _$$PublishOptionsImplToJson(
        _$PublishOptionsImpl instance) =>
    <String, dynamic>{
      if (instance.ttl case final value?) 'ttl': value,
      if (instance.tag case final value?) 'tag': value,
      if (instance.correlationId case final value?) 'correlationId': value,
      if (instance.tvf case final value?) 'tvf': value,
      if (instance.publishMethod case final value?) 'publishMethod': value,
    };

_$SubscribeOptionsImpl _$$SubscribeOptionsImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscribeOptionsImpl(
      topic: json['topic'] as String,
      transportType:
          $enumDecodeNullable(_$TransportTypeEnumMap, json['transportType']) ??
              TransportType.relay,
      skipSubscribe: json['skipSubscribe'] as bool? ?? false,
    );

Map<String, dynamic> _$$SubscribeOptionsImplToJson(
        _$SubscribeOptionsImpl instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'transportType': _$TransportTypeEnumMap[instance.transportType]!,
      'skipSubscribe': instance.skipSubscribe,
    };

const _$TransportTypeEnumMap = {
  TransportType.relay: 'relay',
  TransportType.linkMode: 'linkMode',
};
