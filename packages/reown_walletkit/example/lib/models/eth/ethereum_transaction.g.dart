// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ethereum_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EthereumTransaction _$EthereumTransactionFromJson(Map<String, dynamic> json) =>
    EthereumTransaction(
      from: json['from'] as String,
      to: json['to'] as String,
      value: json['value'] as String,
      nonce: json['nonce'] as String?,
      gasPrice: json['gasPrice'] as String?,
      maxFeePerGas: json['maxFeePerGas'] as String?,
      maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String?,
      gas: json['gas'] as String?,
      gasLimit: json['gasLimit'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$EthereumTransactionToJson(
        EthereumTransaction instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'value': instance.value,
      if (instance.nonce case final value?) 'nonce': value,
      if (instance.gasPrice case final value?) 'gasPrice': value,
      if (instance.maxFeePerGas case final value?) 'maxFeePerGas': value,
      if (instance.maxPriorityFeePerGas case final value?)
        'maxPriorityFeePerGas': value,
      if (instance.gas case final value?) 'gas': value,
      if (instance.gasLimit case final value?) 'gasLimit': value,
      if (instance.data case final value?) 'data': value,
    };
