// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cacao_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CacaoRequestPayload _$CacaoRequestPayloadFromJson(Map<String, dynamic> json) =>
    _CacaoRequestPayload(
      domain: json['domain'] as String,
      aud: json['aud'] as String,
      version: json['version'] as String,
      nonce: json['nonce'] as String,
      iat: json['iat'] as String,
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CacaoRequestPayloadToJson(
  _CacaoRequestPayload instance,
) => <String, dynamic>{
  'domain': instance.domain,
  'aud': instance.aud,
  'version': instance.version,
  'nonce': instance.nonce,
  'iat': instance.iat,
  'nbf': ?instance.nbf,
  'exp': ?instance.exp,
  'statement': ?instance.statement,
  'requestId': ?instance.requestId,
  'resources': ?instance.resources,
};

_CacaoPayload _$CacaoPayloadFromJson(Map<String, dynamic> json) =>
    _CacaoPayload(
      iss: json['iss'] as String,
      domain: json['domain'] as String,
      aud: json['aud'] as String,
      version: json['version'] as String,
      nonce: json['nonce'] as String,
      iat: json['iat'] as String,
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CacaoPayloadToJson(_CacaoPayload instance) =>
    <String, dynamic>{
      'iss': instance.iss,
      'domain': instance.domain,
      'aud': instance.aud,
      'version': instance.version,
      'nonce': instance.nonce,
      'iat': instance.iat,
      'nbf': ?instance.nbf,
      'exp': ?instance.exp,
      'statement': ?instance.statement,
      'requestId': ?instance.requestId,
      'resources': ?instance.resources,
    };

_CacaoHeader _$CacaoHeaderFromJson(Map<String, dynamic> json) =>
    _CacaoHeader(t: json['t'] as String? ?? 'eip4361');

Map<String, dynamic> _$CacaoHeaderToJson(_CacaoHeader instance) =>
    <String, dynamic>{'t': instance.t};

_CacaoSignature _$CacaoSignatureFromJson(Map<String, dynamic> json) =>
    _CacaoSignature(
      t: json['t'] as String,
      s: json['s'] as String,
      m: json['m'] as String?,
    );

Map<String, dynamic> _$CacaoSignatureToJson(_CacaoSignature instance) =>
    <String, dynamic>{'t': instance.t, 's': instance.s, 'm': ?instance.m};

_Cacao _$CacaoFromJson(Map<String, dynamic> json) => _Cacao(
  h: CacaoHeader.fromJson(json['h'] as Map<String, dynamic>),
  p: CacaoPayload.fromJson(json['p'] as Map<String, dynamic>),
  s: CacaoSignature.fromJson(json['s'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CacaoToJson(_Cacao instance) => <String, dynamic>{
  'h': instance.h.toJson(),
  'p': instance.p.toJson(),
  's': instance.s.toJson(),
};

_StoredCacao _$StoredCacaoFromJson(Map<String, dynamic> json) => _StoredCacao(
  id: (json['id'] as num).toInt(),
  pairingTopic: json['pairingTopic'] as String,
  h: CacaoHeader.fromJson(json['h'] as Map<String, dynamic>),
  p: CacaoPayload.fromJson(json['p'] as Map<String, dynamic>),
  s: CacaoSignature.fromJson(json['s'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoredCacaoToJson(_StoredCacao instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pairingTopic': instance.pairingTopic,
      'h': instance.h.toJson(),
      'p': instance.p.toJson(),
      's': instance.s.toJson(),
    };
