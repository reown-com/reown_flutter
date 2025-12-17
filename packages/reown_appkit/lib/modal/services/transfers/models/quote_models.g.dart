// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteFee _$QuoteFeeFromJson(Map<String, dynamic> json) => _QuoteFee(
  id: json['id'] as String,
  label: json['label'] as String,
  amount: json['amount'] as String,
  amountFormatted: json['amountFormatted'] as String,
  chainId: json['chainId'] as String,
  amountUsd: json['amountUsd'] as String,
  currency: ExchangeAsset.fromJson(json['currency'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuoteFeeToJson(_QuoteFee instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'amount': instance.amount,
  'amountFormatted': instance.amountFormatted,
  'chainId': instance.chainId,
  'amountUsd': instance.amountUsd,
  'currency': instance.currency.toJson(),
};

_QuoteCurrency _$QuoteCurrencyFromJson(Map<String, dynamic> json) =>
    _QuoteCurrency(
      amount: json['amount'] as String,
      amountFormatted: json['amountFormatted'] as String,
      chainId: json['chainId'] as String,
      symbol: json['symbol'] as String?,
      decimals: (json['decimals'] as num?)?.toInt(),
    );

Map<String, dynamic> _$QuoteCurrencyToJson(_QuoteCurrency instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'amountFormatted': instance.amountFormatted,
      'chainId': instance.chainId,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
    };

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
  type: $enumDecode(_$QuoteTypeEnumMap, json['type']),
  origin: QuoteCurrency.fromJson(json['origin'] as Map<String, dynamic>),
  destination: QuoteCurrency.fromJson(
    json['destination'] as Map<String, dynamic>,
  ),
  fees: (json['fees'] as List<dynamic>)
      .map((e) => QuoteFee.fromJson(e as Map<String, dynamic>))
      .toList(),
  requestId: json['requestId'] as String,
  depositAddress: json['depositAddress'] as String,
  timeEstimate: (json['timeEstimate'] as num).toInt(),
);

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
  'type': _$QuoteTypeEnumMap[instance.type]!,
  'origin': instance.origin.toJson(),
  'destination': instance.destination.toJson(),
  'fees': instance.fees.map((e) => e.toJson()).toList(),
  'requestId': instance.requestId,
  'depositAddress': instance.depositAddress,
  'timeEstimate': instance.timeEstimate,
};

const _$QuoteTypeEnumMap = {
  QuoteType.sameChain: 'same-chain',
  QuoteType.crossChain: 'cross-chain',
};
