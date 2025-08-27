import 'package:event/event.dart';
import 'package:collection/collection.dart';

import 'package:reown_core/reown_core.dart' hide ErrorEvent;
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_pos/i_reown_pos.dart';
import 'package:reown_pos/models/events.dart';
import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_sign/reown_sign.dart';

export 'package:reown_core/reown_core.dart';
export 'package:reown_sign/reown_sign.dart';

/// A Calculator.
class ReownPos implements IReownPos {
  bool _initialized = false;

  @override
  late final IReownSign reOwnSign;

  @override
  final Event<PosEvent> onPosEvent = Event();

  // late final Map<String, dynamic> _initParams;
  late final IReownCore _reOwnCore;
  final Map<String, RequiredNamespace> _sessionNamespaces = {};
  List<PaymentIntent> _pendingPaymentIntents = [];

  ReownPos({
    required String projectId,
    required String deviceId, // to be used with blockchain api methods
    required Metadata metadata,
    LogLevel logLevel = LogLevel.nothing,
  }) {
    // _initParams = Map.from({
    //   'projectId': projectId,
    //   'deviceId': deviceId,
    //   ...metadata.toJson(),
    // });
    _reOwnCore = ReownCore(projectId: projectId, logLevel: logLevel);
    reOwnSign = ReownSign(
      core: _reOwnCore,
      metadata: PairingMetadata(
        name: metadata.merchantName,
        description: metadata.description,
        icons: [metadata.logoIcon],
        url: metadata.url,
      ),
      proposals: GenericStore(
        storage: _reOwnCore.storage,
        context: StoreVersions.CONTEXT_PROPOSALS,
        version: StoreVersions.VERSION_PROPOSALS,
        fromJson: (dynamic value) {
          return ProposalData.fromJson(value);
        },
      ),
      sessions: Sessions(
        storage: _reOwnCore.storage,
        context: StoreVersions.CONTEXT_SESSIONS,
        version: StoreVersions.VERSION_SESSIONS,
        fromJson: (dynamic value) {
          return SessionData.fromJson(value);
        },
      ),
      pendingRequests: GenericStore(
        storage: _reOwnCore.storage,
        context: StoreVersions.CONTEXT_PENDING_REQUESTS,
        version: StoreVersions.VERSION_PENDING_REQUESTS,
        fromJson: (dynamic value) {
          return SessionRequest.fromJson(value);
        },
      ),
      authKeys: GenericStore(
        storage: _reOwnCore.storage,
        context: StoreVersions.CONTEXT_AUTH_KEYS,
        version: StoreVersions.VERSION_AUTH_KEYS,
        fromJson: (dynamic value) {
          return AuthPublicKey.fromJson(value);
        },
      ),
      pairingTopics: GenericStore(
        storage: _reOwnCore.storage,
        context: StoreVersions.CONTEXT_PAIRING_TOPICS,
        version: StoreVersions.VERSION_PAIRING_TOPICS,
        fromJson: (dynamic value) {
          return value;
        },
      ),
      sessionAuthRequests: GenericStore(
        storage: _reOwnCore.storage,
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

      await _reOwnCore.start();
      await reOwnSign.init();

      _reOwnCore.logger.i('[$runtimeType] initialized');
      _initialized = true;
    } catch (e) {
      _reOwnCore.logger.e('[$runtimeType] init error: $e');
      rethrow;
    }
  }

  @override
  void setChains({required List<String> chainIds}) {
    if (chainIds.isEmpty) {
      throw Errors.getSdkError(
        Errors.MISSING_OR_INVALID,
        context: 'No chainIds provided',
      ).toSignError();
    }

    for (var chainId in chainIds) {
      if (!NamespaceUtils.isValidChainId(chainId)) {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context: 'chainId should conform to "CAIP-2" format',
        ).toSignError();
      }

      if (!chainId.startsWith('eip155')) {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context:
              'Only EVM chains are supported, please provide eip155 chains',
        ).toSignError();
      }
    }

