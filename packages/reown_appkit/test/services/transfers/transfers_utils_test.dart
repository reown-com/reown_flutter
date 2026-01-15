import 'package:flutter_test/flutter_test.dart';
import 'package:reown_appkit/modal/services/transfers/utils/transfers_utils.dart';

void main() {
  group('transfers_utils', () {
    group('parseUnits', () {
      test('converts integer amount correctly', () {
        final result = parseUnits('100', 18);
        expect(result, BigInt.parse('100000000000000000000'));
      });

      test('converts decimal amount correctly', () {
        final result = parseUnits('1.5', 18);
        expect(result, BigInt.parse('1500000000000000000'));
      });

      test('handles zero correctly', () {
        final result = parseUnits('0', 18);
        expect(result, BigInt.zero);
      });

      test('handles very small amounts', () {
        final result = parseUnits('0.000001', 18);
        expect(result, BigInt.parse('1000000000000'));
      });

      test('handles amounts with fewer decimals than specified', () {
        final result = parseUnits('1.5', 6);
        expect(result, BigInt.parse('1500000'));
      });

      test('handles amounts with more decimals than specified (truncates)', () {
        final result = parseUnits('1.123456789', 6);
        expect(result, BigInt.parse('1123456'));
      });

      test('handles negative amounts', () {
        final result = parseUnits('-1.5', 18);
        expect(result, BigInt.parse('-1500000000000000000'));
      });

      test('handles leading zeros', () {
        final result = parseUnits('0001.5', 18);
        expect(result, BigInt.parse('1500000000000000000'));
      });

      test('handles whitespace', () {
        final result = parseUnits('  1.5  ', 18);
        expect(result, BigInt.parse('1500000000000000000'));
      });

      test('handles zero decimals', () {
        final result = parseUnits('100', 0);
        expect(result, BigInt.parse('100'));
      });

      test('handles empty integer part', () {
        final result = parseUnits('.5', 18);
        expect(result, BigInt.parse('500000000000000000'));
      });
    });

    group('scaleAmountToBaseUnits', () {
      test('converts integer amount correctly', () {
        final result = scaleAmountToBaseUnits('100', 18);
        expect(result, '100000000000000000000');
      });

      test('converts decimal amount correctly', () {
        final result = scaleAmountToBaseUnits('1.5', 18);
        expect(result, '1500000000000000000');
      });

      test('handles zero correctly', () {
        final result = scaleAmountToBaseUnits('0', 18);
        expect(result, '0');
      });

      test('handles very small amounts', () {
        final result = scaleAmountToBaseUnits('0.000001', 18);
        expect(result, '1000000000000');
      });

      test('handles amounts with fewer decimals than specified', () {
        final result = scaleAmountToBaseUnits('1.5', 6);
        expect(result, '1500000');
      });

      test('handles amounts with more decimals than specified (truncates)', () {
        final result = scaleAmountToBaseUnits('1.123456789', 6);
        expect(result, '1123456');
      });

      test('handles leading zeros', () {
        final result = scaleAmountToBaseUnits('0001.5', 18);
        expect(result, '1500000000000000000');
      });

      test('handles whitespace', () {
        final result = scaleAmountToBaseUnits('  1.5  ', 18);
        expect(result, '1500000000000000000');
      });

      test('handles zero decimals', () {
        final result = scaleAmountToBaseUnits('100', 0);
        expect(result, '100');
      });

      test('handles empty integer part', () {
        final result = scaleAmountToBaseUnits('.5', 18);
        expect(result, '500000000000000000');
      });

      test('throws ArgumentError for invalid format', () {
        expect(
          () => scaleAmountToBaseUnits('invalid', 18),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('handles empty string as zero', () {
        // Empty string is treated as '0' after normalization
        final result = scaleAmountToBaseUnits('', 18);
        expect(result, '0');
      });
    });

    group('DEAD_ADDRESSES_BY_NAMESPACE', () {
      test('contains correct addresses for each namespace', () {
        expect(
          DEAD_ADDRESSES_BY_NAMESPACE['eip155'],
          '0x000000000000000000000000000000000000dead',
        );
        expect(
          DEAD_ADDRESSES_BY_NAMESPACE['solana'],
          'CbKGgVKLJFb8bBrf58DnAkdryX6ubewVytn7X957YwNr',
        );
        expect(
          DEAD_ADDRESSES_BY_NAMESPACE['bip122'],
          'bc1q4vxn43l44h30nkluqfxd9eckf45vr2awz38lwa',
        );
      });
    });
  });
}
