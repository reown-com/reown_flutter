import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/models/shared.dart';

class MethodChannelStacks {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final bool? result = await methodChannel.invokeMethod<bool>(
        'stacks_init',
        {
          'projectId': projectId,
          'pulseMetadata': pulseMetadata.toJson(),
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stacks_init $e');
      rethrow;
    }
  }

  Future<String> generateWallet() async {
    try {
      final String? result = await methodChannel.invokeMethod<String>(
        'stacks_generateWallet',
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stacks_generateWallet $e');
      rethrow;
    }
  }

  Future<String> getAddress({
    required String wallet,
    required String version,
  }) async {
    try {
      final String? result = await methodChannel.invokeMethod<String>(
        'stx_getAddress',
        {
          'wallet': wallet,
          'version': version,
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_getAddress $e');
      rethrow;
    }
  }

  Future<String> signMessage({
    required String wallet,
    required String message,
  }) async {
    try {
      final String? result = await methodChannel.invokeMethod<String>(
        'stx_signMessage',
        {
          'wallet': wallet,
          'message': message,
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_signMessage $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> transferStx({
    required String wallet,
    required String network,
    required Map<String, dynamic> request,
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMethod<Map<String, dynamic>>(
        'stx_transferStx',
        {
          'wallet': wallet,
          'network': network,
          'request': request,
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_transferStx $e');
      rethrow;
    }
  }
}