    _sessionNamespaces['eip155'] = RequiredNamespace(
      chains: chainIds,
      methods: ['eth_sendTransaction'],
      events: ['chainChanged', 'accountsChanged'],
    );
  }

  @override
  Future<void> createPaymentIntent({
    required List<PaymentIntent> paymentIntents,
  }) async {
    if (_sessionNamespaces.isEmpty) {
      throw 'No chains set, call setChains method first';
    }
    if (_sessionNamespaces.isEmpty) {
      throw 'No payment intents provided';
    }
    for (var intent in paymentIntents) {
      if (intent.chainId.isEmpty) {
        throw 'chainId cannot be empty on intent ${intent.toJson()}';
      }
      if (intent.amount.isEmpty) {
        throw 'amount cannot be empty intent ${intent.toJson()}';
      }
      if (intent.token.isEmpty) {
        throw 'token cannot be empty intent ${intent.toJson()}';
      }
      if (intent.recipient.isEmpty) {
        throw 'recipient cannot be empty intent ${intent.toJson()}';
      }
    }

    _pendingPaymentIntents = List.from(paymentIntents);
    _reOwnCore.logger.d('[$runtimeType] intents: $_pendingPaymentIntents');

    try {
      // final CreateResponse pairing = await reOwnSign.core.pairing.create();
      // reOwnSign.core.logger.d('[$runtimeType] pairing: $pairing');

      final ConnectResponse connect = await reOwnSign.connect(
        optionalNamespaces: _sessionNamespaces,
        // pairingTopic: pairing.topic,
      );
      _reOwnCore.logger.d('[$runtimeType] connect: ${connect.uri}');

      onPosEvent.broadcast(QrReadyEvent(connect.uri!));

      // We can await the session or we can listen to onSessionConnected
      // final connectedSession = await connect.session.future;
    } on JsonRpcError catch (e) {
      if (e.isUserRejected) {
        // User rejected session
        onPosEvent.broadcast(ConnectRejectedEvent());
      } else {
        onPosEvent.broadcast(ConnectFailedEvent(e.message ?? ''));
      }
    } on ReownCoreError catch (e) {
      onPosEvent.broadcast(ConnectFailedEvent(e.message));
    } catch (e, s) {
      _reOwnCore.logger.e('[$runtimeType] createPaymentIntent error: $e, $s');
      onPosEvent.broadcast(ConnectFailedEvent(e.toString()));
    }
  }

  @override
  Future<void> dispose() async {
    _sessionNamespaces.clear();
    _pendingPaymentIntents.clear();
    _initialized = false;
  }
}

extension on JsonRpcError {
  bool get isUserRejected {
    final regexp = RegExp(
      r'\b(rejected|cancelled|disapproved|denied)\b',
      caseSensitive: false,
    );
    final code = (this.code ?? 0);
    final match = RegExp(r'\b500[0-3]\b').hasMatch(code.toString());
    if (match || code == Errors.getSdkError(Errors.USER_REJECTED_SIGN).code) {
      return true;
    }
    return regexp.hasMatch(toString());
  }
}

// listener handlers
extension _SessionListeners on ReownPos {
  void _onSessionConnect(SessionConnect? event) async {
    reOwnSign.core.logger.i('[$runtimeType] event: onSessionConnect, $event');
    onPosEvent.broadcast(ConnectedEvent());

    final approvedSession = event!.session;
    final paymentIntent = _pendingPaymentIntents.firstWhere(
      (_) => true,
      orElse: () => throw StateError('No payment intent available'),
    );
    final namespace = _sessionNamespaces.values.firstWhere(
      (_) => true,
      orElse: () => throw StateError('No namespace available'),
    );
    final method = namespace.methods.firstWhere(
      (_) => true,
      orElse: () => throw StateError('No method available'),
    );

    // TODO: Mocking endpoint to build the transaction
    await Future.delayed(Duration(seconds: 3));

    final senderAddress = _findSenderAddress(
      approvedSession,
      paymentIntent.chainId,
    );
    if (senderAddress == null) {
      throw StateError(
        "No matching account found for chain ${paymentIntent.chainId}",
      );
    }

    try {
      reOwnSign.core.logger.i('[$runtimeType] sending request');
      final futureTxHash = reOwnSign.request(
        topic: approvedSession.topic,
        chainId: paymentIntent.chainId,
        request: SessionRequestParams(
          method: method,
          params: [_reownPosBuildTransaction(senderAddress, paymentIntent)],
        ),
      );
      onPosEvent.broadcast(PaymentRequestedEvent());

      final txHash = await futureTxHash;

      onPosEvent.broadcast(PaymentBroadcastedEvent());

      // TODO: Mocking transaction status check on server
      await Future.delayed(Duration(seconds: 4));

      //TODO: get txHash and receipt from server
      onPosEvent.broadcast(PaymentSuccessfulEvent(txHash, "tx_hash_test"));
    } on JsonRpcError catch (e) {
      if (e.isUserRejected) {
        // User rejected payment
        onPosEvent.broadcast(PaymentRejectedEvent());
      } else {
        reOwnSign.core.logger.e('[$runtimeType] JsonRpcError, $e');
        onPosEvent.broadcast(PaymentFailedEvent(e.message ?? ''));
      }
    } on ReownCoreError catch (e) {
      reOwnSign.core.logger.e('[$runtimeType] ReownCoreError, $e');
      onPosEvent.broadcast(PaymentFailedEvent(e.message));
    } catch (e, s) {
      _reOwnCore.logger.e('[$runtimeType] createPaymentIntent error: $e, $s');
      onPosEvent.broadcast(PaymentFailedEvent(e.toString()));
    }

    // disconnect the session when completing payment
    reOwnSign.core.logger.d('[$runtimeType] disconnecting session');
    await reOwnSign.disconnectSession(
      topic: approvedSession.topic,
      reason: ReownSignError(code: 6000, message: 'POS disconnected'),
    );
  }

