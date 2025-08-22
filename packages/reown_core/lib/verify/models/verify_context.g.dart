// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyContext _$VerifyContextFromJson(Map<String, dynamic> json) =>
    _VerifyContext(
      origin: json['origin'] as String,
      validation: $enumDecode(_$ValidationEnumMap, json['validation']),
      verifyUrl: json['verifyUrl'] as String,
      isScam: json['isScam'] as bool?,
    );

Map<String, dynamic> _$VerifyContextToJson(_VerifyContext instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'validation': _$ValidationEnumMap[instance.validation]!,
      'verifyUrl': instance.verifyUrl,
      'isScam': instance.isScam,
    };

const _$ValidationEnumMap = {
  Validation.UNKNOWN: 'UNKNOWN',
  Validation.VALID: 'VALID',
  Validation.INVALID: 'INVALID',
  Validation.SCAM: 'SCAM',
};

_AttestationResponse _$AttestationResponseFromJson(Map<String, dynamic> json) =>
    _AttestationResponse(
      origin: json['origin'] as String,
      attestationId: json['attestationId'] as String,
      isScam: json['isScam'] as bool?,
    );

Map<String, dynamic> _$AttestationResponseToJson(
  _AttestationResponse instance,
) => <String, dynamic>{
  'origin': instance.origin,
  'attestationId': instance.attestationId,
  'isScam': instance.isScam,
};
