import 'package:reown_yttrium/clients/erc6492_client.dart';
import 'reown_yttrium_platform_interface.dart';

/// An implementation of [ReownYttriumPlatform] that uses method channels.
class MethodChannelReownYttrium extends ReownYttriumPlatform {
  @override
  MethodChannelErc6492 get erc6492Channel => MethodChannelErc6492();
}
