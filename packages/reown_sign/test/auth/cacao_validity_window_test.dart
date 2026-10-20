import 'package:flutter_test/flutter_test.dart';
import 'package:reown_sign/reown_sign.dart';

void main() {
  final now = DateTime.fromMillisecondsSinceEpoch(
    1700000000 * 1000,
    isUtc: true,
  );

  test('absent exp and nbf are valid', () {
    expect(AuthSignature.isWithinValidityWindow(now: now), isTrue);
  });

  test('future exp is valid', () {
    expect(
      AuthSignature.isWithinValidityWindow(
        exp: '2024-01-01T00:00:00Z',
        now: now,
      ),
      isTrue,
    );
  });

  test('past exp is expired', () {
    expect(
      AuthSignature.isWithinValidityWindow(
        exp: '2023-01-01T00:00:00Z',
        now: now,
      ),
      isFalse,
    );
  });

  test('exp equal to now is expired', () {
    expect(
      AuthSignature.isWithinValidityWindow(
        exp: '2023-11-14T22:13:20Z',
        now: now,
      ),
      isFalse,
    );
  });

  test('past nbf is valid', () {
    expect(
      AuthSignature.isWithinValidityWindow(
        nbf: '2023-01-01T00:00:00Z',
        now: now,
      ),
      isTrue,
    );
  });

  test('future nbf is not yet valid', () {
    expect(
      AuthSignature.isWithinValidityWindow(
        nbf: '2024-01-01T00:00:00Z',
        now: now,
      ),
      isFalse,
    );
  });

  test('unparseable exp fails closed', () {
    expect(
      AuthSignature.isWithinValidityWindow(exp: 'not-a-timestamp', now: now),
      isFalse,
    );
  });

  test('unparseable nbf fails closed', () {
    expect(
      AuthSignature.isWithinValidityWindow(nbf: 'not-a-timestamp', now: now),
      isFalse,
    );
  });
}
