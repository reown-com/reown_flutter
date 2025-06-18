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
      rethrow;
    }
  }
}
