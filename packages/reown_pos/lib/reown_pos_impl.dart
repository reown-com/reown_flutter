import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:event/event.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:reown_core/reown_core.dart' hide ErrorEvent;
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_pos/i_reown_pos_impl.dart';
import 'package:reown_pos/models/events.dart';
import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_pos/services/blockchain_service.dart';
import 'package:reown_pos/services/models/query_models.dart';
import 'package:reown_pos/services/validator_service.dart';
import 'package:reown_pos/utils/extensions.dart';
import 'package:reown_sign/reown_sign.dart';

export 'package:reown_core/reown_core.dart';
export 'package:reown_sign/reown_sign.dart';

class ReownPos with BlockchainService, ValidatorService implements IReownPos {
  bool _initialized = false;
  QueryParams? _queryParams;
  final List<PosToken> _configuredTokens = [];
  final Map<String, RequiredNamespace> _sessionNamespaces = {};
  PaymentIntent? _pendingIntent;
  Completer<String> _statusCheckCompleter = Completer<String>();
  IReownCore? _reOwnCore;

  /// Gets the environment string safely for both web and native platforms
  String _getEnvironmentString() {
    if (kIsWeb) {
      return 'web';
    }
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
      st: 'flutter-${_getEnvironmentString()}',
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

    final List<PosNetwork> chains = tokens.map((e) => e.network).toList();
    _setNamespaces(chains);
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
        ReownCoreError(code: -1, message: 'ABORTED'),
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

    isValidSessionApproved(approvedSession, chainId); // throws if not valid

    final senderAddress = approvedSession.getSenderCaip10Account(chainId);
    if (senderAddress == null) {
      throw StateError("No matching account found for chain $chainId");
    }

    try {
      // Blockchain API call
      final transactionParams = BuildTransactionParams.fromPaymentIntent(
        _pendingIntent!,
        senderAddress,
      );
      final response = await reownPosBuildTransaction(
        params: transactionParams,
        queryParams: _queryParams!,
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

      _reOwnCore!.logger.d('[$runtimeType] sending request to wallet');
      final futureTxHash = reOwnSign!.request(
        topic: approvedSession.topic,
        chainId: _pendingIntent!.token.network.chainId,
        request: SessionRequestParams(method: method, params: params),
      );
      onPosEvent.broadcast(PaymentRequestedEvent());

      final txHash = await futureTxHash;

      onPosEvent.broadcast(PaymentBroadcastedEvent());

      // Loop on status check
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

    // Complete the completer to prevent hanging
    _safeCompleteStatus();

    // disconnect the session when completing payment
    _reOwnCore!.logger.d('[$runtimeType] disconnecting session');
    await reOwnSign!.disconnectSession(
      topic: approvedSession.topic,
      reason: ReownSignError(code: 6000, message: 'POS disconnected'),
    );
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
  void _setNamespaces(List<PosNetwork> chains) {
    final evmChains = chains
        .where((chain) => chain.chainId.startsWith('eip155'))
        .toSet()
        .toList();
    if (evmChains.isNotEmpty) {
      _sessionNamespaces['eip155'] = RequiredNamespace(
        chains: evmChains.map((chain) => chain.chainId).toList(),
        methods: ['eth_sendTransaction'],
        events: ['chainChanged', 'accountsChanged'],
      );
    }

    _reOwnCore!.logger.d(
      '[$runtimeType] set namespaces: ${jsonEncode(_sessionNamespaces)}}',
    );
  }

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

  Future<void> _expirePreviousPairings() async {
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
  }

  void _loopOnStatusCheck(String receiptId, String txHash) async {
    int maxAttempts = 10;
    int currentAttempt = 0;

    while (currentAttempt < maxAttempts) {
      try {
        final response = await reownPosCheckTransaction(
          params: CheckTransactionParams(id: receiptId, txid: txHash),
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
}
