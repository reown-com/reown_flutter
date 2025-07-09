import 'package:reown_yttrium/clients/i_sui_client.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/reown_yttrium_platform_interface.dart';

class SuiClient implements ISuiClient {
  @override
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    return await ReownYttriumPlatformInterface.instance.suiChannel.init(
      projectId: projectId,
      pulseMetadata: pulseMetadata,
    );
  }

  @override
  Future<String> generateKeyPair() async {
    return await ReownYttriumPlatformInterface.instance.suiChannel
        .generateKeyPair();
  }

  @override
  Future<String> getAddressFromPublicKey({required String publicKey}) async {
    return await ReownYttriumPlatformInterface.instance.suiChannel
        .getAddressFromPublicKey(
      publicKey: publicKey,
    );
  }

  @override
  Future<String> getPublicKeyFromKeyPair({required String keyPair}) async {
    return await ReownYttriumPlatformInterface.instance.suiChannel
        .getPublicKeyFromKeyPair(
      keyPair: keyPair,
    );
  }

  @override
  Future<String> personalSign({
    required String keyPair,
    required String message,
  }) async {
    return await ReownYttriumPlatformInterface.instance.suiChannel.personalSign(
      keyPair: keyPair,
      message: message,
    );
  }

  @override
  Future<String> signAndExecuteTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  }) async {
    return await ReownYttriumPlatformInterface.instance.suiChannel
        .signAndExecuteTransaction(
      chainId: chainId,
      keyPair: keyPair,
      txData: txData,
    );
  }

  @override
  Future<(String, String)> signTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  }) async {
    return await ReownYttriumPlatformInterface.instance.suiChannel
        .signTransaction(
      chainId: chainId,
      keyPair: keyPair,
      txData: txData,
    );
  }
}
