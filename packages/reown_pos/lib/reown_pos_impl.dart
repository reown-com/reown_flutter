import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:event/event.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:reown_core/store/generic_store.dart';
import 'package:reown_pos/reown_pos.dart';
import 'package:reown_pos/services/blockchain_service.dart';
import 'package:reown_pos/services/models/query_models.dart';
import 'package:reown_pos/services/models/result_models.dart';
import 'package:reown_pos/services/validator_service.dart';
import 'package:reown_pos/src/version.dart';
import 'package:reown_pos/utils/extensions.dart';

class ReownPos with BlockchainService, ValidatorService implements IReownPos {
  bool _initialized = false;
  QueryParams? _queryParams;
  final List<PosToken> _configuredTokens = [];
  final Map<String, RequiredNamespace> _sessionNamespaces = {};
  // TODO convert to a List
  PaymentIntent? _pendingIntent;
  var _statusCheckCompleter = Completer<(String, String?)>();
  IReownCore? _reOwnCore;

  /// Gets the environment string safely for both web and native platforms
  // TODO move to some other file
  String get _environment {
    if (kIsWeb) return 'web';
    try {
      return Platform.environment['FLUTTER_ENV'] ?? 'mobile';
    } catch (e) {
      return 'mobile';
    }
  }

  @override
  IReownSign? reOwnSign;

  @override
  final Event<PosEvent> onPosEvent = Event();

  @override
  List<PosToken> get configuredTokens => _configuredTokens;

  ReownPos({
    required String projectId,
    required String deviceId,
    required Metadata metadata,
    LogLevel logLevel = LogLevel.all,
  }) {
    _queryParams = QueryParams(
      projectId: projectId,
      deviceId: deviceId,
      st: 'flutter-$_environment',
      sv: 'pos-flutter-$packageVersion',
    );
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
  }

  @override
  Future<void> init() async {
    try {
      if (_initialized) {
        return;
      }

      await _reOwnCore!.start();
      await reOwnSign!.init();

      // TODO implement posSupportedNetworks
      // final JsonRpcResponse response = await posSupportedNetworks(
      //   queryParams: _queryParams!,
      // );
      // _reOwnCore!.logger.d(
      //   '[$runtimeType] posSupportedNetworks ${jsonEncode(response.result)}',
      // );

      _registerListeners();

      _reOwnCore!.logger.d('[$runtimeType] initialized');
      _initialized = true;
    } catch (e) {
      _reOwnCore!.logger.e('[$runtimeType] init error: $e');
      rethrow;
    }
  }

  @override
  void setTokens({required List<PosToken> tokens}) {
    if (tokens.isEmpty) {
      throw Errors.getSdkError(
        Errors.MISSING_OR_INVALID,
        context: 'No tokens provided',
      ).toSignError();
    }

    _reOwnCore!.logger.d('[$runtimeType] set tokens $tokens');

    _configuredTokens
      ..clear()
      ..addAll(tokens);

    _setNamespacesFromTokens(tokens);
  }

  ConnectResponse? _connect;
  @override
  Future<void> createPaymentIntent({
    required List<PaymentIntent> paymentIntents,
  }) async {
    if (_sessionNamespaces.isEmpty) {
      throw StateError('No chains set, call setTokens method first');
    }
    if (paymentIntents.isEmpty) {
      throw StateError('No payment intents provided');
    }

    _pendingIntent = paymentIntents.first.copyWith();
    // TODO catch
    isValidPaymentIntent(_pendingIntent!);
    _reOwnCore!.logger.d('[$runtimeType] paymentIntent $_pendingIntent');

    try {
      _connect = await reOwnSign!.connect(
        optionalNamespaces: _sessionNamespaces,
      );
      _reOwnCore!.logger.d('[$runtimeType] pairing uri: ${_connect!.uri}');
      onPosEvent.broadcast(QrReadyEvent(_connect!.uri!));

      // We await the response in case of failure, success is handled in _onSessionConnect
      await _connect!.session.future;
    } on JsonRpcError catch (e) {
      _reOwnCore!.logger.e('[$runtimeType] connect error: $e');
      if (e.isUserRejected) {
        onPosEvent.broadcast(ConnectRejectedEvent());
      } else {
        onPosEvent.broadcast(ConnectFailedEvent(e.message ?? ''));
      }
    } on ReownCoreError catch (e) {
      _reOwnCore!.logger.e('[$runtimeType] connect error: $e');
      onPosEvent.broadcast(ConnectFailedEvent(e.message));
    } catch (e, s) {
      _reOwnCore!.logger.e('[$runtimeType] connect error: $e, $s');
      onPosEvent.broadcast(ConnectFailedEvent(e.toString()));
    }
  }

  @override
  Future<void> restart({bool reinit = false}) async {
    // Complete any pending status check completer to prevent hanging
    _safeCompleteStatus();
    _pendingIntent = null;
    await _expirePreviousPairings();
    if (_connect?.session.isCompleted == false) {
      _connect!.session.completeError(
        ReownCoreError(code: 5090, message: 'ABORTED'),
      );
    }
    if (reinit) {
      _sessionNamespaces.clear();
      _unregisterListeners();
      _initialized = false;
    }
  }
}

