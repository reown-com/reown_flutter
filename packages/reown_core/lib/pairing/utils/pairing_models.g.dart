// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PairingInfo _$PairingInfoFromJson(Map<String, dynamic> json) => _PairingInfo(
  topic: json['topic'] as String,
  expiry: (json['expiry'] as num).toInt(),
  relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
  active: json['active'] as bool,
  methods: (json['methods'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  peerMetadata: json['peerMetadata'] == null
      ? null
      : PairingMetadata.fromJson(json['peerMetadata'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PairingInfoToJson(_PairingInfo instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'expiry': instance.expiry,
      'relay': instance.relay.toJson(),
      'active': instance.active,
      'methods': instance.methods,
      'peerMetadata': instance.peerMetadata?.toJson(),
    };

_PairingMetadata _$PairingMetadataFromJson(Map<String, dynamic> json) =>
    _PairingMetadata(
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String? ?? '',
      icons:
          (json['icons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      verifyUrl: json['verifyUrl'] as String?,
      redirect: json['redirect'] == null
          ? null
          : Redirect.fromJson(json['redirect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PairingMetadataToJson(_PairingMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'icons': instance.icons,
      'verifyUrl': ?instance.verifyUrl,
      'redirect': ?instance.redirect?.toJson(),
    };

_Redirect _$RedirectFromJson(Map<String, dynamic> json) => _Redirect(
  native: json['native'] as String?,
  universal: json['universal'] as String?,
  linkMode: json['linkMode'] as bool? ?? false,
);

Map<String, dynamic> _$RedirectToJson(_Redirect instance) => <String, dynamic>{
  'native': instance.native,
  'universal': instance.universal,
  'linkMode': instance.linkMode,
};

_JsonRpcRecord _$JsonRpcRecordFromJson(Map<String, dynamic> json) =>
    _JsonRpcRecord(
      id: (json['id'] as num).toInt(),
      topic: json['topic'] as String,
      method: json['method'] as String,
      params: json['params'],
      chainId: json['chainId'] as String?,
      expiry: (json['expiry'] as num?)?.toInt(),
      response: json['response'],
    );

Map<String, dynamic> _$JsonRpcRecordToJson(_JsonRpcRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'method': instance.method,
      'params': ?instance.params,
      'chainId': ?instance.chainId,
      'expiry': ?instance.expiry,
      'response': ?instance.response,
    };

_ReceiverPublicKey _$ReceiverPublicKeyFromJson(Map<String, dynamic> json) =>
    _ReceiverPublicKey(
      topic: json['topic'] as String,
      publicKey: json['publicKey'] as String,
      expiry: (json['expiry'] as num).toInt(),
    );

Map<String, dynamic> _$ReceiverPublicKeyToJson(_ReceiverPublicKey instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'publicKey': instance.publicKey,
      'expiry': instance.expiry,
    };
