import 'dart:typed_data';

import 'package:bs58/bs58.dart';
import 'package:pointycastle/digests/sha256.dart';

class NearChainUtils {
  static Uint8List _bufferFromJson(List<dynamic> data) {
    return Uint8List.fromList(data.cast<int>());
  }

  static String computeNearTxHashFromWalletResponse(Map<String, dynamic> json) {
    final buffer = _bufferFromJson(json['result']['data']);
    final hash = SHA256Digest().process(buffer).toList();
    return base58.encode(Uint8List.fromList(hash));
  }
}
