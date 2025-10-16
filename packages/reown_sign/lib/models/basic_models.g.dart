// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReownSignError _$ReownSignErrorFromJson(Map<String, dynamic> json) =>
    _ReownSignError(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ReownSignErrorToJson(_ReownSignError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': ?instance.data,
    };

_ConnectionMetadata _$ConnectionMetadataFromJson(Map<String, dynamic> json) =>
    _ConnectionMetadata(
      publicKey: json['publicKey'] as String,
      metadata: PairingMetadata.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ConnectionMetadataToJson(_ConnectionMetadata instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'metadata': instance.metadata.toJson(),
    };

_AuthPublicKey _$AuthPublicKeyFromJson(Map<String, dynamic> json) =>
    _AuthPublicKey(publicKey: json['publicKey'] as String);

Map<String, dynamic> _$AuthPublicKeyToJson(_AuthPublicKey instance) =>
    <String, dynamic>{'publicKey': instance.publicKey};
