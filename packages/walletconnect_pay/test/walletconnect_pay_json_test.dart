import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_pay/walletconnect_pay.dart';
import 'package:walletconnect_pay/walletconnect_pay_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWalletconnectPayPlatform
    with MockPlatformInterfaceMixin
    implements WalletconnectPayPlatform {
  String? _getPaymentOptionsResponse;
  String? _getRequiredPaymentActionsResponse;
  String? _confirmPaymentResponse;
  Exception? _throwException;

  void setGetPaymentOptionsResponse(String response) {
    _getPaymentOptionsResponse = response;
  }

  void setGetRequiredPaymentActionsResponse(String response) {
    _getRequiredPaymentActionsResponse = response;
  }

  void setConfirmPaymentResponse(String response) {
    _confirmPaymentResponse = response;
  }

  void setException(Exception exception) {
    _throwException = exception;
  }

  @override
  Future<bool> initialize({
    String? apiKey,
    String? appId,
    String? clientId,
    String? baseUrl,
  }) async {
    if (_throwException != null) throw _throwException!;
    return true;
  }

  @override
  Future<String> confirmPayment({required String requestJson}) async {
    if (_throwException != null) throw _throwException!;
    if (_confirmPaymentResponse != null) return _confirmPaymentResponse!;
    return '{"status": "succeeded", "isFinal": true}';
  }

  @override
  Future<String> getPaymentOptions({required String requestJson}) async {
    if (_throwException != null) throw _throwException!;
    if (_getPaymentOptionsResponse != null) {
      return _getPaymentOptionsResponse!;
    }
    return '{"paymentId": "test-payment-id", "options": []}';
  }

  @override
  Future<String> getRequiredPaymentActions({
    required String requestJson,
  }) async {
    if (_throwException != null) throw _throwException!;
    if (_getRequiredPaymentActionsResponse != null) {
      return _getRequiredPaymentActionsResponse!;
    }
    return '[]';
  }
}

