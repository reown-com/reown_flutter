import 'package:reown_yttrium/clients/i_stacks_client.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/models/stacks.dart';
import 'package:reown_yttrium/reown_yttrium_platform_interface.dart';

class StacksClient implements IStacksClient {
  @override
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      return await ReownYttriumPlatformInterface.instance.stacksChannel.init(
        projectId: projectId,
        pulseMetadata: pulseMetadata,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> generateWallet() async {
    try {
      return await ReownYttriumPlatformInterface.instance.stacksChannel
          .generateWallet();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getAddress({
    required String wallet,
    required StacksVersion version,
  }) async {
    try {
      return await ReownYttriumPlatformInterface.instance.stacksChannel
          .getAddress(
        wallet: wallet,
        version: version.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signMessage({
    required String wallet,
    required String message,
  }) async {
    try {
      return await ReownYttriumPlatformInterface.instance.stacksChannel
          .signMessage(
        wallet: wallet,
        message: message,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TransferStxResponse> transferStx({
    required String wallet,
    required String network,
    required TransferStxRequest request,
  }) async {
    try {
      final response = await ReownYttriumPlatformInterface
          .instance.stacksChannel
          .transferStx(
        wallet: wallet,
        network: network,
        request: request.toJson(),
      );
      return TransferStxResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StacksAccount> getAccount({
    required String principal,
    required String network,
  }) async {
    try {
      final response =
          await ReownYttriumPlatformInterface.instance.stacksChannel.getAccount(
        principal: principal,
        network: network,
      );
      return StacksAccount.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BigInt> transferFees({required String network}) async {
    try {
      final response = await ReownYttriumPlatformInterface
          .instance.stacksChannel
          .transferFees(
        network: network,
      );
      return response;
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
  //         await ReownYttriumPlatformInterface.instance.stacksChannel.getNonce(
  //       principal: principal,
  //       network: network,
  //     );
  //     return BigInt.parse(response.toString());
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
