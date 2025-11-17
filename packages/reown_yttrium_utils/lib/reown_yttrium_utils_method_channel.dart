import 'package:reown_yttrium_utils/channels/chain_abstraction_channel.dart';
import 'package:reown_yttrium_utils/channels/stacks_channel.dart';
import 'package:reown_yttrium_utils/channels/sui_channel.dart';
import 'package:reown_yttrium_utils/channels/ton_channel.dart';

import 'reown_yttrium_utils_platform_interface.dart';

/// An implementation of [ReownYttriumUtilsPlatform] that uses method channels.
class MethodChannelReownYttriumUtils extends ReownYttriumUtilsPlatform {
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
