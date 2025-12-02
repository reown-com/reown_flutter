// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stacks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransferStxRequest _$TransferStxRequestFromJson(Map<String, dynamic> json) =>
    _TransferStxRequest(
      amount: BigInt.parse(json['amount'] as String),
      sender: json['sender'] as String,
      recipient: json['recipient'] as String,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$TransferStxRequestToJson(_TransferStxRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount.toString(),
      'sender': instance.sender,
      'recipient': instance.recipient,
      'memo': instance.memo,
    };

_TransferStxResponse _$TransferStxResponseFromJson(Map<String, dynamic> json) =>
    _TransferStxResponse(
      transaction: json['transaction'] as String,
      txid: json['txid'] as String,
    );

Map<String, dynamic> _$TransferStxResponseToJson(
  _TransferStxResponse instance,
) => <String, dynamic>{
  'transaction': instance.transaction,
  'txid': instance.txid,
};

_StacksAccount _$StacksAccountFromJson(Map<String, dynamic> json) =>
    _StacksAccount(
      balance: json['balance'] as String,
      locked: json['locked'] as String,
      unlockHeight: json['unlock_height'] as String,
      nonce: json['nonce'] as String,
      balanceProof: json['balance_proof'] as String,
      nonceProof: json['nonce_proof'] as String,
    );

Map<String, dynamic> _$StacksAccountToJson(_StacksAccount instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'locked': instance.locked,
      'unlock_height': instance.unlockHeight,
      'nonce': instance.nonce,
      'balance_proof': instance.balanceProof,
      'nonce_proof': instance.nonceProof,
    };

_FeeEstimation _$FeeEstimationFromJson(Map<String, dynamic> json) =>
    _FeeEstimation(
      costScalarChangeByByte: (json['cost_scalar_change_by_byte'] as num)
          .toDouble(),
      estimatedCost: EstimatedCost.fromJson(
        json['estimated_cost'] as Map<String, dynamic>,
      ),
      estimatedCostScalar: (json['estimated_cost_scalar'] as num).toInt(),
      estimations: (json['estimations'] as List<dynamic>)
          .map((e) => Estimation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeeEstimationToJson(_FeeEstimation instance) =>
    <String, dynamic>{
      'cost_scalar_change_by_byte': instance.costScalarChangeByByte,
      'estimated_cost': instance.estimatedCost.toJson(),
      'estimated_cost_scalar': instance.estimatedCostScalar,
      'estimations': instance.estimations.map((e) => e.toJson()).toList(),
    };

_EstimatedCost _$EstimatedCostFromJson(Map<String, dynamic> json) =>
    _EstimatedCost(
      readCount: (json['read_count'] as num).toInt(),
      readLength: (json['read_length'] as num).toInt(),
      runtime: (json['runtime'] as num).toInt(),
      writeCount: (json['write_count'] as num).toInt(),
      writeLength: (json['write_length'] as num).toInt(),
    );

Map<String, dynamic> _$EstimatedCostToJson(_EstimatedCost instance) =>
    <String, dynamic>{
      'read_count': instance.readCount,
      'read_length': instance.readLength,
      'runtime': instance.runtime,
      'write_count': instance.writeCount,
      'write_length': instance.writeLength,
    };

_Estimation _$EstimationFromJson(Map<String, dynamic> json) => _Estimation(
  fee: (json['fee'] as num).toInt(),
  feeRate: (json['fee_rate'] as num).toDouble(),
);

Map<String, dynamic> _$EstimationToJson(_Estimation instance) =>
    <String, dynamic>{'fee': instance.fee, 'fee_rate': instance.feeRate};
