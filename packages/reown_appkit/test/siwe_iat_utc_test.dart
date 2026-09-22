import 'package:flutter_test/flutter_test.dart';
import 'package:reown_appkit/reown_appkit.dart';

void main() {
  test('SIWECreateMessageArgs default iat is real UTC', () {
    final before = DateTime.now().toUtc();
    final args = SIWECreateMessageArgs.fromSIWEMessageArgs(
      const SIWEMessageArgs(
        domain: 'example.com',
        uri: 'https://example.com/login',
      ),
      address: '0x06C6A22feB5f8CcEDA0db0D593e6F26A3611d5fa',
      chainId: 'eip155:1',
      nonce: 'n',
      type: const CacaoHeader(t: 'eip4361'),
    );
    final after = DateTime.now().toUtc();
    final iat = DateTime.parse(args.iat!);

    expect(args.iat!.endsWith('Z'), isTrue);
    expect(iat.isUtc, isTrue);
    expect(!iat.isBefore(before.subtract(const Duration(seconds: 1))), isTrue);
    expect(!iat.isAfter(after.add(const Duration(seconds: 1))), isTrue);
  });
}
