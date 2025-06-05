import 'package:reown_yttrium/channels/chain_abstraction.dart';

import 'reown_yttrium_platform_interface.dart';

/// An implementation of [ReownYttriumPlatform] that uses method channels.
class MethodChannelReownYttrium extends ReownYttriumPlatformInterface {
  @override
  MethodChannelChainAbstraction get chainAbstractionClient =>
      MethodChannelChainAbstraction();
}
