import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'reown_appkit_platform_interface.dart';

/// An implementation of [ReownAppkitPlatform] that uses method channels.
class MethodChannelReownAppkit extends ReownAppkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_appkit');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
