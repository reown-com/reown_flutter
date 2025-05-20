import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/digests/blake2b.dart';
import 'package:reown_core/reown_core.dart';

class PolkadotChainUtils {
  // Polkadot related methods
  static List<int> ss58ToPublic(String ss58Address) {
    final decoded = base58.decode(ss58Address);

    if (decoded.length < 33) {
      throw FormatException('Too short to contain a public key');
    }

    // Skip the prefix (1st byte), take 32 bytes
    return decoded.sublist(1, 33);
  }

  static String addSignatureToExtrinsic({
    required List<int> publicKey,
    required String hexSignature,
    required Map<String, dynamic> payload,
  }) {
    final version = [0x84];
    // final publicKey = _ss58ToPublic(ss58Address);

    final signaturePrefix = [0x01]; // sr25519
    final signature = hex.decode(_normalizeHex(hexSignature));
    final fullSignature = signaturePrefix + signature;

    final era = hex.decode(_normalizeHex(payload['era']));
    final nonce = _compactEncodeInt(_parseHex(payload['nonce']));
    final tip = _compactEncodeInt(_parseHex(payload['tip']));
    final method = hex.decode(_normalizeHex(payload['method']));

    final fullBytes = Uint8List.fromList([
      ...version,
      ...publicKey,
      ...fullSignature,
      ...era,
      ...nonce,
      ...tip,
      ...method
    ]);

    return '0x${hex.encode(fullBytes)}';
  }

  static String _normalizeHex(dynamic input) {
    if (input.toString().startsWith('0x')) {
      return input.toString().replaceAll('0x', '');
    }
    return input.toString();
  }

  static int _parseHex(dynamic input) {
    final raw = _normalizeHex(input);
    return int.parse(raw, radix: 16);
  }

  static List<int> _compactEncodeInt(int value) {
    if (value < 1 << 6) {
      return [(value << 2)];
    } else if (value < 1 << 14) {
      return [
        ((value << 2) | 0x01) & 0xff,
        ((value >> 6) & 0xff),
      ];
    } else {
      throw UnimplementedError('Only supports small ints for now');
    }
  }

  static String deriveExtrinsicHash(String signed) {
    final digest = Blake2bDigest(digestSize: 32); // 256-bit
    final input = hex.decode(signed.replaceAll('0x', ''));
    final bytes = digest.process(Uint8List.fromList(input));
    return '0x${hex.encode(bytes)}';
  }
}
