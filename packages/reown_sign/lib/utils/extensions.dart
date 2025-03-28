import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:web3dart/crypto.dart' as crypto;
import 'package:web3dart/web3dart.dart';

import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/models/basic_models.dart';

extension ReownSignErrorExtension on ReownCoreError {
  ReownSignError toSignError() => ReownSignError(
        code: code,
        message: message,
        data: data,
      );
}

extension UriExtension on String {
  Uri get toLinkMode => Uri.parse(Uri.decodeFull(this));
}

extension TransactionExtension on Transaction {
  Map<String, dynamic> toJson() {
    return {
      if (from != null) 'from': from!.hexEip55,
      if (to != null) 'to': to!.hexEip55,
      if (maxGas != null) 'gas': '0x${maxGas!.toRadixString(16)}',
      if (gasPrice != null)
        'gasPrice': '0x${gasPrice!.getInWei.toRadixString(16)}',
      if (value != null) 'value': '0x${value!.getInWei.toRadixString(16)}',
      if (data != null) 'data': crypto.bytesToHex(data!),
      if (nonce != null) 'nonce': nonce,
      if (maxFeePerGas != null)
        'maxFeePerGas': '0x${maxFeePerGas!.getInWei.toRadixString(16)}',
      if (maxPriorityFeePerGas != null)
        'maxPriorityFeePerGas':
            '0x${maxPriorityFeePerGas!.getInWei.toRadixString(16)}',
    };
  }
}

extension TransactionExtension2 on Map<String, dynamic> {
  Transaction toTransaction() {
    return Transaction(
      from: EthereumAddress.fromHex(this['from']),
      to: EthereumAddress.fromHex(this['to']),
      value: (this['value'] as String?)?.toEthereAmount(),
      gasPrice: (this['gasPrice'] as String?)?.toEthereAmount(),
      maxFeePerGas: (this['maxFeePerGas'] as String?)?.toEthereAmount(),
      maxPriorityFeePerGas:
          (this['maxPriorityFeePerGas'] as String?)?.toEthereAmount(),
      maxGas: (this['maxGas'] as String?)?.toIntFromHex(),
      nonce: (this['nonce'] as String?)?.toIntFromHex(),
      data: _parseTransactionData(this['input'] ?? this['data']),
    );
  }
}

Uint8List? _parseTransactionData(dynamic data) {
  if (data != null && data != '0x') {
    if (data.startsWith('0x')) {
      return Uint8List.fromList(hex.decode(data.substring(2)));
    }
    return Uint8List.fromList(hex.decode(data));
  }
  return null;
}

extension EtheraAmountExtension on String? {
  EtherAmount? toEthereAmount() {
    if (this != null) {
      final hexValue = this!.replaceFirst('0x', '');
      return EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.parse(hexValue, radix: 16),
      );
    }
    return null;
  }

  int? toIntFromHex() {
    if (this != null) {
      final hexValue = this!.replaceFirst('0x', '');
      return int.parse(hexValue, radix: 16);
    }
    return null;
  }

  int? toInt() {
    if (this != null) {
      return int.tryParse(this!);
    }
    return null;
  }
}
