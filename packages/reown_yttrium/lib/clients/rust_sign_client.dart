import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:reown_yttrium/channels/methods_channel/rust_sign_client_methods_channel.dart';
import 'package:reown_yttrium/clients/i_rust_sign_client.dart';
import 'package:reown_yttrium/clients/models/rust_sign_client.dart';
import 'package:reown_yttrium/reown_yttrium_platform_interface.dart';

class SignClient implements ISignClient {
  bool _initialized = false;

  MethodChannelSign get _methodChannelSign =>
      ReownYttriumPlatformInterface.instance.methodChannelSign;

  @override
  late Function(
    String topic,
    SessionRequestJsonRpcFfi request,
  ) onSessionRequest;

  @override
  Future<bool> init({required String projectId}) async {
    final result = await _methodChannelSign.init(
      projectId: projectId,
    );
    _initialized = result;
    return _initialized;
  }

  @override
  Future<void> initListener() async {
    if (!_initialized) {
      throw Exception('SignClient is not initialized. Call SignClient.init()');
    }
    ReownYttriumPlatformInterface.instance.eventChannelSign
      ..init()
      ..onEvent = _onRequestEvent;
  }

  void _onRequestEvent(SessionRequestNativeEvent eventRequest) {
    debugPrint('☢️ [$runtimeType] _onSessionRequest $eventRequest');
    final topic = eventRequest.topic;
    final sessionRequestJson = SessionRequestJsonRpcFfi.fromJson(jsonDecode(
      eventRequest.sessionRequest,
    ));
    onSessionRequest.call(topic, sessionRequestJson);
  }

  @override
  Future<String> generateKey() async {
    return await _methodChannelSign.generateKey();
  }

  @override
  Future<bool> setKey({required String key}) async {
    return await _methodChannelSign.setKey(
      key: key,
    );
  }

  @override
  Future<SessionProposalFfi> pair({
    required String uri,
  }) async {
    final result = await _methodChannelSign.pair(uri: uri);
    return SessionProposalFfi.fromJson(result);
  }

  @override
  Future<ApproveResultFfi> approve({
    required SessionProposalFfi proposal,
    required Map<String, SettleNamespaceFfi> approvedNamespaces,
    required MetadataFfi selfMetadata,
  }) async {
    final result = await _methodChannelSign.approve(
      proposal: proposal.toJson(),
      approvedNamespaces: approvedNamespaces.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      selfMetadata: selfMetadata.toJson(),
    );
    return ApproveResultFfi.fromJson(result);
  }

  @override
  Future<bool> reject({
    required SessionProposalFfi proposal,
    required ErrorDataFfi error,
  }) async {
    return await _methodChannelSign.reject(
      proposal: proposal.toJson(),
      reason: error.toJson(),
    );
  }
}
