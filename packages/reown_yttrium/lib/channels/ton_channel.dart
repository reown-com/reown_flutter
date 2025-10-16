import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/models/ton.dart';
import 'package:reown_yttrium/utils/channel_utils.dart';

class MethodChannelTon {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> init({
    required String projectId,
    required String networkId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final bool? result = await methodChannel.invokeMethod<bool>('ton_init', {
        'projectId': projectId,
        'networkId': _chainMapper[networkId],
        'pulseMetadata': pulseMetadata.toJson(),
      });
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_init $e');
      rethrow;
    }
  }

  Future<TonKeyPair> generateKeypair({required String networkId}) async {
    try {
      final dynamic result = await methodChannel.invokeMethod<dynamic>(
        'ton_generateKeypair',
        {'networkId': _chainMapper[networkId]},
      );
      final parsedResult = ChannelUtils.handlePlatformResult(result);
      return TonKeyPair.fromJson(parsedResult);
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
      final dynamic result = await methodChannel.invokeMethod<dynamic>(
        'ton_generateKeypairFromTonMnemonic',
        {'mnemonic': mnemonic, 'networkId': _chainMapper[networkId]},
      );
      final parsedResult = ChannelUtils.handlePlatformResult(result);
      return TonKeyPair.fromJson(parsedResult);
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
      final dynamic result = await methodChannel.invokeMethod<dynamic>(
        'ton_generateKeypairFromBip39Mnemonic',
        {'mnemonic': mnemonic, 'networkId': _chainMapper[networkId]},
      );
      final parsedResult = ChannelUtils.handlePlatformResult(result);
      return TonKeyPair.fromJson(parsedResult);
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
      final dynamic result = await methodChannel.invokeMethod<dynamic>(
        'ton_getAddressFromKeypair',
        {
          'networkId': _chainMapper[networkId],
          'sk': keyPair.sk,
          'pk': keyPair.pk,
        },
      );
      final parsedResult = ChannelUtils.handlePlatformResult(result);
      return TonIdentity.fromJson(parsedResult);
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
      final String? result = await methodChannel
          .invokeMethod<String>('ton_signData', {
            'networkId': _chainMapper[networkId],
            'text': text,
            'sk': keyPair.sk,
            'pk': keyPair.pk,
          });
      return result!;
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
      final String? result = await methodChannel
          .invokeMethod<dynamic>('ton_sendMessage', {
            'networkId': _chainMapper[networkId],
            'from': from,
            'validUntil': validUntil,
            'messages': messages.map((e) => e.toJson()).toList(),
            'sk': keyPair.sk,
            'pk': keyPair.pk,
          });
      return result!;
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
      final String? result = await methodChannel
          .invokeMethod<dynamic>('ton_broadcastMessage', {
            'networkId': _chainMapper[networkId],
            'from': from,
            'validUntil': validUntil,
            'messages': messages.map((e) => e.toJson()),
            'sk': keyPair.sk,
            'pk': keyPair.pk,
          });
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] ton_broadcastMessage $e');
      throw Exception(e.message);
    }
  }

  final Map<String, String> _chainMapper = {
    'ton:-239': 'ton:mainnet',
    'ton:mainnet': 'ton:mainnet',
    'ton:-3': 'ton:testnet',
    'ton:testnet': 'ton:testnet',
  };
}
