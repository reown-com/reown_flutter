import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/sha256.dart';

class CosmosUtils {
  static String computeTxHash({
    required String bodyBytesBase64,
    required String authInfoBytesBase64,
    required String signatureBase64,
  }) {
    final baos = BytesBuilder();
    final bodyBytes = base64.decode(bodyBytesBase64);
    final authInfoBytes = base64.decode(authInfoBytesBase64);
    final signature = base64.decode(signatureBase64);

    baos.addByte(0x0A);
    baos.add(_encodeVarint(bodyBytes.length));
    baos.add(bodyBytes);

    baos.addByte(0x12);
    baos.add(_encodeVarint(authInfoBytes.length));
    baos.add(authInfoBytes);

    baos.addByte(0x1A);
    baos.add(_encodeVarint(signature.length));
    baos.add(signature);

    final txRawBytes = baos.toBytes();

    final hashBytes = SHA256Digest().process(txRawBytes);

    return hashBytes
        .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join();
  }

  static Uint8List _encodeVarint(int value) {
    final bytes = <int>[];
    var v = value;
    while (v > 127) {
      bytes.add((v & 0x7F) | 0x80);
      v >>= 7;
    }
    bytes.add(v);
    return Uint8List.fromList(bytes);
  }
}
