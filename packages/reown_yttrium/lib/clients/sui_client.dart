import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';

class SuiClient {
  final _methodChannel = MethodChannelReownYttrium();

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    return await _methodChannel.suiChannel.init(
      projectId: projectId,
      pulseMetadata: pulseMetadata,
    );
  }

  Future<String> generateKeyPair() async {
    return await _methodChannel.suiChannel.generateKeyPair();
  }

  Future<String> getAddressFromPublicKey({required String publicKey}) async {
    return await _methodChannel.suiChannel.getAddressFromPublicKey(
      publicKey: publicKey,
    );
  }

  Future<String> getPublicKeyFromKeyPair({required String keyPair}) async {
    return await _methodChannel.suiChannel.getPublicKeyFromKeyPair(
      keyPair: keyPair,
    );
  }

  Future<String> personalSign({
    required String keyPair,
    required String message,
  }) async {
    return await _methodChannel.suiChannel.personalSign(
      keyPair: keyPair,
      message: message,
    );
  }

  Future<String> signAndExecuteTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  }) async {
    return await _methodChannel.suiChannel.signAndExecuteTransaction(
      chainId: chainId,
      keyPair: keyPair,
      txData: txData,
    );
  }

  Future<(String, String)> signTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  }) async {
    return await _methodChannel.suiChannel.signTransaction(
      chainId: chainId,
      keyPair: keyPair,
      txData: txData,
    );
  }
}
