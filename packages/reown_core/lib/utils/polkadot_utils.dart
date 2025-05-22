import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/digests/blake2b.dart';
import 'package:reown_core/reown_core.dart';

class PolkadotChainUtils {
  // Polkadot related methods
  static List<int> ss58AddressToPublicKey(String ss58Address) {
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

  /// SCALE-encodes a BigInt using compact encoding.
  static Uint8List _compactEncodeBigInt(BigInt value) {
    if (value < BigInt.from(1 << 6)) {
      // single-byte mode
      return Uint8List.fromList([value.toInt() << 2]);
    } else if (value < BigInt.from(1 << 14)) {
      // two-byte mode
      int val = value.toInt() << 2 | 0x01;
      return Uint8List.fromList([
        val & 0xFF,
        (val >> 8) & 0xFF,
      ]);
    } else if (value < BigInt.from(1 << 30)) {
      // four-byte mode
      int val = value.toInt() << 2 | 0x02;
      return Uint8List.fromList([
        val & 0xFF,
        (val >> 8) & 0xFF,
        (val >> 16) & 0xFF,
        (val >> 24) & 0xFF,
      ]);
    } else {
      // big-integer mode
      final bytes = _bigIntToLEBytes(value);
      final len = bytes.length;
      if (len > 67) {
        throw ArgumentError('Compact encoding supports max 2^536-1');
      }

      return Uint8List.fromList([
        ((len - 4) << 2) | 0x03,
        ...bytes,
      ]);
    }
  }

  static Uint8List _bigIntToLEBytes(BigInt value) {
    final bytes = <int>[];
    BigInt current = value;
    while (current > BigInt.zero) {
      bytes.add((current & BigInt.from(0xff)).toInt());
      current = current >> 8;
    }
    return Uint8List.fromList(bytes);
  }

  /// Constructs the method field for transferKeepAlive.
  static String constructHexMethod(String destAddress, BigInt amount) {
    final callIndex = [0x04, 0x03];
    final dest = ss58AddressToPublicKey(destAddress);
    final value = _compactEncodeBigInt(amount);
    final method = [...callIndex, ...dest, ...value];
    return '0x${method.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';
  }
}
