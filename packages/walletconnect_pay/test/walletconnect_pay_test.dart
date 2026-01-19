import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_pay/walletconnect_pay.dart';
import 'package:walletconnect_pay/walletconnect_pay_platform_interface.dart';
import 'package:walletconnect_pay/walletconnect_pay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWalletconnectPayPlatform
    with MockPlatformInterfaceMixin
    implements WalletconnectPayPlatform {
  @override
  Future<bool> initialize({
    String? apiKey,
    String? appId,
    String? clientId,
    String? baseUrl,
  }) async {
    return true;
  }

  @override
  Future<String> confirmPayment({required String requestJson}) async {
    return '{"status": "succeeded", "isFinal": true}';
  }

  @override
  Future<String> getPaymentOptions({required String requestJson}) async {
    return '{"paymentId": "test-payment-id", "options": []}';
  }

  @override
  Future<String> getRequiredPaymentActions({
    required String requestJson,
  }) async {
    return '[]';
  }
}

void main() {
  final WalletconnectPayPlatform initialPlatform =
      WalletconnectPayPlatform.instance;

  test('$MethodChannelWalletconnectPay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWalletconnectPay>());
  });

  test('initialize', () async {
    WalletConnectPay walletconnectPayPlugin = WalletConnectPay(
      appId: 'test-project-id',
      apiKey: 'test-api-key',
    );
    MockWalletconnectPayPlatform fakePlatform = MockWalletconnectPayPlatform();
    WalletconnectPayPlatform.instance = fakePlatform;

    expect(await walletconnectPayPlugin.init(), true);
  });

  test('confirmPayment', () async {
    WalletConnectPay walletconnectPayPlugin = WalletConnectPay(
      appId: 'test-project-id',
      apiKey: 'test-api-key',
    );
    MockWalletconnectPayPlatform fakePlatform = MockWalletconnectPayPlatform();
    WalletconnectPayPlatform.instance = fakePlatform;

    final result = await walletconnectPayPlugin.confirmPayment(
      request: ConfirmPaymentRequest(
        paymentId: 'test-payment-id',
        optionId: 'test-option-id',
        signatures: ['test-signature'],
      ),
    );
    expect(result.status, PaymentStatus.succeeded);
    expect(result.isFinal, true);
  });

  test('getPaymentOptions', () async {
    WalletConnectPay walletconnectPayPlugin = WalletConnectPay(
      appId: 'test-project-id',
      apiKey: 'test-api-key',
    );
    MockWalletconnectPayPlatform fakePlatform = MockWalletconnectPayPlatform();
    WalletconnectPayPlatform.instance = fakePlatform;

    final result = await walletconnectPayPlugin.getPaymentOptions(
      request: GetPaymentOptionsRequest(
        paymentLink: 'https://test.com/pay',
        accounts: ['0x123'],
      ),
    );
    expect(result.options, isEmpty);
  });

  test('getRequiredPaymentActions', () async {
    WalletConnectPay walletconnectPayPlugin = WalletConnectPay(
      appId: 'test-project-id',
      apiKey: 'test-api-key',
    );
    MockWalletconnectPayPlatform fakePlatform = MockWalletconnectPayPlatform();
    WalletconnectPayPlatform.instance = fakePlatform;

    final result = await walletconnectPayPlugin.getRequiredPaymentActions(
      request: GetRequiredPaymentActionsRequest(
        optionId: 'test-option-id',
        paymentId: 'test-payment-id',
      ),
    );
    expect(result, isEmpty);
  });
}
