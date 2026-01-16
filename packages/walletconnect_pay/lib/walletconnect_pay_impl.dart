import 'dart:convert';

import 'package:walletconnect_pay/models/walletconnect_pay_models.dart';

import 'walletconnect_pay_platform_interface.dart';

class WalletConnectPay {
  WalletconnectPayPlatform get _platformInstance =>
      WalletconnectPayPlatform.instance;

  final String projectId;
  final String apiKey;
  final String? clientId;

  const WalletConnectPay({
    required this.projectId,
    required this.apiKey,
    this.clientId,
  });

  Future<bool> init() async {
    try {
      return await WalletconnectPayPlatform.instance.initialize(
        apiKey: apiKey,
        projectId: projectId,
        clientId: clientId,
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
      rethrow;
    }
  }
}
