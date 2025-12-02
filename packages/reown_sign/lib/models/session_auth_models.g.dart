// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionAuthRequestParams _$SessionAuthRequestParamsFromJson(
  Map<String, dynamic> json,
) => _SessionAuthRequestParams(
  domain: json['domain'] as String,
  chains: (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
  nonce: json['nonce'] as String,
  uri: json['uri'] as String,
  type: json['type'] == null
      ? null
      : CacaoHeader.fromJson(json['type'] as Map<String, dynamic>),
  exp: json['exp'] as String?,
  nbf: json['nbf'] as String?,
  statement: json['statement'] as String?,
  requestId: json['requestId'] as String?,
  resources: (json['resources'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  expiry: (json['expiry'] as num?)?.toInt(),
  signatureTypes: (json['signatureTypes'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
  methods: (json['methods'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SessionAuthRequestParamsToJson(
  _SessionAuthRequestParams instance,
) => <String, dynamic>{
  'domain': instance.domain,
  'chains': instance.chains,
  'nonce': instance.nonce,
  'uri': instance.uri,
  'type': ?instance.type?.toJson(),
  'exp': ?instance.exp,
  'nbf': ?instance.nbf,
  'statement': ?instance.statement,
  'requestId': ?instance.requestId,
  'resources': ?instance.resources,
  'expiry': ?instance.expiry,
  'signatureTypes': ?instance.signatureTypes,
  'methods': ?instance.methods,
};

_SessionAuthPayload _$SessionAuthPayloadFromJson(Map<String, dynamic> json) =>
    _SessionAuthPayload(
      domain: json['domain'] as String,
      chains: (json['chains'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nonce: json['nonce'] as String,
      aud: json['aud'] as String,
      type: json['type'] as String,
      version: json['version'] as String,
      iat: json['iat'] as String,
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SessionAuthPayloadToJson(_SessionAuthPayload instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'chains': instance.chains,
      'nonce': instance.nonce,
      'aud': instance.aud,
      'type': instance.type,
      'version': instance.version,
      'iat': instance.iat,
      'nbf': ?instance.nbf,
      'exp': ?instance.exp,
      'statement': ?instance.statement,
      'requestId': ?instance.requestId,
      'resources': ?instance.resources,
    };

_PendingSessionAuthRequest _$PendingSessionAuthRequestFromJson(
  Map<String, dynamic> json,
) => _PendingSessionAuthRequest(
  id: (json['id'] as num).toInt(),
  pairingTopic: json['pairingTopic'] as String,
  requester: ConnectionMetadata.fromJson(
    json['requester'] as Map<String, dynamic>,
  ),
  expiryTimestamp: (json['expiryTimestamp'] as num).toInt(),
  authPayload: CacaoRequestPayload.fromJson(
    json['authPayload'] as Map<String, dynamic>,
  ),
  verifyContext: VerifyContext.fromJson(
    json['verifyContext'] as Map<String, dynamic>,
  ),
  transportType:
      $enumDecodeNullable(_$TransportTypeEnumMap, json['transportType']) ??
      TransportType.relay,
);

Map<String, dynamic> _$PendingSessionAuthRequestToJson(
  _PendingSessionAuthRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'pairingTopic': instance.pairingTopic,
  'requester': instance.requester.toJson(),
  'expiryTimestamp': instance.expiryTimestamp,
  'authPayload': instance.authPayload.toJson(),
  'verifyContext': instance.verifyContext.toJson(),
  'transportType': _$TransportTypeEnumMap[instance.transportType]!,
};

const _$TransportTypeEnumMap = {
  TransportType.relay: 'relay',
  TransportType.linkMode: 'linkMode',
};
