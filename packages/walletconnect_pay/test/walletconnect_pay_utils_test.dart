import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_pay/walletconnect_pay_utils.dart';
import 'package:walletconnect_pay/version.dart';

/// Tests for WalletconnectPayUtils, ported from Rust yttrium crate pay module.
/// Reference: /Users/alfreedom/Development/Reown/yttrium/crates/yttrium/src/pay/mod.rs
void main() {
  group('WalletconnectPayUtils Tests', () {
    group('Base URL', () {
      test('test_get_base_url_returns_production_url', () {
        final baseUrl = WalletconnectPayUtils.getBaseUrl();

        expect(baseUrl, 'https://api.pay.walletconnect.com');
        expect(baseUrl.startsWith('https://'), true);
      });

      test('test_base_url_is_secure', () {
        final baseUrl = WalletconnectPayUtils.getBaseUrl();

        expect(baseUrl.startsWith('https://'), true);
        expect(baseUrl.startsWith('http://'), false);
      });
    });

    group('SDK Name', () {
      test('test_get_sdk_name', () {
        final sdkName = WalletconnectPayUtils.getSdkName();

        expect(sdkName, 'flutter-walletconnect-pay');
        expect(sdkName.contains('flutter'), true);
      });

      test('test_sdk_name_format', () {
        final sdkName = WalletconnectPayUtils.getSdkName();

        // SDK name should follow the pattern: platform-product-name
        expect(sdkName.split('-').length, greaterThanOrEqualTo(2));
      });
    });

    group('SDK Version', () {
      test('test_get_sdk_version', () {
        final sdkVersion = WalletconnectPayUtils.getSdkVersion();

        expect(sdkVersion, isNotEmpty);
        expect(sdkVersion, packageVersion);
      });

      test('test_sdk_version_format', () {
        final sdkVersion = WalletconnectPayUtils.getSdkVersion();

        // Version should follow semver pattern (at minimum X.Y.Z)
        final parts = sdkVersion.split('.');
        expect(parts.length, greaterThanOrEqualTo(3));
      });

      test('test_sdk_version_matches_package_version', () {
        final sdkVersion = WalletconnectPayUtils.getSdkVersion();

        expect(sdkVersion, packageVersion);
      });
    });

    group('Platform', () {
      test('test_get_platform_returns_valid_value', () {
        final platform = WalletconnectPayUtils.getPlatform();

        // Platform should be one of the known values
        final validPlatforms = [
          'android',
          'ios',
          'linux',
          'macos',
          'windows',
          'web',
          'unknown',
        ];

        expect(validPlatforms.contains(platform), true);
      });

      test('test_platform_is_not_empty', () {
        final platform = WalletconnectPayUtils.getPlatform();

        expect(platform, isNotEmpty);
      });
    });

    group('Operating System', () {
      test('test_get_os_returns_valid_value', () {
        final os = WalletconnectPayUtils.getOS();

        expect(os, isNotEmpty);
      });

      test('test_os_format_for_native_platforms', () {
        final os = WalletconnectPayUtils.getOS();

        // For native platforms, OS should contain a hyphen separating name and version
        // For web, it should be 'web-browser'
        if (os == 'web-browser') {
          expect(os, 'web-browser');
        } else {
          expect(os.contains('-'), true);
        }
      });
    });

    group('SDK Headers Configuration', () {
      // Tests based on Rust test: test_sdk_headers_are_set
      test('test_sdk_configuration_values_are_valid', () {
        final baseUrl = WalletconnectPayUtils.getBaseUrl();
        final sdkName = WalletconnectPayUtils.getSdkName();
        final sdkVersion = WalletconnectPayUtils.getSdkVersion();
        final sdkPlatform = WalletconnectPayUtils.getPlatform();

        // All values should be non-empty strings
        expect(baseUrl, isNotEmpty);
        expect(sdkName, isNotEmpty);
        expect(sdkVersion, isNotEmpty);
        expect(sdkPlatform, isNotEmpty);

        // Values should not contain whitespace-only content
        expect(baseUrl.trim(), baseUrl);
        expect(sdkName.trim(), sdkName);
        expect(sdkVersion.trim(), sdkVersion);
        expect(sdkPlatform.trim(), sdkPlatform);
      });

      // Based on Rust test: test_custom_sdk_config_headers
      test('test_sdk_name_contains_walletconnect', () {
        final sdkName = WalletconnectPayUtils.getSdkName();

        expect(sdkName.toLowerCase().contains('walletconnect'), true);
      });

      test('test_sdk_name_contains_pay', () {
        final sdkName = WalletconnectPayUtils.getSdkName();

        expect(sdkName.toLowerCase().contains('pay'), true);
      });
    });
  });

  group('Version Constants', () {
    test('test_package_version_is_defined', () {
      expect(packageVersion, isNotEmpty);
    });

    test('test_package_version_is_semver', () {
      // Check that version follows semver format
      final versionRegex = RegExp(r'^\d+\.\d+\.\d+');
      expect(versionRegex.hasMatch(packageVersion), true);
    });
  });
}
