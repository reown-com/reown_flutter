// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'package:convert/convert.dart';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:reown_core/verify/models/jwk.dart';

class JWTValidator {
  static const String _jwtDelimiter = ".";

  static String generateP256PublicKeyFromJWK(JWK jwk) {
    final xBytes = base64Url.decode(_normalizeBase64(jwk.publicKey.x));
    final yBytes = base64Url.decode(_normalizeBase64(jwk.publicKey.y));

    final ecDomain = ECDomainParameters('prime256v1');
    final x = BigInt.parse(hex.encode(xBytes), radix: 16);
    final y = BigInt.parse(hex.encode(yBytes), radix: 16);

    final q = ecDomain.curve.createPoint(x, y);
    final pubKeyParams = ECPublicKey(q, ecDomain);

    final encoded = pubKeyParams.Q!.getEncoded(false); // Uncompressed point
    return hex.encode(encoded);
  }

  static bool verifyES256JWT(String jwt, Uint8List publicKeyBytes) {
    try {
      final parts = jwt.split(_jwtDelimiter);
      if (parts.length != 3) throw Exception('Unable to split jwt: $jwt');
      final header = parts[0];
      final claims = parts[1];
      final signatureBase64 = parts[2];

      final signatureBytes = base64Url.decode(
        _normalizeBase64(signatureBase64),
      );
      final data = utf8.encode('$header.$claims');

      final r = BigInt.parse(
        hex.encode(signatureBytes.sublist(0, signatureBytes.length ~/ 2)),
        radix: 16,
      );
      final s = BigInt.parse(
        hex.encode(signatureBytes.sublist(signatureBytes.length ~/ 2)),
        radix: 16,
      );

      final ecDomain = ECDomainParameters('prime256v1');
      final q = ecDomain.curve.decodePoint(publicKeyBytes)!;
      final pubKeyParams = ECPublicKey(q, ecDomain);

      final signer = ECDSASigner(null, HMac(SHA256Digest(), 64));
      signer.init(false, PublicKeyParameter(pubKeyParams));

      final hash = SHA256Digest().process(Uint8List.fromList(data));

      return signer.verifySignature(hash, ECSignature(r, s));
    } catch (_) {
      return false;
    }
  }

  static Map<String, dynamic> decodeClaimsJWT(String attestation) {
    final parts = attestation.split(_jwtDelimiter);
    if (parts.length != 3) throw Exception('Unable to split jwt: $attestation');

    final claims = parts[1];
    final decoded = base64Url.decode(_normalizeBase64(claims));
    return jsonDecode(utf8.decode(decoded)) as Map<String, dynamic>;
  }

  // Helper to fix padding in base64url
  static String _normalizeBase64(String input) {
    return input.padRight((input.length + 3) ~/ 4 * 4, '=');
  }
}
