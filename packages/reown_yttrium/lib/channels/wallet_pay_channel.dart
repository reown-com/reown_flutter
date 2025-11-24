import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/utils/channel_utils.dart';

class MethodChannelWalletPay {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> createWalletPay({required Map<String, dynamic> rawData}) async {
    try {
      final bool? result = await methodChannel
          .invokeMethod<bool>('wallet_pay_createWalletPay', {
            'rawData': jsonEncode(rawData),
            'bapiBaseUrl': 'https://rpc.walletconnect.org/v1',
          });
      return result!;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] wallet_pay_createWalletPay $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDisplayData() async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'wallet_pay_getDisplayData',
      );
      return ChannelUtils.handlePlatformResult(response)
          as Map<String, dynamic>;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] wallet_pay_getDisplayData $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getPaymentAction({
    required String optionIndex,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'wallet_pay_getPaymentAction',
        {'optionIndex': optionIndex},
      );
      return ChannelUtils.handlePlatformResult(response)
          as Map<String, dynamic>;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] wallet_pay_getPaymentAction $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getActionFromPaymentOption({
    required Map<String, dynamic> paymentOption,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'wallet_pay_getActionFromPaymentOption',
        {'paymentOption': paymentOption},
      );
      return ChannelUtils.handlePlatformResult(response)
          as Map<String, dynamic>;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] wallet_pay_getActionFromPaymentOption $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> finalize({
    required String optionIndex,
    required String signature,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'wallet_pay_finalize',
        {'optionIndex': optionIndex, 'signature': signature},
      );
      return ChannelUtils.handlePlatformResult(response)
          as Map<String, dynamic>;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] wallet_pay_finalize $e');
      rethrow;
    }
  }

  Future<bool> dispose() async {
    try {
      final bool? result = await methodChannel.invokeMethod<dynamic>(
        'wallet_pay_dispose',
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] wallet_pay_dispose $e');
      rethrow;
    }
  }
}
