import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/cosmos_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/kadena_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/polkadot_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/solana_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/stacks/stacks_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/sui/sui_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/ton/ton_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/tron_service.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/chain_key.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';
import 'package:reown_walletkit_wallet/utils/eth_utils.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_last_token_store.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_confirming_payment.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_get_payment_options.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_payment_details.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_payment_result.dart';
import 'package:reown_walletkit_wallet/widgets/scan_modal.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_request/wc_connect_modal.dart';
import 'package:reown_walletkit_wallet/main.dart' show navigatorKey;
import 'package:shared_preferences/shared_preferences.dart';

class WalletKitService implements IWalletKitService {
  final _bottomSheetHandler = GetIt.I<IBottomSheetService>();

  ConfirmPaymentRequest? _pendingPaymentRequest;
  PaymentOptionsResponse? _currentPaymentOptions;

  ReownWalletKit? _walletKit;
  @override
  ReownWalletKit get walletKit => _walletKit!;

  @override
  IPairingStore? get pairings => _walletKit?.pairings;

  @override
  final ValueNotifier<ChainMetadata?> currentSelectedChain = ValueNotifier(
    ChainsDataList.eip155Chains.firstWhere((e) => e.chainId == 'eip155:1'),
  );

  @override
  Future<void> create() async {
    final prefs = await SharedPreferences.getInstance();
    final linkModeEnabled = prefs.getBool('rwkt_sample_linkmode') ?? true;

    // Create the ReownWalletKit instance
    _walletKit = ReownWalletKit(
      core: ReownCore(projectId: DartDefines.projectId, logLevel: LogLevel.all),
      metadata: PairingMetadata(
        name: 'Flutter Wallet Sample',
        description: 'Reown\'s sample wallet with Flutter',
        url: _universalLink(),
        icons: [
          'https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/walletkit-icon$_flavor.png',
        ],
        redirect: _constructRedirect(linkModeEnabled),
      ),
    );

    _walletKit!.core.addLogListener(_logListener);

    // Setup our listeners
    debugPrint('[SampleWallet] create');
    _walletKit!.core.pairing.onPairingInvalid.subscribe(_onPairingInvalid);
    _walletKit!.core.pairing.onPairingCreate.subscribe(_onPairingCreate);
    _walletKit!.core.relayClient.onRelayClientError.subscribe(
      _onRelayClientError,
    );
    _walletKit!.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayClientMessage,
    );

    _walletKit!.onSessionProposal.subscribe(_onSessionProposal);
    _walletKit!.onSessionProposalError.subscribe(_onSessionProposalError);
    _walletKit!.onSessionConnect.subscribe(_onSessionConnect);
    _walletKit!.onSessionAuthRequest.subscribe(_onSessionAuthRequest);

