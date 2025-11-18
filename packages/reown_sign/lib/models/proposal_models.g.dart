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
  requests: json['requests'] == null
      ? null
      : ProposalRequests.fromJson(json['requests'] as Map<String, dynamic>),
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
      'requests': ?instance.requests?.toJson(),
    };

_ProposalRequests _$ProposalRequestsFromJson(Map<String, dynamic> json) =>
    _ProposalRequests(
      authentication: (json['authentication'] as List<dynamic>?)
          ?.map((e) => SessionAuthPayload.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletPayRequest: json['walletPayRequest'] == null
          ? null
          : WalletPayRequestParams.fromJson(
              json['walletPayRequest'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ProposalRequestsToJson(
  _ProposalRequests instance,
) => <String, dynamic>{
  'authentication': ?instance.authentication?.map((e) => e.toJson()).toList(),
  'walletPayRequest': ?instance.walletPayRequest?.toJson(),
};

_WalletPayRequestParams _$WalletPayRequestParamsFromJson(
  Map<String, dynamic> json,
) => _WalletPayRequestParams(
  version: json['version'] as String,
  acceptedPayments: (json['acceptedPayments'] as List<dynamic>)
      .map((e) => PaymentOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  expiry: (json['expiry'] as num).toInt(),
  orderId: json['orderId'] as String?,
);

Map<String, dynamic> _$WalletPayRequestParamsToJson(
  _WalletPayRequestParams instance,
) => <String, dynamic>{
  'version': instance.version,
  'acceptedPayments': instance.acceptedPayments.map((e) => e.toJson()).toList(),
  'expiry': instance.expiry,
  'orderId': instance.orderId,
};

_PaymentOption _$PaymentOptionFromJson(Map<String, dynamic> json) =>
    _PaymentOption(
      recipient: json['recipient'] as String,
      asset: json['asset'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$PaymentOptionToJson(_PaymentOption instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'asset': instance.asset,
      'amount': instance.amount,
    };
