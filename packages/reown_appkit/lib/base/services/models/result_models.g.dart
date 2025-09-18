// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exchange _$ExchangeFromJson(Map<String, dynamic> json) => _Exchange(
  id: json['id'] as String,
  imageUrl: json['imageUrl'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$ExchangeToJson(_Exchange instance) => <String, dynamic>{
  'id': instance.id,
  'imageUrl': instance.imageUrl,
  'name': instance.name,
};

_GetExchangesResult _$GetExchangesResultFromJson(Map<String, dynamic> json) =>
    _GetExchangesResult(
      exchanges: (json['exchanges'] as List<dynamic>)
          .map((e) => Exchange.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$GetExchangesResultToJson(_GetExchangesResult instance) =>
    <String, dynamic>{
      'exchanges': instance.exchanges.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };

_GetExchangeUrlResult _$GetExchangeUrlResultFromJson(
  Map<String, dynamic> json,
) => _GetExchangeUrlResult(
  sessionId: json['sessionId'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$GetExchangeUrlResultToJson(
  _GetExchangeUrlResult instance,
) => <String, dynamic>{'sessionId': instance.sessionId, 'url': instance.url};

_GetExchangeDepositStatusResult _$GetExchangeDepositStatusResultFromJson(
  Map<String, dynamic> json,
) => _GetExchangeDepositStatusResult(
  status: json['status'] as String,
  txHash: json['txHash'] as String?,
);

Map<String, dynamic> _$GetExchangeDepositStatusResultToJson(
  _GetExchangeDepositStatusResult instance,
) => <String, dynamic>{'status': instance.status, 'txHash': instance.txHash};
