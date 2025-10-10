import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pointycastle/export.dart';

part 'jwk.freezed.dart';
part 'jwk.g.dart';

@freezed
sealed class JWK with _$JWK {
  const factory JWK({required PublicKey publicKey, required int expiresAt}) =
      _JWK;

  factory JWK.fromJson(Map<String, dynamic> json) => _$JWKFromJson(json);
}

@freezed
sealed class PublicKey with _$PublicKey {
  const factory PublicKey({
    @JsonKey(name: 'crv') required String crv,
    @JsonKey(name: 'ext') required bool ext,
    @JsonKey(name: 'key_ops') required List<String> keyOps,
    @JsonKey(name: 'kty') required String kty,
    @JsonKey(name: 'x') required String x,
    @JsonKey(name: 'y') required String y,
  }) = _PublicKey;

  factory PublicKey.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyFromJson(json);
}

extension JWKExtension on JWK {
  Uint8List toBytes() {
    final xBytes = base64Url.decode(_normalizeBase64(publicKey.x));
    final yBytes = base64Url.decode(_normalizeBase64(publicKey.y));

    final xBigInt = BigInt.parse(hex.encode(xBytes), radix: 16);
    final yBigInt = BigInt.parse(hex.encode(yBytes), radix: 16);

    final ecDomain = ECDomainParameters('prime256v1');
    final ecPoint = ecDomain.curve.createPoint(xBigInt, yBigInt);

    return ecPoint.getEncoded(false); // uncompressed format (starts with 0x04)
  }

  // Padding fix for base64url (needed for JWT/JWK)
  String _normalizeBase64(String str) {
    return str.padRight((str.length + 3) ~/ 4 * 4, '=');
  }

  bool isExpired() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return expiresAt < now;
  }

  DateTime expirationDate() {
    return DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);
  }
}
