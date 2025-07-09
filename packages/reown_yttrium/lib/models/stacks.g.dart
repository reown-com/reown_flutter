// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stacks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferStxRequestImpl _$$TransferStxRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferStxRequestImpl(
      amount: BigInt.parse(json['amount'] as String),
      sender: json['sender'] as String,
      recipient: json['recipient'] as String,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$$TransferStxRequestImplToJson(
        _$TransferStxRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount.toString(),
      'sender': instance.sender,
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

_$StacksAccountImpl _$$StacksAccountImplFromJson(Map<String, dynamic> json) =>
    _$StacksAccountImpl(
      balance: json['balance'] as String,
      locked: json['locked'] as String,
      unlockHeight: json['unlock_height'] as String,
      nonce: json['nonce'] as String,
      balanceProof: json['balance_proof'] as String,
      nonceProof: json['nonce_proof'] as String,
    );

Map<String, dynamic> _$$StacksAccountImplToJson(_$StacksAccountImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'locked': instance.locked,
      'unlock_height': instance.unlockHeight,
      'nonce': instance.nonce,
      'balance_proof': instance.balanceProof,
      'nonce_proof': instance.nonceProof,
    };

_$FeeEstimationImpl _$$FeeEstimationImplFromJson(Map<String, dynamic> json) =>
    _$FeeEstimationImpl(
      costScalarChangeByByte:
          (json['cost_scalar_change_by_byte'] as num).toDouble(),
      estimatedCost: EstimatedCost.fromJson(
          json['estimated_cost'] as Map<String, dynamic>),
      estimatedCostScalar: (json['estimated_cost_scalar'] as num).toInt(),
      estimations: (json['estimations'] as List<dynamic>)
          .map((e) => Estimation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FeeEstimationImplToJson(_$FeeEstimationImpl instance) =>
    <String, dynamic>{
      'cost_scalar_change_by_byte': instance.costScalarChangeByByte,
      'estimated_cost': instance.estimatedCost.toJson(),
      'estimated_cost_scalar': instance.estimatedCostScalar,
      'estimations': instance.estimations.map((e) => e.toJson()).toList(),
    };

_$EstimatedCostImpl _$$EstimatedCostImplFromJson(Map<String, dynamic> json) =>
    _$EstimatedCostImpl(
      readCount: (json['read_count'] as num).toInt(),
      readLength: (json['read_length'] as num).toInt(),
      runtime: (json['runtime'] as num).toInt(),
      writeCount: (json['write_count'] as num).toInt(),
      writeLength: (json['write_length'] as num).toInt(),
    );

Map<String, dynamic> _$$EstimatedCostImplToJson(_$EstimatedCostImpl instance) =>
    <String, dynamic>{
      'read_count': instance.readCount,
      'read_length': instance.readLength,
      'runtime': instance.runtime,
      'write_count': instance.writeCount,
      'write_length': instance.writeLength,
    };

_$EstimationImpl _$$EstimationImplFromJson(Map<String, dynamic> json) =>
    _$EstimationImpl(
      fee: (json['fee'] as num).toInt(),
      feeRate: (json['fee_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$EstimationImplToJson(_$EstimationImpl instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'fee_rate': instance.feeRate,
    };
