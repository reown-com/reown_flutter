import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:walletconnect_pay/version.dart';
import 'package:walletconnect_pay/models/walletconnect_pay_models.dart';
import 'package:walletconnect_pay/walletconnect_pay_utils.dart';

import 'walletconnect_pay_platform_interface.dart';

/// An implementation of [WalletconnectPayPlatform] that uses method channels.
class MethodChannelWalletconnectPay extends WalletconnectPayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('walletconnect_pay');

  // only apikey
  @override
  Future<bool> initialize({
    required String projectId,
    required String apiKey,
    String? clientId,
    String? baseUrl,
  }) async {
    try {
      final packageName = await WalletconnectPayUtils.getPackageName();
      final sdkConfig = SdkConfig(
        baseUrl: baseUrl ?? WalletconnectPayUtils.baseUrl,
        apiKey: apiKey,
        sdkName: WalletconnectPayUtils.sdkName,
        sdkVersion: packageVersion,
        sdkPlatform: WalletconnectPayUtils.getPlatform(),
        projectId: projectId,
        bundleId: packageName,
        clientId: clientId,
      );
      final result = await methodChannel.invokeMethod<bool>(
        'initialize',
        sdkConfig.toJsonString(),
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ❌ initialize: $e');
      throw PayInitializeError(
        code: e.code,
        message: e.message,
        details: e.details,
        stacktrace: e.stacktrace,
      );
    }
  }

  @override
  Future<String> getPaymentOptions({required String requestJson}) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'getPaymentOptions',
        requestJson,
      );
      debugPrint('[$runtimeType] ✅ getPaymentOptions: $result');
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ❌ getPaymentOptions: $e');
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
      debugPrint('[$runtimeType] ✅ getRequiredPaymentActions: $result');
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ❌ getRequiredPaymentActions: $e');
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
      debugPrint('[$runtimeType] ✅ confirmPayment: $result');
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ❌ confirmPayment: $e');
      throw ConfirmPaymentError(
        code: e.code,
        message: e.message,
        details: e.details,
        stacktrace: e.stacktrace,
      );
    }
  }
}
