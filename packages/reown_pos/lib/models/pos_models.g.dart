// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) =>
    _PaymentIntent(
      token: json['token'] as String,
      amount: json['amount'] as String,
      chainId: json['chainId'] as String,
      recipient: json['recipient'] as String,
    );

Map<String, dynamic> _$PaymentIntentToJson(_PaymentIntent instance) =>
    <String, dynamic>{
      'token': instance.token,
      'amount': instance.amount,
      'chainId': instance.chainId,
      'recipient': instance.recipient,
    };

_Metadata _$MetadataFromJson(Map<String, dynamic> json) => _Metadata(
  merchantName: json['merchantName'] as String,
  description: json['description'] as String,
  url: json['url'] as String,
  logoIcon: json['logoIcon'] as String,
);

Map<String, dynamic> _$MetadataToJson(_Metadata instance) => <String, dynamic>{
  'merchantName': instance.merchantName,
  'description': instance.description,
  'url': instance.url,
  'logoIcon': instance.logoIcon,
};
