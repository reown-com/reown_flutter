import 'package:flutter/foundation.dart';

import 'reown_walletkit_event_channel.dart';
import 'reown_walletkit_method_channel.dart';
import 'reown_walletkit_platform_interface.dart';

/// A service that composes both method and event channels for wallet functionality.
/// This approach keeps channels separate and composes them at the usage level.
class ReownWalletKitPlatformService extends ReownWalletkitPlatform {
  final MethodChannelReownWalletkit _methodChannel;
  final EventChannelReownWalletkit _eventChannel;

  ReownWalletKitPlatformService()
      : _methodChannel = MethodChannelReownWalletkit(),
        _eventChannel = EventChannelReownWalletkit();

  // Method channel operations - delegate to method channel
  @override
  Future<bool> initialize({
    required String projectId,
    required Map<String, dynamic> metadata,
  }) async {
    debugPrint('[$runtimeType] initialize - delegating to method channel');
    return await _methodChannel.initialize(
      projectId: projectId,
      metadata: metadata,
    );
  }

  @override
  Future<String> pair({required String uri}) async {
    debugPrint('[$runtimeType] pair - delegating to method channel');
    return await _methodChannel.pair(uri: uri);
  }

  @override
  Future<bool> approveSession({
    required String proposalPublicKey,
    required Map<String, dynamic> namespaces,
    Map<String, dynamic>? sessionProperties,
    Map<String, dynamic>? scopedProperties,
  }) async {
    debugPrint('[$runtimeType] approveSession - delegating to method channel');
    return await _methodChannel.approveSession(
      proposalPublicKey: proposalPublicKey,
      namespaces: namespaces,
      sessionProperties: sessionProperties,
      scopedProperties: scopedProperties,
    );
  }

  @override
  Future<bool> rejectSession({
    required String proposalPublicKey,
    required String rejectionReason,
  }) async {
    debugPrint('[$runtimeType] rejectSession - delegating to method channel');
    return await _methodChannel.rejectSession(
      proposalPublicKey: proposalPublicKey,
      rejectionReason: rejectionReason,
    );
  }

  @override
  Future<bool> updateSession({
    required String topic,
    required Map<String, dynamic> namespaces,
  }) async {
    debugPrint('[$runtimeType] updateSession - delegating to method channel');
    return await _methodChannel.updateSession(
      topic: topic,
      namespaces: namespaces,
    );
  }

  @override
  Future<bool> extendSession({required String topic}) async {
    debugPrint('[$runtimeType] extendSession - delegating to method channel');
    return await _methodChannel.extendSession(topic: topic);
  }

  @override
  Future<bool> respondSessionRequest({
    required String topic,
    required Map<String, dynamic> response,
  }) async {
    debugPrint('[$runtimeType] respondSessionRequest - delegating to method channel');
    return await _methodChannel.respondSessionRequest(
      topic: topic,
      response: response,
    );
  }

  @override
  Future<bool> emitSessionEvent({
    required String topic,
    required String chainId,
    required String name,
    required String data,
  }) async {
    debugPrint('[$runtimeType] emitSessionEvent - delegating to method channel');
    return await _methodChannel.emitSessionEvent(
      topic: topic,
      chainId: chainId,
      name: name,
      data: data,
    );
  }

  @override
  Future<bool> disconnectSession({
    required String topic,
    required String disconnectReason,
  }) async {
    debugPrint('[$runtimeType] disconnectSession - delegating to method channel');
    return await _methodChannel.disconnectSession(
      topic: topic,
      disconnectReason: disconnectReason,
    );
  }

  @override
  Future<bool> dispatchEnvelope({required String uri}) async {
    debugPrint('[$runtimeType] dispatchEnvelope - delegating to method channel');
    return await _methodChannel.dispatchEnvelope(uri: uri);
  }

  @override
  Future<bool> approveSessionAuthenticate({
    required int id,
    List<Map<String, dynamic>>? auths,
  }) async {
    debugPrint('[$runtimeType] approveSessionAuthenticate - delegating to method channel');
    return await _methodChannel.approveSessionAuthenticate(
      id: id,
      auths: auths,
    );
  }

  @override
  Future<bool> rejectSessionAuthenticate({
    required int id,
    required String rejectionReason,
  }) async {
    debugPrint('[$runtimeType] rejectSessionAuthenticate - delegating to method channel');
    return await _methodChannel.rejectSessionAuthenticate(
      id: id,
      rejectionReason: rejectionReason,
    );
  }

  @override
  Future<String> formatAuthMessage({
    required String issuer,
    required Map<String, dynamic> cacaoPayload,
  }) async {
    debugPrint('[$runtimeType] formatAuthMessage - delegating to method channel');
    return await _methodChannel.formatAuthMessage(
      issuer: issuer,
      cacaoPayload: cacaoPayload,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getSessionProposals() async {
    debugPrint('[$runtimeType] getSessionProposals - delegating to method channel');
    return await _methodChannel.getSessionProposals();
  }

  @override
  Future<List<Map<String, dynamic>>> getPendingListOfSessionRequests({
    required String topic,
  }) async {
    debugPrint('[$runtimeType] getPendingListOfSessionRequests - delegating to method channel');
    return await _methodChannel.getPendingListOfSessionRequests(topic: topic);
  }

  @override
  Future<List<Map<String, dynamic>>> getActiveSessionByTopic({
    required String topic,
  }) async {
    debugPrint('[$runtimeType] getActiveSessionByTopic - delegating to method channel');
    return await _methodChannel.getActiveSessionByTopic(topic: topic);
  }

  @override
  Future<List<Map<String, dynamic>>> getListOfActiveSessions() async {
    debugPrint('[$runtimeType] getListOfActiveSessions - delegating to method channel');
    return await _methodChannel.getListOfActiveSessions();
  }

  // Event channel operations - delegate to event channel
  @override
  Stream<dynamic> get eventStream {
    debugPrint('[$runtimeType] eventStream - delegating to event channel');
    return _eventChannel.eventStream;
  }

  @override
  void initEventChannel() {
    debugPrint('[$runtimeType] initEventChannel - delegating to event channel');
    _eventChannel.init();
  }

  // Direct access to channels if needed for advanced usage
  MethodChannelReownWalletkit get methodChannel => _methodChannel;
  EventChannelReownWalletkit get eventChannel => _eventChannel;
}
