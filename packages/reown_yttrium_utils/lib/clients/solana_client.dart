import 'dart:typed_data';

import 'package:reown_yttrium_utils/reown_yttrium_utils_method_channel.dart';

class SolanaClient {
  final _methodChannel = MethodChannelReownYttriumUtils();

  Future<String> generateKeyPair() async {
    return await _methodChannel.solanaChannel.generateKeyPair();
  }

  Future<String> getPublicKey({required String keyPair}) async {
    return await _methodChannel.solanaChannel.getPublicKey(keyPair: keyPair);
  }

  Future<({String transaction, String signature})> signTransaction({
    required String keyPair,
    required String transaction,
  }) async {
    return await _methodChannel.solanaChannel.signTransaction(
      keyPair: keyPair,
      transaction: transaction,
    );
  }

  Future<List<({String transaction, String signature})>> signAllTransactions({
    required String keyPair,
    required List<String> transactions,
  }) async {
    return await _methodChannel.solanaChannel.signAllTransactions(
      keyPair: keyPair,
      transactions: transactions,
    );
  }

  Future<String> signMessage({
    required String keyPair,
    required Uint8List message,
  }) async {
    return await _methodChannel.solanaChannel.signMessage(
      keyPair: keyPair,
      message: message,
    );
  }
}
