import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MethodChannelErc6492 {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> init({
    required String projectId,
    required String networkId,
  }) async {
    try {
      final bool? result = await methodChannel.invokeMethod<bool>('erc6492_init', {
        'projectId': projectId,
        'networkId': networkId,
      });
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] erc6492_init $e');
      rethrow;
    }
  }

  Future<bool> verify({
    required String projectId,
    required String networkId,
    required String signature,
    required String address,
    required String hexStringPrefixedMessageHash,
  }) async {
    try {
      final bool? result = await methodChannel.invokeMethod<bool>('erc6492_verify', {
        'projectId': projectId,
        'networkId': networkId,
        'signature': signature,
        'address': address,
        'hexStringPrefixedMessageHash': hexStringPrefixedMessageHash,
      });
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] erc6492_verify $e');
      rethrow;
    }
  }
}
