import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/verify/jwt_validation.dart';
import 'package:reown_core/verify/models/jwk.dart';
import 'package:convert/convert.dart';

void main() {
  // final sut = JWTRepository();

  final validJwt =
      'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.'
      'eyJleHAiOjE3MjI1Nzk5MDgsImlkIjoiNTEwNmEyNTU1MmU4OWFjZmI1YmVkODNlZTIxYmY0ZTgwZGJjZDUxYjBiMjAzZjY5MjVhMzY5YWFjYjFjODYwYiIsIm9yaWdpbiI6Imh0dHBzOi8vcmVhY3QtZGFwcC12Mi1naXQtY2hvcmUtdmVyaWZ5LXYyLXNhbXBsZXMtd2FsbGV0Y29ubmVjdDEudmVyY2VsLmFwcCIsImlzU2NhbSI6bnVsbCwiaXNWZXJpZmllZCI6dHJ1ZX0.'
      'vm1TUofxpKc6yLYXDgR_p7AYhTC9_WMu9FOgY7l3fMAX_COgqIBGaY9NE8Sq8WmDGjTJroF15qsy9xD8dUXIcw';

  final jwk = JWK(
    publicKey: PublicKey(
      crv: 'P-256',
      ext: true,
      keyOps: ['verify'],
      kty: 'EC',
      x: 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
      y: 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
    ),
    expiresAt: 1722579908,
  );

  test('verifyJWT should return true for valid JWT', () {
    final publicKey = JWTValidator.generateP256PublicKeyFromJWK(jwk);
    final isValid = JWTValidator.verifyES256JWT(
      validJwt,
      Uint8List.fromList(hex.decode(publicKey)),
    );
    expect(isValid, isTrue);
  });

  test('generateP256PublicKeyFromJWK should generate valid public key', () {
    final publicKey = JWTValidator.generateP256PublicKeyFromJWK(jwk);
    expect(publicKey, isNotNull);
  });

  test('verifyJWT should return false for invalid JWT', () {
    final invalidJwt = 'invalid.jwt.sig';
    final publicKey = JWTValidator.generateP256PublicKeyFromJWK(jwk);
    final isValid = JWTValidator.verifyES256JWT(
      invalidJwt,
      Uint8List.fromList(hex.decode(publicKey)),
    );
    expect(isValid, isFalse);
  });

  test('decodeClaimsJWT should return decoded claims for valid JWT', () {
    final claims = JWTValidator.decodeClaimsJWT(validJwt);
    expect(claims.containsKey('isScam'), isTrue);
    expect(claims.containsKey('isVerified'), isTrue);
  });

  test('decodeClaimsJWT should throw error for invalid JWT', () {
    final invalidJwt = 'invalid.jwt';
    expect(
      () => JWTValidator.decodeClaimsJWT(invalidJwt),
      throwsA(
        predicate(
          (e) => e is Exception && e.toString().contains('Unable to split jwt'),
        ),
      ),
    );
  });
}
