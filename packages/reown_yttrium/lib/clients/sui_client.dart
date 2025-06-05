import 'package:reown_yttrium/clients/i_sui_client.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/reown_yttrium_platform_interface.dart';

class SuiClient implements ISuiClient {
  @override
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    return await ReownYttriumPlatformInterface.instance.suiChannel.init(
      projectId: projectId,
      pulseMetadata: pulseMetadata,
    );
  }
}
