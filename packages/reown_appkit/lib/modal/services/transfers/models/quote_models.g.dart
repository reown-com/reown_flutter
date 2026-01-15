// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteFee _$QuoteFeeFromJson(Map<String, dynamic> json) => _QuoteFee(
  id: json['id'] as String,
  label: json['label'] as String,
  amount: json['amount'] as String,
  currency: ExchangeAsset.fromJson(json['currency'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuoteFeeToJson(_QuoteFee instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'amount': instance.amount,
  'currency': instance.currency.toJson(),
};

_QuoteAmount _$QuoteAmountFromJson(Map<String, dynamic> json) => _QuoteAmount(
  amount: json['amount'] as String,
  currency: ExchangeAsset.fromJson(json['currency'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuoteAmountToJson(_QuoteAmount instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency.toJson(),
    };

_QuoteDeposit _$QuoteDepositFromJson(Map<String, dynamic> json) =>
    _QuoteDeposit(
      amount: json['amount'] as String,
      currency: json['currency'] as String,
      receiver: json['receiver'] as String,
    );

Map<String, dynamic> _$QuoteDepositToJson(_QuoteDeposit instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'receiver': instance.receiver,
    };

QuoteStepDeposit _$QuoteStepDepositFromJson(Map<String, dynamic> json) =>
    QuoteStepDeposit(
      requestId: json['requestId'] as String,
      deposit: QuoteDeposit.fromJson(json['deposit'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$QuoteStepDepositToJson(QuoteStepDeposit instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'deposit': instance.deposit.toJson(),
      'type': instance.$type,
    };

QuoteStepTransaction _$QuoteStepTransactionFromJson(
  Map<String, dynamic> json,
) => QuoteStepTransaction(
  requestId: json['requestId'] as String,
  transaction: json['transaction'],
  $type: json['type'] as String?,
);

Map<String, dynamic> _$QuoteStepTransactionToJson(
  QuoteStepTransaction instance,
) => <String, dynamic>{
  'requestId': instance.requestId,
  'transaction': instance.transaction,
  'type': instance.$type,
};

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
  type: $enumDecodeNullable(_$QuoteTypeEnumMap, json['type']),
  origin: QuoteAmount.fromJson(json['origin'] as Map<String, dynamic>),
  destination: QuoteAmount.fromJson(
    json['destination'] as Map<String, dynamic>,
  ),
  steps: (json['steps'] as List<dynamic>)
      .map((e) => QuoteStep.fromJson(e as Map<String, dynamic>))
      .toList(),
  fees: (json['fees'] as List<dynamic>)
      .map((e) => QuoteFee.fromJson(e as Map<String, dynamic>))
      .toList(),
  timeInSeconds: (json['timeInSeconds'] as num).toInt(),
);

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
  'type': ?_$QuoteTypeEnumMap[instance.type],
  'origin': instance.origin.toJson(),
  'destination': instance.destination.toJson(),
  'steps': instance.steps.map((e) => e.toJson()).toList(),
  'fees': instance.fees.map((e) => e.toJson()).toList(),
  'timeInSeconds': instance.timeInSeconds,
};

const _$QuoteTypeEnumMap = {QuoteType.directTransfer: 'direct-transfer'};
