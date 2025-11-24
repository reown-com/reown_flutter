import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';

class Erc6492VerifyClient {
  final _methodChannel = MethodChannelReownYttrium();

  Future<bool> init({
    required String projectId,
    required String networkId,
  }) async {
    try {
      final result = await _methodChannel.erc6492Channel.init(
        projectId: projectId,
        networkId: networkId,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] init $e');
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
      final result = await _methodChannel.erc6492Channel.verify(
        projectId: projectId,
        networkId: networkId,
        signature: signature,
        address: address,
        hexStringPrefixedMessageHash: hexStringPrefixedMessageHash,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] generateKeypair $e');
      rethrow;
    }
  }
}
