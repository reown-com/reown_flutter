import 'package:flutter/foundation.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/version.dart' as wk;

import 'package:reown_yttrium/reown_yttrium.dart';

class SuiClient {
  final String projectId;
  final String networkId;

  SuiClient({required this.projectId, required this.networkId});

  Future<void> init() async {
    try {
      final packageName = await ReownCoreUtils.getPackageName();
      await ReownYttrium.suiClient.init(
        projectId: projectId,
        networkId: networkId,
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

  Future<String> generateKeyPair({required String networkId}) async {
    return await ReownYttrium.suiClient.generateKeyPair(
      networkId: networkId,
    );
  }

  Future<String> getAddressFromPublicKey({
    required String publicKey,
    required String networkId,
  }) async {
    return await ReownYttrium.suiClient.getAddressFromPublicKey(
      publicKey: publicKey,
      networkId: networkId,
    );
  }

  Future<String> getPublicKeyFromKeyPair({
    required String keyPair,
    required String networkId,
  }) async {
    return await ReownYttrium.suiClient.getPublicKeyFromKeyPair(
      keyPair: keyPair,
      networkId: networkId,
    );
  }

  Future<String> personalSign({
    required String keyPair,
    required String message,
    required String networkId,
  }) async {
    return await ReownYttrium.suiClient.personalSign(
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
    return await ReownYttrium.suiClient.signAndExecuteTransaction(
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
    return await ReownYttrium.suiClient.signTransaction(
      networkId: networkId,
      keyPair: keyPair,
      txData: txData,
    );
  }
}
