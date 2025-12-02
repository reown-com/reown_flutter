import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:reown_yttrium_utils/channels/chain_abstraction_channel.dart';
import 'package:reown_yttrium_utils/channels/stacks_channel.dart';
import 'package:reown_yttrium_utils/channels/sui_channel.dart';
import 'package:reown_yttrium_utils/channels/ton_channel.dart';

import 'reown_yttrium_utils_method_channel.dart';

abstract class ReownYttriumUtilsPlatform extends PlatformInterface {
  /// Constructs a ReownYttriumPlatform.
  ReownYttriumUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static ReownYttriumUtilsPlatform _instance = MethodChannelReownYttriumUtils();

  /// The default instance of [ReownYttriumPlatform] to use.
  ///
  /// Defaults to [MethodChannelReownYttrium].
  static ReownYttriumUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ReownYttriumPlatform] when
  /// they register themselves.
  static set instance(ReownYttriumUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  abstract final MethodChannelChainAbstraction chainAbstractionChannel;
  abstract final MethodChannelTon tonChannel;
  abstract final MethodChannelStacks stacksChannel;
  abstract final MethodChannelSui suiChannel;
}