    // Support EVM Chains
    for (final chainData in ChainsDataList.eip155Chains) {
      GetIt.I.registerSingleton<EVMService>(
        EVMService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Kadena Chains
    for (final chainData in ChainsDataList.kadenaChains) {
      GetIt.I.registerSingleton<KadenaService>(
        KadenaService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Polkadot Chains
    for (final chainData in ChainsDataList.polkadotChains) {
      GetIt.I.registerSingleton<PolkadotService>(
        PolkadotService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Solana Chains
    // Change SolanaService to SolanaService2 to switch between `solana` package and `solana_web3` package
    for (final chainData in ChainsDataList.solanaChains) {
      GetIt.I.registerSingleton<SolanaService>(
        SolanaService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Cosmos Chains
    for (final chainData in ChainsDataList.cosmosChains) {
      GetIt.I.registerSingleton<CosmosService>(
        CosmosService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Tron Chains
    for (final chainData in ChainsDataList.tronChains) {
      GetIt.I.registerSingleton<TronService>(
        TronService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Tron Chains
    for (final chainData in ChainsDataList.tonChains) {
      GetIt.I.registerSingletonAsync<TonService>(() async {
        final tonService = TonService(chainSupported: chainData);
        await tonService.init();
        return tonService;
      }, instanceName: chainData.chainId);
    }

    // Support Stacks Chains
    for (final chainData in ChainsDataList.stacksChains) {
      GetIt.I.registerSingletonAsync<StacksService>(() async {
        final stacksService = StacksService(chainSupported: chainData);
        await stacksService.init();
        return stacksService;
      }, instanceName: chainData.chainId);
    }

    // Support Sui Chains
    for (final chainData in ChainsDataList.suiChains) {
      GetIt.I.registerSingletonAsync<SUIService>(() async {
        final suiService = SUIService(chainSupported: chainData);
        await suiService.init();
        return suiService;
      }, instanceName: chainData.chainId);
    }
  }

  @override
  Future<void> init() async {
    await _walletKit!.init();
    await _emitEvent();
  }

  @override
  Future<dynamic> pair(String uri) async {
    if (_walletKit!.isPaymentLink(uri)) {
      return await processPayment(uri);
    } else {
      return await _walletKit!.pair(uri: Uri.parse(uri));
    }
  }

  @override
  Future<List<String>> getWalletAccounts([String namespace = '']) async {
    // Setup our accounts
    final List<String> accounts = [];
    List<ChainKey> chainKeys = await GetIt.I<IKeyService>().loadKeys();
    if (chainKeys.isEmpty) {
      if (DartDefines.enableTestMode &&
          DartDefines.testWalletPrivateKey.isNotEmpty) {
        var privateKey = DartDefines.testWalletPrivateKey;
        if (privateKey.startsWith('0x') || privateKey.startsWith('0X')) {
          privateKey = privateKey.substring(2);
        }
        await GetIt.I<IKeyService>().restoreWallet(
          mnemonicOrPrivate: privateKey,
        );
      } else {
        await GetIt.I<IKeyService>().createRandomWallet();
      }
      chainKeys = await GetIt.I<IKeyService>().loadKeys();
    }
    for (final chainKey in chainKeys) {
      for (final chainId in chainKey.chains) {
        if (chainId.startsWith('kadena')) {
          accounts.add('$chainId:k**${chainKey.address}');
        } else {
          accounts.add('$chainId:${chainKey.address}');
        }
      }
    }
    if (namespace.isNotEmpty) {
      return accounts.where((a) => a.startsWith(namespace)).toList();
    }
    return accounts;
  }

  @override
  Future<void> setUpAccounts() async {
    // Setup our accounts
    final accounts = await getWalletAccounts();
    for (var account in accounts) {
      final chainId = NamespaceUtils.getChainFromAccount(account);
      final address = NamespaceUtils.getAccount(account);
      _walletKit!.registerAccount(chainId: chainId, accountAddress: address);
    }
  }

  @override
  List<(ISS, AuthMessage, AuthRequest)> prepareAuthenticationMessages(
    List<SessionAuthPayload>? authenticationRequests,
    Map<String, Namespace>? generatedNamespaces,
  ) {
    final List<(String, String, SessionAuthPayload)> formattedMessages = [];
    if (authenticationRequests == null || authenticationRequests.isEmpty) {
      return formattedMessages;
    }

    if (generatedNamespaces == null || generatedNamespaces.isEmpty) {
      return formattedMessages;
    }

    for (var request in authenticationRequests) {
      for (var chain in request.chains) {
        try {
          final namespace = NamespaceUtils.getNamespaceFromChain(chain);
          final namespaces = generatedNamespaces[namespace];
          final account = namespaces?.accounts.first;
          if (account != null) {
            final address = NamespaceUtils.getAccount(account);
            final iss = 'did:pkh:$chain:$address';
            final message = _walletKit!.formatAuthMessage(
              iss: iss,
              cacaoPayload: CacaoRequestPayload.fromSessionAuthPayload(request),
            );
            formattedMessages.add((iss, message, request));
          }
        } catch (e, s) {
          debugPrint('❌ prepareAuthenticationMessages error: $e, $s');
        }
      }
    }

    return formattedMessages;
  }

  Future<void> processPayment(String paymentLink) async {
    try {
      // PaymentOptionsResponse. Pay backend only accepts Solana mainnet
      // (5eykt4...) — sending devnet/testnet chain ids trips its CAIP-10
      // validator, so filter to mainnet only.
      const solanaMainnet = 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp';
      final accounts = [
        ...await getWalletAccounts('eip155'),
        ...(await getWalletAccounts('solana'))
            .where((a) => a.startsWith('$solanaMainnet:')),
      ];
      final optionsResponse = await _bottomSheetHandler.queueBottomSheet(
        widget: WCPGetPaymentOptions(
          paymentLink: paymentLink,
          accounts: accounts,
        ),
      );

      if (optionsResponse is! PaymentOptionsResponse) {
        // GetPaymentOptionsError (e.g. expired link) — show result modal
        if (optionsResponse is GetPaymentOptionsError) {
          final errorType = _detectErrorType(optionsResponse);
          String? errorMsg;
          if (errorType == 'generic') {
            errorMsg = optionsResponse.message;
          }
          final errorResult = await _bottomSheetHandler.queueBottomSheet(
            widget: WCPPaymentResult(
              status: PaymentStatus.failed,
              errorType: errorType,
              errorMessage: errorMsg,
            ),
          );
          if (errorResult == 'scan_qr') {
            _openScanModal();
          }
          return;
        }
        throw optionsResponse;
      }

      _currentPaymentOptions = optionsResponse;

      if (_currentPaymentOptions!.options.isEmpty) {
        // Empty options can mean the payment is terminal (expired / cancelled /
        // already paid) or simply that the wallet can't afford any option.
        // getPaymentOptions is called with includePaymentInfo: true, so a
        // terminal payment comes back as a successful response carrying
        // info.status rather than throwing — inspect it to show the right
        // message instead of defaulting everything to "Not enough funds".
        await _bottomSheetHandler.queueBottomSheet(
          widget: WCPPaymentResult(
            status: PaymentStatus.failed,
            info: _currentPaymentOptions!.info,
            errorType: _emptyOptionsErrorType(_currentPaymentOptions!.info),
          ),
        );
        _currentPaymentOptions = null;
        return;
      }

      final paymentOptions = _currentPaymentOptions!.options;
      _pendingPaymentRequest = ConfirmPaymentRequest(
        paymentId: _currentPaymentOptions!.paymentId,
        // Single-option flows: pre-select the only choice. Multi-option
        // flows: leave empty so the user must tap a row on the select
        // screen to make their choice — never pre-pick the first option.
        optionId: paymentOptions.length == 1 ? paymentOptions.first.id : '',
        signatures: [],
      );

      await _processPayment(_currentPaymentOptions!);
    } catch (e) {
      if (e == 'cancelled' || e == 'close') {
        return;
      }
      await _bottomSheetHandler.queueBottomSheet(
        widget: WCPPaymentResult(
          status: PaymentStatus.failed,
          errorType: 'generic',
        ),
      );
    }
  }

  /// Fetches payment options from the WalletConnect Pay API for the given payment link.
  @override
  Future<PaymentOptionsResponse> getPaymentOptions(
    GetPaymentOptionsRequest request,
  ) async {
    final response = await _walletKit!.getPaymentOptions(request: request);
    return response;
  }

  @override
  Future<List<Action>> getRequiredPaymentActions(
    String optionId,
    String paymentId,
  ) async {
    final response = await _walletKit!.getRequiredPaymentActions(
      request: GetRequiredPaymentActionsRequest(
        optionId: optionId,
        paymentId: paymentId,
      ),
    );
    return response;
  }

  @override
  Future<ConfirmPaymentResponse> confirmPayment(
    ConfirmPaymentRequest payment,
  ) async {
    final response = await _walletKit!.confirmPayment(
      request: payment.copyWith(maxPollMs: 60000),
    );
    return response;
  }

  @override
  T getChainService<T extends Object>({required String chainId}) =>
      GetIt.I.get<T>(instanceName: chainId);

  @override
  FutureOr onDispose() {
    _walletKit!.core.removeLogListener(_logListener);

    _walletKit!.core.pairing.onPairingInvalid.unsubscribe(_onPairingInvalid);
    _walletKit!.core.pairing.onPairingCreate.unsubscribe(_onPairingCreate);
    _walletKit!.core.relayClient.onRelayClientError.unsubscribe(
      _onRelayClientError,
    );
    _walletKit!.core.relayClient.onRelayClientMessage.unsubscribe(
      _onRelayClientMessage,
    );

    _walletKit!.onSessionProposal.unsubscribe(_onSessionProposal);
    _walletKit!.onSessionProposalError.unsubscribe(_onSessionProposalError);
    _walletKit!.onSessionConnect.unsubscribe(_onSessionConnect);
    _walletKit!.onSessionAuthRequest.unsubscribe(_onSessionAuthRequest);
  }

  Future<void> _emitEvent() async {
    final isOnline = _walletKit!.core.connectivity.isOnline.value;
    if (!isOnline) {
      await Future.delayed(const Duration(milliseconds: 500));
      _emitEvent();
      return;
    }

    final sessions = _walletKit!.sessions.getAll();
    for (var session in sessions) {
      try {
        final events = NamespaceUtils.getNamespacesEventsForChain(
          chainId: 'eip155:1',
          namespaces: session.namespaces,
        );
        if (events.contains('accountsChanged')) {
          final chainKeys = GetIt.I<IKeyService>().getKeysForChain('eip155');
          _walletKit!.emitSessionEvent(
            topic: session.topic,
            chainId: 'eip155:1',
            event: SessionEventParams(
              name: 'accountsChanged',
              data: [chainKeys.first.address],
            ),
          );
        }
      } catch (_) {}
    }
  }

  void _logListener(String event) {
    debugPrint('[WalletKit] $event');
  }

  List<String> get _loaderMethods => [
        MethodConstants.WC_SESSION_PROPOSE,
        MethodConstants.WC_SESSION_REQUEST,
        MethodConstants.WC_SESSION_AUTHENTICATE,
      ];

  void _onRelayClientMessage(MessageEvent? event) async {
    if (event != null) {
      final jsonObject = await EthUtils.decodeMessageEvent(event);
      debugPrint('[SampleWallet] _onRelayClientMessage $jsonObject');
      if (jsonObject is JsonRpcRequest) {
        DeepLinkHandler.waiting.value = _loaderMethods.contains(
          jsonObject.method,
        );
      }
    }
  }

  void _onSessionProposal(SessionProposalEvent? args) async {
    final debugString = jsonEncode(args?.params);
    debugPrint('[SampleWallet] _onSessionProposal $debugString');
    if (args != null) {
      final proposer = args.params.proposer;

      final result = await _bottomSheetHandler.queueBottomSheet(
        widget: WCConnectModal(
          proposalData: args.params,
          verifyContext: args.verifyContext,
          requester: proposer,
        ),
      );

      if (result is ConnectApprovalResult) {
        final approvedNamespaces = result.namespaces;
        // Auth requests
        final authenticationRequests = args.params.requests?.authentication;
        final formattedMessages = prepareAuthenticationMessages(
          authenticationRequests,
          approvedNamespaces,
        );

        try {
          final cacaos = await signAuthenticationMessages(formattedMessages);

          // Build session properties, merging with proposal's existing ones
          final sessionProperties = Map<String, String>.from(
            args.params.sessionProperties ?? {},
          );

          // Add TON session properties if TON namespace is present
          if (approvedNamespaces.containsKey('ton')) {
            await _addTonSessionProperties(
              sessionProperties,
              approvedNamespaces,
            );
          }

          await _walletKit!.approveSession(
            id: args.id,
            namespaces: approvedNamespaces,
            sessionProperties: sessionProperties,
            proposalRequestsResponses: ProposalRequestsResponses(
              authentication: cacaos,
            ),
          );
        } on ReownSignError catch (error) {
          MethodsUtils.handleRedirect(
            '',
            proposer.metadata.redirect,
            error.message,
          );
        }
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED).toSignError();
        await _walletKit!.rejectSession(id: args.id, reason: error);
        await _walletKit!.core.pairing.disconnect(
          topic: args.params.pairingTopic,
        );
        MethodsUtils.handleRedirect(
          '',
          proposer.metadata.redirect,
          error.message,
        );
      }
    }
  }

  /// Adds TON-specific session properties (public key and state init)
  Future<void> _addTonSessionProperties(
    Map<String, String> sessionProperties,
    Map<String, Namespace> namespaces,
  ) async {
    try {
      final tonNamespace = namespaces['ton'];
      if (tonNamespace == null || tonNamespace.accounts.isEmpty) return;

      final firstAccount = tonNamespace.accounts.first;
      final chainId = NamespaceUtils.getChainFromAccount(firstAccount);

      final tonService = getChainService<TonService>(chainId: chainId);
      final props = await tonService.getSessionProperties();

      if (props != null) {
        sessionProperties['ton_getPublicKey'] = props.publicKey;
        sessionProperties['ton_getStateInit'] = props.stateInit;

        final pkPreview = props.publicKey.length > 10
            ? '${props.publicKey.substring(0, 10)}...'
            : props.publicKey;
        final siPreview = props.stateInit.length > 10
            ? '${props.stateInit.substring(0, 10)}...'
            : props.stateInit;
        debugPrint(
          '[$runtimeType] Added TON session properties: '
          'ton_getPublicKey=$pkPreview, '
          'ton_getStateInit=$siPreview',
        );
      } else {
        debugPrint('[$runtimeType] TON session properties not available');
      }
    } catch (e) {
      debugPrint('[$runtimeType] Failed to add TON session properties: $e');
    }
  }

  void _onSessionProposalError(SessionProposalErrorEvent? args) async {
    debugPrint('[SampleWallet] _onSessionProposalError $args');
    DeepLinkHandler.waiting.value = false;
    if (args != null) {
      String errorMessage = args.error.message;
      if (args.error.code == 5100) {
        errorMessage = errorMessage.replaceFirst(
          'Requested:',
          '\n\nRequested:',
        );
        errorMessage = errorMessage.replaceFirst(
          'Supported:',
          '\n\nSupported:',
        );
      }
      MethodsUtils.goBackModal(
        title: 'Error',
        message: errorMessage,
        success: false,
      );
    }
  }

  void _onSessionConnect(SessionConnect? args) {
    if (args != null) {
      final session = jsonEncode(args.session.toJson());
      debugPrint('[SampleWallet] _onSessionConnect $session');
      MethodsUtils.handleRedirect(
        args.session.topic,
        args.session.peer.metadata.redirect,
        '',
        true,
      );
    }
  }

  void _onRelayClientError(ErrorEvent? args) {
    debugPrint('[SampleWallet] _onRelayClientError ${args?.error}');
  }

  void _onPairingInvalid(PairingInvalidEvent? args) {
    debugPrint('[SampleWallet] _onPairingInvalid $args');
  }

  void _onPairingCreate(PairingEvent? args) {
    debugPrint('[SampleWallet] _onPairingCreate $args');
  }

  void _onSessionAuthRequest(SessionAuthRequest? args) async {
    final debugString = jsonEncode(args?.authPayload.toJson());
    debugPrint('[SampleWallet] _onSessionAuthRequest $debugString');
    if (args != null) {
      final supportedChains = ChainsDataList.eip155Chains.map((e) => e.chainId);
      final supportedMethods = SupportedEVMMethods.values.map((e) => e.name);
      final authenticationRequest = AuthSignature.populateAuthPayload(
        authPayload: args.authPayload,
        chains: supportedChains.toList(),
        methods: supportedMethods.toList(),
      );
      // _onSessionAuthRequest will only be executed during authenticate method,
      // which is only available for eip155 namespace and it's going to be deprecated soon
      final chainKeys = GetIt.I<IKeyService>().getKeysForChain('eip155');
      final address = chainKeys.first.address;

      final result = await _bottomSheetHandler.queueBottomSheet(
        widget: WCConnectModal(
          sessionAuthPayload: authenticationRequest,
          verifyContext: args.verifyContext,
          requester: args.requester,
        ),
      );

      if (result is AuthApprovalResult) {
        final selectedChains = result.selectedChainIds;
        // Filter supported chains to only include selected ones
        final filteredChains =
            supportedChains.where((c) => selectedChains.contains(c)).toList();
        final formattedMessages = prepareAuthenticationMessages(
          [authenticationRequest],
          {
            'eip155': Namespace(
              accounts: filteredChains.map((e) => '$e:$address').toList(),
              methods: supportedMethods.toList(),
              events: EventsConstants.allEvents,
            ),
          },
        );
        try {
          final cacaos = await signAuthenticationMessages(formattedMessages);
          final session = await _walletKit!.approveSessionAuthenticate(
            id: args.id,
            auths: cacaos,
          );
          debugPrint('[$runtimeType] approveSessionAuthenticate $session');
          MethodsUtils.handleRedirect(
            session.topic,
            session.session?.peer.metadata.redirect,
            '',
            true,
          );
        } on ReownSignError catch (error) {
          MethodsUtils.handleRedirect(
            args.topic,
            args.requester.metadata.redirect,
            error.message,
          );
        }
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED_AUTH);
        await _walletKit!.rejectSessionAuthenticate(
          id: args.id,
          reason: error.toSignError(),
        );
        MethodsUtils.handleRedirect(
          args.topic,
          args.requester.metadata.redirect,
          error.message,
        );
      }
    }
  }

  Future<List<Cacao>> signAuthenticationMessages(
    List<(String, String, SessionAuthPayload)> messagesToSign,
  ) async {
    final List<Cacao> signedAuths = [];
    for (var messageToSign in messagesToSign) {
      try {
        final iss = messageToSign.$1;
        final message = messageToSign.$2;
        final request = messageToSign.$3;
        final namespace = AddressUtils.getDidAddressNamespace(iss);
        final chainId = AddressUtils.getDidAddressChainId(iss);
        final (String, String, String?) result = await signAuthMessage(
          namespace!,
          chainId!,
          message,
        );
        final signature = result.$1;
        final type = result.$2;
        final publicKey = result.$3;

        final auth = AuthSignature.buildAuthObject(
          requestPayload: CacaoRequestPayload.fromSessionAuthPayload(request),
          signature: CacaoSignature(s: signature, t: type, m: publicKey),
          iss: iss,
        );
        signedAuths.add(auth);
      } catch (e, s) {
        debugPrint('❌ signAuthenticationMessages error: $e, $s');
      }
    }
    return signedAuths;
  }

  Future<(String, String, String?)> signAuthMessage(
    String namespace,
    String chainId,
    String message,
  ) async {
    try {
      final caip2chain = '$namespace:$chainId';
      debugPrint('[$runtimeType] signAuthMessage: $caip2chain, $message');
      switch (namespace) {
        case 'eip155':
          final service = getChainService<EVMService>(chainId: caip2chain);
          final signature = service.signMessage(message);
          final type = getSignatureType(namespace);
          return (signature, type, null);
        case 'solana':
          final service = getChainService<SolanaService>(chainId: caip2chain);
          final encodedMessage = base58.encode(utf8.encode(message));
          final signature = await service.signMessage(encodedMessage);
          final type = getSignatureType(namespace);
          return (signature, type, null);
        case 'polkadot':
          final service = getChainService<PolkadotService>(chainId: caip2chain);
          final signature = await service.signMessage(message);
          final type = getSignatureType(namespace);
          return (signature, type, null);
        case 'tron':
          final service = getChainService<TronService>(chainId: caip2chain);
          final signature = await service.signMessage(message);
          final type = getSignatureType(namespace);
          return (signature, type, null);
        case 'ton':
          final service = getChainService<TonService>(chainId: caip2chain);
          final signature = await service.signMessage(message);
          final publicKey = service.getBase64PublicKey();
          final type = getSignatureType(namespace);
          return (signature, type, publicKey);
        case 'sui':
          final service = getChainService<SUIService>(chainId: caip2chain);
          final signature = await service.signMessage(message);
          final type = getSignatureType(namespace);
          return (signature, type, null);
        case 'stacks':
          final service = getChainService<StacksService>(chainId: caip2chain);
          final signature = await service.signMessage(message);
          final type = getSignatureType(namespace);
          return (signature, type, null);
        default:
          throw StateError('Unsupported signature for chain $chainId');
      }
    } catch (e, s) {
      debugPrint('❌ signMessage error: $e, $s');
      rethrow;
    }
  }

  // TODO: Add more signature types for other chains
  String getSignatureType(String namespace) {
    switch (namespace) {
      case 'eip155':
        return CacaoSignature.EIP191;
      case 'bip122':
        return CacaoSignature.ECDSA;
      case 'solana':
        return CacaoSignature.ED25519;
      default:
        return namespace;
    }
  }

  String get _flavor {
    String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    return flavor.replaceAll('-production', '');
  }

  String _universalLink() {
    Uri link = Uri.parse('https://lab.reown.com/flutter_walletkit');
    if (_flavor.isNotEmpty || kDebugMode) {
      return link.replace(path: '${link.path}_internal').toString();
    }
    return link.toString();
  }

  Redirect _constructRedirect(bool linkModeEnabled) {
    return Redirect(
      native: 'wcflutterwallet$_flavor://',
      universal: _universalLink(),
      // enable linkMode on Wallet so Dapps can use relay-less connection
      // universal: value must be set on cloud config as well
      linkMode: linkModeEnabled,
    );
  }

  // WalletConnectPay related UX

  /// Processes the payment flow: shows payment details, confirms payment, and displays the result.
  Future<dynamic> _processPayment(PaymentOptionsResponse response) async {
    final hasMultipleOptions = response.options.length > 1;
    final showInfoPage = ValueNotifier<bool>(false);
    final showReview = ValueNotifier<bool>(false);
    final showGasFee = ValueNotifier<bool>(false);
    final committed = ValueNotifier<bool>(false);
    final preferredUnit = await WCPLastTokenStore.instance.read();
    final result = await _bottomSheetHandler.queueBottomSheet(
      // The select view hosts its own scrollable option list. Disable the
      // sheet's drag-to-dismiss so its vertical drag recognizer doesn't compete
      // with (and swallow) the inner scroll — otherwise the list won't scroll
      // under a programmatic swipe (Maestro pay_usdt_polygon). Dismissal is
      // already gated (isDismissible: false + explicit close button + PopScope).
      enableDrag: false,
      widget: WCPPaymentDetailsWidget(
        paymentOptionsResponse: response,
        paymentRequest: _pendingPaymentRequest!,
        preferredUnit: preferredUnit,
        showInfoPageNotifier: showInfoPage,
        showReviewNotifier: hasMultipleOptions ? showReview : null,
        showGasFeeNotifier: showGasFee,
        committedNotifier: committed,
      ),
      leadingWidget: AnimatedBuilder(
        animation:
            Listenable.merge([showInfoPage, showReview, showGasFee, committed]),
        builder: (_, __) {
          // Once the user taps PAY we honor the WCPay one-call contract: the
          // back arrow is removed so there's no way to navigate out of the
          // committal step.
          if (committed.value) {
            return const SizedBox(key: ValueKey('committed_spacer'), width: 38);
          }
          if (showGasFee.value) {
            return Semantics(
              container: true,
              identifier: 'pay-button-back',
              label: 'pay-button-back',
              child: WCPSheetIconButton(
                key: const ValueKey('gas_fee_back_button'),
                icon: Icons.arrow_back,
                showBorder: false,
                onPressed: () => showGasFee.value = false,
              ),
            );
          }
          if (showInfoPage.value) {
            return Semantics(
              container: true,
              identifier: 'pay-button-back',
              label: 'pay-button-back',
              child: WCPSheetIconButton(
                key: const ValueKey('back_button'),
                icon: Icons.arrow_back,
                showBorder: false,
                onPressed: () => showInfoPage.value = false,
              ),
            );
          }
          if (showReview.value) {
            return Semantics(
              container: true,
              identifier: 'pay-button-back',
              label: 'pay-button-back',
              child: WCPSheetIconButton(
                key: const ValueKey('review_back_button'),
                icon: Icons.arrow_back,
                showBorder: false,
                onPressed: () => showReview.value = false,
              ),
            );
          }
          // The "Why we collect personal details" info button used to live
          // in the leading slot; it now appears on the row that needs data
          // collection, so the leading slot stays empty on the select page.
          return const SizedBox(key: ValueKey('spacer'), width: 38);
        },
      ),
    );

    // Payment expired/failed during collectData — skip confirming, show result.
    if (result is PaymentStatus) {
      final earlyResult = await _bottomSheetHandler.queueBottomSheet(
        widget: WCPPaymentResult(
          status: result,
          info: _currentPaymentOptions!.info!,
          errorType: _paymentErrorType(result),
        ),
      );
      _pendingPaymentRequest = null;
      _currentPaymentOptions = null;
      if (earlyResult == 'scan_qr') {
        _openScanModal();
      }
      return;
    }

    if (result is! (ConfirmPaymentRequest, List<Action>)) {
      _pendingPaymentRequest = null;
      _currentPaymentOptions = null;
      throw result;
    }

    final (signedRequest, resolvedActions) = result;
    final selectedOption = response.options.firstWhere(
      (o) => o.id == signedRequest.optionId,
    );
    // Step 2: Confirming Payment
    final paymentStatusResult = await _bottomSheetHandler.queueBottomSheet(
      widget: WCPConfirmingPayment(
        paymentRequest: signedRequest,
        actions: resolvedActions,
        tokenSymbol: selectedOption.amount.display.assetSymbol,
      ),
    );
    if (paymentStatusResult is! PaymentStatus) {
      // confirmPayment threw an error — detect the error type and show result
      final errorType = _detectErrorType(paymentStatusResult);
      String? errorMsg;
      if (errorType == 'generic') {
        if (paymentStatusResult is PayError) {
          errorMsg = paymentStatusResult.message;
        } else {
          errorMsg = paymentStatusResult.toString();
        }
      }
      final errorResult = await _bottomSheetHandler.queueBottomSheet(
        widget: WCPPaymentResult(
          status: PaymentStatus.failed,
          info: _currentPaymentOptions!.info!,
          errorType: errorType,
          errorMessage: errorMsg,
        ),
      );
      _pendingPaymentRequest = null;
      _currentPaymentOptions = null;
      if (errorResult == 'scan_qr') {
        _openScanModal();
      }
      return;
    }

    // Step 3: Payment Result
    if (paymentStatusResult == PaymentStatus.succeeded) {
      // Persist the unit the user just paid with so the next merchant flow
      // can pre-select the same token when available.
      unawaited(WCPLastTokenStore.instance.write(selectedOption.amount.unit));
    }
    String? errorType;
    errorType = _paymentErrorType(paymentStatusResult);
    final resultStatus = await _bottomSheetHandler.queueBottomSheet(
      widget: WCPPaymentResult(
        status: paymentStatusResult,
        info: _currentPaymentOptions!.info!,
        errorType: errorType,
      ),
    );
    _pendingPaymentRequest = null;
    _currentPaymentOptions = null;

    if (resultStatus == 'scan_qr') {
      _openScanModal();
      return;
    }

    if (resultStatus != WCBottomSheetResult.next.name &&
        resultStatus != WCBottomSheetResult.close.name &&
        resultStatus != null) {
      throw resultStatus;
    }
  }

  String _detectErrorType(dynamic error) {
    // Check typed SDK errors first. The native layer surfaces the Yttrium pay
    // error variant name / HTTP status as `code` (e.g. PaymentExpired, 410),
    // which is far more reliable than substring-matching the message.
    if (error is ConfirmPaymentError || error is GetPaymentOptionsError) {
      final code = (error as PayError).code.toLowerCase();
      if (code.contains('expired') || code == '410') {
        return 'expired';
      }
      if (code.contains('cancel')) {
        return 'cancelled';
      }
      if (code.contains('notfound') || code == '404') {
        return 'not_found';
      }
      if (code.contains('insufficient') || code.contains('funds')) {
        return 'insufficient_funds';
      }

      final message = error.message?.toLowerCase() ?? '';
      final byMessage = _detectErrorTypeFromString(message);
      if (byMessage != null) {
        return byMessage;
      }
    }

    // Fallback: string matching on toString()
    return _detectErrorTypeFromString(error.toString().toLowerCase()) ??
        'generic';
  }

  /// Substring-based classification shared by the message and toString()
  /// fallbacks. Keyword set mirrors the RN reference wallet's detectErrorType.
  String? _detectErrorTypeFromString(String value) {
    if (value.contains('insufficient') ||
        value.contains('balance') ||
        value.contains('funds')) {
      return 'insufficient_funds';
    }
    if (value.contains('expired') || value.contains('timeout')) {
      return 'expired';
    }
    if (value.contains('cancel')) {
      return 'cancelled';
    }
    if (value.contains('not found') || value.contains('404')) {
      return 'not_found';
    }
    return null;
  }

  String? _paymentErrorType(PaymentStatus status) {
    if (status == PaymentStatus.failed) {
      return 'generic';
    }
    if (status == PaymentStatus.expired) {
      return 'expired';
    }
    if (status == PaymentStatus.cancelled) {
      return 'cancelled';
    }
    return null;
  }

  /// Maps the payment status carried by a successful (but option-less)
  /// getPaymentOptions response to a result-modal error type. Terminal
  /// payments (expired / cancelled / already paid) surface their own message;
  /// an active payment with no affordable option falls back to no-funds.
  String _emptyOptionsErrorType(PaymentInfo? info) {
    switch (info?.status) {
      case PaymentStatus.expired:
        return 'expired';
      case PaymentStatus.cancelled:
        return 'cancelled';
      case PaymentStatus.succeeded:
        // Already paid (e.g. re-scanning a completed payment) — surfaced as a
        // generic result, matching the shared Maestro pay test contract.
        return 'generic';
      case PaymentStatus.failed:
        return 'generic';
      case PaymentStatus.requires_action:
      case PaymentStatus.processing:
      case null:
        return 'insufficient_funds';
    }
  }

  void _openScanModal() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => const ScanModal(),
      );
    }
  }
}
