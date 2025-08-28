import 'dart:async';
import 'dart:convert';

import 'package:event/event.dart';
import 'package:collection/collection.dart';

import 'package:reown_core/reown_core.dart' hide ErrorEvent;
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_pos/i_reown_pos_impl.dart';
import 'package:reown_pos/models/events.dart';
import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_pos/services/blockchain_service.dart';
import 'package:reown_pos/utils/caip_validator.dart';
import 'package:reown_pos/utils/extensions.dart';
import 'package:reown_sign/reown_sign.dart';

export 'package:reown_core/reown_core.dart';
export 'package:reown_sign/reown_sign.dart';

class ReownPos implements IReownPos {
  bool _initialized = false;

  @override
  IReownSign? reOwnSign;

  @override
  final Event<PosEvent> onPosEvent = Event();

  // late final Map<String, dynamic> _initParams;
  IReownCore? _reOwnCore;
  final Map<String, RequiredNamespace> _sessionNamespaces = {};
  PaymentIntent? _pendingIntent;
  Completer<String> _statusCheckCompleter = Completer<String>();

  ReownPos({
    required String projectId,
    required String deviceId, // to be used with blockchain api methods
    required Metadata metadata,
    LogLevel logLevel = LogLevel.all,
  }) {
    // _initParams = Map.from({
    //   'projectId': projectId,
    //   'deviceId': deviceId,
    //   ...metadata.toJson(),
    // });
    _reOwnCore = ReownCore(projectId: projectId, logLevel: logLevel);
    reOwnSign = ReownSign(
      core: _reOwnCore!,
      metadata: PairingMetadata(
        name: metadata.merchantName,
        description: metadata.description,
        icons: [metadata.logoIcon],
        url: metadata.url,
      ),
      proposals: GenericStore(
        storage: _reOwnCore!.storage,
        context: StoreVersions.CONTEXT_PROPOSALS,
        version: StoreVersions.VERSION_PROPOSALS,
        fromJson: (dynamic value) {
          return ProposalData.fromJson(value);
        },
      ),
      sessions: Sessions(
        storage: _reOwnCore!.storage,
        context: StoreVersions.CONTEXT_SESSIONS,
        version: StoreVersions.VERSION_SESSIONS,
        fromJson: (dynamic value) {
          return SessionData.fromJson(value);
        },
      ),
      pendingRequests: GenericStore(
        storage: _reOwnCore!.storage,
        context: StoreVersions.CONTEXT_PENDING_REQUESTS,
        version: StoreVersions.VERSION_PENDING_REQUESTS,
        fromJson: (dynamic value) {
          return SessionRequest.fromJson(value);
        },
      ),
      authKeys: GenericStore(
        storage: _reOwnCore!.storage,
        context: StoreVersions.CONTEXT_AUTH_KEYS,
        version: StoreVersions.VERSION_AUTH_KEYS,
        fromJson: (dynamic value) {
          return AuthPublicKey.fromJson(value);
        },
      ),
      pairingTopics: GenericStore(
        storage: _reOwnCore!.storage,
        context: StoreVersions.CONTEXT_PAIRING_TOPICS,
        version: StoreVersions.VERSION_PAIRING_TOPICS,
        fromJson: (dynamic value) {
          return value;
        },
      ),
      sessionAuthRequests: GenericStore(
        storage: _reOwnCore!.storage,
        context: StoreVersions.CONTEXT_AUTH_REQUESTS,
        version: StoreVersions.VERSION_AUTH_REQUESTS,
        fromJson: (dynamic value) {
          return PendingSessionAuthRequest.fromJson(value);
        },
      ),
    );

    _registerListeners();
  }

  @override
  Future<void> init() async {
    try {
      if (_initialized) {
        return;
      }

      await _reOwnCore!.start();
      await reOwnSign!.init();

      // TODO check on this
      for (var session in reOwnSign!.sessions.getAll()) {
        // if (!pairing.active) {
        await reOwnSign!.disconnectSession(
          topic: session.topic,
          reason: ReownSignError(code: 6000, message: 'POS disconnected'),
        );
        // }
      }
      for (var pairing in reOwnSign!.pairings.getAll()) {
        // if (!pairing.active) {
        await reOwnSign!.core.expirer.expire(pairing.topic);
        // }
      }

      _reOwnCore!.logger.i('[$runtimeType] initialized');
      _initialized = true;
    } catch (e) {
      _reOwnCore!.logger.e('[$runtimeType] init error: $e');
      rethrow;
    }
  }

