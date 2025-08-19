// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain_abstraction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AmountCompat _$AmountCompatFromJson(Map<String, dynamic> json) =>
    _AmountCompat(
      symbol: json['symbol'] as String,
      amount: json['amount'] as String,
      unit: (json['unit'] as num).toInt(),
      formatted: json['formatted'] as String,
      formattedAlt: json['formattedAlt'] as String,
    );

Map<String, dynamic> _$AmountCompatToJson(_AmountCompat instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'amount': instance.amount,
      'unit': instance.unit,
      'formatted': instance.formatted,
      'formattedAlt': instance.formattedAlt,
    };

_CallCompat _$CallCompatFromJson(Map<String, dynamic> json) => _CallCompat(
  to: json['to'] as String,
  input: json['input'] as String,
  value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
);

Map<String, dynamic> _$CallCompatToJson(_CallCompat instance) =>
    <String, dynamic>{
      'to': instance.to,
      'input': instance.input,
      'value': instance.value?.toString(),
    };

_Eip1559EstimationCompat _$Eip1559EstimationCompatFromJson(
  Map<String, dynamic> json,
) => _Eip1559EstimationCompat(
  maxFeePerGas: json['maxFeePerGas'] as String,
  maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String,
);

Map<String, dynamic> _$Eip1559EstimationCompatToJson(
  _Eip1559EstimationCompat instance,
) => <String, dynamic>{
  'maxFeePerGas': instance.maxFeePerGas,
  'maxPriorityFeePerGas': instance.maxPriorityFeePerGas,
};

_ExecuteDetailsCompat _$ExecuteDetailsCompatFromJson(
  Map<String, dynamic> json,
) => _ExecuteDetailsCompat(
  initialTxnReceipt: json['initialTxnReceipt'] as String,
  initialTxnHash: json['initialTxnHash'] as String,
);

Map<String, dynamic> _$ExecuteDetailsCompatToJson(
  _ExecuteDetailsCompat instance,
) => <String, dynamic>{
  'initialTxnReceipt': instance.initialTxnReceipt,
  'initialTxnHash': instance.initialTxnHash,
};

_FeeEstimatedTransactionCompat _$FeeEstimatedTransactionCompatFromJson(
  Map<String, dynamic> json,
) => _FeeEstimatedTransactionCompat(
  chainId: json['chainId'] as String,
  from: json['from'] as String,
  to: json['to'] as String,
  value: json['value'] as String,
  input: json['input'] as String,
  gasLimit: json['gasLimit'] as String,
  nonce: json['nonce'] as String,
  maxFeePerGas: json['maxFeePerGas'] as String,
  maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String,
);

Map<String, dynamic> _$FeeEstimatedTransactionCompatToJson(
  _FeeEstimatedTransactionCompat instance,
) => <String, dynamic>{
  'chainId': instance.chainId,
  'from': instance.from,
  'to': instance.to,
  'value': instance.value,
  'input': instance.input,
  'gasLimit': instance.gasLimit,
  'nonce': instance.nonce,
  'maxFeePerGas': instance.maxFeePerGas,
  'maxPriorityFeePerGas': instance.maxPriorityFeePerGas,
};

_FundingMetadataCompat _$FundingMetadataCompatFromJson(
  Map<String, dynamic> json,
) => _FundingMetadataCompat(
  chainId: json['chainId'] as String,
  tokenContract: json['tokenContract'] as String,
  symbol: json['symbol'] as String,
  amount: json['amount'] as String,
  bridgingFee: json['bridgingFee'] as String,
  decimals: (json['decimals'] as num).toInt(),
);

Map<String, dynamic> _$FundingMetadataCompatToJson(
  _FundingMetadataCompat instance,
) => <String, dynamic>{
  'chainId': instance.chainId,
  'tokenContract': instance.tokenContract,
  'symbol': instance.symbol,
  'amount': instance.amount,
  'bridgingFee': instance.bridgingFee,
  'decimals': instance.decimals,
};

_InitialTransactionMetadataCompat _$InitialTransactionMetadataCompatFromJson(
  Map<String, dynamic> json,
) => _InitialTransactionMetadataCompat(
  transferTo: json['transferTo'] as String,
  amount: json['amount'] as String,
  tokenContract: json['tokenContract'] as String,
  symbol: json['symbol'] as String,
  decimals: (json['decimals'] as num).toInt(),
);

Map<String, dynamic> _$InitialTransactionMetadataCompatToJson(
  _InitialTransactionMetadataCompat instance,
) => <String, dynamic>{
  'transferTo': instance.transferTo,
  'amount': instance.amount,
  'tokenContract': instance.tokenContract,
  'symbol': instance.symbol,
  'decimals': instance.decimals,
};

