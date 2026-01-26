// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetQuoteStatusResult _$GetQuoteStatusResultFromJson(
  Map<String, dynamic> json,
) => _GetQuoteStatusResult(
  status: $enumDecode(_$QuoteStatusEnumMap, json['status']),
  txHash: json['txHash'] as String?,
);

Map<String, dynamic> _$GetQuoteStatusResultToJson(
  _GetQuoteStatusResult instance,
) => <String, dynamic>{
  'status': _$QuoteStatusEnumMap[instance.status]!,
  'txHash': instance.txHash,
};

const _$QuoteStatusEnumMap = {
  QuoteStatus.waiting: 'waiting',
  QuoteStatus.pending: 'pending',
  QuoteStatus.success: 'success',
  QuoteStatus.submitted: 'submitted',
  QuoteStatus.failure: 'failure',
  QuoteStatus.refund: 'refund',
  QuoteStatus.timeout: 'timeout',
};

_GetExchangeAssetsResult _$GetExchangeAssetsResultFromJson(
  Map<String, dynamic> json,
) => _GetExchangeAssetsResult(
  exchangeId: json['exchangeId'] as String,
  assets: (json['assets'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      (e as List<dynamic>)
          .map((e) => ExchangeAsset.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  ),
);

Map<String, dynamic> _$GetExchangeAssetsResultToJson(
  _GetExchangeAssetsResult instance,
) => <String, dynamic>{
  'exchangeId': instance.exchangeId,
  'assets': instance.assets.map(
    (k, e) => MapEntry(k, e.map((e) => e.toJson()).toList()),
  ),
};
