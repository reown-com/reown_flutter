import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:event/event.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/yttrium/i_rust_sign_client.dart';
import 'package:reown_core/models/rust_sign_client_models.dart';

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
  Future<SessionProposal> pair({required Uri uri}) async {
    _checkInitialized();

    final sessionProposalFfi = await _yttrium.signClient.pair(
      uri: '$uri',
    );
    final sessionProposal = SessionProposal(
      id: sessionProposalFfi.id,
      topic: sessionProposalFfi.topic,
      pairingSymKey: hex.encode(sessionProposalFfi.pairingSymKey),
      proposerPublicKey: hex.encode(sessionProposalFfi.proposerPublicKey),
      relays: sessionProposalFfi.relays.map((e) => Relay.fromJson(e)).toList(),
      requiredNamespaces: sessionProposalFfi.requiredNamespaces,
      optionalNamespaces: sessionProposalFfi.optionalNamespaces,
      metadata: PairingMetadata.fromJson(sessionProposalFfi.metadata),
      sessionProperties: sessionProposalFfi.sessionProperties,
      scopedProperties: sessionProposalFfi.scopedProperties,
      expiryTimestamp: sessionProposalFfi.expiryTimestamp ??
          ReownCoreUtils.calculateExpiry(
            ReownConstants.FIVE_MINUTES,
          ),
    );

    core.pairing.onPairingCreate.subscribe((pairingEvent) {
      if (pairingEvent.topic == sessionProposal.topic) {
        onYttriumSessionPropose.broadcast(
          YttriumSessionPropose(
            sessionProposal.topic,
            sessionProposal,
          ),
        );
      }
    });

    return sessionProposal;
  }

  @override
  Future<ApproveResult> approve({
    required SessionProposalFfi proposal,
    required Map<String, Map<String, dynamic>> approvedNamespaces,
    required Map<String, dynamic> selfMetadata,
  }) async {
    _checkInitialized();

    final approveResultFfi = await _yttrium.signClient.approve(
      proposal: proposal,
      approvedNamespaces: approvedNamespaces.map(
        (key, value) => MapEntry(key, SettleNamespaceFfi.fromJson(value)),
      ),
      selfMetadata: MetadataFfi.fromJson(selfMetadata),
    );

    return ApproveResult(
      sessionSymKey: hex.encode(approveResultFfi.sessionSymKey),
      selfPublicKey: hex.encode(approveResultFfi.selfPublicKey),
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
