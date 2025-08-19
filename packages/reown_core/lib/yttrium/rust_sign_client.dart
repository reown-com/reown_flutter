import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/yttrium/i_rust_sign_client.dart';
import 'package:reown_core/models/rust_sign_client_models.dart';

class RustSignClient implements IRustSignClient {
  bool _initialized = false;
  static const clientSeed = 'CLIENT_SEED';

  @override
  late Function(
    String topic,
    JsonRpcRequest payload, [
    TransportType transportType,
  ]) onSessionProposeRequest;

  @override
  late Function(
    String topic,
    JsonRpcRequest payload, [
    TransportType transportType,
  ]) onSessionRequest;

  final IReownCore core;
  final Map<String, SessionProposal> pendingProposals = {};

  RustSignClient({required this.core});

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }
    try {
      await ReownYttrium().signClient.init(projectId: core.projectId);
      await ReownYttrium().signClient.setKey(key: await _getKey());
      await ReownYttrium().signClient.initListener();
      ReownYttrium().signClient.onSessionRequest = _onSessionRequest;
      core.pairing.onPairingCreate.subscribe(_onPairingEvent);
      _initialized = true;
    } catch (e) {
      core.logger.e('[$runtimeType] $e');
      rethrow;
    }
  }

  void _onSessionRequest(String topic, SessionRequestJsonRpcFfi request) {
    core.logger.d('[$runtimeType] signClient onRequest ${request.toJson()}');
    final payload = JsonRpcRequest(
      id: request.id,
      method: request.method,
      params: {
        'chainId': request.params.chainId,
        'request': {
          'method': request.params.request.method,
          'params': jsonDecode(request.params.request.params),
        }
      },
    );
    onSessionRequest.call(topic, payload);
  }

  @override
  Future<SessionProposal> pair({required Uri uri}) async {
    _checkInitialized();

    final pairResponse = await ReownYttrium().signClient.pair(uri: '$uri');
    final sessionProposal = SessionProposal.fromFfi(pairResponse);
    pendingProposals[sessionProposal.pairingTopic] = sessionProposal;

    return sessionProposal;
  }

  void _onPairingEvent(PairingEvent pairingEvent) {
    // TODO could it be id instead of topic?
    if (pendingProposals.containsKey(pairingEvent.topic)) {
      final sessionProposal = pendingProposals[pairingEvent.topic]!;
      pendingProposals.remove(pairingEvent.topic);
      onSessionProposeRequest.call(
        sessionProposal.pairingTopic,
        JsonRpcRequest(
          id: sessionProposal.id,
          method: MethodConstants.WC_SESSION_PROPOSE,
          params: {
            ...sessionProposal.toJson(),
            'proposer': {
              'publicKey': sessionProposal.proposerPublicKey,
              'metadata': sessionProposal.metadata,
            },
          },
        ),
      );
    }
  }

  @override
  Future<ApproveResult> approve({
    required SessionProposalFfi proposal,
    required Map<String, Map<String, dynamic>> approvedNamespaces,
    required Map<String, dynamic> selfMetadata,
  }) async {
    _checkInitialized();

    final approveResponse = await ReownYttrium().signClient.approve(
          proposal: proposal,
          approvedNamespaces: approvedNamespaces.map(
            (key, value) => MapEntry(key, SettleNamespaceFfi.fromJson(value)),
          ),
          selfMetadata: MetadataFfi.fromJson(selfMetadata),
        );

    return ApproveResult.fromFfi(approveResponse);
  }

  @override
  Future<bool> reject({
    required SessionProposalFfi proposal,
    required ErrorDataFfi error,
  }) async {
    _checkInitialized();

    return await ReownYttrium().signClient.reject(
          proposal: proposal,
          error: error,
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
