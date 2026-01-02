import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:walletconnect_pay/walletconnect_pay_models.dart';

import 'walletconnect_pay_platform_interface.dart';

class WalletconnectPay {
  WalletconnectPayPlatform get _platformInstance =>
      WalletconnectPayPlatform.instance;

  Future<bool> initialize({required String apiKey}) async {
    try {
      return await WalletconnectPayPlatform.instance.initialize(apiKey: apiKey);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<PaymentOptionsResponse> getPaymentOptions({
    required GetPaymentOptionsRequest request,
  }) async {
    try {
      final requestJson = jsonEncode(request.toJson());
      final channelResponse = await _platformInstance.getPaymentOptions(
        requestJson: requestJson,
      );
      final json = jsonDecode(channelResponse) as Map<String, dynamic>;
      return PaymentOptionsResponse.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<RequiredAction>> getRequiredPaymentActions({
    required GetRequiredPaymentActionsRequest request,
  }) async {
    try {
      final requestJson = jsonEncode(request.toJson());
      final channelResponse = await _platformInstance.getRequiredPaymentActions(
        requestJson: requestJson,
      );
      final json = jsonDecode(channelResponse) as List;
      return json.map((action) => RequiredAction.fromJson(action)).toList();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ConfirmPaymentResponse> confirmPayment({
    required ConfirmPaymentJsonRequest request,
  }) async {
    try {
      final requestJson = jsonEncode(request.toJson());
      final channelResponse = await _platformInstance.confirmPayment(
        requestJson: requestJson,
      );
      final json = jsonDecode(channelResponse) as Map<String, dynamic>;
      return ConfirmPaymentResponse.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
