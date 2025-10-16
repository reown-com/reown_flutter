import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/models/stacks.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';

class StacksClient {
  final _methodChannel = MethodChannelReownYttrium();

  Future<bool> init({
    required String projectId,
    required String networkId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      return await _methodChannel.stacksChannel.init(
        projectId: projectId,
        networkId: networkId,
        pulseMetadata: pulseMetadata,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> generateWallet({required String networkId}) async {
    try {
      return await _methodChannel.stacksChannel.generateWallet(
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
      return await _methodChannel.stacksChannel.getAddress(
        wallet: wallet,
        version: version.toString(),
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
      return await _methodChannel.stacksChannel.signMessage(
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
      final response = await _methodChannel.stacksChannel.transferStx(
        wallet: wallet,
        networkId: networkId,
        request: request.toJson(),
      );
      return TransferStxResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<StacksAccount> getAccount({
    required String principal,
    required String networkId,
  }) async {
    try {
      final response = await _methodChannel.stacksChannel.getAccount(
        principal: principal,
        networkId: networkId,
      );
      return StacksAccount.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BigInt> transferFees({required String networkId}) async {
    try {
      final response = await _methodChannel.stacksChannel.transferFees(
        networkId: networkId,
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
