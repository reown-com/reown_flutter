// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequiredNamespace _$RequiredNamespaceFromJson(
  Map<String, dynamic> json,
) => _RequiredNamespace(
  chains: (json['chains'] as List<dynamic>?)?.map((e) => e as String).toList(),
  methods: (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
  events: (json['events'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$RequiredNamespaceToJson(_RequiredNamespace instance) =>
    <String, dynamic>{
      'chains': ?instance.chains,
      'methods': instance.methods,
      'events': instance.events,
    };

_SessionProposal _$SessionProposalFromJson(Map<String, dynamic> json) =>
    _SessionProposal(
      id: (json['id'] as num).toInt(),
      params: ProposalData.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionProposalToJson(_SessionProposal instance) =>
    <String, dynamic>{'id': instance.id, 'params': instance.params.toJson()};

_ProposalData _$ProposalDataFromJson(
  Map<String, dynamic> json,
) => _ProposalData(
  id: (json['id'] as num).toInt(),
  expiry: (json['expiry'] as num).toInt(),
  relays: (json['relays'] as List<dynamic>)
      .map((e) => Relay.fromJson(e as Map<String, dynamic>))
      .toList(),
  proposer: ConnectionMetadata.fromJson(
    json['proposer'] as Map<String, dynamic>,
  ),
  requiredNamespaces: (json['requiredNamespaces'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
  ),
  optionalNamespaces: (json['optionalNamespaces'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
  ),
  pairingTopic: json['pairingTopic'] as String,
  sessionProperties: (json['sessionProperties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  generatedNamespaces: (json['generatedNamespaces'] as Map<String, dynamic>?)
      ?.map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
);

Map<String, dynamic> _$ProposalDataToJson(_ProposalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expiry': instance.expiry,
      'relays': instance.relays.map((e) => e.toJson()).toList(),
      'proposer': instance.proposer.toJson(),
      'requiredNamespaces': instance.requiredNamespaces.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
      'optionalNamespaces': instance.optionalNamespaces.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
      'pairingTopic': instance.pairingTopic,
      'sessionProperties': ?instance.sessionProperties,
      'generatedNamespaces': ?instance.generatedNamespaces?.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
    };
