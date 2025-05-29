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

  static Uint8List addSignatureToExtrinsic({
    required Uint8List publicKey,
    required String hexSignature,
    required Map<String, dynamic> payload,
  }) {
    final method = payload['method'] is Uint8List
        ? (payload['method'] as Uint8List).toList()
        : hex.decode(_normalizeHex(payload['method']));
    final signature = hex.decode(_normalizeHex(hexSignature));

    // Extrinsic version: signed + version (0x84 for sr25519, version 4)
    const extrinsicVersion = 0x84;

    // Signature type (sr25519 = 1)
    const signatureType = 0x01;

    // Era
    final eraValue = payload['era'].toString();
    final eraPeriod = _parseHex(eraValue);
    final eraBytes = _compactEncodeInt(eraPeriod);

    // Nonce - decode from hex and compact encode
    final nonceValue = _parseHex(payload['nonce']);
    final nonceBytes = _compactEncodeInt(nonceValue);

    // Tip - decode from hex and compact encode
    final tipValue = BigInt.parse(_normalizeHex(payload['tip']), radix: 16);
    final tipBytes = _compactEncodeBigInt(tipValue);

    final extrinsicBody = BytesBuilder();

    extrinsicBody.add(publicKey); // Signer (public key)
    extrinsicBody.addByte(signatureType); // Signature type (sr25519)
    extrinsicBody.add(signature); // Signature
    extrinsicBody.add(eraBytes); // Era
    extrinsicBody.add(nonceBytes); // Nonce
    extrinsicBody.add(tipBytes); // Tip
    extrinsicBody.add(method); // Encoded method

    final bodyBytes = extrinsicBody.toBytes();

    final lengthPrefix = _compactEncodeBigInt(
        BigInt.from(bodyBytes.length + 1)); // +1 for version byte

    final full = BytesBuilder();
    full.add(lengthPrefix);
    full.addByte(extrinsicVersion);
    full.add(bodyBytes);

    return full.toBytes();

    // return '0x${hex.encode(full.toBytes())}';
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

  static List<int> _compactEncodeInt(dynamic value) {
    // Convert int to BigInt if needed
    final bigValue = value is BigInt ? value : BigInt.from(value);

    if (bigValue < BigInt.from(1 << 6)) {
      return [(bigValue.toInt() << 2)];
    } else if (bigValue < BigInt.from(1 << 14)) {
      return [
        ((bigValue.toInt() << 2) | 0x01) & 0xff,
        ((bigValue.toInt() >> 6) & 0xff),
      ];
    } else if (bigValue < BigInt.from(1 << 30)) {
      final val = bigValue.toInt() << 2 | 0x02;
      return [
        val & 0xff,
        (val >> 8) & 0xff,
        (val >> 16) & 0xff,
        (val >> 24) & 0xff,
      ];
    } else {
      // big-integer mode
      final bytes = _bigIntToLEBytes(bigValue);
      final len = bytes.length;
      if (len > 67) {
        throw ArgumentError('Compact encoding supports max 2^536-1');
      }

      return [
        ((len - 4) << 2) | 0x03,
        ...bytes,
      ];
    }
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
  // static String constructHexMethod(String destAddress, BigInt amount) {
  //   final callIndex = [0x04, 0x03];
  //   final dest = ss58AddressToPublicKey(destAddress);
  //   final value = _compactEncodeBigInt(amount);
  //   final method = [...callIndex, ...dest, ...value];
  //   return '0x${method.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';
  // }

  static String deriveExtrinsicHash(String signed) {
    final digest = Blake2bDigest(digestSize: 32); // 256-bit
    final input = hex.decode(signed.replaceAll('0x', ''));
    final bytes = digest.process(Uint8List.fromList(input));
    return hex.encode(bytes);
  }
}
