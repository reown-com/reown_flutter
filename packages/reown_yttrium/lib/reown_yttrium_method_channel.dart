import 'package:reown_yttrium/channels/chain_abstraction_channel.dart';
import 'package:reown_yttrium/channels/rust_sign_client_channel.dart';

import 'reown_yttrium_platform_interface.dart';

/// An implementation of [ReownYttriumPlatform] that uses method channels.
class MethodChannelReownYttrium extends ReownYttriumPlatformInterface {
  @override
  MethodChannelChainAbstraction get chainAbstractionChannel =>
      MethodChannelChainAbstraction();

  @override
  MethodChannelSign get signChannel => MethodChannelSign();
}
