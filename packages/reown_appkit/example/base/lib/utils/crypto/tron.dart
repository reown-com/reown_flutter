import 'package:flutter/foundation.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:convert/convert.dart';

class Tron {
  static final List<String> methods = [
    'tron_signTransaction',
    'tron_signMessage'
  ];

  static final List<String> events = [];

  static Map<String, dynamic> tronSignMessage({
    required String chainId,
    required String walletAdress,
  }) {
    return {
      'message': 'Welcome to Flutter AppKit on Tron ($chainId)',
      'address': walletAdress,
    };
  }

  static Future<Map<String, dynamic>> tronSignTransaction({
    required ReownAppKitModalNetworkInfo chainData,
    required String walletAdress,
    required bool isV1,
  }) async {
    final transaction = await triggerSmartContract(
      chainData: chainData,
      walletAdress: walletAdress,
    );

    if (isV1) {
      return {
        'address': walletAdress,
        'transaction': transaction['transaction'],
      };
    }

    return {
      'address': walletAdress,
      'transaction': {
        'transaction': transaction['transaction'],
      },
    };
  }

  static Future<Map<String, dynamic>> triggerSmartContract({
    required ReownAppKitModalNetworkInfo chainData,
    required String walletAdress,
  }) async {
    // Get the USDT contract address
    final usdTContract = chainData.isTestNetwork
        ? 'TXYZopYRdj2D9XRtbG411XZZ3kM5VkAeBf'
        : 'TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t';

    final apiEndpoint = chainData.isTestNetwork
        ? 'https://nile.trongrid.io'
        : 'https://api.trongrid.io';

    final parameter = [
      {'type': 'address', 'value': walletAdress},
      {'type': 'uint256', 'value': 100000},
    ];
    final params = _convertToFormat(parameter);

    // https://developers.tron.network/reference/triggersmartcontract
    final url = '$apiEndpoint/wallet/triggersmartcontract';
    final paradic = {
      'owner_address': walletAdress,
      'contract_address': usdTContract,
      'function_selector': 'approve(address,uint256)',
      'parameter': params,
      'fee_limit': 200000000,
      'call_value': 0,
      'visible': true,
    };
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(paradic),
      headers: {'accept': 'application/json'},
    );
    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> createTransaction({
    required ReownAppKitModalNetworkInfo chainData,
    required String walletAdress,
  }) async {
    final apiEndpoint = chainData.isTestNetwork
        ? 'https://nile.trongrid.io'
        : 'https://api.trongrid.io';

    // https://developers.tron.network/reference/createtransaction
    final url = '$apiEndpoint/wallet/createtransaction';
    final txPayload = {
      'owner_address': walletAdress,
      'to_address': walletAdress,
      'amount': 1000000, // 1 TRX = 1000000 sun
      'visible': true,
    };
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(txPayload),
      headers: {'accept': 'application/json'},
    );
    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> broadcastTransaction({
    required ReownAppKitModalNetworkInfo chainData,
    required Map<String, dynamic> signedTransaction,
  }) async {
    final apiEndpoint = chainData.isTestNetwork
        ? 'https://nile.trongrid.io'
        : 'https://api.trongrid.io';

    // https://developers.tron.network/reference/broadcasttransaction
    final url = '$apiEndpoint/wallet/broadcasttransaction';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(signedTransaction),
      headers: {'accept': 'application/json'},
    );
    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
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
