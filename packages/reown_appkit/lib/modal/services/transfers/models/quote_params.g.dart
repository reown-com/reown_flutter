// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetQuoteParams _$GetQuoteParamsFromJson(Map<String, dynamic> json) =>
    _GetQuoteParams(
      sourceToken: ExchangeAsset.fromJson(
        json['sourceToken'] as Map<String, dynamic>,
      ),
      toToken: ExchangeAsset.fromJson(json['toToken'] as Map<String, dynamic>),
      recipient: json['recipient'] as String,
      amount: json['amount'] as String,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$GetQuoteParamsToJson(_GetQuoteParams instance) =>
    <String, dynamic>{
      'sourceToken': instance.sourceToken.toJson(),
      'toToken': instance.toToken.toJson(),
      'recipient': instance.recipient,
      'amount': instance.amount,
      'address': instance.address,
    };

_GetTransfersQuoteParams _$GetTransfersQuoteParamsFromJson(
  Map<String, dynamic> json,
) => _GetTransfersQuoteParams(
  user: json['user'] as String?,
  originChainId: json['originChainId'] as String,
  originCurrency: json['originCurrency'] as String,
  destinationChainId: json['destinationChainId'] as String,
  destinationCurrency: json['destinationCurrency'] as String,
  recipient: json['recipient'] as String,
  amount: json['amount'] as String,
);

Map<String, dynamic> _$GetTransfersQuoteParamsToJson(
  _GetTransfersQuoteParams instance,
) => <String, dynamic>{
  'user': ?instance.user,
  'originChainId': instance.originChainId,
  'originCurrency': instance.originCurrency,
  'destinationChainId': instance.destinationChainId,
  'destinationCurrency': instance.destinationCurrency,
  'recipient': instance.recipient,
  'amount': instance.amount,
};

_GetQuoteStatusParams _$GetQuoteStatusParamsFromJson(
  Map<String, dynamic> json,
) => _GetQuoteStatusParams(requestId: json['requestId'] as String);

Map<String, dynamic> _$GetQuoteStatusParamsToJson(
  _GetQuoteStatusParams instance,
) => <String, dynamic>{'requestId': instance.requestId};
