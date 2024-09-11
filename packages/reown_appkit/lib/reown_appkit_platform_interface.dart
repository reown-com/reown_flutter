import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'reown_appkit_method_channel.dart';

abstract class ReownAppkitPlatform extends PlatformInterface {
  /// Constructs a ReownAppkitPlatform.
  ReownAppkitPlatform() : super(token: _token);

  static final Object _token = Object();

  static ReownAppkitPlatform _instance = MethodChannelReownAppkit();

  /// The default instance of [ReownAppkitPlatform] to use.
  ///
  /// Defaults to [MethodChannelReownAppkit].
  static ReownAppkitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ReownAppkitPlatform] when
  /// they register themselves.
  static set instance(ReownAppkitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
