import 'dart:convert';
import 'package:reown_appkit/reown_appkit.dart' hide TransactionExtension;

extension TxExtension on Transaction {
  Map<String, dynamic> toJson() {
    return {
      if (from != null) 'from': from!.hexEip55,
      if (to != null) 'to': to!.hexEip55,
      if (maxGas != null) 'gas': '0x${maxGas!.toRadixString(16)}',
      if (gasPrice != null)
        'gasPrice': '0x${gasPrice!.getInWei.toRadixString(16)}',
      if (value != null) 'value': '0x${value!.getInWei.toRadixString(16)}',
      if (data != null) 'data': utf8.decode(data!),
      if (nonce != null) 'nonce': nonce,
      if (maxFeePerGas != null)
        'maxFeePerGas': '0x${maxFeePerGas!.getInWei.toRadixString(16)}',
      if (maxPriorityFeePerGas != null)
        'maxPriorityFeePerGas':
            '0x${maxPriorityFeePerGas!.getInWei.toRadixString(16)}',
    };
  }
}

extension StringExtension on String {
  double toDouble() {
    return double.parse(this);
  }
}

String constructCallData(String recipient, BigInt sendValue) {
  // Keccak256 hash of `transfer(address,uint256)`'s signature
  final transferMethodId = 'a9059cbb';
  // Remove '0x' and pad
  final paddedReceiver = recipient.replaceFirst('0x', '').padLeft(64, '0');
  // Amount in hex, padded
  final paddedAmount = sendValue.toRadixString(16).padLeft(64, '0');
  //
  return '0x$transferMethodId$paddedReceiver$paddedAmount';
}
