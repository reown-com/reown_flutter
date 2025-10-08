import 'package:reown_yttrium/models/ton.dart';

abstract class ITonClient {
  Future<void> init();

  Future<TonKeyPair> generateKeypair();

  Future<String> signData({required String text, required TonKeyPair keyPair});

  Future<String> sendMessage({
    required String network,
    required String from,
    required int validUntil,
    required List<TonMessage> messages,
    required TonKeyPair keyPair,
  });

  Future<String> broadcastMessage({
    required String from,
    required int validUntil,
    required List<TonMessage> messages,
    required TonKeyPair keyPair,
  });
}
