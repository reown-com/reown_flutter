import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';
import 'package:reown_yttrium/wallet_pay/i_walletpay_request.dart';

class WalletPayRequest implements IWalletPayRequest {
  final _methodChannel = MethodChannelReownYttrium();

  @override
  Future<Map<String, dynamic>> getDisplayData() async {
    try {
      final result = await _methodChannel.walletPayChannel.getDisplayData();
      return result;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] getDisplayData $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getPaymentAction({
    required int optionIndex,
  }) async {
    try {
      final result = await _methodChannel.walletPayChannel.getPaymentAction(
        optionIndex: optionIndex.toString(),
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] getPaymentAction $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getActionFromPaymentOption({
    required Map<String, dynamic> paymentOption,
  }) async {
    try {
      final result = await _methodChannel.walletPayChannel
          .getActionFromPaymentOption(paymentOption: paymentOption);
      return result;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] getActionFromPaymentOption $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> finalize({
    required int optionIndex,
    required String signature,
  }) async {
    try {
      final result = await _methodChannel.walletPayChannel.finalize(
        optionIndex: optionIndex.toString(),
        signature: signature,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] finalize $e');
      rethrow;
    }
  }

  @override
  Future<bool> dispose() async {
    try {
      final result = await _methodChannel.walletPayChannel.dispose();
      return result;
    } on PlatformException catch (e) {
      debugPrint('❌ [$runtimeType] dispose $e');
      rethrow;
    }
  }
}
