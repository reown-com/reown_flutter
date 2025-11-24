import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium_utils/models/shared.dart';

class MethodChannelSui {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium_utils');

  Future<bool> init({
    required String projectId,
    required String networkId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('sui_init', {
        'projectId': projectId,
        'networkId': networkId,
        'pulseMetadata': pulseMetadata.toJson(),
      });
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sui_init $e');
      rethrow;
    }
  }

  Future<String> generateKeyPair({required String networkId}) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'sui_generateKeyPair',
        {'networkId': networkId},
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sui_generateKeyPair $e');
      rethrow;
    }
  }

  Future<String> getPublicKeyFromKeyPair({
    required String keyPair,
    required String networkId,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'sui_getPublicKeyFromKeyPair',
        {'keyPair': keyPair, 'networkId': networkId},
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sui_getPublicKeyFromKeyPair $e');
      rethrow;
    }
  }

  Future<String> getAddressFromPublicKey({
    required String publicKey,
    required String networkId,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'sui_getAddressFromPublicKey',
        {'publicKey': publicKey, 'networkId': networkId},
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sui_getAddressFromPublicKey $e');
      rethrow;
    }
  }

  Future<String> personalSign({
    required String keyPair,
    required String message,
    required String networkId,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'sui_personalSign',
        {
          'keyPair': keyPair,
          'message': message, // base64 encoded message
          'networkId': networkId,
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sui_personalSign $e');
      rethrow;
    }
  }

  Future<(String, String)> signTransaction({
    required String networkId,
    required String keyPair,
    required String txData,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<dynamic>(
        'sui_signTransaction',
        {
          'networkId': networkId,
          'keyPair': keyPair,
          'txData': txData, // base64 encoded txData
        },
      );
      final resultMap = result as Map<Object?, Object?>;
      final signature = resultMap['signature'].toString();
      final transactionBytes = resultMap['transactionBytes'].toString();
      return (signature, transactionBytes);
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sui_signTransaction $e');
      rethrow;
    }
  }

  Future<String> signAndExecuteTransaction({
    required String networkId,
    required String keyPair,
    required String txData,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'sui_signAndExecuteTransaction',
        {
          'networkId': networkId,
          'keyPair': keyPair,
          'txData': txData, // base64 encoded txData
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sui_signAndExecuteTransaction $e');
      rethrow;
    }
  }
}
