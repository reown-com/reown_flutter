// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stacks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferStxRequestImpl _$$TransferStxRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferStxRequestImpl(
      amount: BigInt.parse(json['amount'] as String),
      recipient: json['recipient'] as String,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$$TransferStxRequestImplToJson(
        _$TransferStxRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount.toString(),
      'recipient': instance.recipient,
      'memo': instance.memo,
    };

_$TransferStxResponseImpl _$$TransferStxResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferStxResponseImpl(
      transaction: json['transaction'] as String,
      txid: json['txid'] as String,
    );

Map<String, dynamic> _$$TransferStxResponseImplToJson(
        _$TransferStxResponseImpl instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'txid': instance.txid,
    };
