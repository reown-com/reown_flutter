import 'dart:typed_data';
import 'package:reown_core/reown_core.dart';

class NearChainUtils {
  static Uint8List parseResponse(dynamic result) {
    if (result is Uint8List) {
      return result;
    } else if (result is List<int>) {
      return Uint8List.fromList(result);
    } else if (result is Map) {
      return Uint8List.fromList(result.values.cast<int>().toList());
    } else {
      throw Exception('Unexpected result type from near_signTransaction');
    }
  }

  static String computeNearHashFromTxBytes(Uint8List txData) {
    final hash = SHA256Digest().process(txData).toList();
    return base58.encode(Uint8List.fromList(hash));
  }
}
