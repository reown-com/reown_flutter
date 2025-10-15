import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/models/ton.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';

class TonClient {
  final _methodChannel = MethodChannelReownYttrium();

  Future<bool> init({
    required String projectId,
    required String networkId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final result = await _methodChannel.tonChannel.init(
        projectId: projectId,
        networkId: networkId,
        pulseMetadata: pulseMetadata,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_init $e');
      rethrow;
    }
  }

  Future<TonKeyPair> generateKeypair({required String networkId}) async {
    try {
      final result = await _methodChannel.tonChannel.generateKeypair(
        networkId: networkId,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_generateKeypair $e');
      rethrow;
    }
  }

  Future<TonKeyPair> generateKeypairFromTonMnemonic({
    required String networkId,
    required String mnemonic,
  }) async {
    try {
      final result = await _methodChannel.tonChannel
          .generateKeypairFromTonMnemonic(
            networkId: networkId,
            mnemonic: mnemonic,
          );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_generateKeypairFromTonMnemonic $e');
      rethrow;
    }
  }

  Future<TonKeyPair> generateKeypairFromBip39Mnemonic({
    required String networkId,
    required String mnemonic,
  }) async {
    try {
      final result = await _methodChannel.tonChannel
          .generateKeypairFromBip39Mnemonic(
            networkId: networkId,
            mnemonic: mnemonic,
          );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_generateKeypairFromBip39Mnemonic $e');
      rethrow;
    }
  }

  Future<TonIdentity> getAddressFromKeypair({
    required String networkId,
    required TonKeyPair keyPair,
  }) async {
    try {
      final result = await _methodChannel.tonChannel.getAddressFromKeypair(
        networkId: networkId,
        keyPair: keyPair,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_getAddressFromKeypair $e');
      rethrow;
    }
  }

  Future<String> signData({
    required String text,
    required String networkId,
    required TonKeyPair keyPair,
  }) async {
    try {
      final result = await _methodChannel.tonChannel.signData(
        text: text,
        networkId: networkId,
        keyPair: keyPair,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_signData $e');
      throw Exception(e.message);
    }
  }

  Future<String> sendMessage({
    required String networkId,
    required String from,
    required int validUntil,
    required List<TonMessage> messages,
    required TonKeyPair keyPair,
  }) async {
    try {
      final result = await _methodChannel.tonChannel.sendMessage(
        networkId: networkId,
        from: from,
        validUntil: validUntil,
        messages: messages,
        keyPair: keyPair,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_sendMessage $e');
      throw Exception(e.message);
    }
  }

  Future<String> broadcastMessage({
    required String networkId,
    required String from,
    required int validUntil,
    required List<TonMessage> messages,
    required TonKeyPair keyPair,
  }) async {
    try {
      final result = await _methodChannel.tonChannel.broadcastMessage(
        networkId: networkId,
        from: from,
        validUntil: validUntil,
        messages: messages,
        keyPair: keyPair,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_broadcastMessage $e');
      throw Exception(e.message);
    }
  }
}
