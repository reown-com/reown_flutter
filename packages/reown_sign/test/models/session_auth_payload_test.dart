import 'package:flutter_test/flutter_test.dart';
import 'package:reown_sign/reown_sign.dart';

void main() {
  test('fromRequestParams stamps iat in real UTC, not local clock as Z', () {
    final before = DateTime.now().toUtc();
    final payload = SessionAuthPayload.fromRequestParams(
      const SessionAuthRequestParams(
        domain: 'example.com',
        chains: ['eip155:1'],
        nonce: 'n',
        uri: 'https://example.com/login',
      ),
    );
    final after = DateTime.now().toUtc();
    final iat = DateTime.parse(payload.iat);

    expect(payload.iat.endsWith('Z'), isTrue);
    expect(iat.isUtc, isTrue);
    expect(!iat.isBefore(before.subtract(const Duration(seconds: 1))), isTrue);
    expect(!iat.isAfter(after.add(const Duration(seconds: 1))), isTrue);

    final localAsUtc = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    );
    if (DateTime.now().timeZoneOffset.inMinutes.abs() >= 2) {
      expect(
        iat.difference(localAsUtc).inMinutes.abs(),
        greaterThanOrEqualTo(1),
      );
    }
  });
}