_MetadataCompat _$MetadataCompatFromJson(Map<String, dynamic> json) =>
    _MetadataCompat(
      fundingFrom: (json['fundingFrom'] as List<dynamic>)
          .map((e) => FundingMetadataCompat.fromJson(e as Map<String, dynamic>))
          .toList(),
      initialTransaction: InitialTransactionMetadataCompat.fromJson(
        json['initialTransaction'] as Map<String, dynamic>,
      ),
      checkIn: BigInt.parse(json['checkIn'] as String),
    );

Map<String, dynamic> _$MetadataCompatToJson(_MetadataCompat instance) =>
    <String, dynamic>{
      'fundingFrom': instance.fundingFrom.map((e) => e.toJson()).toList(),
      'initialTransaction': instance.initialTransaction.toJson(),
      'checkIn': instance.checkIn.toString(),
    };

PrepareDetailedResponseSuccessCompat_Available
_$PrepareDetailedResponseSuccessCompat_AvailableFromJson(
  Map<String, dynamic> json,
) => PrepareDetailedResponseSuccessCompat_Available(
  value: UiFieldsCompat.fromJson(json['value'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PrepareDetailedResponseSuccessCompat_AvailableToJson(
  PrepareDetailedResponseSuccessCompat_Available instance,
) => <String, dynamic>{
  'value': instance.value.toJson(),
  'runtimeType': instance.$type,
};

PrepareDetailedResponseSuccessCompat_NotRequired
_$PrepareDetailedResponseSuccessCompat_NotRequiredFromJson(
  Map<String, dynamic> json,
) => PrepareDetailedResponseSuccessCompat_NotRequired(
  value: PrepareResponseNotRequiredCompat.fromJson(
    json['value'] as Map<String, dynamic>,
  ),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PrepareDetailedResponseSuccessCompat_NotRequiredToJson(
  PrepareDetailedResponseSuccessCompat_NotRequired instance,
) => <String, dynamic>{
  'value': instance.value.toJson(),
  'runtimeType': instance.$type,
};

_PrepareResponseAvailableCompat _$PrepareResponseAvailableCompatFromJson(
  Map<String, dynamic> json,
) => _PrepareResponseAvailableCompat(
  orchestrationId: json['orchestrationId'] as String,
  initialTransaction: TransactionCompat.fromJson(
    json['initialTransaction'] as Map<String, dynamic>,
  ),
  transactions: (json['transactions'] as List<dynamic>)
      .map((e) => TransactionCompat.fromJson(e as Map<String, dynamic>))
      .toList(),
  metadata: MetadataCompat.fromJson(json['metadata'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PrepareResponseAvailableCompatToJson(
  _PrepareResponseAvailableCompat instance,
) => <String, dynamic>{
  'orchestrationId': instance.orchestrationId,
  'initialTransaction': instance.initialTransaction.toJson(),
  'transactions': instance.transactions.map((e) => e.toJson()).toList(),
  'metadata': instance.metadata.toJson(),
};

_PrepareResponseNotRequiredCompat _$PrepareResponseNotRequiredCompatFromJson(
  Map<String, dynamic> json,
) => _PrepareResponseNotRequiredCompat(
  initialTransaction: TransactionCompat.fromJson(
    json['initialTransaction'] as Map<String, dynamic>,
  ),
  transactions: (json['transactions'] as List<dynamic>)
      .map((e) => TransactionCompat.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PrepareResponseNotRequiredCompatToJson(
  _PrepareResponseNotRequiredCompat instance,
) => <String, dynamic>{
  'initialTransaction': instance.initialTransaction.toJson(),
  'transactions': instance.transactions.map((e) => e.toJson()).toList(),
};

_PulseMetadataCompat _$PulseMetadataCompatFromJson(Map<String, dynamic> json) =>
    _PulseMetadataCompat(
      url: json['url'] as String?,
      bundleId: json['bundleId'] as String?,
      packageName: json['packageName'] as String?,
      sdkVersion: json['sdkVersion'] as String,
      sdkPlatform: json['sdkPlatform'] as String,
    );

Map<String, dynamic> _$PulseMetadataCompatToJson(
  _PulseMetadataCompat instance,
) => <String, dynamic>{
  'url': instance.url,
  'bundleId': instance.bundleId,
  'packageName': instance.packageName,
  'sdkVersion': instance.sdkVersion,
  'sdkPlatform': instance.sdkPlatform,
};

_TransactionCompat _$TransactionCompatFromJson(Map<String, dynamic> json) =>
    _TransactionCompat(
      chainId: json['chainId'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      value: json['value'] as String,
      input: json['input'] as String,
      gasLimit: BigInt.parse(json['gasLimit'] as String),
      nonce: BigInt.parse(json['nonce'] as String),
    );

Map<String, dynamic> _$TransactionCompatToJson(_TransactionCompat instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value,
      'input': instance.input,
      'gasLimit': instance.gasLimit.toString(),
      'nonce': instance.nonce.toString(),
    };

_TransactionFeeCompat _$TransactionFeeCompatFromJson(
  Map<String, dynamic> json,
) => _TransactionFeeCompat(
  fee: AmountCompat.fromJson(json['fee'] as Map<String, dynamic>),
  localFee: AmountCompat.fromJson(json['localFee'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransactionFeeCompatToJson(
  _TransactionFeeCompat instance,
) => <String, dynamic>{
  'fee': instance.fee.toJson(),
  'localFee': instance.localFee.toJson(),
};

_TransactionReceiptCompat _$TransactionReceiptCompatFromJson(
  Map<String, dynamic> json,
) => _TransactionReceiptCompat(
  transactionHash: json['transactionHash'] as String,
  transactionIndex: json['transactionIndex'] == null
      ? null
      : BigInt.parse(json['transactionIndex'] as String),
  blockHash: json['blockHash'] as String?,
  blockNumber: json['blockNumber'] == null
      ? null
      : BigInt.parse(json['blockNumber'] as String),
  gasUsed: BigInt.parse(json['gasUsed'] as String),
  effectiveGasPrice: json['effectiveGasPrice'] as String,
  blobGasUsed: json['blobGasUsed'] == null
      ? null
      : BigInt.parse(json['blobGasUsed'] as String),
  blobGasPrice: json['blobGasPrice'] as String?,
  from: json['from'] as String,
  to: json['to'] as String?,
  contractAddress: json['contractAddress'] as String?,
);

Map<String, dynamic> _$TransactionReceiptCompatToJson(
  _TransactionReceiptCompat instance,
) => <String, dynamic>{
  'transactionHash': instance.transactionHash,
  'transactionIndex': instance.transactionIndex?.toString(),
  'blockHash': instance.blockHash,
  'blockNumber': instance.blockNumber?.toString(),
  'gasUsed': instance.gasUsed.toString(),
  'effectiveGasPrice': instance.effectiveGasPrice,
  'blobGasUsed': instance.blobGasUsed?.toString(),
  'blobGasPrice': instance.blobGasPrice,
  'from': instance.from,
  'to': instance.to,
  'contractAddress': instance.contractAddress,
};

_TxnDetailsCompat _$TxnDetailsCompatFromJson(Map<String, dynamic> json) =>
    _TxnDetailsCompat(
      transaction: FeeEstimatedTransactionCompat.fromJson(
        json['transaction'] as Map<String, dynamic>,
      ),
      transactionHashToSign: json['transactionHashToSign'] as String,
      fee: TransactionFeeCompat.fromJson(json['fee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TxnDetailsCompatToJson(_TxnDetailsCompat instance) =>
    <String, dynamic>{
      'transaction': instance.transaction.toJson(),
      'transactionHashToSign': instance.transactionHashToSign,
      'fee': instance.fee.toJson(),
    };

_UiFieldsCompat _$UiFieldsCompatFromJson(
  Map<String, dynamic> json,
) => _UiFieldsCompat(
  routeResponse: PrepareResponseAvailableCompat.fromJson(
    json['routeResponse'] as Map<String, dynamic>,
  ),
  route: (json['route'] as List<dynamic>)
      .map((e) => TxnDetailsCompat.fromJson(e as Map<String, dynamic>))
      .toList(),
  localRouteTotal: AmountCompat.fromJson(
    json['localRouteTotal'] as Map<String, dynamic>,
  ),
  bridge: (json['bridge'] as List<dynamic>)
      .map((e) => TransactionFeeCompat.fromJson(e as Map<String, dynamic>))
      .toList(),
  localBridgeTotal: AmountCompat.fromJson(
    json['localBridgeTotal'] as Map<String, dynamic>,
  ),
  initial: TxnDetailsCompat.fromJson(json['initial'] as Map<String, dynamic>),
  localTotal: AmountCompat.fromJson(json['localTotal'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UiFieldsCompatToJson(_UiFieldsCompat instance) =>
    <String, dynamic>{
      'routeResponse': instance.routeResponse.toJson(),
      'route': instance.route.map((e) => e.toJson()).toList(),
      'localRouteTotal': instance.localRouteTotal.toJson(),
      'bridge': instance.bridge.map((e) => e.toJson()).toList(),
      'localBridgeTotal': instance.localBridgeTotal.toJson(),
      'initial': instance.initial.toJson(),
      'localTotal': instance.localTotal.toJson(),
    };
