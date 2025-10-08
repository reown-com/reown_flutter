import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/ton/i_ton_client.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/models/ton.dart';
import 'package:reown_yttrium/reown_yttrium.dart';

class TonClient implements ITonClient {
  final IReownCore core;
  final PulseMetadataCompat pulseMetadata;

  TonClient({required this.core, required this.pulseMetadata});

  ReownYttrium get _reownYttrium => ReownYttrium();

  @override
  Future<void> init() async {
    try {
      final packageName = await ReownCoreUtils.getPackageName();
      await _reownYttrium.tonClient.init(
        projectId: core.projectId,
        networkId: '',
        pulseMetadata: pulseMetadata.copyWith(
          packageName: pulseMetadata.sdkPlatform == 'android'
              ? packageName
              : null,
          bundleId: pulseMetadata.sdkPlatform == 'ios' ? packageName : null,
        ),
      );
    } catch (e) {
      core.logger.e('[$runtimeType] $e');
    }
  }

  @override
  Future<TonKeyPair> generateKeypair() async {
    return await _reownYttrium.tonClient.generateKeypair();
  }

  @override
  Future<String> signData({
    required String text,
    required TonKeyPair keyPair,
  }) async {
    return await _reownYttrium.tonClient.signData(
      text: text,
      keyPair: keyPair,
    );
  }

  @override
  Future<String> sendMessage({
    required String network,
    required String from,
    required int validUntil,
    required List<TonMessage> messages,
    required TonKeyPair keyPair,
  }) async {
    return await _reownYttrium.tonClient.sendMessage(
      network: network,
      from: from,
      validUntil: validUntil,
      messages: messages,
      keyPair: keyPair,
    );
  }

  @override
  Future<String> broadcastMessage({
    required String from,
    required int validUntil,
    required List<TonMessage> messages,
    required TonKeyPair keyPair,
  }) async {
    return await _reownYttrium.tonClient.broadcastMessage(
      from: from,
      validUntil: validUntil,
      messages: messages,
      keyPair: keyPair,
    );
  }
}