// listener handlers
extension _SessionListeners on ReownPos {
  void _onSessionConnect(SessionConnect? event) async {
    _reOwnCore!.logger.d('[$runtimeType] session connected: ${event?.session}');
    onPosEvent.broadcast(ConnectedEvent());

    final approvedSession = event!.session;
    final chainId = _pendingIntent!.token.network.chainId;

    try {
      isValidSessionApproved(approvedSession, chainId);
    } catch (e) {
      onPosEvent.broadcast(PaymentRequestFailedEvent(e.toString()));
      await _disconnect(approvedSession.topic);
      return;
    }

    try {
      final senderAddress = approvedSession.getSenderCaip10Account(chainId)!;
      // Blockchain API call
      final JsonRpcResponse response = await posBuildTransaction(
        params: BuildTransactionParams(
          paymentIntents: [
            PaymentIntentParams.fromPaymentIntent(
              _pendingIntent!,
              senderAddress,
            ),
          ],
          // TODO implement capabilities
          // capabilities: null,
        ),
        queryParams: _queryParams!,
      );
      final result = BuildTransactionResult.fromJson(response.result);

      // TODO implement proper handling transaction list instead always the first one
      final TransactionRpc transaction = result.transactions.first;
      final String receiptId = transaction.id;
      final Future<dynamic> sessionRequest = reOwnSign!.request(
        topic: approvedSession.topic,
        chainId: chainId,
        request: SessionRequestParams(
          method: transaction.method,
          params: transaction.params,
        ),
      );
      onPosEvent.broadcast(PaymentRequestedEvent());

      final requestResponse = await sessionRequest;

      onPosEvent.broadcast(PaymentBroadcastedEvent());

      // Loop on status check
      _loopOnStatusCheck(receiptId, requestResponse);
      // TODO move this logic inside _loopOnStatusCheck if possible
      final statusResult = await _statusCheckCompleter.future;
      if (statusResult.$1 == 'CONFIRMED') {
        onPosEvent.broadcast(PaymentSuccessfulEvent(statusResult.$2!));
      } else if (statusResult.$1 == 'FAILED') {
        onPosEvent.broadcast(PaymentFailedEvent('Transaction failed'));
      } else if (statusResult.$1 == 'TIMEOUT') {
        onPosEvent.broadcast(PaymentFailedEvent('Failed to check status'));
      }
      // other statuses are handled inside the loop
    } on JsonRpcError catch (e) {
      if (e.isUserRejected) {
        // User rejected payment
        onPosEvent.broadcast(PaymentRequestRejectedEvent());
      } else {
        _reOwnCore!.logger.e('[$runtimeType] JsonRpcError, $e');
        onPosEvent.broadcast(PaymentRequestFailedEvent(e.message ?? ''));
      }
    } on ReownCoreError catch (e) {
      _reOwnCore!.logger.e('[$runtimeType] ReownCoreError, $e');
      onPosEvent.broadcast(PaymentRequestFailedEvent(e.message));
    } catch (e, s) {
      _reOwnCore!.logger.e('[$runtimeType] createPaymentIntent error: $e, $s');
      onPosEvent.broadcast(PaymentRequestFailedEvent(e.toString()));
    }

    await _disconnect(approvedSession.topic);
  }
}

extension _SignEventListeners on ReownPos {
  void _registerListeners() {
    reOwnSign!.onSessionConnect.subscribe(_onSessionConnect);
    reOwnSign!.onSessionDelete.subscribe(_onSessionDelete);
    reOwnSign!.onSessionExpire.subscribe(_onSessionExpire);
    reOwnSign!.onSessionEvent.subscribe(_onSessionEvent);
    reOwnSign!.onSessionUpdate.subscribe(_onSessionUpdate);
    reOwnSign!.onSessionProposalError.subscribe(_onSessionProposalError);
  }

  void _unregisterListeners() {
    reOwnSign!.onSessionConnect.unsubscribe(_onSessionConnect);
    reOwnSign!.onSessionDelete.unsubscribe(_onSessionDelete);
    reOwnSign!.onSessionExpire.unsubscribe(_onSessionExpire);
    reOwnSign!.onSessionEvent.unsubscribe(_onSessionEvent);
    reOwnSign!.onSessionUpdate.unsubscribe(_onSessionUpdate);
    reOwnSign!.onSessionProposalError.unsubscribe(_onSessionProposalError);
  }

  void _onSessionDelete(SessionDelete? event) async {
    _reOwnCore!.logger.d('[$runtimeType] event: onSessionDelete, $event');
    onPosEvent.broadcast(DisconnectedEvent());
  }

  void _onSessionExpire(SessionExpire? event) async {
    _reOwnCore!.logger.d('[$runtimeType] event: onSessionExpire, $event');
  }

