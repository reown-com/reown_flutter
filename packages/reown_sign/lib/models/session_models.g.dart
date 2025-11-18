// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Namespace _$NamespaceFromJson(Map<String, dynamic> json) => _Namespace(
  chains: (json['chains'] as List<dynamic>?)?.map((e) => e as String).toList(),
  accounts: (json['accounts'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  methods: (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
  events: (json['events'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$NamespaceToJson(_Namespace instance) =>
    <String, dynamic>{
      'chains': ?instance.chains,
      'accounts': instance.accounts,
      'methods': instance.methods,
      'events': instance.events,
    };

_SessionData _$SessionDataFromJson(Map<String, dynamic> json) => _SessionData(
  topic: json['topic'] as String,
  pairingTopic: json['pairingTopic'] as String,
  relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
  expiry: (json['expiry'] as num).toInt(),
  acknowledged: json['acknowledged'] as bool,
  controller: json['controller'] as String,
  namespaces: (json['namespaces'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
  ),
  self: ConnectionMetadata.fromJson(json['self'] as Map<String, dynamic>),
  peer: ConnectionMetadata.fromJson(json['peer'] as Map<String, dynamic>),
  requiredNamespaces: (json['requiredNamespaces'] as Map<String, dynamic>?)
      ?.map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
  optionalNamespaces: (json['optionalNamespaces'] as Map<String, dynamic>?)
      ?.map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
  sessionProperties: (json['sessionProperties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  authentication: (json['authentication'] as List<dynamic>?)
      ?.map((e) => Cacao.fromJson(e as Map<String, dynamic>))
      .toList(),
  walletPayResult: json['walletPayResult'] == null
      ? null
      : WalletPayResult.fromJson(
          json['walletPayResult'] as Map<String, dynamic>,
        ),
  transportType:
      $enumDecodeNullable(_$TransportTypeEnumMap, json['transportType']) ??
      TransportType.relay,
);

Map<String, dynamic> _$SessionDataToJson(
  _SessionData instance,
) => <String, dynamic>{
  'topic': instance.topic,
  'pairingTopic': instance.pairingTopic,
  'relay': instance.relay.toJson(),
  'expiry': instance.expiry,
  'acknowledged': instance.acknowledged,
  'controller': instance.controller,
  'namespaces': instance.namespaces.map((k, e) => MapEntry(k, e.toJson())),
  'self': instance.self.toJson(),
  'peer': instance.peer.toJson(),
  'requiredNamespaces': ?instance.requiredNamespaces?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'optionalNamespaces': ?instance.optionalNamespaces?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'sessionProperties': ?instance.sessionProperties,
  'authentication': ?instance.authentication?.map((e) => e.toJson()).toList(),
  'walletPayResult': ?instance.walletPayResult?.toJson(),
  'transportType': _$TransportTypeEnumMap[instance.transportType]!,
};

const _$TransportTypeEnumMap = {
  TransportType.relay: 'relay',
  TransportType.linkMode: 'linkMode',
};

_SessionRequest _$SessionRequestFromJson(Map<String, dynamic> json) =>
    _SessionRequest(
      id: (json['id'] as num).toInt(),
      topic: json['topic'] as String,
      chainId: json['chainId'] as String,
      method: json['method'] as String,
      params: json['params'],
      verifyContext: VerifyContext.fromJson(
        json['verifyContext'] as Map<String, dynamic>,
      ),
      transportType:
          $enumDecodeNullable(_$TransportTypeEnumMap, json['transportType']) ??
          TransportType.relay,
    );

Map<String, dynamic> _$SessionRequestToJson(_SessionRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'chainId': instance.chainId,
      'method': instance.method,
      'params': instance.params,
      'verifyContext': instance.verifyContext.toJson(),
      'transportType': _$TransportTypeEnumMap[instance.transportType]!,
    };

_SessionRequestParams _$SessionRequestParamsFromJson(
  Map<String, dynamic> json,
) => _SessionRequestParams(
  method: json['method'] as String,
  params: json['params'],
);

Map<String, dynamic> _$SessionRequestParamsToJson(
  _SessionRequestParams instance,
) => <String, dynamic>{'method': instance.method, 'params': instance.params};

_SessionEventParams _$SessionEventParamsFromJson(Map<String, dynamic> json) =>
    _SessionEventParams(name: json['name'] as String, data: json['data']);

Map<String, dynamic> _$SessionEventParamsToJson(_SessionEventParams instance) =>
    <String, dynamic>{'name': instance.name, 'data': instance.data};

_WalletPayResult _$WalletPayResultFromJson(Map<String, dynamic> json) =>
    _WalletPayResult(
      version: json['version'] as String,
      txid: json['txid'] as String,
      recipient: json['recipient'] as String,
      asset: json['asset'] as String,
      amount: json['amount'] as String,
      orderId: json['orderId'] as String?,
    );

Map<String, dynamic> _$WalletPayResultToJson(_WalletPayResult instance) =>
    <String, dynamic>{
      'version': instance.version,
      'txid': instance.txid,
      'recipient': instance.recipient,
      'asset': instance.asset,
      'amount': instance.amount,
      'orderId': instance.orderId,
    };
