// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueryParams _$QueryParamsFromJson(Map<String, dynamic> json) => _QueryParams(
  projectId: json['projectId'] as String,
  deviceId: json['deviceId'] as String,
  st: json['st'] as String,
  sv: json['sv'] as String,
);

Map<String, dynamic> _$QueryParamsToJson(_QueryParams instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'deviceId': instance.deviceId,
      'st': instance.st,
      'sv': instance.sv,
    };

_PaymentIntentParams _$PaymentIntentParamsFromJson(Map<String, dynamic> json) =>
    _PaymentIntentParams(
      asset: json['asset'] as String,
      amount: json['amount'] as String,
      sender: json['sender'] as String,
      recipient: json['recipient'] as String,
    );

Map<String, dynamic> _$PaymentIntentParamsToJson(
  _PaymentIntentParams instance,
) => <String, dynamic>{
  'asset': instance.asset,
  'amount': instance.amount,
  'sender': instance.sender,
  'recipient': instance.recipient,
};

_BuildTransactionParams _$BuildTransactionParamsFromJson(
  Map<String, dynamic> json,
) => _BuildTransactionParams(
  paymentIntents: (json['paymentIntents'] as List<dynamic>)
      .map((e) => PaymentIntentParams.fromJson(e as Map<String, dynamic>))
      .toList(),
  capabilities: json['capabilities'],
);

Map<String, dynamic> _$BuildTransactionParamsToJson(
  _BuildTransactionParams instance,
) => <String, dynamic>{
  'paymentIntents': instance.paymentIntents,
  'capabilities': instance.capabilities,
};

_CheckTransactionParams _$CheckTransactionParamsFromJson(
  Map<String, dynamic> json,
) => _CheckTransactionParams(
  id: json['id'] as String,
  sendResult: json['sendResult'] as String,
);

Map<String, dynamic> _$CheckTransactionParamsToJson(
  _CheckTransactionParams instance,
) => <String, dynamic>{'id': instance.id, 'sendResult': instance.sendResult};
