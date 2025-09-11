// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SolanaTransactionParams _$SolanaTransactionParamsFromJson(
  Map<String, dynamic> json,
) => _SolanaTransactionParams(
  transaction: json['transaction'] as String,
  pubkey: json['pubkey'] as String,
);

Map<String, dynamic> _$SolanaTransactionParamsToJson(
  _SolanaTransactionParams instance,
) => <String, dynamic>{
  'transaction': instance.transaction,
  'pubkey': instance.pubkey,
};

_EvmTransactionParams _$EvmTransactionParamsFromJson(
  Map<String, dynamic> json,
) => _EvmTransactionParams(
  from: json['from'] as String,
  to: json['to'] as String,
  value: json['value'] as String,
  gas: json['gas'] as String?,
  gasPrice: json['gasPrice'] as String?,
  maxFeePerGas: json['maxFeePerGas'] as String?,
  maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String?,
  input: json['input'] as String?,
  data: json['data'] as String?,
);

Map<String, dynamic> _$EvmTransactionParamsToJson(
  _EvmTransactionParams instance,
) => <String, dynamic>{
  'from': instance.from,
  'to': instance.to,
  'value': instance.value,
  'gas': instance.gas,
  'gasPrice': instance.gasPrice,
  'maxFeePerGas': instance.maxFeePerGas,
  'maxPriorityFeePerGas': instance.maxPriorityFeePerGas,
  'input': instance.input,
  'data': instance.data,
};

_TronTransactionObject _$TronTransactionObjectFromJson(
  Map<String, dynamic> json,
) => _TronTransactionObject(
  raw_data: json['raw_data'],
  raw_data_hex: json['raw_data_hex'] as String,
  signature: (json['signature'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  txID: json['txID'] as String,
  visible: json['visible'] as bool?,
);

Map<String, dynamic> _$TronTransactionObjectToJson(
  _TronTransactionObject instance,
) => <String, dynamic>{
  'raw_data': instance.raw_data,
  'raw_data_hex': instance.raw_data_hex,
  'signature': instance.signature,
  'txID': instance.txID,
  'visible': instance.visible,
};

_TronTransaction _$TronTransactionFromJson(Map<String, dynamic> json) =>
    _TronTransaction(
      result: TronTransactionResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
      transaction: TronTransactionObject.fromJson(
        json['transaction'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$TronTransactionToJson(_TronTransaction instance) =>
    <String, dynamic>{
      'result': instance.result,
      'transaction': instance.transaction,
    };

_TronTransactionResult _$TronTransactionResultFromJson(
  Map<String, dynamic> json,
) => _TronTransactionResult(result: json['result'] as bool);

Map<String, dynamic> _$TronTransactionResultToJson(
  _TronTransactionResult instance,
) => <String, dynamic>{'result': instance.result};

_TronTransactionParams _$TronTransactionParamsFromJson(
  Map<String, dynamic> json,
) => _TronTransactionParams(
  transaction: TronTransaction.fromJson(
    json['transaction'] as Map<String, dynamic>,
  ),
  address: json['address'] as String,
);

Map<String, dynamic> _$TronTransactionParamsToJson(
  _TronTransactionParams instance,
) => <String, dynamic>{
  'transaction': instance.transaction,
  'address': instance.address,
};

EvmTransactionRpc _$EvmTransactionRpcFromJson(Map<String, dynamic> json) =>
    EvmTransactionRpc(
      id: json['id'] as String,
      chainId: json['chainId'] as String,
      method: json['method'] as String? ?? 'eth_sendTransaction',
      params: (json['params'] as List<dynamic>)
          .map((e) => EvmTransactionParams.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EvmTransactionRpcToJson(EvmTransactionRpc instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chainId': instance.chainId,
      'method': instance.method,
      'params': instance.params,
    };

SolanaTransactionRpc _$SolanaTransactionRpcFromJson(
  Map<String, dynamic> json,
) => SolanaTransactionRpc(
  id: json['id'] as String,
  chainId: json['chainId'] as String,
  method: json['method'] as String? ?? 'solana_signAndSendTransaction',
  params: SolanaTransactionParams.fromJson(
    json['params'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$SolanaTransactionRpcToJson(
  SolanaTransactionRpc instance,
) => <String, dynamic>{
  'id': instance.id,
  'chainId': instance.chainId,
  'method': instance.method,
  'params': instance.params,
};

TronTransactionRpc _$TronTransactionRpcFromJson(Map<String, dynamic> json) =>
    TronTransactionRpc(
      id: json['id'] as String,
      chainId: json['chainId'] as String,
      method: json['method'] as String? ?? 'tron_signTransaction',
      params: TronTransactionParams.fromJson(
        json['params'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$TronTransactionRpcToJson(TronTransactionRpc instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chainId': instance.chainId,
      'method': instance.method,
      'params': instance.params,
    };

_BuildTransactionResult _$BuildTransactionResultFromJson(
  Map<String, dynamic> json,
) => _BuildTransactionResult(
  transactions: (json['transactions'] as List<dynamic>)
      .map((e) => TransactionRpc.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BuildTransactionResultToJson(
  _BuildTransactionResult instance,
) => <String, dynamic>{'transactions': instance.transactions};
