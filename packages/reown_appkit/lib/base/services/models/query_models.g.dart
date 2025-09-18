// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueryParams _$QueryParamsFromJson(Map<String, dynamic> json) => _QueryParams(
  projectId: json['projectId'] as String,
  source: json['source'] as String,
  st: json['st'] as String,
  sv: json['sv'] as String,
);

Map<String, dynamic> _$QueryParamsToJson(_QueryParams instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'source': instance.source,
      'st': instance.st,
      'sv': instance.sv,
    };

_GetExchangesParams _$GetExchangesParamsFromJson(Map<String, dynamic> json) =>
    _GetExchangesParams(
      page: (json['page'] as num?)?.toInt() ?? 1,
      asset: json['asset'] == null
          ? null
          : ExchangeAsset.fromJson(json['asset'] as Map<String, dynamic>),
      includeOnly: (json['includeOnly'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      exclude: (json['exclude'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GetExchangesParamsToJson(_GetExchangesParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'asset': ?instance.asset?.toJson(),
      'includeOnly': ?instance.includeOnly,
      'exclude': ?instance.exclude,
    };

_GetExchangeUrlParams _$GetExchangeUrlParamsFromJson(
  Map<String, dynamic> json,
) => _GetExchangeUrlParams(
  exchangeId: json['exchangeId'] as String,
  asset: ExchangeAsset.fromJson(json['asset'] as Map<String, dynamic>),
  amount: json['amount'] as String,
  recipient: json['recipient'] as String,
);

Map<String, dynamic> _$GetExchangeUrlParamsToJson(
  _GetExchangeUrlParams instance,
) => <String, dynamic>{
  'exchangeId': instance.exchangeId,
  'asset': instance.asset.toJson(),
  'amount': instance.amount,
  'recipient': instance.recipient,
};

_GetExchangeByStatusParams _$GetExchangeByStatusParamsFromJson(
  Map<String, dynamic> json,
) => _GetExchangeByStatusParams(
  exchangeId: json['exchangeId'] as String,
  sessionId: json['sessionId'] as String,
);

Map<String, dynamic> _$GetExchangeByStatusParamsToJson(
  _GetExchangeByStatusParams instance,
) => <String, dynamic>{
  'exchangeId': instance.exchangeId,
  'sessionId': instance.sessionId,
};