  // @override
  // void setChains({required List<PosNetwork> chains}) {
  //   if (chains.isEmpty) {
  //     throw Errors.getSdkError(
  //       Errors.MISSING_OR_INVALID,
  //       context: 'No chainIds provided',
  //     ).toSignError();
  //   }

  //   // for (var chain in chains) {
  //   //   if (!NamespaceUtils.isValidChainId(chainId)) {
  //   //     throw Errors.getSdkError(
  //   //       Errors.UNSUPPORTED_CHAINS,
  //   //       context: 'chainId should conform to "CAIP-2" format',
  //   //     ).toSignError();
  //   //   }

  //   //   if (!chainId.startsWith('eip155')) {
  //   //     throw Errors.getSdkError(
  //   //       Errors.UNSUPPORTED_CHAINS,
  //   //       context:
  //   //           'Only EVM chains are supported, please provide eip155 chains',
  //   //     ).toSignError();
  //   //   }
  //   // }

  //   _reOwnCore!.logger.i('[$runtimeType] set chains $chains');
  //   _setNamespaces(chains);
  // }

  @override
  void setTokens({required List<PosToken> tokens}) {
    if (tokens.isEmpty) {
      throw Errors.getSdkError(
        Errors.MISSING_OR_INVALID,
        context: 'No tokens provided',
      ).toSignError();
    }

    _reOwnCore!.logger.i('[$runtimeType] set tokens $tokens');

    final chains = tokens.map((e) => e.network).toList();
    _setNamespaces(chains);
  }

  @override
  Future<void> createPaymentIntent({
    required List<PaymentIntent> paymentIntents,
  }) async {
    if (_sessionNamespaces.isEmpty) {
      throw StateError('No chains set, call setChains method first');
    }
    if (paymentIntents.isEmpty) {
      throw StateError('No payment intents provided');
    }

    _pendingIntent = paymentIntents.first.toCAIP();
    _isValidPaymentIntent(_pendingIntent!);
    _reOwnCore!.logger.d('[$runtimeType] intents $_pendingIntent');

    try {
      // final CreateResponse pairing = await reOwnSign!.core.pairing.create();
      // reOwnSign!.core.logger.d('[$runtimeType] pairing: $pairing');

      final ConnectResponse connect = await reOwnSign!.connect(
        optionalNamespaces: _sessionNamespaces,
        // pairingTopic: pairing.topic,
      );
      _reOwnCore!.logger.d('[$runtimeType] connect: ${connect.uri}');

      onPosEvent.broadcast(QrReadyEvent(connect.uri!));

      // We can await the session or we can listen to onSessionConnected
      // final connectedSession = await connect.session.future;
    } on JsonRpcError catch (e) {
      _reOwnCore!.logger.e(
        '[$runtimeType] createPaymentIntent JsonRpcError: $e',
      );
      if (e.isUserRejected) {
        // TODO User rejected session is not coming from connect method rather from relay
        onPosEvent.broadcast(ConnectRejectedEvent());
      } else {
        onPosEvent.broadcast(ConnectFailedEvent(e.message ?? ''));
      }
    } on ReownCoreError catch (e) {
      _reOwnCore!.logger.e(
        '[$runtimeType] createPaymentIntent ReownCoreError: $e',
      );
      onPosEvent.broadcast(ConnectFailedEvent(e.message));
    } catch (e, s) {
      _reOwnCore!.logger.e('[$runtimeType] createPaymentIntent error: $e, $s');
      onPosEvent.broadcast(ConnectFailedEvent(e.toString()));
    }
  }

  @override
  Future<void> dispose() async {
    // Complete any pending status check completer to prevent hanging
    _safeCompleteStatus();
    _sessionNamespaces.clear();
    _pendingIntent = null;
    // _initialized = false;
  }
}

