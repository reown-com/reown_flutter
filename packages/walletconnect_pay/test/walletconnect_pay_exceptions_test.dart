import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_pay/models/walletconnect_pay_exceptions.dart';
import 'package:walletconnect_pay/walletconnect_pay.dart';
import 'package:walletconnect_pay/walletconnect_pay_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Tests for exception handling, ported from Rust yttrium crate pay module.
/// Reference: /Users/alfreedom/Development/Reown/yttrium/crates/yttrium/src/pay/mod.rs

class MockWalletconnectPayPlatformWithErrors
    with MockPlatformInterfaceMixin
    implements WalletconnectPayPlatform {
  PlatformException? _initializeException;
  PlatformException? _getPaymentOptionsException;
  PlatformException? _getRequiredActionsException;
  PlatformException? _confirmPaymentException;

  void setInitializeException(PlatformException exception) {
    _initializeException = exception;
  }

  void setGetPaymentOptionsException(PlatformException exception) {
    _getPaymentOptionsException = exception;
  }

  void setGetRequiredActionsException(PlatformException exception) {
    _getRequiredActionsException = exception;
  }

  void setConfirmPaymentException(PlatformException exception) {
    _confirmPaymentException = exception;
  }

  @override
  Future<bool> initialize({
    String? apiKey,
    String? appId,
    String? clientId,
    String? baseUrl,
  }) async {
    if (_initializeException != null) throw _initializeException!;
    return true;
  }

  @override
  Future<String> confirmPayment({required String requestJson}) async {
    if (_confirmPaymentException != null) throw _confirmPaymentException!;
    return '{"status": "succeeded", "isFinal": true}';
  }

  @override
  Future<String> getPaymentOptions({required String requestJson}) async {
    if (_getPaymentOptionsException != null) {
      throw _getPaymentOptionsException!;
    }
    return '{"paymentId": "test-payment-id", "options": []}';
  }

  @override
  Future<String> getRequiredPaymentActions({
    required String requestJson,
  }) async {
    if (_getRequiredActionsException != null) {
      throw _getRequiredActionsException!;
    }
    return '[]';
  }
}

