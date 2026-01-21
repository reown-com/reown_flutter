import 'dart:convert';

import 'package:walletconnect_pay/models/walletconnect_pay_models.dart';

import 'walletconnect_pay_platform_interface.dart';

class WalletConnectPay {
  WalletconnectPayPlatform get _platformInstance =>
      WalletconnectPayPlatform.instance;

  final String? apiKey;
  final String? appId;
  final String? clientId;
  final String? baseUrl;

  const WalletConnectPay({
    this.apiKey,
    this.appId,
    this.clientId,
    this.baseUrl,
  });

  Future<bool> init() async {
    try {
      return await WalletconnectPayPlatform.instance.initialize(
        apiKey: apiKey,
        appId: appId,
        clientId: clientId,
        baseUrl: baseUrl,
      );
    } catch (e) {
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
      rethrow;
    }
  }

  Future<List<Action>> getRequiredPaymentActions({
    required GetRequiredPaymentActionsRequest request,
  }) async {
    try {
      final requestJson = jsonEncode(request.toJson());
      final channelResponse = await _platformInstance.getRequiredPaymentActions(
        requestJson: requestJson,
      );
      final json = jsonDecode(channelResponse) as List;
      return json.map((action) => Action.fromJson(action)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ConfirmPaymentResponse> confirmPayment({
    required ConfirmPaymentRequest request,
  }) async {
    try {
      final requestJson = request.copyWith(maxPollMs: 60000).toJson();
      final channelResponse = await _platformInstance.confirmPayment(
        requestJson: jsonEncode(requestJson),
      );
      final json = jsonDecode(channelResponse) as Map<String, dynamic>;
      return ConfirmPaymentResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