// listener handlers
extension _SessionListeners on ReownPos {
  void _onSessionConnect(SessionConnect? event) async {
    final json = jsonEncode(event?.session.toJson());
    reOwnSign!.core.logger.i('[$runtimeType] event: onSessionConnect, $json');
    onPosEvent.broadcast(ConnectedEvent());

    final approvedSession = event!.session;
    final chainId = _pendingIntent!.chainId;

    final namespace = _sessionNamespaces.values.firstWhereOrNull((_) => true);
    if (namespace == null) {
      throw StateError('No namespace available');
    }

    // TODO `method` is returned by the api endpoing _reownPosBuildTransaction, is this needed?
    final method = namespace.methods.firstWhereOrNull((_) => true);
    if (method == null) {
      throw StateError('No method available');
    }

    final senderAddress = approvedSession.getSenderCaip10Account(chainId);
    if (senderAddress == null) {
      throw StateError(
        "No matching account found for chain ${_pendingIntent!.chainId}",
      );
    }

    try {
      // Blockchain API call
      final response = await BlockchainService.reownPosBuildTransaction(
        token: _pendingIntent!.token,
        recipient: _pendingIntent!.recipient,
        amount: _pendingIntent!.amount,
        sender: senderAddress,
        projectId: _reOwnCore!.projectId,
      );
      _reOwnCore!.logger.d('[$runtimeType] api response ${response.result}');
      final String receiptId = ReownCoreUtils.recursiveSearchForMapKey(
        response.result,
        'id',
      );
      final payload = ReownCoreUtils.recursiveSearchForMapKey(
        response.result,
        'transactionRpc',
      );
      final List<dynamic> params = ReownCoreUtils.recursiveSearchForMapKey(
        payload,
        'params',
      );
      final String method = ReownCoreUtils.recursiveSearchForMapKey(
        payload,
        'method',
      );

      reOwnSign!.core.logger.i('[$runtimeType] sending request to wallet');
      final futureTxHash = reOwnSign!.request(
        topic: approvedSession.topic,
        chainId: _pendingIntent!.chainId,
        request: SessionRequestParams(method: method, params: params),
      );
      onPosEvent.broadcast(PaymentRequestedEvent());

      final txHash = await futureTxHash;

      onPosEvent.broadcast(PaymentBroadcastedEvent());

      _statusCheckCompleter = Completer<String>();
      _loopOnStatusCheck(receiptId, txHash);
      final status = await _statusCheckCompleter.future;
      if (status == 'CONFIRMED') {
        onPosEvent.broadcast(PaymentSuccessfulEvent(txHash));
      } else if (status == 'FAILED') {
        onPosEvent.broadcast(PaymentFailedEvent('Transaction failed'));
      } else if (status == 'TIMEOUT') {
        onPosEvent.broadcast(PaymentFailedEvent('Failed to check status'));
      }
      // other statuses are handled inside the loop
    } on JsonRpcError catch (e) {
      if (e.isUserRejected) {
        // User rejected payment
        onPosEvent.broadcast(PaymentRejectedEvent());
      } else {
        reOwnSign!.core.logger.e('[$runtimeType] JsonRpcError, $e');
        onPosEvent.broadcast(PaymentFailedEvent(e.message ?? ''));
      }
    } on ReownCoreError catch (e) {
      reOwnSign!.core.logger.e('[$runtimeType] ReownCoreError, $e');
      onPosEvent.broadcast(PaymentFailedEvent(e.message));
    } catch (e, s) {
      _reOwnCore!.logger.e('[$runtimeType] createPaymentIntent error: $e, $s');
      onPosEvent.broadcast(PaymentFailedEvent(e.toString()));
    }

    // Complete the completer to prevent hanging
    _safeCompleteStatus();

    // disconnect the session when completing payment
    reOwnSign!.core.logger.d('[$runtimeType] disconnecting session');
    await reOwnSign!.disconnectSession(
      topic: approvedSession.topic,
      reason: ReownSignError(code: 6000, message: 'POS disconnected'),
    );
  }

  void _onSessionDelete(SessionDelete? event) async {
    reOwnSign!.core.logger.i('[$runtimeType] event: onSessionDelete, $event');
    await dispose();
    onPosEvent.broadcast(DisconnectedEvent());
  }

  void _onSessionExpire(SessionExpire? event) async {
    reOwnSign!.core.logger.i('[$runtimeType] event: onSessionExpire, $event');
  }

  void _onSessionEvent(SessionEvent? event) {
    reOwnSign!.core.logger.i('[$runtimeType] event: onSessionEvent, $event');
  }

