import 'package:reown_yttrium/channels/events_channel/rust_sign_client_event_channel.dart';
import 'package:reown_yttrium/channels/methods_channel/chain_abstraction_methods_channel.dart';
import 'package:reown_yttrium/channels/methods_channel/rust_sign_client_methods_channel.dart';

import 'reown_yttrium_platform_interface.dart';

/// An implementation of [ReownYttriumPlatform] that uses method channels.
class MethodChannelReownYttrium extends ReownYttriumPlatformInterface {
  @override
  MethodChannelChainAbstraction get chainAbstractionChannel =>
      MethodChannelChainAbstraction();

  @override
  MethodChannelSign get methodChannelSign => MethodChannelSign();

  @override
  EventChannelSign get eventChannelSign => EventChannelSign();
}
