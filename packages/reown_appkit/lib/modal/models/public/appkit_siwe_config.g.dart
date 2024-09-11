// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appkit_siwe_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SIWECreateMessageArgsImpl _$$SIWECreateMessageArgsImplFromJson(
        Map<String, dynamic> json) =>
    _$SIWECreateMessageArgsImpl(
      chainId: json['chainId'] as String,
      domain: json['domain'] as String,
      nonce: json['nonce'] as String,
      uri: json['uri'] as String,
      address: json['address'] as String,
      version: json['version'] as String? ?? '1',
      type: json['type'] == null
          ? const CacaoHeader(t: 'eip4361')
          : CacaoHeader.fromJson(json['type'] as Map<String, dynamic>),
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expiry: (json['expiry'] as num?)?.toInt(),
      iat: json['iat'] as String?,
    );

Map<String, dynamic> _$$SIWECreateMessageArgsImplToJson(
        _$SIWECreateMessageArgsImpl instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'domain': instance.domain,
      'nonce': instance.nonce,
      'uri': instance.uri,
      'address': instance.address,
      'version': instance.version,
      'type': instance.type?.toJson(),
      'nbf': instance.nbf,
      'exp': instance.exp,
      'statement': instance.statement,
      'requestId': instance.requestId,
      'resources': instance.resources,
      'expiry': instance.expiry,
      'iat': instance.iat,
    };

_$SIWEMessageArgsImpl _$$SIWEMessageArgsImplFromJson(
        Map<String, dynamic> json) =>
    _$SIWEMessageArgsImpl(
      domain: json['domain'] as String,
      uri: json['uri'] as String,
      type: json['type'] == null
          ? const CacaoHeader(t: 'eip4361')
          : CacaoHeader.fromJson(json['type'] as Map<String, dynamic>),
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expiry: (json['expiry'] as num?)?.toInt(),
      iat: json['iat'] as String?,
      methods:
          (json['methods'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SIWEMessageArgsImplToJson(
        _$SIWEMessageArgsImpl instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'uri': instance.uri,
      'type': instance.type?.toJson(),
      'nbf': instance.nbf,
      'exp': instance.exp,
      'statement': instance.statement,
      'requestId': instance.requestId,
      'resources': instance.resources,
      'expiry': instance.expiry,
      'iat': instance.iat,
      'methods': instance.methods,
    };

_$SIWEVerifyMessageArgsImpl _$$SIWEVerifyMessageArgsImplFromJson(
        Map<String, dynamic> json) =>
    _$SIWEVerifyMessageArgsImpl(
      message: json['message'] as String,
      signature: json['signature'] as String,
      cacao: json['cacao'] == null
          ? null
          : Cacao.fromJson(json['cacao'] as Map<String, dynamic>),
      clientId: json['clientId'] as String?,
    );

Map<String, dynamic> _$$SIWEVerifyMessageArgsImplToJson(
        _$SIWEVerifyMessageArgsImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'signature': instance.signature,
      'cacao': instance.cacao?.toJson(),
      'clientId': instance.clientId,
    };

_$SIWESessionImpl _$$SIWESessionImplFromJson(Map<String, dynamic> json) =>
    _$SIWESessionImpl(
      address: json['address'] as String,
      chains:
          (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SIWESessionImplToJson(_$SIWESessionImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'chains': instance.chains,
    };
