import 'package:flutter_test/flutter_test.dart';
import 'package:reown_sign/reown_sign.dart';

import '../shared/shared_test_values.dart';
import '../shared/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AddressUtils', () {
    test('getDidAddress', () async {
      expect(
        AddressUtils.getDidAddressAddress(TEST_ISSUER_EIP191),
        TEST_ADDRESS_EIP191,
      );
    });

    test('getDidChainId', () async {
      expect(
        AddressUtils.getDidAddressChainId(TEST_ISSUER_EIP191),
        TEST_ETHEREUM_CHAIN.split(':')[1],
      );
    });

    test('toEIP55 checksums a lowercase EVM address', () {
      expect(
        '0x5aaeb6053f3e94c9b9a09f33669435e7ef1beaed'.toEIP55(),
        '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
      );
    });

    test('toEIP55 keeps an already checksummed address', () {
      expect(TEST_ADDRESS_EIP191.toEIP55(), TEST_ADDRESS_EIP191);
    });

    test('toEIP55 leaves non-EVM addresses unchanged', () {
      const solana = '7EcDhSYGxXyscszYEp35KHN8vvw3svAuLKTzXwCFLtV';
      expect(solana.toEIP55(), solana);
    });
  });
}
