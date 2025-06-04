import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';

import 'reown_yttrium_method_channel.dart';

abstract class ReownYttriumPlatformInterface extends PlatformInterface {
  /// Constructs a ReownYttriumPlatformInterface.
  ReownYttriumPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static ReownYttriumPlatformInterface _instance = MethodChannelReownYttrium();

  /// The default instance of [ReownYttriumPlatformInterface] to use.
  ///
  /// Defaults to [MethodChannelReownYttrium].
  static ReownYttriumPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ReownYttriumPlatformInterface] when
  /// they register themselves.
  static set instance(ReownYttriumPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  });

  abstract final MethodChannelChainAbstraction chainAbstractionClient;
}
