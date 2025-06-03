import 'dart:convert';
import 'dart:typed_data';

import 'package:reown_core/reown_core.dart';

class SolanaChainUtils {
  static String extractSolanaSignature(String transaction) {
    late final Uint8List buffer;
    try {
      buffer = base64.decode(transaction);
    } catch (e) {
      buffer = base58.decode(transaction);
    }

    if (buffer.isEmpty) {
      throw ArgumentError('Transaction buffer is empty');
    }

    int numSignatures = buffer[0];

    if (numSignatures > 0 && buffer.length >= 65) {
      Uint8List signatureBuffer = buffer.sublist(1, 65);
      return base58.encode(signatureBuffer);
    } else {
      throw ArgumentError('No signatures found in transaction');
    }
  }
}
