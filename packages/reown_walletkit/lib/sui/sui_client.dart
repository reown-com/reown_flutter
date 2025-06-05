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
      await _reownYttrium.chainAbstractionClient.init(
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
}
