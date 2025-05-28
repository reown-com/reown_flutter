import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/digests/blake2b.dart';
import 'package:reown_core/reown_core.dart';

class SuiChainUtils {
  static String getSuiDigestFromEncodedTx(String base64Tx) {
    // Decode base64 to bytes
    final txBytes = base64.decode(base64Tx);

    // Convert "TransactionData::" to bytes
    final prefix = utf8.encode('TransactionData::');

    // Concatenate prefix and txBytes
    final dataWithTag = Uint8List(prefix.length + txBytes.length)
      ..setRange(0, prefix.length, prefix)
      ..setRange(prefix.length, prefix.length + txBytes.length, txBytes);

    // Blake2b hash with 32 byte output
    final digest = Blake2bDigest(digestSize: 32); // 256-bit
    final hash = digest.process(Uint8List.fromList(dataWithTag));

    // Base58 encode the result
    return base58.encode(hash);
  }
}
