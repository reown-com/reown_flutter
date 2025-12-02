import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_walletkit/utils/walletkit_utils.dart';

/// An implementation that uses method channels for wallet functionality.
/// This class only handles method operations and should not be used directly.
class MethodChannelReownWalletkit {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_walletkit/methods');

  Future<bool> initialize({
    required String projectId,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('initialize', {
        'projectId': projectId,
        'metadata': metadata,
      });
      debugPrint('[$runtimeType] initialize $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] initialize $e');
      rethrow;
    }
  }

  Future<String> pair({required String uri}) async {
    try {
      final result = await methodChannel.invokeMethod<String>('pair', {
        'uri': uri,
      });
      debugPrint('[$runtimeType] pair $result');
      return WalletKitUtils.handlePlatformResult(result!);
    } catch (e) {
      debugPrint('[$runtimeType] pair $e');
      rethrow;
    }
  }

  Future<bool> approveSession({
    required String proposalPublicKey,
    required Map<String, dynamic> namespaces,
    Map<String, dynamic>? sessionProperties,
    Map<String, dynamic>? scopedProperties,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('approveSession', {
        'proposalPublicKey': proposalPublicKey,
        'namespaces': namespaces,
        'sessionProperties': sessionProperties,
        'scopedProperties': scopedProperties,
      });
      debugPrint('[$runtimeType] approveSession $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] approveSession $e');
      rethrow;
    }
  }

  Future<bool> rejectSession({
    required String proposalPublicKey,
    required String rejectionReason,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('rejectSession', {
        'proposalPublicKey': proposalPublicKey,
        'rejectionReason': rejectionReason,
      });
      debugPrint('[$runtimeType] rejectSession $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] rejectSession $e');
      rethrow;
    }
  }

  Future<bool> updateSession({
    required String topic,
    required Map<String, dynamic> namespaces,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('updateSession', {
        'topic': topic,
        'namespaces': namespaces,
      });
      debugPrint('[$runtimeType] approveSession $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] approveSession $e');
      rethrow;
    }
  }

  Future<bool> extendSession({required String topic}) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('extendSession', {
        'topic': topic,
      });
      debugPrint('[$runtimeType] extendSession $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] extendSession $e');
      rethrow;
    }
  }

  Future<bool> respondSessionRequest({
    required String topic,
    required Map<String, dynamic> response,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>(
        'respondSessionRequest',
        {'topic': topic, 'response': response},
      );
      debugPrint('[$runtimeType] respondSessionRequest $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] respondSessionRequest $e');
      rethrow;
    }
  }

  Future<bool> emitSessionEvent({
    required String topic,
    required String chainId,
    required String name,
    required String data,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>(
        'emitSessionEvent',
        {'topic': topic, 'chainId': chainId, 'name': name, 'data': data},
      );
      debugPrint('[$runtimeType] emitSessionEvent $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] emitSessionEvent $e');
      rethrow;
    }
  }

  Future<bool> disconnectSession({
    required String topic,
    required String disconnectReason,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>(
        'disconnectSession',
        {'topic': topic, 'disconnectReason': disconnectReason},
      );
      debugPrint('[$runtimeType] disconnectSession $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] disconnectSession $e');
      rethrow;
    }
  }

  Future<bool> dispatchEnvelope({required String uri}) async {
    try {
      final result = await methodChannel.invokeMethod<bool>(
        'dispatchEnvelope',
        {'uri': uri},
      );
      debugPrint('[$runtimeType] dispatchEnvelope $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] dispatchEnvelope $e');
      rethrow;
    }
  }

  Future<bool> approveSessionAuthenticate({
    required int id,
    List<Map<String, dynamic>>? auths,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>(
        'approveSessionAuthenticate',
        {'id': id, 'auths': auths},
      );
      debugPrint('[$runtimeType] approveSessionAuthenticate $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] approveSessionAuthenticate $e');
      rethrow;
    }
  }

  Future<bool> rejectSessionAuthenticate({
    required int id,
    required String rejectionReason,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>(
        'rejectSessionAuthenticate',
        {'id': id, 'rejectionReason': rejectionReason},
      );
      debugPrint('[$runtimeType] rejectSession $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] rejectSession $e');
      rethrow;
    }
  }

  Future<String> formatAuthMessage({
    required String issuer,
    required Map<String, dynamic> cacaoPayload,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'formatAuthMessage',
        {'issuer': issuer, 'payload': cacaoPayload},
      );
      debugPrint('[$runtimeType] formatAuthMessage $result');
      return result!;
    } catch (e) {
      debugPrint('[$runtimeType] formatAuthMessage $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getSessionProposals() async {
    try {
      final result = await methodChannel.invokeMethod<dynamic>(
        'getSessionProposals',
      );
      debugPrint('[$runtimeType] getSessionProposals $result');
      return WalletKitUtils.handlePlatformResult(result!);
    } catch (e) {
      debugPrint('[$runtimeType] getSessionProposals $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getPendingListOfSessionRequests({
    required String topic,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<dynamic>(
        'getPendingListOfSessionRequests',
        {'topic': topic},
      );
      debugPrint('[$runtimeType] getPendingListOfSessionRequests $result');
      return WalletKitUtils.handlePlatformResult(result!);
    } catch (e) {
      debugPrint('[$runtimeType] getPendingListOfSessionRequests $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getActiveSessionByTopic({
    required String topic,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<dynamic>(
        'getActiveSessionByTopic',
        {'topic': topic},
      );
      debugPrint('[$runtimeType] getActiveSessionByTopic $result');
      return WalletKitUtils.handlePlatformResult(result!);
    } catch (e) {
      debugPrint('[$runtimeType] getActiveSessionByTopic $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getListOfActiveSessions() async {
    try {
      final result = await methodChannel.invokeMethod<dynamic>(
        'getListOfActiveSessions',
      );
      debugPrint('[$runtimeType] getListOfActiveSessions $result');
      return WalletKitUtils.handlePlatformResult(result!);
    } catch (e) {
      debugPrint('[$runtimeType] getListOfActiveSessions $e');
      rethrow;
    }
  }
}