  void _onSessionDelete(SessionDelete? event) async {
    reOwnSign.core.logger.i('[$runtimeType] event: onSessionDelete, $event');
    await dispose();
    onPosEvent.broadcast(DisconnectedEvent());
  }

  void _onSessionExpire(SessionExpire? event) async {
    reOwnSign.core.logger.i('[$runtimeType] event: onSessionExpire, $event');
  }

  void _onSessionEvent(SessionEvent? event) {
    reOwnSign.core.logger.i('[$runtimeType] event: onSessionEvent, $event');
  }

  void _onSessionUpdate(SessionUpdate? event) {
    reOwnSign.core.logger.i('[$runtimeType] event: onSessionUpdate, $event');
  }

  void _onSessionProposalError(SessionProposalErrorEvent? event) {
    reOwnSign.core.logger.i(
      '[$runtimeType] event: onSessionProposalError, $event',
    );
  }
}

extension _PrivateMembers on ReownPos {
  void _registerListeners() {
    reOwnSign.onSessionConnect.subscribe(_onSessionConnect);
    reOwnSign.onSessionDelete.subscribe(_onSessionDelete);
    reOwnSign.onSessionExpire.subscribe(_onSessionExpire);
    reOwnSign.onSessionEvent.subscribe(_onSessionEvent);
    reOwnSign.onSessionUpdate.subscribe(_onSessionUpdate);
    reOwnSign.onSessionProposalError.subscribe(_onSessionProposalError);
  }

  String? _findSenderAddress(SessionData approvedSession, String chainId) {
    for (final entry in approvedSession.namespaces.entries) {
      final namespaceKey = entry.key;
      final namespaceValue = entry.value;

      final chainIds = NamespaceUtils.getChainIdsFromNamespaces(
        namespaces: Map.fromEntries([entry]),
      );

      if (chainIds.isNotEmpty) {
        final matchingAccount = namespaceValue.accounts.firstWhereOrNull(
          (account) => namespaceValue.chains!.any(
            (chain) => chain == chainId || account.startsWith(chain),
          ),
        );
        if (matchingAccount != null) return matchingAccount;
      }

      if (namespaceKey == chainId) {
        final account = namespaceValue.accounts.firstWhereOrNull((_) => true);
        if (account != null) return account;
      }
    }

    return null;
  }
}

extension _ApiRequestMethods on ReownPos {
  Map<String, dynamic> _reownPosBuildTransaction(
    String senderAddress,
    PaymentIntent paymentIntent,
  ) {
    // TODO: Get from Blockchain API endpoint reown_pos_buildTransaction when ready
    return {
      "from": NamespaceUtils.getAccount(senderAddress),
      "to": paymentIntent.recipient,
      "data": "0x",
      // "gasLimit": "0x5208",
      // "gasPrice": "0x0649534e00",
      "value": _ethToHexWei(paymentIntent.amount),
      // "nonce": "0x07",
    };
    // return jsonEncode(params);
  }

  String _ethToHexWei(String ethAmount) {
    final parsed = double.tryParse(ethAmount);
    if (parsed == null) throw ArgumentError('Invalid ETH string amount');
    final weiAmount = BigInt.from(parsed * 1e18);
    return '0x${weiAmount.toRadixString(16)}';
  }
}
