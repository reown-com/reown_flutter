import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/sui/i_sui_client.dart';

class SuiClient implements ISuiClient {
  final IReownCore core;
  final PulseMetadataCompat pulseMetadata;

  SuiClient({required this.core, required this.pulseMetadata});

  ReownYttrium get _reownYttrium => ReownYttrium();

  @override
  Future<void> init() async {
    try {
      final packageName = await ReownCoreUtils.getPackageName();
      await _reownYttrium.suiClient.init(
        projectId: core.projectId,
        pulseMetadata: pulseMetadata.copyWith(
          packageName:
              pulseMetadata.sdkPlatform == 'android' ? packageName : null,
          bundleId: pulseMetadata.sdkPlatform == 'ios' ? packageName : null,
        ),
      );
    } catch (e) {
      core.logger.e('[$runtimeType] $e');
    }
  }

  @override
  Future<String> generateKeyPair() async {
    return await _reownYttrium.suiClient.generateKeyPair();
  }

  @override
  Future<String> getAddressFromPublicKey({required String publicKey}) async {
    return await _reownYttrium.suiClient.getAddressFromPublicKey(
      publicKey: publicKey,
    );
  }

  @override
  Future<String> getPublicKeyFromKeyPair({required String keyPair}) async {
    return await _reownYttrium.suiClient.getPublicKeyFromKeyPair(
      keyPair: keyPair,
    );
  }

  @override
  Future<String> personalSign({
    required String keyPair,
    required String message,
  }) async {
    return await _reownYttrium.suiClient.personalSign(
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
    return await _reownYttrium.suiClient.signAndExecuteTransaction(
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
    return await _reownYttrium.suiClient.signTransaction(
      chainId: chainId,
      keyPair: keyPair,
      txData: txData,
    );
  }
}