  void _onSessionUpdate(SessionUpdate? event) {
    reOwnSign!.core.logger.i('[$runtimeType] event: onSessionUpdate, $event');
  }

  void _onSessionProposalError(SessionProposalErrorEvent? event) {
    reOwnSign!.core.logger.i(
      '[$runtimeType] event: onSessionProposalError, $event',
    );
  }
}

extension _PrivateMembers on ReownPos {
  void _setNamespaces(List<PosNetwork> chains) {
    final evmChains = chains
        .where((chain) => chain.networkData.chainId.startsWith('eip155'))
        .toSet()
        .toList();
    if (evmChains.isNotEmpty) {
      _sessionNamespaces['eip155'] = RequiredNamespace(
        chains: evmChains.map((chain) => chain.networkData.chainId).toList(),
        methods: ['eth_sendTransaction'],
        events: ['chainChanged', 'accountsChanged'],
      );
    }

    reOwnSign!.core.logger.d(
      '[$runtimeType] namespaces: ${jsonEncode(_sessionNamespaces)}}',
    );
  }

  void _registerListeners() {
    reOwnSign!.onSessionConnect.subscribe(_onSessionConnect);
    reOwnSign!.onSessionDelete.subscribe(_onSessionDelete);
    reOwnSign!.onSessionExpire.subscribe(_onSessionExpire);
    reOwnSign!.onSessionEvent.subscribe(_onSessionEvent);
    reOwnSign!.onSessionUpdate.subscribe(_onSessionUpdate);
    reOwnSign!.onSessionProposalError.subscribe(_onSessionProposalError);
    // TODO implement
    // reOwnSign!.core.relayClient.onRelayClientConnect.subscribe(
    //   _onRelayClientConnect,
    // );
    // reOwnSign!.core.relayClient.onRelayClientError.subscribe(
    //   _onRelayClientError,
    // );
    // reOwnSign!.core.relayClient.onRelayClientDisconnect.subscribe(
    //   _onRelayClientDisconnect,
    // );
    // reOwnSign!.core.connectivity.isOnline.addListener(_connectivityListener);
  }

  void _loopOnStatusCheck(String receiptId, String txHash) async {
    int maxAttempts = 10;
    int currentAttempt = 0;

    while (currentAttempt < maxAttempts) {
      try {
        final response = await BlockchainService.reownPosCheckTransaction(
          id: receiptId,
          txId: txHash,
          projectId: _reOwnCore!.projectId,
        );
        _reOwnCore!.logger.d('[$runtimeType] api response ${response.result}');
        final String status = ReownCoreUtils.recursiveSearchForMapKey(
          response.result,
          'status',
        );
        if (status.toUpperCase() == 'PENDING') {
          currentAttempt++;
          if (currentAttempt < maxAttempts) {
            // Keep trying
            await Future.delayed(Duration(seconds: 3));
          } else {
            // Max attempts reached, complete with timeout status
            _safeCompleteStatus(status: 'TIMEOUT');
            break;
          }
        } else {
          // Either CONFIRMED or FAILED received
          _safeCompleteStatus(status: status.toUpperCase());
          break;
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  /// Safely completes the status completer if it hasn't been completed yet
  void _safeCompleteStatus({String status = ''}) {
    if (!_statusCheckCompleter.isCompleted) {
      _statusCheckCompleter.complete(status);
    }
  }

  void _isValidPaymentIntent(PaymentIntent intent) {
    try {
      double.tryParse(_pendingIntent!.amount);
    } catch (_) {
      throw StateError(
        'invalid amount value. Should be double expressed as String (${_pendingIntent!.amount})',
      );
    }
    if (!CaipValidator.isValidCaip2(_pendingIntent!.chainId)) {
      throw StateError(
        'chainId should conform to "CAIP-2" format (${_pendingIntent!.chainId})',
      );
    }
    if (!CaipValidator.isValidCaip19(_pendingIntent!.token)) {
      throw StateError(
        'token should conform to "CAIP-19" format (${_pendingIntent!.token})',
      );
    }
    if (!CaipValidator.isValidCaip10(_pendingIntent!.recipient)) {
      throw StateError(
        'recipient should conform to "CAIP-10" format (${_pendingIntent!.recipient})',
      );
    }
  }
}
