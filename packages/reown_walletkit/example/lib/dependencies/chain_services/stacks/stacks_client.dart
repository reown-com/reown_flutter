import 'package:flutter/foundation.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/version.dart' as wk;

import 'package:reown_yttrium/reown_yttrium.dart';

class StacksClient {
  final String projectId;
  final String networkId;

  StacksClient({required this.projectId, required this.networkId});

  Future<void> init() async {
    try {
      final packageName = await ReownCoreUtils.getPackageName();
      await ReownYttrium.stacksClient.init(
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

  Future<String> generateWallet({required String networkId}) async {
    try {
      return await ReownYttrium.stacksClient.generateWallet(
        networkId: networkId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAddress({
    required String wallet,
    required StacksVersion version,
    required String networkId,
  }) async {
    try {
      return await ReownYttrium.stacksClient.getAddress(
        wallet: wallet,
        version: version,
        networkId: networkId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signMessage({
    required String wallet,
    required String message,
    required String networkId,
  }) async {
    try {
      return await ReownYttrium.stacksClient.signMessage(
        wallet: wallet,
        message: message,
        networkId: networkId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<TransferStxResponse> transferStx({
    required String wallet,
    required String networkId,
    required TransferStxRequest request,
  }) async {
    try {
      return await ReownYttrium.stacksClient.transferStx(
        wallet: wallet,
        networkId: networkId,
        request: request,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<StacksAccount> getAccount({
    required String principal,
    required String networkId,
  }) async {
    try {
      return await ReownYttrium.stacksClient.getAccount(
        principal: principal,
        networkId: networkId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BigInt> transferFees({required String networkId}) async {
    try {
      return await ReownYttrium.stacksClient.transferFees(
        networkId: networkId,
      );
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<FeeEstimation> estimateFees({
  //   required String transaction_payload,
  //   required String network,
  // }) async {
  //   try {
  //     final response = await ReownYttriumPlatformInterface
  //         .instance.stacksChannel
  //         .estimateFees(
  //       transaction_payload: transaction_payload,
  //       network: network,
  //     );
  //     return FeeEstimation.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<BigInt> getNonce({
  //   required String principal,
  //   required String network,
  // }) async {
  //   try {
  //     final response =
  //         await _methodChannel.stacksChannel.getNonce(
  //       principal: principal,
  //       network: network,
  //     );
  //     return BigInt.parse(response.toString());
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
