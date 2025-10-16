import 'dart:convert';
import 'dart:typed_data';
import 'package:msgpack_dart/msgpack_dart.dart' as msgpack;
import 'package:pointycastle/digests/sha512t.dart';

class AlgorandChainUtils {
  static final _base32Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

  static List<String> calculateTxIDs(List signedTxnBase64List) {
    return signedTxnBase64List.map((signedTxnBase64) {
      // Step 1: Decode base64
      final signedTxnBytes = base64.decode(signedTxnBase64);

      // Step 2: Extract canonical txn
      final canonicalTxnBytes = _extractCanonicalTransaction(signedTxnBytes);

      // Step 3: Prefix with "TX"
      final prefix = ascii.encode('TX');
      final prefixedBytes = Uint8List.fromList([
        ...prefix,
        ...canonicalTxnBytes,
      ]);

      // Step 4: SHA-512/256
      final digest = SHA512tDigest(32);
      digest.update(prefixedBytes, 0, prefixedBytes.length);
      final hash = Uint8List(32);
      digest.doFinal(hash, 0);

      // Step 5: Base32
      return bytesToBase32(hash);
    }).toList();
  }

  static Uint8List _extractCanonicalTransaction(Uint8List signedTxnBytes) {
    final decoded = msgpack.deserialize(signedTxnBytes);
    if (decoded is! Map || !decoded.containsKey('txn')) {
      throw ArgumentError("No 'txn' field found in signed transaction");
    }
    final txn = decoded['txn'];
    return msgpack.serialize(txn);
  }

  static String bytesToBase32(Uint8List bytes) {
    final buffer = StringBuffer();
    int bufferBits = 0;
    int bufferValue = 0;

    for (final byte in bytes) {
      bufferValue = (bufferValue << 8) | byte;
      bufferBits += 8;

      while (bufferBits >= 5) {
        final index = (bufferValue >> (bufferBits - 5)) & 0x1F;
        bufferBits -= 5;
        buffer.write(_base32Alphabet[index]);
      }
    }

    if (bufferBits > 0) {
      final index = (bufferValue << (5 - bufferBits)) & 0x1F;
      buffer.write(_base32Alphabet[index]);
    }

    return buffer.toString();
  }

  static Uint8List base32ToBytes(String base32) {
    final alphabet = _base32Alphabet;
    final alphabetMap = {
      for (var i = 0; i < alphabet.length; i++) alphabet[i]: i,
    };

    int buffer = 0;
    int bitsLeft = 0;
    final output = BytesBuilder();

    for (final char in base32.toUpperCase().split('')) {
      if (!alphabetMap.containsKey(char)) {
        throw ArgumentError('Invalid base32 character: $char');
      }

      buffer = (buffer << 5) | alphabetMap[char]!;
      bitsLeft += 5;

      if (bitsLeft >= 8) {
        bitsLeft -= 8;
        final byte = (buffer >> bitsLeft) & 0xFF;
        output.addByte(byte);
      }
    }

    return output.toBytes();
  }
}
