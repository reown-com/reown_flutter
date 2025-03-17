// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain_abstraction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AmountCompatImpl _$$AmountCompatImplFromJson(Map<String, dynamic> json) =>
    _$AmountCompatImpl(
      symbol: json['symbol'] as String,
      amount: json['amount'] as String,
      unit: (json['unit'] as num).toInt(),
      formatted: json['formatted'] as String,
      formattedAlt: json['formattedAlt'] as String,
    );

Map<String, dynamic> _$$AmountCompatImplToJson(_$AmountCompatImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'amount': instance.amount,
      'unit': instance.unit,
      'formatted': instance.formatted,
      'formattedAlt': instance.formattedAlt,
    };

_$CallCompatImpl _$$CallCompatImplFromJson(Map<String, dynamic> json) =>
    _$CallCompatImpl(
      to: json['to'] as String,
      value: BigInt.parse(json['value'] as String),
      input: json['input'] as String,
    );

Map<String, dynamic> _$$CallCompatImplToJson(_$CallCompatImpl instance) =>
    <String, dynamic>{
      'to': instance.to,
      'value': instance.value.toString(),
      'input': instance.input,
    };

_$Eip1559EstimationCompatImpl _$$Eip1559EstimationCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$Eip1559EstimationCompatImpl(
      maxFeePerGas: json['maxFeePerGas'] as String,
      maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String,
    );

Map<String, dynamic> _$$Eip1559EstimationCompatImplToJson(
        _$Eip1559EstimationCompatImpl instance) =>
    <String, dynamic>{
      'maxFeePerGas': instance.maxFeePerGas,
      'maxPriorityFeePerGas': instance.maxPriorityFeePerGas,
    };

_$ExecuteDetailsCompatImpl _$$ExecuteDetailsCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$ExecuteDetailsCompatImpl(
      initialTxnReceipt: json['initialTxnReceipt'] as String,
      initialTxnHash: json['initialTxnHash'] as String,
    );

Map<String, dynamic> _$$ExecuteDetailsCompatImplToJson(
        _$ExecuteDetailsCompatImpl instance) =>
    <String, dynamic>{
      'initialTxnReceipt': instance.initialTxnReceipt,
      'initialTxnHash': instance.initialTxnHash,
    };

