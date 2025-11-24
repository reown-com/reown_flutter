import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:reown_yttrium/clients/erc6492_client.dart';

import 'reown_yttrium_method_channel.dart';

abstract class ReownYttriumPlatform extends PlatformInterface {
  /// Constructs a ReownYttriumPlatform.
  ReownYttriumPlatform() : super(token: _token);

  static final Object _token = Object();

  static ReownYttriumPlatform _instance = MethodChannelReownYttrium();

  /// The default instance of [ReownYttriumPlatform] to use.
  ///
  /// Defaults to [MethodChannelReownYttrium].
  static ReownYttriumPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ReownYttriumPlatform] when
  /// they register themselves.
  static set instance(ReownYttriumPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  abstract final MethodChannelErc6492 erc6492Channel;
}
