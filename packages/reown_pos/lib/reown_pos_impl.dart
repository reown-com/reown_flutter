import 'dart:async';
import 'dart:convert';
import 'package:event/event.dart';

import 'package:reown_core/store/generic_store.dart';
import 'package:reown_pos/reown_pos.dart';
import 'package:reown_pos/services/blockchain_service.dart';
import 'package:reown_pos/services/models/query_models.dart';
import 'package:reown_pos/services/models/result_models.dart';
import 'package:reown_pos/services/validator_service.dart';
import 'package:reown_pos/src/version.dart';
import 'package:reown_pos/utils/extensions.dart';
import 'package:reown_pos/utils/helpers.dart';

class ReownPos with BlockchainService, ValidatorService implements IReownPos {
  bool _initialized = false;
  QueryParams? _queryParams;
  IReownCore? _reOwnCore;

  final List<PosToken> _configuredTokens = [];
  final List<SupportedNamespace> _supportedNamespaces = [];
  final Map<String, RequiredNamespace> _posNamespaces = {};
  final List<PaymentIntent> _pendingIntents = [];

  @override
  IReownSign? reOwnSign;

  ///
  /// ℹ️
  /// Subscription to POS events:
  /// QrReadyEvent, ConnectedEvent, ConnectRejectedEvent, ConnectFailedEvent, PaymentRequestedEvent, PaymentRequestRejectedEvent, PaymentRequestFailedEvent, PaymentBroadcastedEvent, PaymentSuccessfulEvent, PaymentFailedEvent, DisconnectedEvent
  ///
  @override
  final Event<PosEvent> onPosEvent = Event();

  ///
  /// ℹ️
  /// When you call `setTokens` with your supported tokens a filtering will be applied over WalletConnect API supported networks
  /// So some tokens could end up to be not supported. This list is the result of that check.
  ///
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
      st: 'flutter-$environment',
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

  ///
  /// ℹ️
  /// init the SDK
  ///
  @override
  Future<void> init() async {
    try {
      if (_initialized) {
        return;
      }
      _reOwnCore!.logger.d('[$runtimeType] initializing...');

      await _reOwnCore!.start();
      await reOwnSign!.init();

      final JsonRpcResponse response = await posSupportedNetworks(
        queryParams: _queryParams!,
      );
      final result = SupportedNetworksResult.fromJson(response.result);
      _reOwnCore!.logger.d('[$runtimeType] supported networks: $result');
      _supportedNamespaces
        ..clear()
        ..addAll(result.namespaces);

      await _expirePreviousPairings();

      _configurePosNamespaces();

      _registerListeners();

      _reOwnCore!.logger.d('[$runtimeType] initialized');
      _initialized = true;
      onPosEvent.broadcast(InitializedEvent());
    } catch (e) {
      _reOwnCore!.logger.e('[$runtimeType] init error: $e');
      rethrow;
    }
  }

  ///
  /// ℹ️
  /// configure available tokens on your POS app
  ///
  @override
  void setTokens({required List<PosToken> tokens}) {
    if (tokens.isEmpty) {
      throw Errors.getSdkError(
        Errors.MISSING_OR_INVALID,
        context: 'No tokens provided',
      ).toSignError();
    }

    _reOwnCore!.logger.d('[$runtimeType] setTokens: $tokens');

    _configuredTokens
      ..clear()
      ..addAll(tokens);

    _configurePosNamespaces();
  }

  ConnectResponse? _connectResponse;

  ///
  /// ℹ️
  /// Initiates the payment flow. Best practice is to wrap it with try/catch
  /// for any implementation error
  ///
  @override
  Future<void> createPaymentIntent({
    required List<PaymentIntent> paymentIntents,
  }) async {
    if (_posNamespaces.isEmpty) {
      throw StateError('No chains set, call setTokens method first');
    }
    if (paymentIntents.isEmpty) {
      throw StateError('No payment intents provided');
    }
    if (paymentIntents.length > 1) {
      throw StateError('Currently 1 payment at a time is supported');
    }

    _reOwnCore!.logger.d('[$runtimeType] createPaymentIntent: $paymentIntents');

    _pendingIntents
      ..clear
      ..addAll(paymentIntents);

    // throws if some payment intent is not valid
    isValidPaymentIntents(_pendingIntents.first);

    try {
      _connectResponse = await reOwnSign!.connect(
        optionalNamespaces: _posNamespaces,
      );
      final pairingUri = _connectResponse!.uri!;
      onPosEvent.broadcast(QrReadyEvent(pairingUri));

      // We await the response in case of failure processed in the catch block
      // successful connection is handled in _onSessionConnect event handler
      await _connectResponse!.session.future;
    } catch (e, s) {
      _errorHandling(e, s, ErrorStep.connection);
    }
  }

