// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_pay_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PaymentOptionToJson(_PaymentOption instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'asset': instance.asset,
      'amount': instance.amount,
      'types': instance.types,
    };
