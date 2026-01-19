import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_pay/walletconnect_pay_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWalletconnectPay platform = MethodChannelWalletconnectPay();
  const MethodChannel channel = MethodChannel('walletconnect_pay');
  const MethodChannel packageInfoChannel = MethodChannel(
    'dev.fluttercommunity.plus/package_info',
  );

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(packageInfoChannel, (
          MethodCall methodCall,
        ) async {
          if (methodCall.method == 'getAll') {
            return {
              'appName': 'Test App',
              'packageName': 'com.test.app',
              'version': '1.0.0',
              'buildNumber': '1',
              'buildSignature': 'test',
            };
          }
          throw UnimplementedError(methodCall.method);
        });

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'initialize') {
            // initialize passes a map with 'baseUrl' and 'sdkConfig'
            return true;
          }
          if (methodCall.method == 'confirmPayment') {
            // confirmPayment passes requestJson as positional argument
            return '{"result": "test1"}';
          }
          if (methodCall.method == 'getPaymentOptions') {
            // getPaymentOptions passes requestJson as positional argument
            return '{"result": "test2"}';
          }
          if (methodCall.method == 'getRequiredPaymentActions') {
            // getRequiredPaymentActions passes requestJson as positional argument
            return '{"result": "test3"}';
          }
          throw UnimplementedError(methodCall.method);
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(packageInfoChannel, null);
  });

  test('initialize', () async {
    expect(
      await platform.initialize(
        appId: 'test-project-id',
        apiKey: 'test-api-key',
      ),
      true,
    );
  });

  test('confirmPayment', () async {
    expect(
      await platform.confirmPayment(requestJson: '{}'),
      '{"result": "test1"}',
    );
  });

  test('getPaymentOptions', () async {
    expect(
      await platform.getPaymentOptions(requestJson: '{}'),
      '{"result": "test2"}',
    );
  });

  test('getRequiredPaymentActions', () async {
    expect(
      await platform.getRequiredPaymentActions(requestJson: '{}'),
      '{"result": "test3"}',
    );
  });
}
