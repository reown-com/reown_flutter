import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';
import 'package:reown_yttrium/wallet_pay/walletpay_request.dart';

class WalletPayClient {
  final _methodChannel = MethodChannelReownYttrium();

  Future<WalletPayRequest> createWalletPay({
    required Map<String, dynamic> rawData,
  }) async {
    try {
      final result = await _methodChannel.walletPayChannel.createWalletPay(
        rawData: rawData,
      );
      if (!result) {
        // TODO should this be needed if we have hasPayment() util function?
        throw PlatformException(
          code: 'NoWalletPayRequestFound',
          message:
              'Unable to create WalletPayRequesst with the given rawData: ${jsonEncode(rawData)}',
        );
      }
      return WalletPayRequest();
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] createWalletPay $e');
      rethrow;
    }
  }
}
