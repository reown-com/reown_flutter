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
