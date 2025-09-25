import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/utils/channel_utils.dart';

class MethodChannelSign {
  /// The method channel used to interact with the native platform.
  final _methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> init({
    required String projectId,
    required String key,
  }) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('sign_init', {
        'projectId': projectId,
        'key': key,
      });
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_init $e');
      rethrow;
    }
  }

  Future<String> generateKey() async {
    try {
      final result = await _methodChannel.invokeMethod<String>(
        'sign_generateKey',
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_generateKey $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> pair({required String uri}) async {
    try {
      final result = await _methodChannel.invokeMethod<dynamic>(
        'sign_pair',
        uri,
      );
      return ChannelUtils.handlePlatformResult(jsonDecode(result!));
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_pair $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> approve({
    required Map<String, dynamic> proposal,
    required Map<String, Map<String, dynamic>> approvedNamespaces,
    required Map<String, dynamic> selfMetadata,
  }) async {
    try {
      final result = await _methodChannel.invokeMethod<dynamic>(
        'sign_approve',
        {
          'proposal': jsonEncode(proposal),
          'approvedNamespaces': approvedNamespaces,
          'selfMetadata': jsonEncode(selfMetadata),
        },
      );
      return ChannelUtils.handlePlatformResult(jsonDecode(result!));
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_approve $e');
      rethrow;
    }
  }

  Future<bool> reject({
    required Map<String, dynamic> proposal,
    required Map<String, dynamic> reason,
  }) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'sign_reject',
        {
          'proposal': jsonEncode(proposal),
          'reason': jsonEncode(reason),
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_reject $e');
      rethrow;
    }
  }

  Future<String> respond({
    required String topic,
    required Map<String, dynamic> response,
  }) async {
    try {
      final result = await _methodChannel.invokeMethod<String>(
        'sign_respond',
        {
          'topic': topic,
          // jsonRpcResponse (result) as json String
          'result': response.containsKey('result') ? response : null,
          // jsonRpcResponse (error) as json String
          'error': response.containsKey('error') ? response : null,
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_respond $e');
      rethrow;
    }
  }
}