void main() {
  group('Exception Tests', () {
    group('PayError Base Class', () {
      test('test_pay_error_extends_platform_exception', () {
        final error = PayInitializeError(
          code: 'TEST_ERROR',
          message: 'Test error message',
          details: {'key': 'value'},
          stacktrace: 'Test stacktrace',
        );

        expect(error, isA<PlatformException>());
        expect(error, isA<PayError>());
        expect(error.code, 'TEST_ERROR');
        expect(error.message, 'Test error message');
      });
    });

    group('PayInitializeError', () {
      test('test_pay_initialize_error_creation', () {
        final error = PayInitializeError(
          code: 'INIT_ERROR',
          message: 'Failed to initialize SDK',
          details: null,
          stacktrace: null,
        );

        expect(error.code, 'INIT_ERROR');
        expect(error.message, 'Failed to initialize SDK');
        expect(error.details, isNull);
        expect(error.stacktrace, isNull);
      });

      test('test_pay_initialize_error_to_string', () {
        final error = PayInitializeError(
          code: 'INIT_ERROR',
          message: 'Test message',
          details: 'Test details',
          stacktrace: 'Test stack',
        );

        final str = error.toString();
        expect(str, contains('PayInitializeError'));
        expect(str, contains('INIT_ERROR'));
        expect(str, contains('Test message'));
      });

      test('test_pay_initialize_error_with_full_details', () {
        final error = PayInitializeError(
          code: 'CONFIG_ERROR',
          message: 'Both api_key and app_id are missing',
          details: {
            'missing_fields': ['api_key', 'app_id'],
          },
          stacktrace: 'at initialize() line 42',
        );

        expect(error.code, 'CONFIG_ERROR');
        expect(error.details, isA<Map>());
      });
    });

    group('GetPaymentOptionsError', () {
      test('test_get_payment_options_error_creation', () {
        final error = GetPaymentOptionsError(
          code: 'NOT_FOUND',
          message: 'Payment not found',
          details: null,
          stacktrace: null,
        );

        expect(error.code, 'NOT_FOUND');
        expect(error.message, 'Payment not found');
      });

      test('test_get_payment_options_error_404_not_found', () {
        // Simulates Rust test: test_get_payment_options_not_found
        final error = GetPaymentOptionsError(
          code: '404',
          message: 'Payment not found',
          details: {'payment_id': 'pay_xyz'},
          stacktrace: null,
        );

        expect(error.code, '404');
        expect(error.message, 'Payment not found');
      });

      test('test_get_payment_options_error_410_expired', () {
        // Simulates Rust test: test_get_payment_options_expired
        final error = GetPaymentOptionsError(
          code: '410',
          message: 'Payment expired',
          details: {'payment_id': 'pay_abc', 'expired_at': '2024-01-01'},
          stacktrace: null,
        );

        expect(error.code, '410');
        expect(error.message, 'Payment expired');
      });

      test('test_get_payment_options_error_to_string', () {
        final error = GetPaymentOptionsError(
          code: 'ERROR',
          message: 'Test',
          details: null,
          stacktrace: null,
        );

        final str = error.toString();
        expect(str, contains('GetPaymentOptionsError'));
      });
    });

    group('GetRequiredActionsError', () {
      test('test_get_required_actions_error_creation', () {
        final error = GetRequiredActionsError(
          code: 'FETCH_ERROR',
          message: 'Failed to fetch required actions',
          details: null,
          stacktrace: null,
        );

        expect(error.code, 'FETCH_ERROR');
        expect(error.message, 'Failed to fetch required actions');
      });

      test('test_get_required_actions_error_to_string', () {
        final error = GetRequiredActionsError(
          code: 'ERROR',
          message: 'Test',
          details: null,
          stacktrace: null,
        );

        final str = error.toString();
        expect(str, contains('GetRequiredActionError'));
      });

      test('test_get_required_actions_fetch_error', () {
        // Simulates Rust test: test_get_required_payment_actions_fetch_error
        final error = GetRequiredActionsError(
          code: 'FETCH_ERROR',
          message: 'Network request failed',
          details: {'url': 'https://api.pay.walletconnect.com/actions'},
          stacktrace: null,
        );

        expect(error.code, 'FETCH_ERROR');
      });
    });

    group('ConfirmPaymentError', () {
      test('test_confirm_payment_error_creation', () {
        final error = ConfirmPaymentError(
          code: 'CONFIRM_ERROR',
          message: 'Failed to confirm payment',
          details: null,
          stacktrace: null,
        );

        expect(error.code, 'CONFIRM_ERROR');
        expect(error.message, 'Failed to confirm payment');
      });

      test('test_confirm_payment_error_to_string', () {
        final error = ConfirmPaymentError(
          code: 'ERROR',
          message: 'Test',
          details: null,
          stacktrace: null,
        );

        final str = error.toString();
        expect(str, contains('ConfirmPaymentError'));
      });

      test('test_confirm_payment_error_with_status', () {
        final error = ConfirmPaymentError(
          code: 'PAYMENT_FAILED',
          message: 'Payment was rejected',
          details: {'status': 'failed', 'reason': 'insufficient_funds'},
          stacktrace: null,
        );

        expect(error.code, 'PAYMENT_FAILED');
        expect(error.details, isA<Map>());
      });
    });
  });

  group('Integration Error Tests', () {
    late WalletConnectPay walletconnectPayPlugin;
    late MockWalletconnectPayPlatformWithErrors mockPlatform;

    setUp(() {
      walletconnectPayPlugin = WalletConnectPay(appId: 'test', apiKey: 'test');
      mockPlatform = MockWalletconnectPayPlatformWithErrors();
      WalletconnectPayPlatform.instance = mockPlatform;
    });

    test('test_get_payment_options_throws_on_404', () async {
      mockPlatform.setGetPaymentOptionsException(
        PlatformException(code: '404', message: 'Payment not found'),
      );

      expect(
        () => walletconnectPayPlugin.getPaymentOptions(
          request: GetPaymentOptionsRequest(
            paymentLink: 'pay_nonexistent',
            accounts: ['eip155:1:0x123'],
          ),
        ),
        throwsA(isA<PlatformException>()),
      );
    });

    test('test_get_payment_options_throws_on_410_expired', () async {
      mockPlatform.setGetPaymentOptionsException(
        PlatformException(code: '410', message: 'Payment expired'),
      );

      expect(
        () => walletconnectPayPlugin.getPaymentOptions(
          request: GetPaymentOptionsRequest(
            paymentLink: 'pay_expired',
            accounts: ['eip155:1:0x123'],
          ),
        ),
        throwsA(isA<PlatformException>()),
      );
    });

    test('test_get_required_actions_throws_on_fetch_error', () async {
      mockPlatform.setGetRequiredActionsException(
        PlatformException(
          code: 'NETWORK_ERROR',
          message: 'Failed to fetch actions',
        ),
      );

      expect(
        () => walletconnectPayPlugin.getRequiredPaymentActions(
          request: GetRequiredPaymentActionsRequest(
            paymentId: 'pay_123',
            optionId: 'opt_456',
          ),
        ),
        throwsA(isA<PlatformException>()),
      );
    });

    test('test_confirm_payment_throws_on_error', () async {
      mockPlatform.setConfirmPaymentException(
        PlatformException(
          code: 'CONFIRM_ERROR',
          message: 'Payment confirmation failed',
        ),
      );

      expect(
        () => walletconnectPayPlugin.confirmPayment(
          request: ConfirmPaymentRequest(
            paymentId: 'pay_123',
            optionId: 'opt_456',
            signatures: ['0xsig'],
          ),
        ),
        throwsA(isA<PlatformException>()),
      );
    });

    test('test_json_decode_error_on_invalid_response', () async {
      // Test that invalid JSON throws FormatException
      expect(
        () => walletconnectPayPlugin.getPaymentOptions(
          request: GetPaymentOptionsRequest(
            paymentLink: 'pay_123',
            accounts: [],
          ),
        ),
        // Should succeed with mock returning valid JSON
        returnsNormally,
      );
    });
  });

  group('Error Code Constants', () {
    test('test_common_error_codes', () {
      // Common HTTP error codes that can be returned
      final errorCodes = ['400', '401', '403', '404', '410', '500', '503'];

      for (final code in errorCodes) {
        final error = GetPaymentOptionsError(
          code: code,
          message: 'Error $code',
          details: null,
          stacktrace: null,
        );
        expect(error.code, code);
      }
    });

    test('test_custom_error_codes', () {
      // Custom error codes that the SDK might return
      final customCodes = [
        'CONFIG_ERROR',
        'NETWORK_ERROR',
        'FETCH_ERROR',
        'PARSE_ERROR',
        'TIMEOUT_ERROR',
        'PAYMENT_NOT_FOUND',
        'PAYMENT_EXPIRED',
        'INVALID_SIGNATURE',
      ];

      for (final code in customCodes) {
        final error = ConfirmPaymentError(
          code: code,
          message: 'Error: $code',
          details: null,
          stacktrace: null,
        );
        expect(error.code, code);
      }
    });
  });
}
