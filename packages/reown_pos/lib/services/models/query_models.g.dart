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

_BuildTransactionParams _$BuildTransactionParamsFromJson(
  Map<String, dynamic> json,
) => _BuildTransactionParams(
  asset: json['asset'] as String,
  amount: json['amount'] as String,
  sender: json['sender'] as String,
  recipient: json['recipient'] as String,
);

Map<String, dynamic> _$BuildTransactionParamsToJson(
  _BuildTransactionParams instance,
) => <String, dynamic>{
  'asset': instance.asset,
  'amount': instance.amount,
  'sender': instance.sender,
  'recipient': instance.recipient,
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
