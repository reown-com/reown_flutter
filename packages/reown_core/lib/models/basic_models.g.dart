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
    _$ReownCoreErrorImpl instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}
