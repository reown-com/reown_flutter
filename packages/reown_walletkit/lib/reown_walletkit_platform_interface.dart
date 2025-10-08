import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'reown_walletkit_platform_service.dart';

abstract class ReownWalletkitPlatform extends PlatformInterface {
  /// Constructs a ReownWalletkitPlatform.
  ReownWalletkitPlatform() : super(token: _token);

  static final Object _token = Object();

  static ReownWalletkitPlatform _instance = ReownWalletKitPlatformService();

  /// The default instance of [ReownWalletkitPlatform] to use.
  ///
  /// Defaults to [WalletService].
  static ReownWalletkitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ReownWalletkitPlatform] when
  /// they register themselves.
  static set instance(ReownWalletkitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Method channel operations
  Future<bool> initialize({
    required String projectId,
    required Map<String, dynamic> metadata,
  });

  Future<String> pair({required String uri});

  Future<bool> approveSession({
    required String proposalPublicKey,
    required Map<String, dynamic> namespaces,
    Map<String, dynamic>? sessionProperties,
    Map<String, dynamic>? scopedProperties,
  });

  Future<bool> rejectSession({
    required String proposalPublicKey,
    required String rejectionReason,
  });

  Future<bool> updateSession({
    required String topic,
    required Map<String, dynamic> namespaces,
  });

  Future<bool> extendSession({required String topic});

  Future<bool> respondSessionRequest({
    required String topic,
    required Map<String, dynamic> response,
  });

  Future<bool> emitSessionEvent({
    required String topic,
    required String chainId,
    required String name,
    required String data,
  });

  Future<bool> disconnectSession({
    required String topic,
    required String disconnectReason,
  });

  Future<bool> dispatchEnvelope({required String uri});

  Future<bool> approveSessionAuthenticate({
    required int id,
    List<Map<String, dynamic>>? auths,
  });

  Future<bool> rejectSessionAuthenticate({
    required int id,
    required String rejectionReason,
  });

  Future<String> formatAuthMessage({
    required String issuer,
    required Map<String, dynamic> cacaoPayload,
  });

  Future<List<Map<String, dynamic>>> getSessionProposals();

  Future<List<Map<String, dynamic>>> getPendingListOfSessionRequests({
    required String topic,
  });

  Future<List<Map<String, dynamic>>> getActiveSessionByTopic({
    required String topic,
  });

  Future<List<Map<String, dynamic>>> getListOfActiveSessions();

  // Event channel operations
  Stream<dynamic> get eventStream;
  void initEventChannel();
}
