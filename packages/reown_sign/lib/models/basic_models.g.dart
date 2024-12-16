// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReownSignErrorImpl _$$ReownSignErrorImplFromJson(Map<String, dynamic> json) =>
    _$ReownSignErrorImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$$ReownSignErrorImplToJson(
        _$ReownSignErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      if (instance.data case final value?) 'data': value,
    };

_$ConnectionMetadataImpl _$$ConnectionMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionMetadataImpl(
      publicKey: json['publicKey'] as String,
      metadata:
          PairingMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ConnectionMetadataImplToJson(
        _$ConnectionMetadataImpl instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'metadata': instance.metadata.toJson(),
    };

_$AuthPublicKeyImpl _$$AuthPublicKeyImplFromJson(Map<String, dynamic> json) =>
    _$AuthPublicKeyImpl(
      publicKey: json['publicKey'] as String,
    );

Map<String, dynamic> _$$AuthPublicKeyImplToJson(_$AuthPublicKeyImpl instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
    };
