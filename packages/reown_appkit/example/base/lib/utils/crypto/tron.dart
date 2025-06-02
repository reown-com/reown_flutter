import 'package:flutter/foundation.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:convert/convert.dart';

enum TronMethods {
  tronSignTransaction,
  tronSignMessage,
}

enum TronEvents {
  none,
}

class Tron {
  static final Map<TronMethods, String> methods = {
    TronMethods.tronSignTransaction: 'tron_signTransaction',
    TronMethods.tronSignMessage: 'tron_signMessage'
  };

  static final List<String> events = [];

  static Future<Map<String, dynamic>> triggerSmartContract({
    required ReownAppKitModalNetworkInfo chainData,
    required String walletAdress,
  }) async {
    /// Get the USDT contract address
    final usdtContract = chainData.isTestNetwork
        ? 'TXYZopYRdj2D9XRtbG411XZZ3kM5VkAeBf'
        : 'TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t';

    final parameter = [
      {'type': 'address', 'value': walletAdress},
      {'type': 'uint256', 'value': 1}
    ];
    final params = _convertToFormat(parameter);
    //
    // https://developers.tron.network/reference/triggersmartcontract
    final url = '${chainData.rpcUrl}/wallet/triggersmartcontract';
    final paradic = {
      'owner_address': walletAdress,
      'contract_address': usdtContract,
      'function_selector': 'approve(address,uint256)',
      'parameter': params,
      'fee_limit': 200000000,
      'call_value': 0,
      'visible': true
    };
    final respom = await http.post(
      Uri.parse(url),
      body: jsonEncode(paradic),
      headers: {
        'accept': 'application/json',
      },
    );
    try {
      return jsonDecode(respom.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static String _convertToFormat(List<Map<String, dynamic>> data) {
    String result = '';
    for (var item in data) {
      if (item['type'] == 'address') {
        String addressValue = item['value'];
        result += _addressToFormat(addressValue);
      } else if (item['type'] == 'uint256') {
        int intValue = item['value'];
        result += _uint256ToFormat(intValue);
      } else if (item['type'] == 'bool') {
        String value =
            item['value'].toString().toLowerCase() == 'true' ? '1' : '0';
        result += _boolvalue(value);
      }
    }
    return result;
  }

  static String _addressToFormat(String addressValue) {
    var addres = base58.decode(addressValue);
    var hex1 = hex.encode(addres);
    var hex2 = hex1.substring(2);
    var finalhex = hex2.substring(0, hex2.length - 8);
    return finalhex.padLeft(64, '0');
  }

  static String _boolvalue(String value) {
    return value.padLeft(64, '0');
  }

  static String _uint256ToFormat(int intValue) {
    String hexValue = intValue.toRadixString(16).padLeft(64, '0');
    if (hexValue.length > 64) {
      throw Exception('Integer value exceeds 64 bits');
    }
    return hexValue;
  }
}
