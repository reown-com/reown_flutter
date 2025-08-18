// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rust_sign_client_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionProposalImpl _$$SessionProposalImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionProposalImpl(
      id: (json['id'] as num).toInt(),
      pairingTopic: json['pairingTopic'] as String,
      pairingSymKey: json['pairingSymKey'] as String,
      proposerPublicKey: json['proposerPublicKey'] as String,
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
      expiry: (json['expiry'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SessionProposalImplToJson(
        _$SessionProposalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pairingTopic': instance.pairingTopic,
      'pairingSymKey': instance.pairingSymKey,
      'proposerPublicKey': instance.proposerPublicKey,
      'relays': instance.relays,
      'requiredNamespaces': instance.requiredNamespaces,
      'optionalNamespaces': instance.optionalNamespaces,
      'metadata': instance.metadata,
      'sessionProperties': instance.sessionProperties,
      'scopedProperties': instance.scopedProperties,
      'expiry': instance.expiry,
    };

_$ApproveResultImpl _$$ApproveResultImplFromJson(Map<String, dynamic> json) =>
    _$ApproveResultImpl(
      sessionSymKey: json['sessionSymKey'] as String,
      selfPublicKey: json['selfPublicKey'] as String,
    );

Map<String, dynamic> _$$ApproveResultImplToJson(_$ApproveResultImpl instance) =>
    <String, dynamic>{
      'sessionSymKey': instance.sessionSymKey,
      'selfPublicKey': instance.selfPublicKey,
    };