void main() {
  group('WalletConnectPay JSON Tests', () {
    late WalletConnectPay walletconnectPayPlugin;
    late MockWalletconnectPayPlatform mockPlatform;

    setUp(() {
      walletconnectPayPlugin = WalletConnectPay(appId: '', apiKey: '');
      mockPlatform = MockWalletconnectPayPlatform();
      WalletconnectPayPlatform.instance = mockPlatform;
    });

    tearDown(() {
      WalletconnectPayPlatform.instance = WalletconnectPayPlatform.instance;
    });

    test('test_json_get_payment_options_success', () async {
      final mockResponse = {
        'paymentId': 'pay_json_123',
        'options': [
          {
            'id': 'opt_json_1',
            'account': 'eip155:8453:0xabc',
            'amount': {
              'unit': 'caip19/eip155:8453/erc20:0xUSDC',
              'value': '500000',
              'display': {
                'assetSymbol': 'USDC',
                'assetName': 'USD Coin',
                'decimals': 6,
                'iconUrl': 'https://example.com/usdc.png',
                'networkName': 'Base',
              },
            },
            'etaS': 5,
            'actions': [
              {
                'walletRpc': {
                  'chainId': 'eip155:8453',
                  'method': 'eth_signTypedData_v4',
                  'params': '["0x123", {"types": {}}]',
                },
              },
            ],
          },
        ],
      };

      mockPlatform.setGetPaymentOptionsResponse(jsonEncode(mockResponse));

      final result = await walletconnectPayPlugin.getPaymentOptions(
        request: GetPaymentOptionsRequest(
          paymentLink: 'https://pay.example.com/pay_json_123',
          accounts: ['eip155:8453:0xabc'],
        ),
      );

      expect(result.paymentId, 'pay_json_123');
      expect(result.options.length, 1);
      expect(result.options[0].id, 'opt_json_1');
      expect(result.options[0].amount.value, '500000');
      expect(result.options[0].etaSeconds, 5);
      expect(result.options[0].actions.length, 1);
    });

    test('test_json_get_payment_options_invalid_json', () async {
      mockPlatform.setException(const FormatException('Invalid JSON'));

      expect(
        () => walletconnectPayPlugin.getPaymentOptions(
          request: GetPaymentOptionsRequest(
            paymentLink: 'https://pay.example.com/pay',
            accounts: ['eip155:1:0x123'],
          ),
        ),
        throwsException,
      );
    });

    test('test_json_get_required_payment_actions_success', () async {
      final optionsResponse = {
        'paymentId': 'pay_json_456',
        'options': [
          {
            'id': 'opt_json_2',
            'account': 'eip155:1:0x123',
            'amount': {
              'unit': 'caip19/eip155:1/erc20:0xDAI',
              'value': '100000000000000000000',
              'display': {
                'assetSymbol': 'DAI',
                'assetName': 'Dai Stablecoin',
                'decimals': 18,
                'iconUrl': 'https://example.com/dai.png',
                'networkName': 'Ethereum',
              },
            },
            'etaS': 10,
            'actions': [
              {
                'walletRpc': {
                  'chainId': 'eip155:1',
                  'method': 'eth_signTypedData_v4',
                  'params': '["0xwallet", {"types": {}}]',
                },
              },
            ],
          },
        ],
      };

      final actionsResponse = [
        {
          'walletRpc': {
            'chainId': 'eip155:1',
            'method': 'eth_signTypedData_v4',
            'params': '["0xwallet", {"types": {}}]',
          },
        },
      ];

      mockPlatform.setGetPaymentOptionsResponse(jsonEncode(optionsResponse));
      mockPlatform.setGetRequiredPaymentActionsResponse(
        jsonEncode(actionsResponse),
      );

      await walletconnectPayPlugin.getPaymentOptions(
        request: GetPaymentOptionsRequest(
          paymentLink: 'pay_json_456',
          accounts: ['eip155:1:0x123'],
        ),
      );

      final actions = await walletconnectPayPlugin.getRequiredPaymentActions(
        request: GetRequiredPaymentActionsRequest(
          paymentId: 'pay_json_456',
          optionId: 'opt_json_2',
        ),
      );

      expect(actions.length, 1);
      final action = actions[0];
      expect(action, isA<Action>());
      final walletRpc = action.walletRpc;
      expect(walletRpc.chainId, 'eip155:1');
      expect(walletRpc.method, 'eth_signTypedData_v4');
      final params = jsonDecode(walletRpc.params) as List;
      expect(params[0], '0xwallet');
    });

    test('test_json_confirm_payment_success', () async {
      final confirmResponse = {
        'status': 'succeeded',
        'isFinal': true,
        'pollInMs': null,
      };

      mockPlatform.setConfirmPaymentResponse(jsonEncode(confirmResponse));

      final result = await walletconnectPayPlugin.confirmPayment(
        request: ConfirmPaymentRequest(
          paymentId: 'pay_json_789',
          optionId: 'opt_1',
          signatures: ['0x123'],
        ),
      );

      expect(result.status, PaymentStatus.succeeded);
      expect(result.isFinal, true);
      expect(result.pollInMs, isNull);
    });

    test('test_json_config_mapping', () {
      const baseUrl = 'https://api.example.com';
      final configJson = {
        'baseUrl': baseUrl,
        'projectId': 'test-project-id',
        'apiKey': 'test-api-key',
        'sdkName': 'test-sdk',
        'sdkVersion': '1.0.0',
        'sdkPlatform': 'test',
        'bundleId': 'com.test.app',
      };

      final parsedConfig = SdkConfig.fromJson(configJson);
      expect(parsedConfig.baseUrl, baseUrl);
      expect(parsedConfig.projectId, 'test-project-id');
      expect(parsedConfig.apiKey, 'test-api-key');
      expect(parsedConfig.sdkName, 'test-sdk');
      expect(parsedConfig.sdkVersion, '1.0.0');
      expect(parsedConfig.sdkPlatform, 'test');
      expect(parsedConfig.bundleId, 'com.test.app');
    });

    test('test_json_get_payment_options_empty_payment_link', () async {
      // In Dart, we validate at the model level, but the platform might also validate
      // This test ensures the request can be created (validation happens elsewhere)
      final request = GetPaymentOptionsRequest(
        paymentLink: '',
        accounts: ['eip155:1:0x123'],
      );

      // The request object can be created, but validation should happen at platform level
      expect(request.paymentLink, '');
      expect(request.accounts.isNotEmpty, true);
    });

    test('test_json_get_payment_options_empty_accounts', () async {
      // Similar to above, validation happens at platform level
      final request = GetPaymentOptionsRequest(
        paymentLink: 'pay_123',
        accounts: [],
      );

      expect(request.paymentLink, 'pay_123');
      expect(request.accounts.isEmpty, true);
    });

    test('test_json_confirm_payment_empty_payment_id', () async {
      // Validation happens at platform level
      final request = ConfirmPaymentRequest(
        paymentId: '',
        optionId: 'opt_1',
        signatures: [],
      );

      expect(request.paymentId, '');
      expect(request.optionId, 'opt_1');
    });

    test('test_json_confirm_payment_with_collected_data', () async {
      final confirmResponse = {
        'status': 'succeeded',
        'isFinal': true,
        'pollInMs': null,
      };

      mockPlatform.setConfirmPaymentResponse(jsonEncode(confirmResponse));

      final result = await walletconnectPayPlugin.confirmPayment(
        request: ConfirmPaymentRequest(
          paymentId: 'pay_123',
          optionId: 'opt_1',
          signatures: ['0xsignature1', '0xsignature2'],
          collectedData: [
            CollectDataFieldResult(id: 'field1', value: 'value1'),
            CollectDataFieldResult(id: 'field2', value: 'value2'),
          ],
          maxPollMs: 5000,
        ),
      );

      expect(result.status, PaymentStatus.succeeded);
      expect(result.isFinal, true);
    });

    test('test_json_get_required_payment_actions_empty_payment_id', () async {
      // Validation happens at platform level
      final request = GetRequiredPaymentActionsRequest(
        paymentId: '',
        optionId: 'opt_1',
      );

      expect(request.paymentId, '');
      expect(request.optionId, 'opt_1');
    });

    test('test_json_get_required_payment_actions_empty_option_id', () async {
      // Validation happens at platform level
      final request = GetRequiredPaymentActionsRequest(
        paymentId: 'pay_123',
        optionId: '',
      );

      expect(request.paymentId, 'pay_123');
      expect(request.optionId, '');
    });

    test('test_json_get_payment_options_with_payment_info', () async {
      final mockResponse = {
        'paymentId': 'pay_123',
        'info': {
          'status': 'requires_action',
          'amount': {
            'unit': 'caip19/eip155:1/erc20:0xUSDC',
            'value': '1000000',
            'display': {
              'assetSymbol': 'USDC',
              'assetName': 'USD Coin',
              'decimals': 6,
              'iconUrl': 'https://example.com/usdc.png',
              'networkName': 'Ethereum',
            },
          },
          'expiresAt': 1234567890,
          'merchant': {
            'name': 'Test Merchant',
            'iconUrl': 'https://example.com/merchant.png',
          },
          'buyer': {
            'accountCaip10': 'eip155:1:0xabc',
            'accountProviderName': 'MetaMask',
            'accountProviderIcon': 'https://example.com/metamask.png',
          },
        },
        'options': [],
        'collectData': {
          'fields': [
            {
              'id': 'email',
              'name': 'Email',
              'required': true,
              'fieldType': 'text',
            },
            {
              'id': 'birthdate',
              'name': 'Birth Date',
              'required': false,
              'fieldType': 'date',
            },
          ],
        },
      };

      mockPlatform.setGetPaymentOptionsResponse(jsonEncode(mockResponse));

      final result = await walletconnectPayPlugin.getPaymentOptions(
        request: GetPaymentOptionsRequest(
          paymentLink: 'https://pay.example.com/pay_123',
          accounts: ['eip155:1:0xabc'],
          includePaymentInfo: true,
        ),
      );

      expect(result.paymentId, 'pay_123');
      expect(result.info, isNotNull);
      expect(result.info!.status, PaymentStatus.requires_action);
      expect(result.info!.merchant.name, 'Test Merchant');
      expect(result.info!.buyer, isNotNull);
      expect(result.info!.buyer!.accountCaip10, 'eip155:1:0xabc');
      expect(result.collectData, isNotNull);
      expect(result.collectData!.fields.length, 2);
      expect(
        result.collectData!.fields[0].fieldType,
        CollectDataFieldType.text,
      );
      expect(
        result.collectData!.fields[1].fieldType,
        CollectDataFieldType.date,
      );
    });
  });
}
