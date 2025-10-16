import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/models/stacks.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';

class StacksClient {
  final _methodChannel = MethodChannelReownYttrium();

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      return await _methodChannel.stacksChannel.init(
        projectId: projectId,
        pulseMetadata: pulseMetadata,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> generateWallet() async {
    try {
      return await _methodChannel.stacksChannel.generateWallet();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAddress({
    required String wallet,
    required StacksVersion version,
  }) async {
    try {
      return await _methodChannel.stacksChannel.getAddress(
        wallet: wallet,
        version: version.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signMessage({
    required String wallet,
    required String message,
  }) async {
    try {
      return await _methodChannel.stacksChannel.signMessage(
        wallet: wallet,
        message: message,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<TransferStxResponse> transferStx({
    required String wallet,
    required String network,
    required TransferStxRequest request,
  }) async {
    try {
      final response = await _methodChannel.stacksChannel.transferStx(
        wallet: wallet,
        network: network,
        request: request.toJson(),
      );
      return TransferStxResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<StacksAccount> getAccount({
    required String principal,
    required String network,
  }) async {
    try {
      final response = await _methodChannel.stacksChannel.getAccount(
        principal: principal,
        network: network,
      );
      return StacksAccount.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BigInt> transferFees({required String network}) async {
    try {
      final response = await _methodChannel.stacksChannel.transferFees(
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
