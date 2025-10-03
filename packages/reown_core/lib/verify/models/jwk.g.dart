// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JWK _$JWKFromJson(Map<String, dynamic> json) => _JWK(
  publicKey: PublicKey.fromJson(json['publicKey'] as Map<String, dynamic>),
  expiresAt: (json['expiresAt'] as num).toInt(),
);

Map<String, dynamic> _$JWKToJson(_JWK instance) => <String, dynamic>{
  'publicKey': instance.publicKey.toJson(),
  'expiresAt': instance.expiresAt,
};

_PublicKey _$PublicKeyFromJson(Map<String, dynamic> json) => _PublicKey(
  crv: json['crv'] as String,
  ext: json['ext'] as bool,
  keyOps: (json['key_ops'] as List<dynamic>).map((e) => e as String).toList(),
  kty: json['kty'] as String,
  x: json['x'] as String,
  y: json['y'] as String,
);

Map<String, dynamic> _$PublicKeyToJson(_PublicKey instance) =>
    <String, dynamic>{
      'crv': instance.crv,
      'ext': instance.ext,
      'key_ops': instance.keyOps,
      'kty': instance.kty,
      'x': instance.x,
      'y': instance.y,
    };
