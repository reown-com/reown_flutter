// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rust_sign_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionProposalFfiImpl _$$SessionProposalFfiImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionProposalFfiImpl(
      id: json['id'] as String,
      topic: json['topic'] as String,
      pairingSymKey: (json['pairingSymKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      proposerPublicKey: (json['proposerPublicKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      relays: (json['relays'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      requiredNamespaces:
          (json['requiredNamespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
      optionalNamespaces:
          (json['optionalNamespaces'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
      metadata: json['metadata'] as Map<String, dynamic>,
      sessionProperties:
          (json['sessionProperties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      scopedProperties:
          (json['scopedProperties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      expiryTimestamp: (json['expiryTimestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SessionProposalFfiImplToJson(
        _$SessionProposalFfiImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'pairingSymKey': instance.pairingSymKey,
      'proposerPublicKey': instance.proposerPublicKey,
      'relays': instance.relays,
      'requiredNamespaces': instance.requiredNamespaces,
      'optionalNamespaces': instance.optionalNamespaces,
      'metadata': instance.metadata,
      'sessionProperties': instance.sessionProperties,
      'scopedProperties': instance.scopedProperties,
      'expiryTimestamp': instance.expiryTimestamp,
    };

_$SettleNamespaceFfiImpl _$$SettleNamespaceFfiImplFromJson(
        Map<String, dynamic> json) =>
    _$SettleNamespaceFfiImpl(
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events:
          (json['events'] as List<dynamic>).map((e) => e as String).toList(),
      chains:
          (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SettleNamespaceFfiImplToJson(
        _$SettleNamespaceFfiImpl instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
      'methods': instance.methods,
      'events': instance.events,
      'chains': instance.chains,
    };

_$MetadataFfiImpl _$$MetadataFfiImplFromJson(Map<String, dynamic> json) =>
    _$MetadataFfiImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String? ?? '',
      icons:
          (json['icons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      verifyUrl: json['verifyUrl'] as String?,
      redirect: json['redirect'] == null
          ? null
          : RedirectFfi.fromJson(json['redirect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MetadataFfiImplToJson(_$MetadataFfiImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'icons': instance.icons,
      if (instance.verifyUrl case final value?) 'verifyUrl': value,
      if (instance.redirect?.toJson() case final value?) 'redirect': value,
    };

_$RedirectFfiImpl _$$RedirectFfiImplFromJson(Map<String, dynamic> json) =>
    _$RedirectFfiImpl(
      native: json['native'] as String?,
      universal: json['universal'] as String?,
      linkMode: json['linkMode'] as bool? ?? false,
    );

Map<String, dynamic> _$$RedirectFfiImplToJson(_$RedirectFfiImpl instance) =>
    <String, dynamic>{
      'native': instance.native,
      'universal': instance.universal,
      'linkMode': instance.linkMode,
    };

_$ApproveResultFfiImpl _$$ApproveResultFfiImplFromJson(
        Map<String, dynamic> json) =>
    _$ApproveResultFfiImpl(
      sessionSymKey: (json['sessionSymKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      selfPublicKey: (json['selfPublicKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$ApproveResultFfiImplToJson(
        _$ApproveResultFfiImpl instance) =>
    <String, dynamic>{
      'sessionSymKey': instance.sessionSymKey,
      'selfPublicKey': instance.selfPublicKey,
    };
