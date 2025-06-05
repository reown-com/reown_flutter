import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';

class MethodChannelSui {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('sui_init', {
        'projectId': projectId,
        'pulseMetadata': pulseMetadata.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] init $e');
      rethrow;
    }
  }
}
