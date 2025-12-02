import 'package:reown_yttrium_utils/models/shared.dart';
import 'package:reown_yttrium_utils/reown_yttrium_utils_method_channel.dart';

class SuiClient {
  final _methodChannel = MethodChannelReownYttriumUtils();

  Future<bool> init({
    required String projectId,
    required String networkId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    return await _methodChannel.suiChannel.init(
      projectId: projectId,
      networkId: networkId,
      pulseMetadata: pulseMetadata,
    );
  }

  Future<String> generateKeyPair({required String networkId}) async {
    return await _methodChannel.suiChannel.generateKeyPair(
      networkId: networkId,
    );
  }

  Future<String> getAddressFromPublicKey({
    required String publicKey,
    required String networkId,
  }) async {
    return await _methodChannel.suiChannel.getAddressFromPublicKey(
      publicKey: publicKey,
      networkId: networkId,
    );
  }

  Future<String> getPublicKeyFromKeyPair({
    required String keyPair,
    required String networkId,
  }) async {
    return await _methodChannel.suiChannel.getPublicKeyFromKeyPair(
      keyPair: keyPair,
      networkId: networkId,
    );
  }

  Future<String> personalSign({
    required String keyPair,
    required String message,
    required String networkId,
  }) async {
    return await _methodChannel.suiChannel.personalSign(
      keyPair: keyPair,
      message: message,
      networkId: networkId,
    );
  }

  Future<String> signAndExecuteTransaction({
    required String networkId,
    required String keyPair,
    required String txData,
  }) async {
    return await _methodChannel.suiChannel.signAndExecuteTransaction(
      networkId: networkId,
      keyPair: keyPair,
      txData: txData,
    );
  }

  Future<(String, String)> signTransaction({
    required String networkId,
    required String keyPair,
    required String txData,
  }) async {
    return await _methodChannel.suiChannel.signTransaction(
      networkId: networkId,
      keyPair: keyPair,
      txData: txData,
    );
  }
}