  ///
  /// ℹ️
  /// To be called when you want to abort an ongoing intent or restart the flow when a payment finished.
  /// With reinit = true will clear the instance meaning that init() and setTokens() will have to be called again
  ///
  @override
  Future<void> restart({bool reinit = false}) async {
    _reOwnCore!.logger.d('[$runtimeType] restart');
    _pendingIntents.clear();
    await _expirePreviousPairings();
    if (_connectResponse?.session.isCompleted == false) {
      _connectResponse!.session.completeError(
        ReownCoreError(code: 5090, message: 'ABORTED'),
      );
    }
    if (reinit) {
      _unregisterListeners();
      _configuredTokens.clear();
      _supportedNamespaces.clear();
      _posNamespaces.clear();
      _posNamespaces.clear();
      _initialized = false;
    }
  }
}

// listener handlers
extension _SessionListeners on ReownPos {
  void _onSessionConnect(SessionConnect? args) async {
    final approvedSession = args?.session;
    if (approvedSession == null) {
      onPosEvent.broadcast(ConnectFailedEvent('No session found'));
      return;
    }

    _reOwnCore!.logger.d('[$runtimeType] onSessionConnect: $approvedSession');
    onPosEvent.broadcast(ConnectedEvent());

    try {
      isValidSessionApproved(approvedSession, _pendingIntents.first);
    } catch (e) {
      _reOwnCore!.logger.e('[$runtimeType] invalid session: $e');
      onPosEvent.broadcast(ConnectFailedEvent(e.toString()));
      await _disconnect(approvedSession.topic);
      return;
    }

    try {
      // Blockchain API call
      final JsonRpcResponse buildResponse = await posBuildTransaction(
        params: BuildTransactionParams(
          paymentIntents: _pendingIntents.toPaymentIntentParamsList(
            approvedSession,
          ),
          capabilities: _supportedNamespaces.getCapabilities(),
        ),
        queryParams: _queryParams!,
      );
      final buildTransaction = BuildTransactionResult.fromJson(
        buildResponse.result,
      );
      _reOwnCore!.logger.d(
        '[$runtimeType] build transaction: $buildTransaction',
      );

      // Since only one PyamentIntent is supported currently
      // Then only one transaction is received
      final transaction = buildTransaction.transactions.first;
      final sessionRequest = reOwnSign!.request(
        topic: approvedSession.topic,
        chainId: transaction.chainId,
        request: SessionRequestParams(
          method: transaction.method,
          params: transaction.params,
        ),
      );
      onPosEvent.broadcast(PaymentRequestedEvent());

      final requestResponse = await sessionRequest;

      onPosEvent.broadcast(PaymentBroadcastedEvent());

      // Loop on status check
      final String receiptId = transaction.id;
      _loopOnStatusCheck(receiptId, requestResponse, (checkResponse) async {
        _checkResponseHandler(checkResponse, transaction.chainId);
        await _disconnect(approvedSession.topic);
      });
    } catch (e, s) {
      _errorHandling(e, s, ErrorStep.payment);
      await _disconnect(approvedSession.topic);
    }
  }

