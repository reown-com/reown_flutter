import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/stacks/i_stacks_client.dart';

class StacksClient implements IStacksClient {
  final IReownCore core;
  final PulseMetadataCompat pulseMetadata;

  StacksClient({required this.core, required this.pulseMetadata});

  ReownYttrium get _reownYttrium => ReownYttrium();

  @override
  Future<void> init() async {
    try {
      final packageName = await ReownCoreUtils.getPackageName();
      await _reownYttrium.stacksClient.init(
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

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  @override
  Future<String> generateWallet() async {
    try {
      return await _reownYttrium.stacksClient.generateWallet();
    } catch (e) {
      core.logger.e('[$runtimeType] generateWallet $e');
      rethrow;
    }
  }

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  @override
  Future<String> getAddress({
    required String wallet,
    required StacksVersion version,
  }) async {
    try {
      return await _reownYttrium.stacksClient.getAddress(
        wallet: wallet,
        version: version,
      );
    } catch (e) {
      core.logger.e('[$runtimeType] getAddress $e');
      rethrow;
    }
  }

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  @override
  Future<String> signMessage({
    required String wallet,
    required String message,
  }) async {
    try {
      return await _reownYttrium.stacksClient.signMessage(
        wallet: wallet,
        message: message,
      );
    } catch (e) {
      core.logger.e('[$runtimeType] signMessage $e');
      final jsonError = RegExp(r'({.*})').firstMatch(e.toString())?.group(1);
      if (jsonError != null) {
        throw JsonRpcError(code: 0, message: jsonError);
      }
      rethrow;
    }
  }

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  @override
  Future<TransferStxResponse> transferStx({
    required String wallet,
    required String network,
    required TransferStxRequest request,
  }) async {
    try {
      return await _reownYttrium.stacksClient.transferStx(
        wallet: wallet,
        network: network,
        request: request,
      );
    } catch (e) {
      core.logger.e('[$runtimeType] transferStx $e');
      final jsonError = RegExp(r'({.*})').firstMatch(e.toString())?.group(1);
      if (jsonError != null) {
        throw JsonRpcError(code: 0, message: jsonError);
      }
      rethrow;
    }
  }

  @override
  Future<StacksAccount> getAccount({
    required String principal,
    required String network,
  }) async {
    try {
      return await _reownYttrium.stacksClient.getAccount(
        principal: principal,
        network: network,
      );
    } catch (e) {
      core.logger.e('[$runtimeType] getAccount $e');
      final jsonError = RegExp(r'({.*})').firstMatch(e.toString())?.group(1);
      if (jsonError != null) {
        throw JsonRpcError(code: 0, message: jsonError);
      }
      rethrow;
    }
  }

  @override
  Future<FeeEstimation> estimateFees({
    required String transaction_payload,
    required String network,
  }) async {
    try {
      return await _reownYttrium.stacksClient.estimateFees(
        transaction_payload: transaction_payload,
        network: network,
      );
    } catch (e) {
      core.logger.e('[$runtimeType] estimateFees $e');
      final jsonError = RegExp(r'({.*})').firstMatch(e.toString())?.group(1);
      if (jsonError != null) {
        throw JsonRpcError(code: 0, message: jsonError);
      }
      rethrow;
    }
  }
}
