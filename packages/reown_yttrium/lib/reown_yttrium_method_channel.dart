import 'package:reown_yttrium/channels/chain_abstraction_channel.dart';
import 'package:reown_yttrium/channels/stacks_channel.dart';
import 'package:reown_yttrium/channels/sui_channel.dart';
import 'package:reown_yttrium/channels/ton_channel.dart';

import 'reown_yttrium_platform_interface.dart';

/// An implementation of [ReownYttriumPlatform] that uses method channels.
class MethodChannelReownYttrium extends ReownYttriumPlatform {
  @override
  MethodChannelChainAbstraction get chainAbstractionChannel =>
      MethodChannelChainAbstraction();

  @override
  MethodChannelTon get tonChannel => MethodChannelTon();

  @override
  MethodChannelStacks get stacksChannel => MethodChannelStacks();

  @override
  MethodChannelSui get suiChannel => MethodChannelSui();
}