  void _checkResponseHandler(CheckResponse checkResponse, String chainId) {
    // PENDING is handled inside the loop
    if (checkResponse.$1 == StatusCheck.confirmed.value) {
      onPosEvent.broadcast(PaymentSuccessfulEvent(checkResponse.$2!));
    } else if (checkResponse.$1 == StatusCheck.failed.value) {
      String message = 'Transaction failed.';
      final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
      if (namespace == 'eip155') {
        onPosEvent.broadcast(PaymentFailedEvent(message));
      } else {
        onPosEvent.broadcast(PaymentFailedEvent('$message Check your balance'));
      }
    } else if (checkResponse.$1 == StatusCheck.timeout.value) {
      onPosEvent.broadcast(PaymentFailedEvent('Failed to check status'));
    }
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
    reOwnSign!.onSessionConnect.unsubscribeAll();
    reOwnSign!.onSessionDelete.unsubscribeAll();
    reOwnSign!.onSessionExpire.unsubscribeAll();
    reOwnSign!.onSessionEvent.unsubscribeAll();
    reOwnSign!.onSessionUpdate.unsubscribeAll();
    reOwnSign!.onSessionProposalError.unsubscribeAll();
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
  void _configurePosNamespaces() {
    final tokenNamespaces = _configuredTokens.getNamespaces();
    for (var supportedNamespace in _supportedNamespaces) {
      if (tokenNamespaces.contains(supportedNamespace.name)) {
        final namespace = supportedNamespace.name;
        final chains = _configuredTokens.getChainsByNamespace(namespace);
        final methods = supportedNamespace.methods;
        final events = supportedNamespace.events;
        _posNamespaces[namespace] = RequiredNamespace(
          chains: chains,
          methods: methods,
          events: events,
        );
      }
    }

    if (_supportedNamespaces.isNotEmpty) {
      final supportedNamespaces = _posNamespaces.keys.toList();
      _configuredTokens.removeUnsupported(supportedNamespaces);
    }

    _reOwnCore!.logger.d(
      '[$runtimeType] namespaces: ${jsonEncode(_posNamespaces)}',
    );
  }

  Future<void> _expirePreviousPairings() async {
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

  void _loopOnStatusCheck(
    String id,
    dynamic result,
    Function(CheckResponse) completer,
  ) async {
    int maxAttempts = 30;
    int currentAttempt = 0;

    while (currentAttempt < maxAttempts) {
      try {
        _reOwnCore!.logger.d(
          '[$runtimeType] check transaction: {$id, $result}',
        );
        final response = await posCheckTransaction(
          params: CheckTransactionParams(
            id: id,
            sendResult: (result is String) ? result : jsonEncode(result),
          ),
          queryParams: _queryParams!,
        );
        _reOwnCore!.logger.d(
          '[$runtimeType] check response: ${response.result}',
        );
        String? status = ReownCoreUtils.recursiveSearchForMapKey(
          response.result,
          'status',
        );
        status = status ?? StatusCheck.pending.value;
        if (status == StatusCheck.pending.value) {
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
            completer.call((StatusCheck.timeout.value, null));
            break;
          }
        } else {
          // Either CONFIRMED or FAILED received
          final String? txid = ReownCoreUtils.recursiveSearchForMapKey(
            response.result,
            'txid',
          );
          completer.call((status.toUpperCase(), txid));
          break;
        }
      } catch (e, s) {
        _errorHandling(e, s, ErrorStep.statusCheck);
        break;
      }
    }
  }

  void _errorHandling(dynamic error, dynamic trace, ErrorStep errorStep) {
    _reOwnCore!.logger.e(
      '[$runtimeType] ${errorStep.name} error: $error, $trace',
    );
    if (errorStep == ErrorStep.connection) {
      if (error is JsonRpcError) {
        if (error.isUserRejected) {
          onPosEvent.broadcast(ConnectRejectedEvent());
        } else {
          onPosEvent.broadcast(ConnectFailedEvent(error.message ?? ''));
        }
      } else if (error is ReownCoreError) {
        // If session request fails due to the POS restar function we don't need to propagate this error.
        if (error.code != 5090 && error.message != 'ABORTED') {
          onPosEvent.broadcast(ConnectFailedEvent(error.message));
        }
      } else {
        onPosEvent.broadcast(ConnectFailedEvent(error.toString()));
      }
    } else {
      // ErrorStep.payment and ErrorStep.statusCheck are handled equally
      if (error is JsonRpcError) {
        if (error.isUserRejected) {
          // only happening during ErrorStep.payment impossible to happen on ErrorStep.statusCheck
          onPosEvent.broadcast(PaymentRequestRejectedEvent());
        } else {
          final posApiError = PosApiError.fromJsonRpcError(error);
          onPosEvent.broadcast(
            PaymentRequestFailedEvent(
              error.cleanMessage,
              posApiError,
              posApiError.shortMessage,
            ),
          );
        }
      } else if (error is ReownCoreError) {
        onPosEvent.broadcast(PaymentRequestFailedEvent(error.message));
      } else {
        onPosEvent.broadcast(PaymentRequestFailedEvent(error.toString()));
      }
    }
  }

  Future<void> _disconnect(String topic) async {
    // disconnect the session when completing payment
    _reOwnCore!.logger.d('[$runtimeType] disconnecting session');
    await reOwnSign!.disconnectSession(
      topic: topic,
      reason: ReownSignError(code: 6000, message: 'POS disconnected'),
    );
  }
}
