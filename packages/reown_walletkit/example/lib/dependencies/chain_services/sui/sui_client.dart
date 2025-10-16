import 'package:flutter/foundation.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/version.dart' as wk;

import 'package:reown_yttrium/reown_yttrium.dart';

class SuiClient {
  final String projectId;

  SuiClient({required this.projectId});

  Future<void> init() async {
    try {
      final packageName = await ReownCoreUtils.getPackageName();
      await ReownYttrium.suiClient.init(
        projectId: projectId,
        pulseMetadata: PulseMetadataCompat(
          sdkVersion: wk.packageVersion,
          sdkPlatform: ReownCoreUtils.getId(),
          packageName: ReownCoreUtils.getId() == 'android' ? packageName : null,
          bundleId: ReownCoreUtils.getId() == 'ios' ? packageName : null,
        ),
      );
    } catch (e) {
      debugPrint('❌ [$runtimeType] $e');
    }
  }

  Future<String> generateKeyPair() async {
    return await ReownYttrium.suiClient.generateKeyPair();
  }

  Future<String> getAddressFromPublicKey({required String publicKey}) async {
    return await ReownYttrium.suiClient.getAddressFromPublicKey(
      publicKey: publicKey,
    );
  }

  Future<String> getPublicKeyFromKeyPair({required String keyPair}) async {
    return await ReownYttrium.suiClient.getPublicKeyFromKeyPair(
      keyPair: keyPair,
    );
  }

  Future<String> personalSign({
    required String keyPair,
    required String message,
  }) async {
    return await ReownYttrium.suiClient.personalSign(
      keyPair: keyPair,
      message: message,
    );
  }

  Future<String> signAndExecuteTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  }) async {
    return await ReownYttrium.suiClient.signAndExecuteTransaction(
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
    return await ReownYttrium.suiClient.signTransaction(
      chainId: chainId,
      keyPair: keyPair,
      txData: txData,
    );
  }
}
