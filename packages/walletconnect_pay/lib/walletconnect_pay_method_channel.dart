import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:walletconnect_pay/version.dart';
import 'package:walletconnect_pay/walletconnect_pay_models.dart';
import 'package:walletconnect_pay/walletconnect_pay_utils.dart';

import 'walletconnect_pay_platform_interface.dart';

/// An implementation of [WalletconnectPayPlatform] that uses method channels.
class MethodChannelWalletconnectPay extends WalletconnectPayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('walletconnect_pay');

  // only apikey
  @override
  Future<bool> initialize({required String apiKey}) async {
    try {
      final sdkConfig = SdkConfig(
        baseUrl: WalletconnectPayUtils.baseUrl,
        apiKey: apiKey,
        sdkName: WalletconnectPayUtils.sdkName,
        sdkVersion: packageVersion,
        sdkPlatform: WalletconnectPayUtils.getPlatform(),
      );
      final result = await methodChannel.invokeMethod<bool>(
        'initialize',
        sdkConfig.toJsonString(),
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> getPaymentOptions({required String requestJson}) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'getPaymentOptions',
        requestJson,
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      throw GetPaymentOptionsError(
        code: e.code,
        message: e.message,
        details: e.details,
        stacktrace: e.stacktrace,
      );
    }
  }

  @override
  Future<String> getRequiredPaymentActions({
    required String requestJson,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'getRequiredPaymentActions',
        requestJson,
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      throw GetRequiredActionError(
        code: e.code,
        message: e.message,
        details: e.details,
        stacktrace: e.stacktrace,
      );
    }
  }

  @override
  Future<String> confirmPayment({required String requestJson}) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'confirmPayment',
        requestJson,
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      throw ConfirmPaymentError(
        code: e.code,
        message: e.message,
        details: e.details,
        stacktrace: e.stacktrace,
      );
    }
  }
}
