import 'package:reown_yttrium/clients/chain_abstraction.dart';
import 'package:reown_yttrium/clients/i_chain_abstraction.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'reown_yttrium_platform_interface.dart';

export 'utils/signature_utils.dart';

class ReownYttrium {
  ReownYttriumPlatformInterface get _yttriumInstance =>
      ReownYttriumPlatformInterface.instance;

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    return await _yttriumInstance.init(
      projectId: projectId,
      pulseMetadata: pulseMetadata,
    );
  }

  IChainAbstractionClient get chainAbstractionClient =>
      ChainAbstractionClient();
}