_$FeeEstimatedTransactionCompatImpl
    _$$FeeEstimatedTransactionCompatImplFromJson(Map<String, dynamic> json) =>
        _$FeeEstimatedTransactionCompatImpl(
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

Map<String, dynamic> _$$FeeEstimatedTransactionCompatImplToJson(
        _$FeeEstimatedTransactionCompatImpl instance) =>
    <String, dynamic>{
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

_$FundingMetadataCompatImpl _$$FundingMetadataCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$FundingMetadataCompatImpl(
      chainId: json['chainId'] as String,
      tokenContract: json['tokenContract'] as String,
      symbol: json['symbol'] as String,
      amount: json['amount'] as String,
      bridgingFee: json['bridgingFee'] as String,
      decimals: (json['decimals'] as num).toInt(),
    );

Map<String, dynamic> _$$FundingMetadataCompatImplToJson(
        _$FundingMetadataCompatImpl instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'tokenContract': instance.tokenContract,
      'symbol': instance.symbol,
      'amount': instance.amount,
      'bridgingFee': instance.bridgingFee,
      'decimals': instance.decimals,
    };

_$InitialTransactionMetadataCompatImpl
    _$$InitialTransactionMetadataCompatImplFromJson(
            Map<String, dynamic> json) =>
        _$InitialTransactionMetadataCompatImpl(
          transferTo: json['transferTo'] as String,
          amount: json['amount'] as String,
          tokenContract: json['tokenContract'] as String,
          symbol: json['symbol'] as String,
          decimals: (json['decimals'] as num).toInt(),
        );

Map<String, dynamic> _$$InitialTransactionMetadataCompatImplToJson(
        _$InitialTransactionMetadataCompatImpl instance) =>
    <String, dynamic>{
      'transferTo': instance.transferTo,
      'amount': instance.amount,
      'tokenContract': instance.tokenContract,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
    };

_$MetadataCompatImpl _$$MetadataCompatImplFromJson(Map<String, dynamic> json) =>
    _$MetadataCompatImpl(
      fundingFrom: (json['fundingFrom'] as List<dynamic>)
          .map((e) => FundingMetadataCompat.fromJson(e as Map<String, dynamic>))
          .toList(),
      initialTransaction: InitialTransactionMetadataCompat.fromJson(
          json['initialTransaction'] as Map<String, dynamic>),
      checkIn: BigInt.parse(json['checkIn'] as String),
    );

Map<String, dynamic> _$$MetadataCompatImplToJson(
        _$MetadataCompatImpl instance) =>
    <String, dynamic>{
      'fundingFrom': instance.fundingFrom.map((e) => e.toJson()).toList(),
      'initialTransaction': instance.initialTransaction.toJson(),
      'checkIn': instance.checkIn.toString(),
    };

_$PrepareDetailedResponseSuccessCompat_AvailableImpl
    _$$PrepareDetailedResponseSuccessCompat_AvailableImplFromJson(
            Map<String, dynamic> json) =>
        _$PrepareDetailedResponseSuccessCompat_AvailableImpl(
          value: UiFieldsCompat.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$PrepareDetailedResponseSuccessCompat_AvailableImplToJson(
            _$PrepareDetailedResponseSuccessCompat_AvailableImpl instance) =>
        <String, dynamic>{
          'value': instance.value.toJson(),
          'runtimeType': instance.$type,
        };

_$PrepareDetailedResponseSuccessCompat_NotRequiredImpl
    _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplFromJson(
            Map<String, dynamic> json) =>
        _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl(
          value: PrepareResponseNotRequiredCompat.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplToJson(
            _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl instance) =>
        <String, dynamic>{
          'value': instance.value.toJson(),
          'runtimeType': instance.$type,
        };

_$PrepareResponseAvailableCompatImpl
    _$$PrepareResponseAvailableCompatImplFromJson(Map<String, dynamic> json) =>
        _$PrepareResponseAvailableCompatImpl(
          orchestrationId: json['orchestrationId'] as String,
          initialTransaction: TransactionCompat.fromJson(
              json['initialTransaction'] as Map<String, dynamic>),
          transactions: (json['transactions'] as List<dynamic>)
              .map((e) => TransactionCompat.fromJson(e as Map<String, dynamic>))
              .toList(),
          metadata:
              MetadataCompat.fromJson(json['metadata'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$PrepareResponseAvailableCompatImplToJson(
        _$PrepareResponseAvailableCompatImpl instance) =>
    <String, dynamic>{
      'orchestrationId': instance.orchestrationId,
      'initialTransaction': instance.initialTransaction.toJson(),
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
      'metadata': instance.metadata.toJson(),
    };

_$PrepareResponseNotRequiredCompatImpl
    _$$PrepareResponseNotRequiredCompatImplFromJson(
            Map<String, dynamic> json) =>
        _$PrepareResponseNotRequiredCompatImpl(
          initialTransaction: TransactionCompat.fromJson(
              json['initialTransaction'] as Map<String, dynamic>),
          transactions: (json['transactions'] as List<dynamic>)
              .map((e) => TransactionCompat.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$PrepareResponseNotRequiredCompatImplToJson(
        _$PrepareResponseNotRequiredCompatImpl instance) =>
    <String, dynamic>{
      'initialTransaction': instance.initialTransaction.toJson(),
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };

_$PulseMetadataCompatImpl _$$PulseMetadataCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$PulseMetadataCompatImpl(
      url: json['url'] as String?,
      bundleId: json['bundleId'] as String?,
      packageName: json['packageName'] as String?,
      sdkVersion: json['sdkVersion'] as String,
      sdkPlatform: json['sdkPlatform'] as String,
    );

Map<String, dynamic> _$$PulseMetadataCompatImplToJson(
        _$PulseMetadataCompatImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'bundleId': instance.bundleId,
      'packageName': instance.packageName,
      'sdkVersion': instance.sdkVersion,
      'sdkPlatform': instance.sdkPlatform,
    };

_$TransactionCompatImpl _$$TransactionCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionCompatImpl(
      chainId: json['chainId'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      value: json['value'] as String,
      input: json['input'] as String,
      gasLimit: BigInt.parse(json['gasLimit'] as String),
      nonce: BigInt.parse(json['nonce'] as String),
    );

Map<String, dynamic> _$$TransactionCompatImplToJson(
        _$TransactionCompatImpl instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value,
      'input': instance.input,
      'gasLimit': instance.gasLimit.toString(),
      'nonce': instance.nonce.toString(),
    };

_$TransactionFeeCompatImpl _$$TransactionFeeCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionFeeCompatImpl(
      fee: AmountCompat.fromJson(json['fee'] as Map<String, dynamic>),
      localFee: AmountCompat.fromJson(json['localFee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TransactionFeeCompatImplToJson(
        _$TransactionFeeCompatImpl instance) =>
    <String, dynamic>{
      'fee': instance.fee.toJson(),
      'localFee': instance.localFee.toJson(),
    };

_$TransactionReceiptCompatImpl _$$TransactionReceiptCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionReceiptCompatImpl(
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

Map<String, dynamic> _$$TransactionReceiptCompatImplToJson(
        _$TransactionReceiptCompatImpl instance) =>
    <String, dynamic>{
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

_$TxnDetailsCompatImpl _$$TxnDetailsCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$TxnDetailsCompatImpl(
      transaction: FeeEstimatedTransactionCompat.fromJson(
          json['transaction'] as Map<String, dynamic>),
      transactionHashToSign: json['transactionHashToSign'] as String,
      fee: TransactionFeeCompat.fromJson(json['fee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TxnDetailsCompatImplToJson(
        _$TxnDetailsCompatImpl instance) =>
    <String, dynamic>{
      'transaction': instance.transaction.toJson(),
      'transactionHashToSign': instance.transactionHashToSign,
      'fee': instance.fee.toJson(),
    };

_$UiFieldsCompatImpl _$$UiFieldsCompatImplFromJson(Map<String, dynamic> json) =>
    _$UiFieldsCompatImpl(
      routeResponse: PrepareResponseAvailableCompat.fromJson(
          json['routeResponse'] as Map<String, dynamic>),
      route: (json['route'] as List<dynamic>)
          .map((e) => TxnDetailsCompat.fromJson(e as Map<String, dynamic>))
          .toList(),
      localRouteTotal: AmountCompat.fromJson(
          json['localRouteTotal'] as Map<String, dynamic>),
      bridge: (json['bridge'] as List<dynamic>)
          .map((e) => TransactionFeeCompat.fromJson(e as Map<String, dynamic>))
          .toList(),
      localBridgeTotal: AmountCompat.fromJson(
          json['localBridgeTotal'] as Map<String, dynamic>),
      initial:
          TxnDetailsCompat.fromJson(json['initial'] as Map<String, dynamic>),
      localTotal:
          AmountCompat.fromJson(json['localTotal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UiFieldsCompatImplToJson(
        _$UiFieldsCompatImpl instance) =>
    <String, dynamic>{
      'routeResponse': instance.routeResponse.toJson(),
      'route': instance.route.map((e) => e.toJson()).toList(),
      'localRouteTotal': instance.localRouteTotal.toJson(),
      'bridge': instance.bridge.map((e) => e.toJson()).toList(),
      'localBridgeTotal': instance.localBridgeTotal.toJson(),
      'initial': instance.initial.toJson(),
      'localTotal': instance.localTotal.toJson(),
    };
