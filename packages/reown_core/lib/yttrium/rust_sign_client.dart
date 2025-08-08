import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:event/event.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/yttrium/i_rust_sign_client.dart';
import 'package:reown_core/yttrium/models/events.dart';

class RustSignClient implements IRustSignClient {
  bool _initialized = false;
  static const clientSeed = 'CLIENT_SEED';

  @override
  final Event<YttriumSessionPropose> onYttriumSessionPropose =
      Event<YttriumSessionPropose>();

  ReownYttrium get _yttrium => ReownYttrium();

  final IReownCore core;

  RustSignClient({required this.core});

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }
    try {
      await _yttrium.signClient.init(projectId: core.projectId);
      final pk = await _getKey();
      await _yttrium.signClient.setKey(key: pk);
      _initialized = true;
    } catch (e) {
      core.logger.e('[$runtimeType] $e');
      rethrow;
    }
  }

  @override
  Future<PairingInfo> pair({required Uri uri}) async {
    _checkInitialized();

    final URIParseResult parsedUri = ReownCoreUtils.parseUri(uri);
    if (parsedUri.version != URIVersion.v2) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'URI is not WalletConnect version 2 URI',
      );
    }

    final SessionProposalFfi proposalFfi = await _yttrium.signClient.pair(
      uri: '$uri',
    );
    final String topic = proposalFfi.topic;
    final Relay relay = Relay.fromJson(proposalFfi.relays.first);
    final int expiry = int.tryParse(proposalFfi.expiryTimestamp!) ??
        ReownCoreUtils.calculateExpiry(
          ReownConstants.FIVE_MINUTES,
        );
    final PairingInfo pairing = PairingInfo(
      topic: proposalFfi.topic,
      expiry: expiry,
      relay: relay,
      active: false,
      methods:
          parsedUri.v2Data!.methods.isEmpty ? null : parsedUri.v2Data!.methods,
    );

    await core.pairing.getStore().set(topic, pairing);
    await core.crypto.setSymKey(
      proposalFfi.pairingSymKey,
      overrideTopic: topic,
    );
    await core.relayClient.subscribe(
      options: SubscribeOptions(
        topic: topic,
      ),
    );
    await core.expirer.set(topic, expiry);

    core.pairing.onPairingCreate.broadcast(
      PairingEvent(
        topic: topic,
      ),
    );

    onYttriumSessionPropose.broadcast(
      YttriumSessionPropose(
        proposalFfi.topic,
        proposalFfi,
      ),
    );

    return pairing;
  }

  @override
  Future<ApproveResultFfi> approve({
    required SessionProposalFfi proposal,
    required Map<String, Map<String, dynamic>> approvedNamespaces,
    required Map<String, dynamic> selfMetadata,
  }) async {
    _checkInitialized();

    return await _yttrium.signClient.approve(
      proposal: proposal,
      approvedNamespaces: approvedNamespaces.map(
        (key, value) => MapEntry(key, SettleNamespaceFfi.fromJson(value)),
      ),
      selfMetadata: MetadataFfi.fromJson(selfMetadata),
    );
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  Future<String> _getKey() async {
    final seed = core.crypto.keyChain.get(clientSeed)!;
    final seedBytes = Uint8List.fromList(hex.decode(seed));
    final keyPair = await core.crypto.relayAuth.generateKeyPair(seedBytes);
    final keyBytes = keyPair.privateKeyBytes.sublist(0, 32);
    return hex.encode(keyBytes);
  }
}
