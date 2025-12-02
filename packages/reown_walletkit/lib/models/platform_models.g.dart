// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlatformSessionProposal _$PlatformSessionProposalFromJson(
  Map<String, dynamic> json,
) => _PlatformSessionProposal(
  pairingTopic: json['pairingTopic'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  url: json['url'] as String,
  icons: (json['icons'] as List<dynamic>).map((e) => e as String).toList(),
  redirect: json['redirect'] as String,
  requiredNamespaces: (json['requiredNamespaces'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
  ),
  optionalNamespaces: (json['optionalNamespaces'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
  ),
  proposerPublicKey: json['proposerPublicKey'] as String,
  relayProtocol: json['relayProtocol'] as String,
  relayData: json['relayData'],
  scopedProperties: json['scopedProperties'],
  properties: json['properties'],
);

Map<String, dynamic> _$PlatformSessionProposalToJson(
  _PlatformSessionProposal instance,
) => <String, dynamic>{
  'pairingTopic': instance.pairingTopic,
  'name': instance.name,
  'description': instance.description,
  'url': instance.url,
  'icons': instance.icons,
  'redirect': instance.redirect,
  'requiredNamespaces': instance.requiredNamespaces.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'optionalNamespaces': instance.optionalNamespaces.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'proposerPublicKey': instance.proposerPublicKey,
  'relayProtocol': instance.relayProtocol,
  'relayData': instance.relayData,
  'scopedProperties': instance.scopedProperties,
  'properties': instance.properties,
};

_PlatformSessionSettle _$PlatformSessionSettleFromJson(
  Map<String, dynamic> json,
) => _PlatformSessionSettle(
  type: json['type'] as String,
  session: PlatformSession.fromJson(json['session'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlatformSessionSettleToJson(
  _PlatformSessionSettle instance,
) => <String, dynamic>{
  'type': instance.type,
  'session': instance.session.toJson(),
};

_PlatformSession _$PlatformSessionFromJson(
  Map<String, dynamic> json,
) => _PlatformSession(
  pairingTopic: json['pairingTopic'] as String,
  topic: json['topic'] as String,
  expiry: (json['expiry'] as num).toInt(),
  requiredNamespaces: json['requiredNamespaces'] as Map<String, dynamic>,
  optionalNamespaces: (json['optionalNamespaces'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, PlatformNamespace.fromJson(e as Map<String, dynamic>)),
  ),
  namespaces: (json['namespaces'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      PlatformNamespaceWithAccounts.fromJson(e as Map<String, dynamic>),
    ),
  ),
  metaData: PlatformMetaData.fromJson(json['metaData'] as Map<String, dynamic>),
  redirect: json['redirect'] as String,
);

Map<String, dynamic> _$PlatformSessionToJson(_PlatformSession instance) =>
    <String, dynamic>{
      'pairingTopic': instance.pairingTopic,
      'topic': instance.topic,
      'expiry': instance.expiry,
      'requiredNamespaces': instance.requiredNamespaces,
      'optionalNamespaces': instance.optionalNamespaces.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
      'namespaces': instance.namespaces.map((k, e) => MapEntry(k, e.toJson())),
      'metaData': instance.metaData.toJson(),
      'redirect': instance.redirect,
    };

_PlatformNamespace _$PlatformNamespaceFromJson(
  Map<String, dynamic> json,
) => _PlatformNamespace(
  chains: (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
  methods: (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
  events: (json['events'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$PlatformNamespaceToJson(_PlatformNamespace instance) =>
    <String, dynamic>{
      'chains': instance.chains,
      'methods': instance.methods,
      'events': instance.events,
    };

_PlatformNamespaceWithAccounts _$PlatformNamespaceWithAccountsFromJson(
  Map<String, dynamic> json,
) => _PlatformNamespaceWithAccounts(
  chains: (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
  accounts: (json['accounts'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  methods: (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
  events: (json['events'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$PlatformNamespaceWithAccountsToJson(
  _PlatformNamespaceWithAccounts instance,
) => <String, dynamic>{
  'chains': instance.chains,
  'accounts': instance.accounts,
  'methods': instance.methods,
  'events': instance.events,
};

_PlatformMetaData _$PlatformMetaDataFromJson(Map<String, dynamic> json) =>
    _PlatformMetaData(
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      icons: (json['icons'] as List<dynamic>).map((e) => e as String).toList(),
      redirect: json['redirect'] as String,
    );

Map<String, dynamic> _$PlatformMetaDataToJson(_PlatformMetaData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'icons': instance.icons,
      'redirect': instance.redirect,
    };