  void _onSessionEvent(SessionEvent? event) {
    _reOwnCore!.logger.d('[$runtimeType] event: onSessionEvent, $event');
  }

  void _onSessionUpdate(SessionUpdate? event) {
    _reOwnCore!.logger.d('[$runtimeType] event: onSessionUpdate, $event');
  }

  void _onSessionProposalError(SessionProposalErrorEvent? event) {
    _reOwnCore!.logger.d(
      '[$runtimeType] event: onSessionProposalError, $event',
    );
  }
}

extension _PrivateMembers on ReownPos {
  void _setNamespacesFromTokens(List<PosToken> tokens) {
    final List<PosNetwork> chains = tokens.map((e) => e.network).toList();
    // TODO implement posSupportedNetworks to actually check the supported namespaces
    final evmChains = chains
        .where((chain) => chain.chainId.startsWith('eip155'))
        .toSet();
    if (evmChains.isNotEmpty) {
      _sessionNamespaces['eip155'] = RequiredNamespace(
        chains: evmChains.map((chain) => chain.chainId).toList(),
        methods: ['eth_sendTransaction'],
        events: ['chainChanged', 'accountsChanged'],
      );
    }

    final solanaChains = chains
        .where((chain) => chain.chainId.startsWith('solana'))
        .toSet();
    if (solanaChains.isNotEmpty) {
      _sessionNamespaces['solana'] = RequiredNamespace(
        chains: solanaChains.map((chain) => chain.chainId).toList(),
        methods: ['solana_signAndSendTransaction'],
        events: [],
      );
    }

    final tronChains = chains
        .where((chain) => chain.chainId.startsWith('tron'))
        .toSet();
    if (tronChains.isNotEmpty) {
      _sessionNamespaces['tron'] = RequiredNamespace(
        chains: tronChains.map((chain) => chain.chainId).toList(),
        methods: ['tron_signTransaction'],
        events: [],
      );
    }

    _reOwnCore!.logger.d(
      '[$runtimeType] set namespaces: ${jsonEncode(_sessionNamespaces)}}',
    );
  }

  Future<void> _expirePreviousPairings() async {
    // TODO check on this
    for (var session in reOwnSign!.sessions.getAll()) {
      await reOwnSign!.disconnectSession(
        topic: session.topic,
        reason: ReownSignError(code: 6000, message: 'POS disconnected'),
      );
    }
    for (var pairing in reOwnSign!.pairings.getAll()) {
      await reOwnSign!.core.expirer.expire(pairing.topic);
    }
  }

  void _loopOnStatusCheck(String id, dynamic result) async {
    int maxAttempts = 30;
    int currentAttempt = 0;
    _statusCheckCompleter = Completer<(String, String?)>();

    while (currentAttempt < maxAttempts) {
      try {
        _reOwnCore!.logger.d(
          '[$runtimeType] check transaction with params {$id, $result}',
        );
        final response = await posCheckTransaction(
          params: CheckTransactionParams(
            id: id,
            sendResult: (result is String) ? result : jsonEncode(result),
          ),
          queryParams: _queryParams!,
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
            final int ms = ReownCoreUtils.recursiveSearchForMapKey(
              response.result,
              'checkIn',
            );
            await Future.delayed(Duration(milliseconds: ms));
          } else {
            // Max attempts reached, complete with timeout status
            _safeCompleteStatus(status: 'TIMEOUT');
            break;
          }
        } else {
          // Either CONFIRMED or FAILED received
          final String txid = ReownCoreUtils.recursiveSearchForMapKey(
            response.result,
            'txid',
          );
          _safeCompleteStatus(status: status.toUpperCase(), txid: txid);
          break;
        }
      } on JsonRpcError catch (e) {
        _reOwnCore!.logger.e('[$runtimeType] JsonRpcError, $e');
        onPosEvent.broadcast(PaymentRequestFailedEvent(e.message ?? ''));
        break;
      } on ReownCoreError catch (e) {
        _reOwnCore!.logger.e('[$runtimeType] ReownCoreError, $e');
        onPosEvent.broadcast(PaymentRequestFailedEvent(e.message));
        break;
      } catch (e, s) {
        _reOwnCore!.logger.e(
          '[$runtimeType] createPaymentIntent error: $e, $s',
        );
        onPosEvent.broadcast(PaymentRequestFailedEvent(e.toString()));
        break;
      }
    }
  }

  /// Safely completes the status completer if it hasn't been completed yet
  void _safeCompleteStatus({String status = '', String? txid}) {
    if (!_statusCheckCompleter.isCompleted) {
      _statusCheckCompleter.complete((status, txid));
    }
  }

  Future<void> _disconnect(String topic) async {
    // Complete the completer to prevent hanging
    _safeCompleteStatus();

    // disconnect the session when completing payment
    _reOwnCore!.logger.d('[$runtimeType] disconnecting session');
    await reOwnSign!.disconnectSession(
      topic: topic,
      reason: ReownSignError(code: 6000, message: 'POS disconnected'),
    );
  }
}
