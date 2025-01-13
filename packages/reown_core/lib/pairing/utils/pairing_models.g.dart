// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PairingInfoImpl _$$PairingInfoImplFromJson(Map<String, dynamic> json) =>
    _$PairingInfoImpl(
      topic: json['topic'] as String,
      expiry: (json['expiry'] as num).toInt(),
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      active: json['active'] as bool,
      methods:
          (json['methods'] as List<dynamic>?)?.map((e) => e as String).toList(),
      peerMetadata: json['peerMetadata'] == null
          ? null
          : PairingMetadata.fromJson(
              json['peerMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PairingInfoImplToJson(_$PairingInfoImpl instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'expiry': instance.expiry,
      'relay': instance.relay.toJson(),
      'active': instance.active,
      'methods': instance.methods,
      'peerMetadata': instance.peerMetadata?.toJson(),
    };

_$PairingMetadataImpl _$$PairingMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$PairingMetadataImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      icons:
          (json['icons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      verifyUrl: json['verifyUrl'] as String?,
      redirect: json['redirect'] == null
          ? null
          : Redirect.fromJson(json['redirect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PairingMetadataImplToJson(
        _$PairingMetadataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'icons': instance.icons,
      if (instance.verifyUrl case final value?) 'verifyUrl': value,
      if (instance.redirect?.toJson() case final value?) 'redirect': value,
    };

_$RedirectImpl _$$RedirectImplFromJson(Map<String, dynamic> json) =>
    _$RedirectImpl(
      native: json['native'] as String?,
      universal: json['universal'] as String?,
      linkMode: json['linkMode'] as bool? ?? false,
    );

Map<String, dynamic> _$$RedirectImplToJson(_$RedirectImpl instance) =>
    <String, dynamic>{
      'native': instance.native,
      'universal': instance.universal,
      'linkMode': instance.linkMode,
    };

_$JsonRpcRecordImpl _$$JsonRpcRecordImplFromJson(Map<String, dynamic> json) =>
    _$JsonRpcRecordImpl(
      id: (json['id'] as num).toInt(),
      topic: json['topic'] as String,
      method: json['method'] as String,
      params: json['params'],
      chainId: json['chainId'] as String?,
      expiry: (json['expiry'] as num?)?.toInt(),
      response: json['response'],
    );

Map<String, dynamic> _$$JsonRpcRecordImplToJson(_$JsonRpcRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'method': instance.method,
      if (instance.params case final value?) 'params': value,
      if (instance.chainId case final value?) 'chainId': value,
      if (instance.expiry case final value?) 'expiry': value,
      if (instance.response case final value?) 'response': value,
    };

_$ReceiverPublicKeyImpl _$$ReceiverPublicKeyImplFromJson(
        Map<String, dynamic> json) =>
    _$ReceiverPublicKeyImpl(
      topic: json['topic'] as String,
      publicKey: json['publicKey'] as String,
      expiry: (json['expiry'] as num).toInt(),
    );

Map<String, dynamic> _$$ReceiverPublicKeyImplToJson(
        _$ReceiverPublicKeyImpl instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'publicKey': instance.publicKey,
      'expiry': instance.expiry,
    };
