import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/utils/channel_utils.dart';

class MethodChannelSign {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> init({
    required String projectId,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('sign_init', {
        'projectId': projectId,
      });
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_init $e');
      rethrow;
    }
  }

  Future<bool> setKey({
    required String key,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('sign_setKey', key);
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_setKey $e');
      rethrow;
    }
  }

  Future<String> generateKey() async {
    try {
      final result = await methodChannel.invokeMethod<String>(
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
      final result = await methodChannel.invokeMethod<dynamic>(
        'sign_pair',
        uri,
      );
      return ChannelUtils.handlePlatformResult(result!);
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
      final params = {
        'proposal': proposal,
        'approvedNamespaces': approvedNamespaces,
        'selfMetadata': selfMetadata,
      };
      debugPrint('[$runtimeType] sign_approve, params ${jsonEncode(params)}');
      final result = await methodChannel.invokeMethod<dynamic>(
        'sign_approve',
        params,
      );
      return ChannelUtils.handlePlatformResult(result!);
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] sign_approve $e');
      rethrow;
    }
  }
}
