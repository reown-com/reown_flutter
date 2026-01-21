import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_pay/models/walletconnect_pay_models.dart';

/// Tests ported from Rust yttrium crate pay module.
/// Reference: /Users/alfreedom/Development/Reown/yttrium/crates/yttrium/src/pay/mod.rs
void main() {
  group('Model Serialization Tests', () {
    group('SdkConfig', () {
      test('test_sdk_config_serialization_round_trip', () {
        const config = SdkConfig(
          baseUrl: 'https://api.pay.walletconnect.com',
          apiKey: 'test-api-key',
          projectId: 'test-project-id',
          appId: 'test-app-id',
          sdkName: 'flutter-walletconnect-pay',
          sdkVersion: '1.0.0',
          sdkPlatform: 'ios',
          bundleId: 'com.test.app',
          clientId: 'test-client-id',
        );

        final json = config.toJson();
        final parsed = SdkConfig.fromJson(json);

        expect(parsed.baseUrl, config.baseUrl);
        expect(parsed.apiKey, config.apiKey);
        expect(parsed.projectId, config.projectId);
        expect(parsed.appId, config.appId);
        expect(parsed.sdkName, config.sdkName);
        expect(parsed.sdkVersion, config.sdkVersion);
        expect(parsed.sdkPlatform, config.sdkPlatform);
        expect(parsed.bundleId, config.bundleId);
        expect(parsed.clientId, config.clientId);
      });

      test('test_sdk_config_with_null_optional_fields', () {
        const config = SdkConfig(
          baseUrl: 'https://api.pay.walletconnect.com',
          sdkName: 'flutter-walletconnect-pay',
          sdkVersion: '1.0.0',
          sdkPlatform: 'android',
          bundleId: 'com.test.app',
        );

        final json = config.toJson();
        final parsed = SdkConfig.fromJson(json);

        expect(parsed.apiKey, isNull);
        expect(parsed.projectId, isNull);
        expect(parsed.appId, isNull);
        expect(parsed.clientId, isNull);
      });

      test('test_sdk_config_to_json_string', () {
        const config = SdkConfig(
          baseUrl: 'https://api.pay.walletconnect.com',
          apiKey: 'test-key',
          sdkName: 'flutter-walletconnect-pay',
          sdkVersion: '1.0.0',
          sdkPlatform: 'ios',
          bundleId: 'com.test.app',
        );

        final jsonString = config.toJsonString();
        expect(jsonString, isA<String>());

        final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
        expect(decoded['baseUrl'], 'https://api.pay.walletconnect.com');
        expect(decoded['apiKey'], 'test-key');
      });
    });

    group('GetPaymentOptionsRequest', () {
      test('test_get_payment_options_request_serialization', () {
        const request = GetPaymentOptionsRequest(
          paymentLink: 'https://pay.walletconnect.com/pay_123',
          accounts: ['eip155:1:0xabc', 'eip155:137:0xdef'],
          includePaymentInfo: true,
        );

        final json = request.toJson();
        final parsed = GetPaymentOptionsRequest.fromJson(json);

        expect(parsed.paymentLink, request.paymentLink);
        expect(parsed.accounts, request.accounts);
        expect(parsed.includePaymentInfo, request.includePaymentInfo);
      });

      test('test_get_payment_options_request_default_include_payment_info', () {
        const request = GetPaymentOptionsRequest(
          paymentLink: 'pay_123',
          accounts: ['eip155:1:0x123'],
        );

        expect(request.includePaymentInfo, false);
      });
    });

    group('PaymentOptionsResponse', () {
      test('test_payment_options_response_serialization', () {
        final json = {
          'paymentId': 'pay_abc123',
          'options': [
            {
              'id': 'opt_1',
              'account': 'eip155:1:0x123',
              'amount': {
                'unit': 'caip19/eip155:1/erc20:0xUSDC',
                'value': '1000000',
                'display': {
                  'assetSymbol': 'USDC',
                  'assetName': 'USD Coin',
                  'decimals': 6,
                },
              },
              'etaS': 30,
              'actions': [],
            },
          ],
        };

        final response = PaymentOptionsResponse.fromJson(json);

        expect(response.paymentId, 'pay_abc123');
        expect(response.options.length, 1);
        expect(response.options[0].id, 'opt_1');
        expect(response.info, isNull);
        expect(response.collectData, isNull);
      });

      test('test_payment_options_response_with_info_and_collect_data', () {
        final json = {
          'paymentId': 'pay_xyz',
          'info': {
            'status': 'requires_action',
            'amount': {
              'unit': 'caip19/eip155:1/erc20:0xUSDC',
              'value': '5000000',
              'display': {
                'assetSymbol': 'USDC',
                'assetName': 'USD Coin',
                'decimals': 6,
              },
            },
            'expiresAt': 1700000000,
            'merchant': {
              'name': 'Test Store',
              'iconUrl': 'https://example.com/icon.png',
            },
          },
          'options': [],
          'collectData': {
            'fields': [
              {
                'id': 'email',
                'name': 'Email Address',
                'required': true,
                'fieldType': 'text',
              },
            ],
          },
        };

        final response = PaymentOptionsResponse.fromJson(json);

        expect(response.info, isNotNull);
        expect(response.info!.status, PaymentStatus.requires_action);
        expect(response.info!.merchant.name, 'Test Store');
        expect(response.collectData, isNotNull);
        expect(response.collectData!.fields.length, 1);
        expect(response.collectData!.fields[0].id, 'email');
      });
    });

    group('PaymentOption', () {
      test('test_payment_option_serialization', () {
        final json = {
          'id': 'opt_123',
          'account': 'eip155:8453:0xabc',
          'amount': {
            'unit': 'caip19/eip155:8453/erc20:0xUSDC',
            'value': '250000',
            'display': {
              'assetSymbol': 'USDC',
              'assetName': 'USD Coin',
              'decimals': 6,
              'networkName': 'Base',
            },
          },
          'etaS': 5,
          'actions': [
            {
              'walletRpc': {
                'chainId': 'eip155:8453',
                'method': 'eth_signTypedData_v4',
                'params': '{"test": "data"}',
              },
            },
          ],
        };

        final option = PaymentOption.fromJson(json);

        expect(option.id, 'opt_123');
        expect(option.account, 'eip155:8453:0xabc');
        expect(option.etaSeconds, 5);
        expect(option.actions.length, 1);
        expect(option.amount.display.networkName, 'Base');

        // Round trip
        final serialized = option.toJson();
        final reparsed = PaymentOption.fromJson(serialized);
        expect(reparsed.id, option.id);
        expect(reparsed.etaSeconds, option.etaSeconds);
      });

      test('test_payment_option_eta_s_json_key', () {
        // Verify the JSON key is 'etaS' not 'etaSeconds'
        const option = PaymentOption(
          id: 'opt_1',
          account: 'eip155:1:0x123',
          amount: PayAmount(
            unit: 'caip19/eip155:1/native',
            value: '1000000000000000000',
            display: AmountDisplay(
              assetSymbol: 'ETH',
              assetName: 'Ethereum',
              decimals: 18,
            ),
          ),
          etaSeconds: 120,
          actions: [],
        );

        final json = option.toJson();
        expect(json['etaS'], 120);
        expect(json.containsKey('etaSeconds'), false);
      });
    });

    group('Action and WalletRpcAction', () {
      test('test_action_serialization', () {
        final json = {
          'walletRpc': {
            'chainId': 'eip155:1',
            'method': 'eth_sendTransaction',
            'params': '{"to":"0x123","value":"0x0"}',
          },
        };

        final action = Action.fromJson(json);

        expect(action.walletRpc.chainId, 'eip155:1');
        expect(action.walletRpc.method, 'eth_sendTransaction');
        expect(action.walletRpc.params, contains('0x123'));
      });

      test('test_wallet_rpc_action_json_key', () {
        const action = Action(
          walletRpc: WalletRpcAction(
            chainId: 'eip155:137',
            method: 'personal_sign',
            params: '["0xmessage","0xaddress"]',
          ),
        );

        final json = action.toJson();
        expect(json.containsKey('walletRpc'), true);
        expect(json['walletRpc']['chainId'], 'eip155:137');
      });
    });

    group('PayAmount and AmountDisplay', () {
      test('test_pay_amount_serialization', () {
        const amount = PayAmount(
          unit:
              'caip19/eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48',
          value: '100000000',
          display: AmountDisplay(
            assetSymbol: 'USDC',
            assetName: 'USD Coin',
            decimals: 6,
            iconUrl: 'https://example.com/usdc.png',
            networkName: 'Ethereum',
            networkIconUrl: 'https://example.com/eth.png',
          ),
        );

        final json = amount.toJson();
        final parsed = PayAmount.fromJson(json);

        expect(parsed.unit, amount.unit);
        expect(parsed.value, amount.value);
        expect(parsed.display.assetSymbol, 'USDC');
        expect(parsed.display.decimals, 6);
        expect(parsed.display.iconUrl, isNotNull);
        expect(parsed.display.networkIconUrl, isNotNull);
      });

      test('test_amount_display_optional_fields', () {
        final json = {
          'assetSymbol': 'ETH',
          'assetName': 'Ethereum',
          'decimals': 18,
        };

        final display = AmountDisplay.fromJson(json);

        expect(display.iconUrl, isNull);
        expect(display.networkName, isNull);
        expect(display.networkIconUrl, isNull);
      });
    });

    group('PaymentInfo', () {
      test('test_payment_info_serialization', () {
        final json = {
          'status': 'processing',
          'amount': {
            'unit': 'caip19/eip155:1/native',
            'value': '1000000000000000000',
            'display': {
              'assetSymbol': 'ETH',
              'assetName': 'Ethereum',
              'decimals': 18,
            },
          },
          'expiresAt': 1700000000,
          'merchant': {'name': 'Test Merchant'},
        };

        final info = PaymentInfo.fromJson(json);

        expect(info.status, PaymentStatus.processing);
        expect(info.expiresAt, 1700000000);
        expect(info.merchant.name, 'Test Merchant');
        expect(info.merchant.iconUrl, isNull);
        expect(info.buyer, isNull);
      });

      test('test_payment_info_with_buyer', () {
        final json = {
          'status': 'succeeded',
          'amount': {
            'unit': 'caip19/eip155:1/native',
            'value': '1000000000000000000',
            'display': {
              'assetSymbol': 'ETH',
              'assetName': 'Ethereum',
              'decimals': 18,
            },
          },
          'expiresAt': 1700000000,
          'merchant': {'name': 'Test'},
          'buyer': {
            'accountCaip10': 'eip155:1:0xabc123',
            'accountProviderName': 'MetaMask',
            'accountProviderIcon': 'https://example.com/mm.png',
          },
        };

        final info = PaymentInfo.fromJson(json);

        expect(info.buyer, isNotNull);
        expect(info.buyer!.accountCaip10, 'eip155:1:0xabc123');
        expect(info.buyer!.accountProviderName, 'MetaMask');
        expect(info.buyer!.accountProviderIcon, isNotNull);
      });
    });

    group('CollectDataAction and CollectDataField', () {
      test('test_collect_data_action_serialization', () {
        final json = {
          'fields': [
            {
              'id': 'email',
              'name': 'Email',
              'required': true,
              'fieldType': 'text',
            },
            {
              'id': 'dob',
              'name': 'Date of Birth',
              'required': false,
              'fieldType': 'date',
            },
          ],
        };

        final collectData = CollectDataAction.fromJson(json);

        expect(collectData.fields.length, 2);
        expect(collectData.fields[0].id, 'email');
        expect(collectData.fields[0].required, true);
        expect(collectData.fields[0].fieldType, CollectDataFieldType.text);
        expect(collectData.fields[1].fieldType, CollectDataFieldType.date);
      });

      test('test_collect_data_field_types', () {
        // Test text field type
        final textField = CollectDataField.fromJson({
          'id': 'text_field',
          'name': 'Text Field',
          'required': true,
          'fieldType': 'text',
        });
        expect(textField.fieldType, CollectDataFieldType.text);

        // Test date field type
        final dateField = CollectDataField.fromJson({
          'id': 'date_field',
          'name': 'Date Field',
          'required': false,
          'fieldType': 'date',
        });
        expect(dateField.fieldType, CollectDataFieldType.date);
      });
    });

    group('GetRequiredPaymentActionsRequest', () {
      test('test_get_required_payment_actions_request_serialization', () {
        const request = GetRequiredPaymentActionsRequest(
          optionId: 'opt_abc123',
          paymentId: 'pay_xyz789',
        );

        final json = request.toJson();
        final parsed = GetRequiredPaymentActionsRequest.fromJson(json);

        expect(parsed.optionId, request.optionId);
        expect(parsed.paymentId, request.paymentId);
      });
    });

    group('ConfirmPaymentRequest', () {
      test('test_confirm_payment_request_serialization', () {
        const request = ConfirmPaymentRequest(
          paymentId: 'pay_123',
          optionId: 'opt_456',
          signatures: ['0xsig1', '0xsig2'],
        );

        final json = request.toJson();
        final parsed = ConfirmPaymentRequest.fromJson(json);

        expect(parsed.paymentId, request.paymentId);
        expect(parsed.optionId, request.optionId);
        expect(parsed.signatures, request.signatures);
        expect(parsed.collectedData, isNull);
        expect(parsed.maxPollMs, isNull);
      });

      test('test_confirm_payment_request_with_collected_data', () {
        const request = ConfirmPaymentRequest(
          paymentId: 'pay_123',
          optionId: 'opt_456',
          signatures: ['0xsig1'],
          collectedData: [
            CollectDataFieldResult(id: 'email', value: 'test@example.com'),
            CollectDataFieldResult(id: 'phone', value: '+1234567890'),
          ],
          maxPollMs: 30000,
        );

        final json = request.toJson();
        final parsed = ConfirmPaymentRequest.fromJson(json);

        expect(parsed.collectedData, isNotNull);
        expect(parsed.collectedData!.length, 2);
        expect(parsed.collectedData![0].id, 'email');
        expect(parsed.collectedData![0].value, 'test@example.com');
        expect(parsed.maxPollMs, 30000);
      });
    });

    group('ConfirmPaymentResponse', () {
      test('test_confirm_payment_response_serialization', () {
        final json = {'status': 'succeeded', 'isFinal': true, 'pollInMs': null};

        final response = ConfirmPaymentResponse.fromJson(json);

        expect(response.status, PaymentStatus.succeeded);
        expect(response.isFinal, true);
        expect(response.pollInMs, isNull);
      });

      test('test_confirm_payment_response_with_poll', () {
        final json = {
          'status': 'processing',
          'isFinal': false,
          'pollInMs': 2000,
        };

        final response = ConfirmPaymentResponse.fromJson(json);

        expect(response.status, PaymentStatus.processing);
        expect(response.isFinal, false);
        expect(response.pollInMs, 2000);
      });
    });

    group('MerchantInfo and BuyerInfo', () {
      test('test_merchant_info_serialization', () {
        const merchant = MerchantInfo(
          name: 'Test Store',
          iconUrl: 'https://example.com/store.png',
        );

        final json = merchant.toJson();
        final parsed = MerchantInfo.fromJson(json);

        expect(parsed.name, merchant.name);
        expect(parsed.iconUrl, merchant.iconUrl);
      });

      test('test_merchant_info_without_icon', () {
        final json = {'name': 'Simple Store'};
        final merchant = MerchantInfo.fromJson(json);

        expect(merchant.name, 'Simple Store');
        expect(merchant.iconUrl, isNull);
      });

      test('test_buyer_info_serialization', () {
        const buyer = BuyerInfo(
          accountCaip10: 'eip155:1:0xabc',
          accountProviderName: 'Rainbow',
          accountProviderIcon: 'https://example.com/rainbow.png',
        );

        final json = buyer.toJson();
        final parsed = BuyerInfo.fromJson(json);

        expect(parsed.accountCaip10, buyer.accountCaip10);
        expect(parsed.accountProviderName, buyer.accountProviderName);
        expect(parsed.accountProviderIcon, buyer.accountProviderIcon);
      });

      test('test_buyer_info_without_icon', () {
        final json = {
          'accountCaip10': 'eip155:137:0xdef',
          'accountProviderName': 'WalletConnect',
        };

        final buyer = BuyerInfo.fromJson(json);

        expect(buyer.accountCaip10, 'eip155:137:0xdef');
        expect(buyer.accountProviderIcon, isNull);
      });
    });

    group('CollectDataFieldResult', () {
      test('test_collect_data_field_result_serialization', () {
        const result = CollectDataFieldResult(
          id: 'field_123',
          value: 'user input value',
        );

        final json = result.toJson();
        final parsed = CollectDataFieldResult.fromJson(json);

        expect(parsed.id, result.id);
        expect(parsed.value, result.value);
      });
    });
  });

  group('PaymentStatus Enum Tests', () {
    test('test_all_payment_status_values_serialize', () {
      // Test that all enum values serialize correctly (snake_case preserved)
      expect(PaymentStatus.requires_action.name, 'requires_action');
      expect(PaymentStatus.processing.name, 'processing');
      expect(PaymentStatus.succeeded.name, 'succeeded');
      expect(PaymentStatus.failed.name, 'failed');
      expect(PaymentStatus.expired.name, 'expired');
    });

    test('test_payment_status_from_json_all_values', () {
      // Test deserialization of all payment status values
      final statuses = {
        'requires_action': PaymentStatus.requires_action,
        'processing': PaymentStatus.processing,
        'succeeded': PaymentStatus.succeeded,
        'failed': PaymentStatus.failed,
        'expired': PaymentStatus.expired,
      };

      for (final entry in statuses.entries) {
        final json = {'status': entry.key, 'isFinal': true};
        final response = ConfirmPaymentResponse.fromJson(json);
        expect(response.status, entry.value);
      }
    });

    test('test_payment_status_requires_action_is_not_final', () {
      final json = {
        'status': 'requires_action',
        'isFinal': false,
        'pollInMs': 1000,
      };

      final response = ConfirmPaymentResponse.fromJson(json);

      expect(response.status, PaymentStatus.requires_action);
      expect(response.isFinal, false);
    });

    test('test_payment_status_succeeded_is_final', () {
      final json = {'status': 'succeeded', 'isFinal': true};

      final response = ConfirmPaymentResponse.fromJson(json);

      expect(response.status, PaymentStatus.succeeded);
      expect(response.isFinal, true);
    });

    test('test_payment_status_failed_is_final', () {
      final json = {'status': 'failed', 'isFinal': true};

      final response = ConfirmPaymentResponse.fromJson(json);

      expect(response.status, PaymentStatus.failed);
      expect(response.isFinal, true);
    });

    test('test_payment_status_expired_is_final', () {
      final json = {'status': 'expired', 'isFinal': true};

      final response = ConfirmPaymentResponse.fromJson(json);

      expect(response.status, PaymentStatus.expired);
      expect(response.isFinal, true);
    });
  });

  group('CollectDataFieldType Enum Tests', () {
    test('test_all_collect_data_field_types_serialize', () {
      expect(CollectDataFieldType.text.name, 'text');
      expect(CollectDataFieldType.date.name, 'date');
    });

    test('test_collect_data_field_type_from_json', () {
      final textJson = {
        'id': 'text_1',
        'name': 'Text Input',
        'required': true,
        'fieldType': 'text',
      };

      final dateJson = {
        'id': 'date_1',
        'name': 'Date Input',
        'required': false,
        'fieldType': 'date',
      };

      final textField = CollectDataField.fromJson(textJson);
      final dateField = CollectDataField.fromJson(dateJson);

      expect(textField.fieldType, CollectDataFieldType.text);
      expect(dateField.fieldType, CollectDataFieldType.date);
    });
  });
}
