import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack.dart';

import 'package:reown_core/pairing/utils/json_rpc_utils.dart';
import 'package:reown_core/store/i_store.dart';

import 'package:reown_appkit/modal/services/coinbase_service/utils/coinbase_utils.dart';
import 'package:reown_appkit/modal/services/phantom_service/models/phantom_events.dart';
import 'package:reown_appkit/modal/services/third_party_wallet_service.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/services/phantom_service/i_phantom_service.dart';
import 'package:reown_appkit/modal/services/phantom_service/phantom_service.dart';
import 'package:reown_appkit/modal/pages/wallet_features_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/blockchain_identity.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/network_service/i_network_service.dart';
import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service.dart';
import 'package:reown_appkit/modal/services/uri_service/i_url_utils.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/services/network_service/network_service.dart';
import 'package:reown_appkit/modal/services/uri_service/launch_url_exception.dart';
import 'package:reown_appkit/modal/services/uri_service/url_utils.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/pages/account_page.dart';
import 'package:reown_appkit/modal/pages/approve_siwe.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/coinbase_service/coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/i_coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_data.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_events.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/redirect.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_data.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/services/siwe_service/siwe_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/blockchain_service.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/widgets/modal_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

/// Either a [projectId] and [metadata] must be provided or an already created [appKit].
/// optionalNamespaces is mostly not needed, if you use it, the values set here will override every optionalNamespaces set in evey chain
class ReownAppKitModal
    with ChangeNotifier, WidgetsBindingObserver
    implements IReownAppKitModal {
  String _projectId = '';

  @Deprecated(
    'requiredNamespaces are automatically assigned to optionalNamespaces. Considering using only optionalNamespaces',
  )
  @override
  Map<String, RequiredNamespace> get requiredNamespaces => {};

  Map<String, RequiredNamespace> _sessionNamespaces = {};
  @override
  Map<String, RequiredNamespace> get optionalNamespaces => _sessionNamespaces;

  bool _supportsOneClickAuth = false;
  bool _relayConnected = false;

  ReownAppKitModalStatus _status = ReownAppKitModalStatus.idle;
  @override
  ReownAppKitModalStatus get status => _status;

  // TODO convert into a Record
  /// CAIP-2 chain id
  String? _lastChainEmitted;
  String? _selectedChainID;
  @override
  ReownAppKitModalNetworkInfo? get selectedChain {
    if (NamespaceUtils.isValidChainId(_selectedChainID ?? '')) {
      final namespace = NamespaceUtils.getNamespaceFromChain(_selectedChainID!);
      final id = ReownAppKitModalNetworks.getIdFromChain(_selectedChainID!);
      return ReownAppKitModalNetworks.getNetworkInfo(namespace, id);
    }
    return null;
  }

  @override
  Future<void> switchSmartAccounts() async {
    _currentSession!.switchSmartAccounts();
    await loadAccountData();
  }

  ReownAppKitModalWalletInfo? _selectedWallet;
  @override
  ReownAppKitModalWalletInfo? get selectedWallet => _selectedWallet;

  @override
  bool get hasNamespaces => _sessionNamespaces.isNotEmpty;

  String _wcUri = '';
  @override
  String? get wcUri => _wcUri;

  late IReownAppKit _appKit;
  @override
  IReownAppKit? get appKit => _appKit;

  BlockchainIdentity? _blockchainIdentity;
  @override
  BlockchainIdentity? get blockchainIdentity => _blockchainIdentity;

  double? _chainBalance;
  @override
  final balanceNotifier = ValueNotifier<String>('-.--');

  bool _isDisposed = false;
  bool _isOpen = false;
  @override
  bool get isOpen => _isOpen;

  bool _isConnected = false;
  @override
  bool get isConnected => _isConnected;

  ReownAppKitModalSession? _currentSession;
  @override
  ReownAppKitModalSession? get session => _currentSession;

  IStore<Map<String, dynamic>> get _storage => _appKit.core.storage;

  bool _disconnectOnClose = false;

  bool get _isOnline => _appKit.core.connectivity.isOnline.value;

  BuildContext? _context;
  @override
  BuildContext? get modalContext {
    if (_context?.mounted == true) {
      return _context;
    }
    return null;
  }

  @override
  late final FeaturesConfig featuresConfig;

  ///
  late final Future<double> Function()? _getBalance;
  Completer<bool> _awaitRelayOnce = Completer<bool>();

  bool _disconnectOnDispose = true;

  late final List<ReownAppKitModalWalletInfo> _customWallets;

  ReownAppKitModal({
    required BuildContext context,
    IReownAppKit? appKit,
    String? projectId,
    PairingMetadata? metadata,
    bool? enableAnalytics,
    SIWEConfig? siweConfig,
    FeaturesConfig? featuresConfig,
    @Deprecated(
      'requiredNamespaces are automatically assigned to optionalNamespaces. Considering using only optionalNamespaces',
    )
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Set<String>? featuredWalletIds,
    Set<String>? includedWalletIds,
    Set<String>? excludedWalletIds,
    Future<double> Function()? getBalanceFallback,
    LogLevel logLevel = LogLevel.nothing,
    bool disconnectOnDispose = true,
    List<ReownAppKitModalWalletInfo> customWallets = const [],
  }) {
    if (appKit == null) {
      if (projectId == null) {
        throw ReownAppKitModalException(
          'Either a `projectId` and `metadata` must be provided or an already created `appKit` instance. '
          'See https://docs.reown.com/appkit/flutter/core/usage#initialization',
        );
      }
      if (metadata == null) {
        throw ReownAppKitModalException(
          '`metadata:` parameter is required when using `projectId:`. '
          'See https://docs.reown.com/appkit/flutter/core/usage#initialization',
        );
      }
    }

    this.featuresConfig = featuresConfig ?? FeaturesConfig();

    _context = context;
    _getBalance = getBalanceFallback;
    _disconnectOnDispose = disconnectOnDispose;
    _customWallets = customWallets;

    _appKit = appKit ??
        ReownAppKit(
          core: ReownCore(
            projectId: projectId!,
            logLevel: logLevel,
          ),
          metadata: metadata!,
        );
    _projectId = _appKit.core.projectId;

    _setOptionalNamespaces(_buildNamespaces(
      requiredNamespaces,
      optionalNamespaces,
    ));

    _registerSingleton<IWidgetStack>(
      () => WidgetStack(core: _appKit.core),
    );
    _registerSingleton<IUriService>(
      () => UriService(core: _appKit.core),
    );
    _registerSingleton<IAnalyticsService>(
      () => AnalyticsService(
        core: _appKit.core,
        enableAnalytics: enableAnalytics,
      ),
    );
    _registerSingleton<IExplorerService>(
      () => ExplorerService(
        core: _appKit.core,
        referer: _appKit.metadata.name.replaceAll(' ', ''),
        featuredWalletIds: featuredWalletIds,
        includedWalletIds: includedWalletIds,
        excludedWalletIds: excludedWalletIds,
        namespaces: _sessionNamespaces,
        customWallets: _customWallets,
      ),
    );
    _registerSingleton<INetworkService>(() => NetworkService());
    _registerSingleton<IToastService>(() => ToastService());
    _registerSingleton<IBlockChainService>(
      () => BlockChainService(
        core: _appKit.core,
      ),
    );
    _registerSingleton<IMagicService>(
      () => MagicService(
        core: _appKit.core,
        metadata: _appKit.metadata,
        featuresConfig: this.featuresConfig,
      ),
    );
    _registerSingleton<ICoinbaseService>(
      () => CoinbaseService(
        core: _appKit.core,
        metadata: _appKit.metadata,
        enabled: _initializeCoinbaseSDK,
      ),
    );
    _registerSingleton<IPhantomService>(
      () => PhantomService(
        core: _appKit.core,
        metadata: _appKit.metadata,
      ),
    );
    _registerSingleton<ISiweService>(
      () => SiweService(
        appKit: _appKit,
        siweConfig: siweConfig,
        namespaces: _sessionNamespaces,
      ),
    );
  }

  T _registerSingleton<T extends Object>(T Function() factoryFunc) =>
      GetIt.I.registerSingletonIfAbsent<T>(factoryFunc);

  T _getSingleton<T extends Object>() => GetIt.I<T>();

  FutureOr _unregisterSingleton<T extends Object>() => GetIt.I.unregister<T>();

  IMagicService get _magicService => _getSingleton<IMagicService>();
  ICoinbaseService get _coinbaseService => _getSingleton<ICoinbaseService>();
  IPhantomService get _phantomService => _getSingleton<IPhantomService>();

  IWidgetStack get _widgetStack => _getSingleton<IWidgetStack>();
  IUriService get _uriService => _getSingleton<IUriService>();
  IToastService get _toastService => _getSingleton<IToastService>();
  IAnalyticsService get _analyticsService => _getSingleton<IAnalyticsService>();
  IExplorerService get _explorerService => _getSingleton<IExplorerService>();
  INetworkService get _networkService => _getSingleton<INetworkService>();
  IBlockChainService get _blockchainService =>
      _getSingleton<IBlockChainService>();
  ISiweService get _siweService => _getSingleton<ISiweService>();

  bool _isValidProjectID() {
    if (!CoreUtils.isValidProjectID(_projectId)) {
      _appKit.core.logger.e(
        '[$runtimeType] Please provide a valid projectId ($_projectId). '
        'See ${UrlConstants.docsUrl}/appkit/flutter/core/usage for details.',
      );
      _status = ReownAppKitModalStatus.error;
      _notify();
      return false;
    }
    return true;
  }

  bool _hasValidNamespaces() {
    if (!hasNamespaces) {
      final supportedChains = ReownAppKitModalNetworks.getAllSupportedNetworks()
          .map((e) => e.chainId)
          .join(', ');
      _appKit.core.logger.d(
        '[$runtimeType] supported networks: $supportedChains',
      );
      _appKit.core.logger.e(
        '[$runtimeType] You are configuring AppKit without any namespaces. '
        'Try adding `optionalNamespaces` parameter or support chains with `ReownAppKitModalNetworks`',
      );
      _status = ReownAppKitModalStatus.error;
      _notify();
      return false;
    }
    return true;
  }

  ////////* PUBLIC METHODS */////////

  @override
  Future<void> init() async {
    _relayConnected = false;
    _awaitRelayOnce = Completer<bool>();

    if (!_isValidProjectID()) {
      return;
    }
    if (!_hasValidNamespaces()) {
      return;
    }
    if (_status == ReownAppKitModalStatus.initializing ||
        _status == ReownAppKitModalStatus.initialized) {
      return;
    }

    _status = ReownAppKitModalStatus.initializing;
    _notify();

    _registerListeners();

    await _appKit.init();
    await _networkService.init();
    await _explorerService.init();
    await _coinbaseService.init();
    await _phantomService.init();
    await _blockchainService.init();
    await _analyticsService.init();

    _analyticsService.sendEvent(ModalLoadedEvent());

    _currentSession = await _getStoredSession();
    _selectedChainID = _getStoredChainId();
    final isMagic = _currentSession?.sessionService.isMagic == true;
    final isCoinbase = _currentSession?.sessionService.isCoinbase == true;
    final isPhantom = _currentSession?.sessionService.isPhantom == true;
    if (isMagic || isCoinbase || isPhantom) {
      _selectedChainID ??= _currentSession!.chainId;
      await _setSesionAndChainData(_currentSession!);
      if (isMagic) {
        await _magicService.init(chainId: _selectedChainID);
      }
    } else {
      _magicService.init();
    }

    await expirePreviousInactivePairings();

    final wcPairings = _appKit.pairings.getAll();
    final wcSessions = _appKit.sessions.getAll();

    // Loop through all the chain data
    final allNetworks = ReownAppKitModalNetworks.getAllSupportedNetworks();
    for (final chain in allNetworks) {
      final namespace = NamespaceUtils.getNamespaceFromChain(chain.chainId);
      final events = _sessionNamespaces[namespace]?.events ?? [];
      for (final event in events) {
        _appKit.registerEventHandler(
          chainId: chain.chainId,
          event: event,
        );
      }
      _appKit.registerEventHandler(
        chainId: chain.chainId,
        event: 'reown_updateEmail',
      );
    }

    // There's a WC/Relay session stored
    if (wcSessions.isNotEmpty) {
      await _storeSession(ReownAppKitModalSession(
        sessionData: wcSessions.first,
      ));
      // session should not outlive the pairing
      if (wcPairings.isEmpty) {
        await disconnect();
      } else {
        await _checkSIWEStatus();
      }
    } else {
      // Check for other type of sessions stored
      if (_currentSession != null) {
        if (_currentSession!.sessionService.isCoinbase) {
          final isConnected = await _coinbaseService.isConnected();
          if (!isConnected) {
            await _cleanSession();
          }
        } else if (_currentSession!.sessionService.isPhantom) {
          final isConnected = await _phantomService.isConnected();
          if (!isConnected) {
            await _cleanSession();
          }
        } else {
          await _cleanSession();
        }
      }
    }

    // Get the chainId of the chain we are connected to.
    await _selectChainFromStoredId();

    onModalNetworkChange.subscribe(_onNetworkChainRequireSIWE);

    _relayConnected = _appKit.core.relayClient.isConnected;
    if (!_relayConnected && _isOnline) {
      _relayConnected = await _awaitRelayOnce.future;
    } else {
      if (!_awaitRelayOnce.isCompleted) {
        _awaitRelayOnce.complete(_relayConnected);
      }
    }
    _status = _relayConnected
        ? ReownAppKitModalStatus.initialized
        : ReownAppKitModalStatus.initializing;
    _appKit.core.logger.i(
      '[$runtimeType] status $_status with session ${jsonEncode(_currentSession?.toJson())}',
    );
    if (!_isOnline) {
      // We enable buttons anyway in case we want to use LM
      _status = ReownAppKitModalStatus.initialized;
    }
    _notify();

    if (_currentSession != null) {
      onModalConnect.broadcast(ModalConnect(_currentSession!));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      reconnectRelay();
    }
  }

  @override
  Future<bool> dispatchEnvelope(String url) async {
    _appKit.core.logger.d('[$runtimeType] dispatchEnvelope $url');
    final envelope = ReownCoreUtils.getSearchParamFromURL(url, 'wc_ev');
    if (envelope.isNotEmpty) {
      await _appKit.dispatchEnvelope(url);
      return true;
    }

    final phantomRequest = ReownCoreUtils.getSearchParamFromURL(
      url,
      'phantomRequest',
    );
    if (phantomRequest.isNotEmpty) {
      _phantomService.completePhantomRequest(url: url);
      return true;
    }

    return false;
  }

  Future<void> _checkSIWEStatus() async {
    // check if SIWE is enabled and should still sign the message
    if (_siweService.enabled) {
      try {
        // If getSession() throws it means message has not been signed and
        // we should present modal with ApproveSIWEPage
        final siweSession = await _siweService.getSession();
        final session = _currentSession!.copyWith(siweSession: siweSession);
        await _setSesionAndChainData(session);
        _notify();
      } catch (_) {
        _disconnectOnClose = true;
        _showModalView(
          startWidget: ApproveSIWEPage(onSiweFinish: _oneSIWEFinish),
        );
      }
    }
  }

  Future<void> _setSesionAndChainData(ReownAppKitModalSession mSession) async {
    try {
      await _storeSession(mSession);
      _selectedChainID = _selectedChainID ?? mSession.chainId;
      await _setLocalEthChain(_selectedChainID!, logEvent: false);
    } catch (e) {
      _appKit.core.logger.e('[$runtimeType] _setSesionAndChainData error $e');
    }
  }

  Future<ReownAppKitModalSession?> _getStoredSession() async {
    try {
      if (_storage.has(StorageConstants.modalSession)) {
        final storedSession = _storage.get(StorageConstants.modalSession);
        _appKit.core.logger.d(
          '[$runtimeType] _getStoredSession, ${jsonEncode(storedSession)}',
        );
        if (storedSession != null) {
          return ReownAppKitModalSession.fromMap(storedSession);
        }
      }
    } catch (e) {
      _appKit.core.logger.e('[$runtimeType] _getStoredSession error: $e');
    }
    return null;
  }

  Future<void> _storeSession(ReownAppKitModalSession modalSession) async {
    _currentSession = modalSession;
    try {
      await _storage.set(
        StorageConstants.modalSession,
        _currentSession!.toMap(),
      );
    } catch (e) {
      _appKit.core.logger.e('[$runtimeType] _storeSession error: $e');
    }
    // _isConnected shoudl probably go at the very end of the connection
    _isConnected = true;
  }

  Future<void> _selectChainFromStoredId() async {
    if (_currentSession != null) {
      final chainId = _getStoredChainId();
      if (chainId != null) {
        final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
        final chain = ReownAppKitModalNetworks.getNetworkInfo(
          namespace,
          chainId,
        );
        if (chain != null) {
          await _setLocalEthChain(chainId, logEvent: false);
        }
      } else {
        _selectedChainID = chainId;
      }
    }
  }

  @override
  Future<void> selectChain(
    ReownAppKitModalNetworkInfo? chainInfo, {
    bool switchChain = false,
    bool logEvent = true,
  }) async {
    _checkInitialized();

    if (chainInfo?.chainId == _selectedChainID) {
      return;
    }

    // If the chain is null, disconnect and stop.
    if (chainInfo == null) {
      await disconnect();
      return;
    }

    _chainBalance = null;

    try {
      final formattedBalance = CoreUtils.formatChainBalance(_chainBalance);
      balanceNotifier.value = '$formattedBalance ${chainInfo.currency}';

      final hasValidSession = _isConnected && _currentSession != null;
      final ns = NamespaceUtils.getNamespaceFromChain(chainInfo.chainId);
      final approvedChains = _currentSession?.getApprovedChains(namespace: ns);
      final isApproved = (approvedChains ?? []).contains(chainInfo.chainId);

      if (switchChain &&
          hasValidSession &&
          _selectedChainID != null &&
          !isApproved) {
        await requestSwitchToChain(chainInfo);
      } else {
        await _setLocalEthChain(chainInfo.chainId, logEvent: logEvent);
      }
    } on JsonRpcError catch (e) {
      onModalError.broadcast(ModalError(e.message ?? 'An error occurred'));
    } on ReownAppKitModalException catch (e) {
      onModalError.broadcast(ModalError(e.message));
    } catch (e, s) {
      _appKit.core.logger.e('[$runtimeType] selectChain, error: $e, $s');
      onModalError.broadcast(ModalError('An error occurred'));
    }
  }

  /// Will get the list of available chains to add
  @override
  List<String>? getAvailableChains() {
    // if there's no session or if supportsAddChain method then every chain can be used
    if (_currentSession == null) {
      // meaning all chains in the list are available
      return null;
    }
    // Valid only for EVM chains
    final hasSwitchMethod = _currentSession!.hasSwitchMethod();
    if (!hasSwitchMethod) {
      return getApprovedChains();
    }

    final isMagic = _currentSession!.sessionService.isMagic;
    final isCoinbase = _currentSession!.sessionService.isCoinbase;
    final isPhantom = _currentSession!.sessionService.isPhantom;
    if (isMagic || isCoinbase || isPhantom) {
      return getApprovedChains();
    }

    List<String> availableChains = [];
    final namespaces = ReownAppKitModalNetworks.getAllSupportedNamespaces();
    for (var namespace in namespaces) {
      final chains = ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: namespace,
      ).map((e) => e.chainId).toList();
      availableChains.addAll(chains);
    }
    if (availableChains.isEmpty) {
      return getApprovedChains();
    }

    return availableChains;
  }

  /// Will get the list of already approved chains by the wallet (to switch to)
  @override
  List<String>? getApprovedChains({String? namespace}) {
    if (_currentSession == null) {
      return null;
    }
    return _currentSession!.getApprovedChains(namespace: namespace);
  }

  @override
  List<String>? getApprovedMethods({String? namespace}) {
    if (_currentSession == null) {
      return null;
    }
    return _currentSession!.getApprovedMethods(namespace: namespace);
  }

  @override
  List<String>? getApprovedEvents({String? namespace}) {
    if (_currentSession == null) {
      return null;
    }
    return _currentSession!.getApprovedEvents(namespace: namespace);
  }

  Future<void> _setLocalEthChain(String chainId, {bool? logEvent}) async {
    _appKit.core.logger.d('[$runtimeType] _setLocalEthChain $chainId');
    _selectedChainID = chainId;
    _notify();
    try {
      if (isConnected) {
        await _storage.set(
          StorageConstants.selectedChainId,
          {'chainId': _selectedChainID},
        );
      }
    } catch (e) {
      _appKit.core.logger.e('[$runtimeType] _setLocalEthChain error: $e');
    }
    if (_isConnected && logEvent == true) {
      _analyticsService.sendEvent(SwitchNetworkEvent(
        network: _selectedChainID!,
      ));
    }
    if (_lastChainEmitted != _selectedChainID && _isConnected) {
      if (_lastChainEmitted != null) {
        onModalNetworkChange.broadcast(ModalNetworkChange(
          chainId: _selectedChainID!,
        ));
      }
      _lastChainEmitted = _selectedChainID;
    }
    loadAccountData();
  }

  @override
  Future<void> openNetworksView() {
    return _showModalView(
      startWidget: ReownAppKitModalSelectNetworkPage(
        onTapNetwork: (info) {
          selectChain(info);
          _widgetStack.addDefault();
        },
      ),
    );
  }

  @override
  Future<void> openModalView([Widget? startWidget]) {
    final keyString = startWidget?.key?.toString() ?? '';
    final smartAccounts = _currentSession?.sessionSmartAccounts;
    final isMagic = _currentSession?.sessionService.isMagic == true;
    final embeddedWallet = isMagic || (smartAccounts ?? []).isNotEmpty;
    if (_isConnected) {
      final connectedKeys =
          _allowedScreensWhenConnected.map((e) => e.toString()).toList();
      if (startWidget == null) {
        startWidget =
            embeddedWallet ? const WalletFeaturesPage() : const AccountPage();
      } else {
        if (!connectedKeys.contains(keyString)) {
          startWidget =
              embeddedWallet ? const WalletFeaturesPage() : const AccountPage();
        }
      }
    } else {
      final disconnectedKeys =
          _allowedScreensWhenDisconnected.map((e) => e.toString()).toList();
      if (startWidget != null && !disconnectedKeys.contains(keyString)) {
        startWidget = null;
      }
    }
    return _showModalView(startWidget: startWidget);
  }

  final List<Key> _allowedScreensWhenConnected = [
    KeyConstants.approveTransactionPage,
    KeyConstants.confirmEmailPage,
    KeyConstants.selectNetworkPage,
    KeyConstants.eoAccountPage,
    KeyConstants.walletFeaturesPage,
    KeyConstants.socialLoginPage,
  ];

  final List<Key> _allowedScreensWhenDisconnected = [
    KeyConstants.walletListShortPageKey,
    KeyConstants.walletListLongPageKey,
    KeyConstants.qrCodePageKey,
    KeyConstants.selectNetworkPage,
  ];

  Future<void> _showModalView({
    BuildContext? context,
    Widget? startWidget,
  }) async {
    _checkInitialized();

    if (_isOpen) {
      closeModal();
      return;
    }
    _isOpen = true;
    _context = context ?? modalContext;

    if (_context == null) {
      _appKit.core.logger.e(
        'No context was found. '
        'Try adding `context:` parameter in ReownAppKitModal class',
      );
      return;
    }

    _analyticsService.sendEvent(ModalOpenEvent(
      connected: _isConnected,
    ));

    // Reset the explorer
    _explorerService.search(query: null);
    _widgetStack.clear();

    final isBottomSheet = PlatformUtils.isBottomSheet();
    final theme = ReownAppKitModalTheme.maybeOf(_context!);
    await _magicService.syncTheme(theme);
    final themeData = theme?.themeData ?? const ReownAppKitModalThemeData();

    Widget? showWidget = startWidget;
    if (_isConnected && showWidget == null) {
      final isMagic = _currentSession?.sessionService.isMagic == true;
      startWidget = isMagic ? const WalletFeaturesPage() : const AccountPage();
    }

    final childWidget = theme == null
        ? ReownAppKitModalTheme(
            themeData: themeData,
            child: ModalContainer(startWidget: showWidget),
          )
        : ModalContainer(startWidget: showWidget);

    final rootWidget = ModalProvider(
      instance: this,
      child: childWidget,
    );

    final isTabletSize = PlatformUtils.isTablet(_context!);

    if (isBottomSheet && !isTabletSize) {
      final mqData = MediaQueryData.fromView(View.of(_context!));
      final safeGap = mqData.viewPadding.bottom;
      final maxHeight = mqData.size.height - safeGap - 20.0;
      await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: false,
        elevation: 0.0,
        useRootNavigator: true,
        constraints: BoxConstraints(maxHeight: maxHeight),
        context: _context!,
        builder: (_) => rootWidget,
      );
      _close();
    } else {
      await showDialog(
        barrierDismissible: false,
        useSafeArea: true,
        useRootNavigator: true,
        anchorPoint: Offset(0, 0),
        context: _context!,
        builder: (_) {
          final radiuses = ReownAppKitModalTheme.radiusesOf(_context!);
          final maxRadius = min(radiuses.radiusM, 36.0);
          final borderRadius = BorderRadius.all(Radius.circular(maxRadius));
          final constraints = BoxConstraints(maxWidth: 360, maxHeight: 600);
          return Dialog(
            backgroundColor:
                ReownAppKitModalTheme.colorsOf(_context!).background125,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            clipBehavior: Clip.hardEdge,
            child: ConstrainedBox(
              constraints: constraints,
              child: rootWidget,
            ),
          );
        },
      );
      _close();
    }

    _isOpen = false;
    _notify();
  }

  @override
  Future<void> expirePreviousInactivePairings() async {
    for (var pairing in _appKit.pairings.getAll()) {
      if (!pairing.active) {
        await _appKit.core.expirer.expire(pairing.topic);
      }
    }
  }

  void _trackSelectedWallet(
    WalletRedirect? walletRedirect, {
    bool inBrowser = false,
  }) {
    try {
      final walletName = _selectedWallet!.listing.name;
      final walletId = _selectedWallet!.listing.id;
      final event = SelectWalletEvent(
        name: walletName,
        explorerId: walletId,
        platform: inBrowser ? AnalyticsPlatform.web : AnalyticsPlatform.mobile,
      );
      _analyticsService.sendEvent(event);
    } catch (_) {}
  }

  @override
  Future<void> connectSelectedWallet({
    bool inBrowser = false,
    AppKitSocialOption? socialOption,
  }) async {
    _checkInitialized();

    final walletRedirect = _explorerService.getWalletRedirect(
      _selectedWallet,
    );

    if (walletRedirect == null) {
      throw ReownAppKitModalException(
        'You didn\'t select a wallet or walletInfo argument is null',
      );
    }
    _trackSelectedWallet(walletRedirect, inBrowser: inBrowser);

    var pType = PlatformUtils.getPlatformType();
    if (inBrowser) {
      pType = PlatformType.web;
    }
    try {
      if (_selectedWallet!.isCoinbase) {
        await _coinbaseService.getAccount();
      } else if (_selectedWallet!.isPhantom) {
        await _phantomService.connect(chainId: _selectedChainID);
      } else {
        await _connect(walletRedirect, pType, socialOption);
      }
    } on LaunchUrlException catch (e) {
      if (e is CanNotLaunchUrl) {
        onModalError.broadcast(WalletNotInstalled());
      } else {
        onModalError.broadcast(ErrorOpeningWallet());
      }
    } on ThirdPartyWalletException catch (e) {
      if (e is ThirdPartyWalletNotInstalled) {
        onModalError.broadcast(WalletNotInstalled());
      } else {
        onModalError.broadcast(ErrorOpeningWallet(description: e.message));
      }
    } catch (e, s) {
      if (e is PlatformException) {
        final installed = _selectedWallet?.installed ?? false;
        if (!installed) {
          onModalError.broadcast(WalletNotInstalled());
        } else {
          onModalError.broadcast(ErrorOpeningWallet());
        }
      } else if (e is CoinbaseServiceException) {
        if (e is CoinbaseWalletNotInstalledException) {
          onModalError.broadcast(WalletNotInstalled());
        } else {
          if (_isUserRejectedError(e)) {
            onModalError.broadcast(UserRejectedConnection());
            _analyticsService.sendEvent(ConnectErrorEvent(
              message: 'User declined connection',
            ));
          } else {
            onModalError.broadcast(ErrorOpeningWallet());
            _analyticsService.sendEvent(ConnectErrorEvent(
              message: e.message,
            ));
          }
        }
      } else {
        if (_isUserRejectedError(e)) {
          onModalError.broadcast(UserRejectedConnection());
          _analyticsService.sendEvent(ConnectErrorEvent(
            message: 'User declined connection',
          ));
        } else if (e is ReownCoreError) {
          onModalError.broadcast(ErrorOpeningWallet(description: e.message));
          _appKit.core.logger.e(
            '[$runtimeType] connectSelectedWallet error: $e',
            stackTrace: s,
          );
        } else {
          onModalError.broadcast(ErrorOpeningWallet());
          _appKit.core.logger.e(
            '[$runtimeType] connectSelectedWallet error: $e',
            stackTrace: s,
          );
        }
      }
    }
  }

  Future<void> _connect(
    WalletRedirect redirect,
    PlatformType pType,
    AppKitSocialOption? socialOption,
  ) async {
    await buildConnectionUri();
    final linkMode = redirect.linkMode ?? '';
    if (linkMode.isNotEmpty && _wcUri.startsWith(linkMode)) {
      await ReownCoreUtils.openURL(_wcUri);
    }
    // else if (socialOption != null) {
    //   final url = CoreUtils.formatWebUrl(redirect.web, _wcUri);
    //   final social = socialOption.name.toLowerCase();
    //   await ReownCoreUtils.openURL('$url&provider=$social');
    // }
    else {
      await _uriService.openRedirect(
        redirect,
        wcURI: _wcUri,
        pType: pType,
        socialOption: socialOption,
      );
    }
  }

  @override
  Future<void> buildConnectionUri() async {
    if (!_isConnected) {
      try {
        if (_siweService.enabled) {
          final walletRedirect = _explorerService.getWalletRedirect(
            _selectedWallet,
          );
          final nonce = await _siweService.getNonce();
          final p1 = await _siweService.config!.getMessageParams();
          final methods =
              p1.methods ?? NetworkUtils.defaultNetworkMethods['eip155'];
          //
          final networks = ReownAppKitModalNetworks.getAllSupportedNetworks();
          final chainIds = networks.map((chain) => chain.chainId).toList();
          final p2 = {'nonce': nonce, 'chains': chainIds, 'methods': methods};
          final authParams = SessionAuthRequestParams.fromJson({
            ...p1.toJson(),
            ...p2,
          });
          // One-Click Auth
          _appKit.core.logger.d(
            '[$runtimeType] authenticate ${jsonEncode(authParams.toJson())}, ${walletRedirect?.linkMode}',
          );
          final authResponse = await _appKit.authenticate(
            params: authParams,
            walletUniversalLink: walletRedirect?.linkMode,
          );
          _wcUri = authResponse.uri?.toString() ?? '';
          _notify();
          _awaitOCAuthCallback(authResponse);
        } else {
          // Regular Session Proposal
          final connectResponse = await _appKit.connect(
            optionalNamespaces: _sessionNamespaces,
          );
          _wcUri = connectResponse.uri?.toString() ?? '';
          _notify();
          _awaitConnectionCallback(connectResponse);
        }
      } catch (e) {
        _appKit.core.logger.e('[$runtimeType] buildConnectionUri error: $e');
        rethrow;
      }
    }
  }

  void _awaitConnectionCallback(ConnectResponse connectResponse) async {
    try {
      final _ = await connectResponse.session.future;
    } on TimeoutException {
      _appKit.core.logger.i('[$runtimeType] Rebuilding session, ending future');
      return;
    } catch (e, s) {
      await _connectionErrorHandler(e, s);
    }
  }

  SessionAuthResponse? _sessionAuthResponse;
  void _awaitOCAuthCallback(SessionAuthRequestResponse authResponse) async {
    try {
      _sessionAuthResponse = await authResponse.completer.future;
      _supportsOneClickAuth = true;
      if (_sessionAuthResponse?.session != null) {
        _appKit.onSessionConnect.broadcast(SessionConnect(
          _sessionAuthResponse!.session!,
        ));
      } else {
        if (_sessionAuthResponse?.jsonRpcError != null) {
          throw _sessionAuthResponse!.jsonRpcError!;
        }
        if (_sessionAuthResponse?.error != null) {
          throw _sessionAuthResponse!.error!;
        }
      }
    } on TimeoutException {
      _appKit.core.logger.i('[$runtimeType] Rebuilding session, ending future');
      return;
    } catch (e, s) {
      await disconnect();
      await _connectionErrorHandler(e, s);
    }
  }

  Future<void> _connectionErrorHandler(dynamic e, dynamic stackTrace) async {
    if (_isUserRejectedError(e)) {
      onModalError.broadcast(UserRejectedConnection());
      _analyticsService.sendEvent(ConnectErrorEvent(
        message: 'User declined connection',
      ));
    } else {
      if (e is JsonRpcError) {
        final message = e.message ?? '';
        final method = MethodConstants.WC_SESSION_AUTHENTICATE;
        if (e.code == 10001 && message.contains(method)) {
          _supportsOneClickAuth = false;
          // WILL HANDLE SESSION REQUEST
          return;
        }
        onModalError.broadcast(ModalError('Error connecting to wallet'));
        _analyticsService.sendEvent(ConnectErrorEvent(
          message: message,
        ));
      }
      if (e is ReownSignError || e is ReownCoreError) {
        onModalError.broadcast(ModalError(e.message));
        _analyticsService.sendEvent(ConnectErrorEvent(
          message: e.message,
        ));
      }
    }
    _appKit.core.logger.e('[$runtimeType] connection error: $e, $stackTrace');
    return await expirePreviousInactivePairings();
  }

  bool get _isLinkMode {
    final metadataRedirect = _currentSession!.peer?.metadata.redirect;
    final appLink = (metadataRedirect?.universal ?? '');
    final supportedApps = _appKit.core.getLinkModeSupportedApps();
    final isLinkMode = appLink.isNotEmpty && supportedApps.contains(appLink);
    return isLinkMode;
  }

  @Deprecated('This is not needed anymore and shouldn\'t be used')
  @override
  void launchConnectedWallet() async {}

  void _launchRequestOnWallet(int requestId) async {
    _checkInitialized();

    final walletInfo = _explorerService.getConnectedWallet();
    if (walletInfo == null) {
      // if walletInfo is null could mean that either
      // 1. There's no wallet connected (shouldn't happen)
      // 2. Wallet is connected on another device through qr code
      return;
    }

    final isCoinbase = _currentSession!.sessionService.isCoinbase == true;
    if (walletInfo.isCoinbase || isCoinbase) {
      // Coinbase Wallet is getting launched at every request by its service
      // So no need to do it here.
      return;
    }

    final isPhantom = _currentSession!.sessionService.isPhantom == true;
    if (walletInfo.isPhantom || isPhantom) {
      // Phantom Wallet is getting launched at every request by its service
      // So no need to do it here.
      return;
    }

    if (_currentSession!.sessionService.isMagic) {
      // There's no wallet to launch when connected with Email
      // TODO check if this is still relevant with web-wallet
      return;
    }

    if (_isLinkMode) {
      // Opening peers during Link Mode requests is handled in Sign Engine
      return;
    }

    final walletRedirect = _explorerService.getWalletRedirect(walletInfo);
    if (walletRedirect == null) {
      return;
    }

    try {
      final topic = _currentSession!.topic!;
      final metadataRedirect = _currentSession!.peer?.metadata.redirect;
      final link = metadataRedirect?.native ?? metadataRedirect?.universal;
      final redirect = walletRedirect.copyWith(
        // /wc path will be added in CoreUtils
        mobile: link != null ? _removeWcPath(link) : null,
      );
      final platform = PlatformUtils.getPlatformType();
      _uriService.openRedirect(
        redirect,
        pType: platform,
        wcURI: 'requestId=$requestId&sessionTopic=$topic',
      );
    } catch (e) {
      onModalError.broadcast(ErrorOpeningWallet());
    }
  }

  String _removeWcPath(String url) {
    var uri = Uri.parse(url);
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'wc') {
      uri = uri.replace(pathSegments: uri.pathSegments.skip(1).toList());
    }
    return uri.toString();
  }

  @override
  Future<void> reconnectRelay() async {
    try {
      if (!_appKit.core.relayClient.isConnected) {
        await _appKit.core.relayClient.connect();
      }
    } catch (e) {
      _appKit.core.logger.e('[$runtimeType] reconnectRelay $e');
    }
  }

  @override
  Future<void> disconnect({bool disconnectAllSessions = true}) async {
    _checkInitialized();

    if (!_appKit.core.relayClient.isConnected) {
      onModalError.broadcast(ModalError('Websocket is not connected'));
      return;
    }

    _status = ReownAppKitModalStatus.initializing;
    _notify();

    if (_currentSession?.sessionService.isCoinbase == true) {
      try {
        await _coinbaseService.resetSession();
      } catch (e) {
        _appKit.core.logger.d('[$runtimeType] disconnect coinbase $e');
        _status = ReownAppKitModalStatus.initialized;
        _notify();
        return;
      }
    }
    if (_currentSession?.sessionService.isPhantom == true) {
      try {
        await _phantomService.disconnect();
      } catch (e) {
        _appKit.core.logger.d('[$runtimeType] disconnect phantom $e');
        _status = ReownAppKitModalStatus.initialized;
        _notify();
        return;
      }
    }
    if (_currentSession?.sessionService.isMagic == true) {
      try {
        await Future.delayed(Duration(milliseconds: 300));
        await _magicService.disconnect();
      } catch (e) {
        _appKit.core.logger.d('[$runtimeType] disconnect magic $e');
        _status = ReownAppKitModalStatus.initialized;
        _notify();
        return;
      }
    }

    try {
      // If we want to disconnect all sessions, loop through them and disconnect them
      if (disconnectAllSessions) {
        for (final SessionData session in _appKit.sessions.getAll()) {
          await _disconnectSession(session.pairingTopic, session.topic);
        }
      } else {
        // Disconnect the session
        await _disconnectSession(
          _currentSession?.pairingTopic,
          _currentSession?.topic,
        );
      }
      try {
        if (_siweService.signOutOnDisconnect) {
          await _siweService.signOut();
        }
      } catch (_) {}

      _analyticsService.sendEvent(DisconnectSuccessEvent());
      if (!(_currentSession?.sessionService.isWC == true)) {
        // if sessionService.isWC then _cleanSession() is being called on sessionDelete event
        return await _cleanSession();
      }
      return;
    } catch (e) {
      if (_currentSession?.topic != null) {
        _appKit.sessions.delete(_currentSession!.topic!);
      }
      await _cleanSession();
      _analyticsService.sendEvent(DisconnectErrorEvent());
      _status = ReownAppKitModalStatus.initialized;
      _notify();
    }
  }

  @override
  void closeModal({bool disconnectSession = false}) async {
    _disconnectOnClose = disconnectSession;
    // If we aren't open, then we can't and shouldn't close
    _close();
    if (_context != null) {
      final canPop = Navigator.of(_context!, rootNavigator: true).canPop();
      if (canPop) {
        Navigator.of(_context!, rootNavigator: true).pop();
      }
    }
    _notify();
  }

  void _close() async {
    if (!_isOpen) {
      return;
    }
    _isOpen = false;
    final currentKey = _widgetStack.getCurrent().key;
    if (_disconnectOnClose) {
      _disconnectOnClose = false;
      if (currentKey == KeyConstants.approveSiwePageKey) {
        _analyticsService.sendEvent(ClickCancelSiwe(
          network: _selectedChainID ?? '',
        ));
      }
      await disconnect();
      selectWallet(null);
    }
    _toastService.clear();
    _blockchainService.selectSendToken(null);
    _analyticsService.sendEvent(ModalCloseEvent(
      connected: _isConnected,
    ));
  }

  @override
  void selectWallet(ReownAppKitModalWalletInfo? walletInfo) {
    _selectedWallet = walletInfo;
  }

  @override
  void launchBlockExplorer() async {
    if ((selectedChain?.explorerUrl ?? '').isNotEmpty) {
      final blockExplorer = selectedChain!.explorerUrl;
      final namespace = NamespaceUtils.getNamespaceFromChain(
        selectedChain!.chainId,
      );
      final address = _currentSession?.getAddress(namespace);
      final explorerUrl = '$blockExplorer/address/$address';
      await ReownCoreUtils.openURL(explorerUrl);
    }
  }

  @override
  Future<List<dynamic>> requestReadContract({
    required String? topic,
    required String chainId,
    required DeployedContract deployedContract,
    required String functionName,
    List parameters = const [],
  }) async {
    if (_currentSession == null) {
      throw ReownAppKitModalException('Session is null');
    }
    if (!NamespaceUtils.isValidChainId(chainId)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: 'chainId should conform to "CAIP-2" format',
      ).toSignError();
    }
    if (selectedChain == null) {
      throw Errors.getSdkError(
        Errors.MALFORMED_REQUEST_PARAMS,
        context: 'You must select a chain before reading a contract',
      ).toSignError();
    }
    //
    _appKit.core.logger.i(
      '[$runtimeType] requestReadContract, chainId: $chainId',
    );

    try {
      final data = deployedContract.function(functionName).encodeCall(
            parameters,
          );
      final params = {
        'from': _currentSession!.getAddress('eip155'),
        'to': deployedContract.address.hex,
        'data': '0x${_bytesToHex(data)}',
      };

      final rawCallResponse = await _blockchainService.rawCall(
        chainId: chainId,
        params: params,
      );
      return deployedContract.function(functionName).decodeReturnValues(
            rawCallResponse,
          );
    } catch (e, s) {
      _appKit.core.logger.e(
        '[$runtimeType] requestReadContract, error: $e, $s',
      );
      rethrow;
    }
  }

  String _bytesToHex(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  @override
  Future<dynamic> requestWriteContract({
    required String? topic,
    required String chainId,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    List<dynamic> parameters = const [],
    String? method,
  }) async {
    if (_currentSession == null) {
      throw ReownAppKitModalException('Session is null');
    }
    if (!NamespaceUtils.isValidChainId(chainId)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: 'chainId should conform to "CAIP-2" format',
      ).toSignError();
    }
    if (transaction.from == null) {
      throw Errors.getSdkError(
        Errors.MALFORMED_REQUEST_PARAMS,
        context: 'transaction must include `from` value',
      ).toSignError();
    }
    //
    _appKit.core.logger.i(
      '[$runtimeType] requestWriteContract, chainId: $chainId',
    );

    try {
      final trx = Transaction.callContract(
        contract: deployedContract,
        function: deployedContract.function(functionName),
        from: transaction.from!,
        value: transaction.value,
        maxGas: transaction.maxGas,
        gasPrice: transaction.gasPrice,
        nonce: transaction.nonce,
        maxFeePerGas: transaction.maxFeePerGas,
        maxPriorityFeePerGas: transaction.maxPriorityFeePerGas,
        parameters: parameters,
      );

      return await request(
        topic: topic,
        chainId: chainId,
        request: SessionRequestParams(
          method: method ?? MethodsConstants.ethSendTransaction,
          params: [trx.toJson()],
        ),
      );
    } catch (e, s) {
      _appKit.core.logger.e(
        '[$runtimeType] requestWriteContract, error: $e, $s',
      );
      rethrow;
    }
  }

  @override
  Future<dynamic> request({
    required String? topic,
    required String chainId,
    required SessionRequestParams request,
    String? switchToChainId,
  }) async {
    if (_currentSession == null) {
      throw ReownAppKitModalException('Session is null');
    }
    if (!NamespaceUtils.isValidChainId(chainId)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: 'chainId should conform to "CAIP-2" format',
      ).toSignError();
    }
    //
    _appKit.core.logger.d(
      '[$runtimeType] request, chainId: $chainId, '
      '${jsonEncode(request.toJson())}',
    );
    try {
      if (_currentSession!.sessionService.isMagic) {
        return await _magicService.request(
          chainId: chainId,
          request: request,
        );
      }
      if (_currentSession!.sessionService.isCoinbase) {
        return await _coinbaseService.request(
          chainId: switchToChainId ?? chainId,
          request: request,
        );
      }
      if (_currentSession!.sessionService.isPhantom) {
        return await _phantomService.request(
          chainId: chainId,
          request: request,
        );
      }

      final requestId = JsonRpcUtils.payloadId();
      final pendingRequest = _appKit.request(
        requestId: requestId,
        topic: topic!,
        chainId: chainId,
        request: request,
      );

      _launchRequestOnWallet(requestId);

      return await pendingRequest;
    } catch (e) {
      if (_isUserRejectedError(e)) {
        onModalError.broadcast(UserRejectedRequest());
        if (request.method == MethodsConstants.walletSwitchEthChain ||
            request.method == MethodsConstants.walletAddEthChain) {
          rethrow;
        }
        return Errors.getSdkError(Errors.USER_REJECTED).toJson();
      } else {
        if (e is CoinbaseServiceException) {
          // If the error is due to no session on Coinbase Wallet we disconnnect the session on Modal.
          // This is the only way to detect a missing session since Coinbase Wallet is not sending any event.
          throw ReownAppKitModalException('Coinbase Wallet Error');
        }
        rethrow;
      }
    }
  }

  @override
  Future<void> dispose() async {
    if (_status == ReownAppKitModalStatus.initialized) {
      _unregisterListeners();
      if (_disconnectOnDispose) {
        try {
          await expirePreviousInactivePairings();
          await disconnect();
          await _appKit.core.relayClient.disconnect();
          _relayConnected = false;
          _isConnected = false;
          _selectedChainID = null;
          _sessionNamespaces = {};
          _lastChainEmitted = null;
          _supportsOneClickAuth = false;
          _status = ReownAppKitModalStatus.idle;
        } catch (e) {
          _appKit.core.logger.e('[$runtimeType] disconnectOnDispose $e');
        }
      }
      _unregisterSingleton<IUriService>();
      _unregisterSingleton<IAnalyticsService>();
      _unregisterSingleton<IExplorerService>();
      _unregisterSingleton<INetworkService>();
      _unregisterSingleton<IToastService>();
      _unregisterSingleton<IBlockChainService>();
      _unregisterSingleton<IMagicService>();
      _unregisterSingleton<ICoinbaseService>();
      _unregisterSingleton<IPhantomService>();
      _unregisterSingleton<ISiweService>();
      _unregisterSingleton<IWidgetStack>();
      await Future.delayed(Duration(milliseconds: 500));
      _notify();
    }
    _isDisposed = true;
    _isOpen = false;
    super.dispose();
  }

  @override
  final Event<ModalConnect> onModalConnect = Event();

  @override
  final Event<ModalConnect> onModalUpdate = Event();

  @override
  final Event<ModalNetworkChange> onModalNetworkChange = Event();

  @override
  final Event<ModalDisconnect> onModalDisconnect = Event();

  @override
  final Event<ModalError> onModalError = Event();

  @override
  final Event<SessionExpire> onSessionExpireEvent = Event();

  @override
  final Event<SessionUpdate> onSessionUpdateEvent = Event();

  @override
  final Event<SessionEvent> onSessionEventEvent = Event();

  ////////* PRIVATE METHODS */////////

  void _notify() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  bool get _initializeCoinbaseSDK {
    final cbId = CoinbaseUtils.defaultListingData.id;
    final included = (_explorerService.includedWalletIds ?? <String>{});
    final excluded = (_explorerService.excludedWalletIds ?? <String>{});

    if (included.isNotEmpty) {
      return included.contains(cbId);
    }
    if (excluded.isNotEmpty) {
      return !excluded.contains(cbId);
    }

    return true;
  }

  Map<String, RequiredNamespace>? _buildNamespaces(
    Map<String, RequiredNamespace>? requiredNS,
    Map<String, RequiredNamespace>? optionalNS,
  ) {
    Map<String, RequiredNamespace>? totalNS;
    if (requiredNS != null) {
      totalNS = Map<String, RequiredNamespace>.from(requiredNS);
    }
    if (optionalNS != null) {
      if (totalNS != null) {
        totalNS = {...totalNS, ...optionalNS};
      } else {
        totalNS = Map<String, RequiredNamespace>.from(optionalNS);
      }
    }
    return totalNS;
  }

  void _setOptionalNamespaces(Map<String, RequiredNamespace>? optionalNSpaces) {
    if (optionalNSpaces != null) {
      // Set the optional namespaces declared by the user on ReownAppKitModal object
      _sessionNamespaces = optionalNSpaces.map(
        (key, value) => MapEntry(
          key,
          RequiredNamespace(
            chains: value.chains,
            methods: value.methods,
            events: value.events,
          ),
        ),
      );
    } else {
      // Set the optional namespaces to everything in our chain presets
      final namespaces = ReownAppKitModalNetworks.getAllSupportedNamespaces();
      for (var ns in namespaces) {
        final networks = ReownAppKitModalNetworks.getAllSupportedNetworks(
          namespace: ns,
        );
        _sessionNamespaces[ns] = RequiredNamespace(
          chains: networks.map((e) => e.chainId).toList(),
          methods: NetworkUtils.defaultNetworkMethods[ns] ?? [],
          events: NetworkUtils.defaultNetworkEvents[ns] ?? [],
        );
      }
    }

    _appKit.core.logger.d(
      '[$runtimeType] optional namespaces ${jsonEncode(_sessionNamespaces)}',
    );
  }

  /// Loads account balance and avatar.
  /// Returns true if it was able to actually load data (i.e. there is a selected chain and session)
  @override
  Future<void> loadAccountData() async {
    // If there is no selected chain or session, stop. No account to load in.
    if (_selectedChainID == null || _currentSession == null) {
      return;
    }

    // _status = ReownAppKitModalStatus.initializing;
    // _notify();

    // Get the chain balance.
    final namespace = NamespaceUtils.getNamespaceFromChain(_selectedChainID!);

    try {
      _chainBalance = await _blockchainService.getTokenBalance(
        address: _currentSession!.getAddress(namespace)!,
        namespace: namespace,
        chainId: _selectedChainID!,
      );
      final tokenName = selectedChain?.currency ?? '';
      final formattedBalance = CoreUtils.formatChainBalance(_chainBalance);
      balanceNotifier.value = '$formattedBalance $tokenName';
    } catch (_) {
      // Calling getBalanceFallback defined by user
      _chainBalance = await _getBalance?.call();
      final tokenName = selectedChain?.currency ?? '';
      final formattedBalance = CoreUtils.formatChainBalance(_chainBalance);
      balanceNotifier.value = '$formattedBalance $tokenName';
    }

    if (namespace == NetworkUtils.eip155) {
      // Get the avatar, each chainId is just a number in string form.
      try {
        final address = _currentSession!.getAddress(namespace)!;
        final blockchainId = await _blockchainService.getIdentity(
          address: address,
        );
        _blockchainIdentity = BlockchainIdentity.fromJson(
          blockchainId.toJson(),
        );
      } catch (_) {}
    } else {
      _blockchainIdentity = null;
    }

    // _status = ReownAppKitModalStatus.initialized;
    _notify();
  }

  @override
  Future<void> requestSwitchToChain(
    ReownAppKitModalNetworkInfo newChain,
  ) async {
    final namespace = NamespaceUtils.getNamespaceFromChain(newChain.chainId);
    if (namespace != NetworkUtils.eip155) {
      // If chain is not EVM then there's no need to request a switch since it doesn't exist such method for non-EVM chains
      // Therefor at this point the selected non-EVM chain is either already approved, invalidating the need of a switch call, or not approved, failing with the following error.
      throw ReownAppKitModalException('Chain namespace is not supported');
    }
    if (_currentSession?.sessionService.isMagic == true) {
      await selectChain(newChain);
      return;
    }
    _appKit.core.logger.i(
      '[$runtimeType] requesting switch to chain ${newChain.chainId}',
    );
    try {
      await request(
        topic: _currentSession?.topic ?? '',
        chainId: _selectedChainID!,
        switchToChainId: newChain.chainId,
        request: SessionRequestParams(
          method: MethodsConstants.walletSwitchEthChain,
          params: [
            {'chainId': newChain.chainHexId}
          ],
        ),
      );
      _selectedChainID = newChain.chainId;
      await _setSesionAndChainData(_currentSession!);
      return;
    } catch (e) {
      // if request errors due to user rejection then set the previous chain
      if (_isUserRejectedError(e)) {
        // fallback to current chain if rejected by user
        await _setLocalEthChain(_selectedChainID!);
        throw JsonRpcError(code: 5002, message: 'User rejected methods.');
      } else {
        try {
          // Otherwise it meas chain has to be added.
          return await requestAddChain(newChain);
        } on JsonRpcError catch (e) {
          _appKit.core.logger.e(
            '[$runtimeType] Switch to chain error: ${e.toJson()}',
          );
          rethrow;
        } on ReownAppKitModalException catch (e) {
          _appKit.core.logger.e(
            '[$runtimeType] Switch to chain error: ${e.message}',
            stackTrace: e.stackTrace,
          );
          rethrow;
        } catch (e, s) {
          _appKit.core.logger.e(
            '[$runtimeType] Switch to chain error: ${e.toString()}',
            stackTrace: s,
          );
          rethrow;
        }
      }
    }
  }

  @override
  Future<void> requestAddChain(ReownAppKitModalNetworkInfo newChain) async {
    final topic = _currentSession?.topic ?? '';
    _appKit.core.logger.i(
      '[$runtimeType] requesting add chain ${newChain.chainId}',
    );
    try {
      await request(
        topic: topic,
        chainId: _selectedChainID!,
        switchToChainId: newChain.chainId,
        request: SessionRequestParams(
          method: MethodsConstants.walletAddEthChain,
          params: [newChain.toRawJson()],
        ),
      );
      _selectedChainID = newChain.chainId;
      await _setSesionAndChainData(_currentSession!);
      return;
    } on JsonRpcError {
      await _setLocalEthChain(_selectedChainID!);
      rethrow;
    } catch (e, s) {
      await _setLocalEthChain(_selectedChainID!);
      throw ReownAppKitModalException(e.toString(), s);
    }
  }

  bool _isUserRejectedError(dynamic e) {
    final regexp = RegExp(
      r'\b(rejected|cancelled|disapproved|denied)\b',
      caseSensitive: false,
    );

    if (e is JsonRpcError) {
      final code = (e.code ?? 0);
      final match = RegExp(r'\b500[0-3]\b').hasMatch(code.toString());
      if (match || code == Errors.getSdkError(Errors.USER_REJECTED_SIGN).code) {
        return true;
      }
    }
    if (e is CoinbaseServiceException) {
      if (regexp.hasMatch(e.error.toString()) ||
          regexp.hasMatch(e.message.toString())) {
        return true;
      }
    }

    return regexp.hasMatch(e.toString());
  }

  Future<void> _disconnectSession(String? pairingTopic, String? topic) async {
    // Disconnecting the session will produce the onSessionDisconnect callback
    if (topic != null) {
      await _appKit.disconnectSession(
        topic: topic,
        reason: Errors.getSdkError(Errors.USER_DISCONNECTED).toSignError(),
      );
    }
    if (pairingTopic != null) {
      await _appKit.core.pairing.disconnect(topic: pairingTopic);
    }
  }

  Future<void> _deleteStorage() async {
    await _storage.delete(StorageConstants.selectedChainId);
    await _storage.delete(StorageConstants.modalSession);
  }

  Future<void> _cleanSession({SessionDelete? args, bool event = true}) async {
    _blockchainService.dispose();
    await _deleteStorage();

    _selectedChainID = null;
    _isConnected = false;
    _currentSession = null;
    _lastChainEmitted = null;
    _supportsOneClickAuth = false;
    _status = ReownAppKitModalStatus.initialized;
    _notify();

    if (event) {
      Future.delayed(Duration(milliseconds: 200), () {
        onModalDisconnect.broadcast(ModalDisconnect(
          topic: args?.topic ?? _currentSession?.topic,
          id: args?.id,
        ));
      });
    }
  }

  void _onModalError(ModalError? event) {
    _toastService.show(ToastMessage(
      type: ToastType.error,
      text: event?.message ?? 'An error occurred.',
    ));
  }

  void _onNetworkChainRequireSIWE(ModalNetworkChange? args) async {
    if (_siweService.config?.enabled != true) return;
    try {
      if (_siweService.signOutOnNetworkChange) {
        // TODO check if relevant for Farcaster
        await _magicService.getUser(chainId: _selectedChainID, isUpdate: true);
        await _siweService.signOut();
        _disconnectOnClose = true;
        _widgetStack.push(ApproveSIWEPage(
          onSiweFinish: _oneSIWEFinish,
        ));
      }
    } catch (e, s) {
      _appKit.core.logger.e(
        '[$runtimeType] _onNetworkChainRequireSIWE',
        error: e,
        stackTrace: s,
      );
    }
  }

  void _checkInitialized() {
    if (_status != ReownAppKitModalStatus.initialized &&
        _status != ReownAppKitModalStatus.initializing) {
      throw ReownAppKitModalException(
        'ReownAppKitModal must be initialized before calling this method.',
      );
    }
  }

  void _registerListeners() {
    WidgetsBinding.instance.addObserver(this);

    onModalError.subscribe(_onModalError);
    // Magic
    _magicService.onMagicConnect.subscribe(_onMagicConnectEvent);
    _magicService.onMagicLoginSuccess.subscribe(_onMagicLoginEvent);
    _magicService.onMagicError.subscribe(_onMagicErrorEvent);
    _magicService.onMagicUpdate.subscribe(_onMagicSessionUpdateEvent);
    _magicService.onMagicRpcRequest.subscribe(_onMagicRequest);
    // Coinbase
    _coinbaseService.onCoinbaseConnect.subscribe(_onCoinbaseConnect);
    _coinbaseService.onCoinbaseError.subscribe(_onCoinbaseError);
    _coinbaseService.onCoinbaseSessionUpdate.subscribe(
      _onCoinbaseSessionUpdateEvent,
    );
    // Phantom
    _phantomService.onPhantomConnect.subscribe(_onPhantomConnect);
    _phantomService.onPhantomError.subscribe(_onPhantomError);
    //
    _appKit.onSessionAuthResponse.subscribe(_onSessionAuthResponse);
    _appKit.onSessionConnect.subscribe(_onSessionConnect);
    _appKit.onSessionDelete.subscribe(_onSessionDelete);
    _appKit.onSessionExpire.subscribe(_onSessionExpire);
    _appKit.onSessionUpdate.subscribe(_onSessionUpdate);
    _appKit.onSessionEvent.subscribe(_onSessionEvent);
    // Core
    _appKit.core.relayClient.onRelayClientConnect.subscribe(
      _onRelayClientConnect,
    );
    _appKit.core.relayClient.onRelayClientError.subscribe(
      _onRelayClientError,
    );
    _appKit.core.relayClient.onRelayClientDisconnect.subscribe(
      _onRelayClientDisconnect,
    );

    _appKit.core.connectivity.isOnline.addListener(_connectivityListener);
  }

  void _unregisterListeners() {
    WidgetsBinding.instance.removeObserver(this);
    onModalError.unsubscribeAll();
    onModalDisconnect.unsubscribeAll();
    onModalConnect.unsubscribeAll();
    onModalUpdate.unsubscribeAll();
    onModalNetworkChange.unsubscribeAll();

    // Magic
    _magicService.onMagicConnect.unsubscribeAll();
    _magicService.onMagicLoginSuccess.unsubscribeAll();
    _magicService.onMagicError.unsubscribeAll();
    _magicService.onMagicUpdate.unsubscribeAll();
    _magicService.onMagicRpcRequest.unsubscribeAll();
    //
    // Coinbase
    _coinbaseService.onCoinbaseConnect.unsubscribeAll();
    _coinbaseService.onCoinbaseError.unsubscribeAll();
    _coinbaseService.onCoinbaseSessionUpdate.unsubscribeAll();
    // Phantom
    _phantomService.onPhantomConnect.unsubscribeAll();
    _phantomService.onPhantomError.unsubscribeAll();
    //
    _appKit.onSessionAuthResponse.unsubscribeAll();
    _appKit.onSessionConnect.unsubscribeAll();
    _appKit.onSessionDelete.unsubscribeAll();
    _appKit.onSessionEvent.unsubscribeAll();
    _appKit.onSessionUpdate.unsubscribeAll();
    // Core
    _appKit.core.relayClient.onRelayClientConnect.unsubscribeAll();
    _appKit.core.relayClient.onRelayClientError.unsubscribeAll();
    _appKit.core.relayClient.onRelayClientDisconnect.unsubscribeAll();

    _appKit.core.connectivity.isOnline.removeListener(_connectivityListener);
  }

  String? _getStoredChainId([String? defaultValue]) {
    if (_storage.has(StorageConstants.selectedChainId)) {
      final storedChain = _storage.get(StorageConstants.selectedChainId);
      final chainId = storedChain?['chainId'] as String? ?? '';
      if (chainId.isNotEmpty) {
        if (NamespaceUtils.isValidChainId(chainId)) {
          return chainId;
        }
        // if there is a chain id stored with no namespace we know it's an EVM chain
        return 'eip155:$chainId';
      }
      return defaultValue;
    }
    return defaultValue;
  }
}

extension _EmailConnectorExtension on ReownAppKitModal {
  // Login event should be treated like Connect event for regular wallets
  Future<void> _onMagicLoginEvent(MagicLoginEvent? args) async {
    if (args!.data != null) {
      _appKit.core.logger.d(
        '[$runtimeType] _onMagicLoginEvent ${args.data?.toJson()}',
      );
      _selectedChainID = _getStoredChainId(args.data!.chainId)!;
      //
      final email = args.data?.email ?? _currentSession?.sessionEmail;
      final userName =
          args.data?.farcasterUserName ?? _currentSession?.sessionUsername;
      final magicData = args.data?.copytWith(
        chainId: _selectedChainID,
        email: email,
        farcasterUserName: userName,
      );

      final session = ReownAppKitModalSession(magicData: magicData);
      await _setSesionAndChainData(session);
      if (_selectedWallet == null) {
        await _storage.delete(StorageConstants.connectedWalletData);
      }
      onModalConnect.broadcast(ModalConnect(session));
      //
      if (_siweService.enabled) {
        if (!_isOpen) {
          await _checkSIWEStatus();
          onModalUpdate.broadcast(ModalConnect(_currentSession!));
        } else {
          _disconnectOnClose = true;
          // TODO Check if this is still relevant
          final theme = ReownAppKitModalTheme.maybeOf(_context!);
          await _magicService.syncTheme(theme);
          _widgetStack.push(ApproveSIWEPage(
            onSiweFinish: _oneSIWEFinish,
          ));
        }
      } else {
        if (_isOpen) {
          closeModal();
        }
      }
    }
  }

  Future<void> _onMagicSessionUpdateEvent(MagicSessionEvent? args) async {
    if (args != null) {
      _appKit.core.logger.d(
        '[$runtimeType] _onMagicSessionUpdateEvent ${args.toJson()}',
      );
      try {
        final currentUsername = _currentSession?.sessionUsername;
        final currentEmail = _currentSession?.sessionEmail;
        final newEmail = args.email ?? currentEmail ?? currentUsername;
        final newUsername = args.userName ?? currentUsername;
        final newProvider = args.provider ??
            (_currentSession?.socialProvider != null
                ? AppKitSocialOption.fromString(
                    _currentSession!.socialProvider!)
                : null);
        final newChainId = args.chainId?.toString() ?? _currentSession!.chainId;
        final ns = NamespaceUtils.getNamespaceFromChain(newChainId);
        final newAddress = args.address ?? _currentSession!.getAddress(ns)!;
        _selectedChainID = newChainId;
        //
        final magicData = MagicData(
          email: newEmail,
          address: newAddress,
          farcasterUserName: newUsername,
          provider: newProvider,
          chainId: newChainId,
        );
        final session = (_currentSession != null)
            ? _currentSession!.copyWith(magicData: magicData)
            : ReownAppKitModalSession(magicData: magicData);
        await _setSesionAndChainData(session);
        onModalUpdate.broadcast(ModalConnect(session));
      } catch (e, s) {
        _appKit.core.logger.e(
          '[$runtimeType] _onMagicUpdateEvent error: $e',
          stackTrace: s,
        );
      }
    }
  }

  Future<void> _onMagicErrorEvent(MagicErrorEvent? event) async {
    _appKit.core.logger.d('[$runtimeType] _onMagicErrorEvent: ${event?.error}');
    final errorMessage = event?.error ?? 'Something went wrong';
    if (!errorMessage.toLowerCase().contains('user denied')) {
      onModalError.broadcast(ModalError(errorMessage));
    }
    if (event is IsConnectedErrorEvent && _currentSession != null) {
      await _cleanSession();
    }
    _notify();
  }

  void _onMagicRequest(MagicRequestEvent? args) {
    if (args?.result != null) {
      if (args!.result is JsonRpcError && _widgetStack.canPop()) {
        _widgetStack.pop();
      } else {
        closeModal();
      }
    }
  }

  Future<void> _onMagicConnectEvent(MagicConnectEvent? event) async {
    if (event?.connected == false) {
      if (_currentSession != null) {
        onModalConnect.broadcast(ModalConnect(_currentSession!));
      }
    }
  }
}

extension _CoinbaseConnectorExtension on ReownAppKitModal {
  void _onCoinbaseConnect(CoinbaseConnectEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onCoinbaseConnect: $args');
    if (args?.data != null) {
      // TODO change coinbase chainId into CAIP-2 String
      final newChainId = _getStoredChainId(args!.data!.chainId)!;
      _selectedChainID = newChainId;
      //
      final session = ReownAppKitModalSession(coinbaseData: args.data!);
      await _setSesionAndChainData(session);
      await _explorerService.storeConnectedWallet(_selectedWallet);
      onModalConnect.broadcast(ModalConnect(session));
      //
      if (_siweService.enabled) {
        _disconnectOnClose = true;
        _widgetStack.push(ApproveSIWEPage(
          onSiweFinish: _oneSIWEFinish,
        ));
      } else {
        if (_isOpen) {
          closeModal();
        }
      }
    }
  }

  void _onCoinbaseSessionUpdateEvent(CoinbaseSessionEvent? args) async {
    _appKit.core.logger.d(
      '[$runtimeType] _onCoinbaseSessionUpdateEvent: $args',
    );
    if (args != null) {
      try {
        final chainId = args.chainId ?? _currentSession!.chainId;
        final ns = NamespaceUtils.getNamespaceFromChain(chainId);
        final address = args.address ?? _currentSession!.getAddress(ns)!;
        final chainInfo = ReownAppKitModalNetworks.getNetworkInfo(ns, chainId);
        _selectedChainID = chainId;
        final session = _currentSession!.copyWith(
          coinbaseData: CoinbaseData(
            address: address,
            chainName: chainInfo?.name ?? '',
            chainId: chainId,
            peer: _coinbaseService.walletMetadata,
            self: ConnectionMetadata(
              metadata: _appKit.metadata,
              publicKey: await _coinbaseService.ownPublicKey,
            ),
          ),
        );
        await _setSesionAndChainData(session);
        onModalUpdate.broadcast(ModalConnect(session));
      } catch (e, s) {
        _appKit.core.logger.e(
          '[$runtimeType] _onCoinbaseSessionUpdateEvent error: $e',
          stackTrace: s,
        );
      }
    }
  }

  void _onCoinbaseError(CoinbaseErrorEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onCoinbaseError: $args');
    final errorMessage = args?.error ?? 'Something went wrong';
    if (!errorMessage.toLowerCase().contains('user denied')) {
      onModalError.broadcast(ModalError(errorMessage));
    }
  }
}

extension _PhantomConnectorExtension on ReownAppKitModal {
  void _onPhantomConnect(PhantomConnectEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onPhantomConnect: $args');
    if (args?.data != null) {
      // TODO make sure phantom chain id is CAIP-2 string
      _selectedChainID = _getStoredChainId(args!.data!.chainId)!;
      //
      final session = ReownAppKitModalSession(phantomData: args.data!);
      await _setSesionAndChainData(session);
      await _explorerService.storeConnectedWallet(_selectedWallet);
      onModalConnect.broadcast(ModalConnect(session));
      //
      if (_isOpen) {
        closeModal();
      }
    }
  }

  void _onPhantomError(PhantomErrorEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onPhantomError: $args');
    if (_isUserRejectedError(args?.toString())) {
      onModalError.broadcast(UserRejectedConnection());
      _analyticsService.sendEvent(ConnectErrorEvent(
        message: 'User declined connection',
      ));
    } else {
      final errorMessage = args?.error ?? 'Something went wrong';
      onModalError.broadcast(ErrorOpeningWallet());
      _analyticsService.sendEvent(ConnectErrorEvent(
        message: errorMessage,
      ));
    }
  }
}

extension _AppKitModalExtension on ReownAppKitModal {
  void _onSessionAuthResponse(SessionAuthResponse? args) async {
    final debugString = jsonEncode(args?.toJson());
    _appKit.core.logger.d(
      '[$runtimeType] _onSessionAuthResponse: $debugString',
    );
    if (args?.session != null) {
      // IF 1-CA SUPPORTED WE SHOULD CALL SIWECONGIF METHODS HERE
      final session = await _settleSession(args!.session!);
      //
      try {
        // Verify message with just the first cacao
        final Cacao cacao = args.auths!.first;
        final message = _appKit.formatAuthMessage(
          iss: cacao.p.iss,
          cacaoPayload: CacaoRequestPayload.fromCacaoPayload(cacao.p),
        );
        final clientId = await _appKit.core.crypto.getClientId();
        await _siweService.verifyMessage(
          message: message,
          signature: cacao.s.s,
          clientId: clientId,
        );
      } catch (e, s) {
        _appKit.core.logger.e(
          '[$runtimeType] onSessionAuthResponse $e',
          stackTrace: s,
        );
        await disconnect();
        return;
      }
      //
      final siweSession = await _siweService.getSession();
      final newSession = session.copyWith(siweSession: siweSession);
      //
      await _storeSession(newSession);
      onModalConnect.broadcast(ModalConnect(newSession));
      //
      if (_isOpen) {
        closeModal();
      }
    }
  }

  void _onSessionConnect(SessionConnect? args) async {
    if (args == null || (_supportsOneClickAuth && _siweService.enabled)) {
      return;
    }

    // IF SIWE CALLBACK (1-CA NOT SUPPORTED) SIWECONGIF METHODS ARE CALLED ON ApproveSIWEPage
    _appKit.core.logger.d(
      '[$runtimeType] _onSessionConnect: ${jsonEncode(args.session.toJson())}',
    );
    final session = await _settleSession(args.session);
    onModalConnect.broadcast(ModalConnect(session));
    //
    if (_siweService.enabled) {
      _disconnectOnClose = true;
      _widgetStack.push(ApproveSIWEPage(onSiweFinish: _oneSIWEFinish));
    } else {
      if (_isOpen) {
        closeModal();
      }
    }
  }

  // HAS TO BE CALLED JUST ONCE ON CONNECTION
  Future<ReownAppKitModalSession> _settleSession(SessionData mSession) async {
    _selectedChainID ??= NamespaceUtils.getChainIdsFromNamespaces(
      namespaces: mSession.namespaces,
    ).first;

    final session = ReownAppKitModalSession(sessionData: mSession);
    await _setSesionAndChainData(session);
    if (_selectedWallet == null) {
      _analyticsService.sendEvent(ConnectSuccessEvent(
        name: 'WalletConnect',
        method: AnalyticsPlatform.qrcode,
      ));
      await _storage.delete(StorageConstants.connectedWalletData);
    } else {
      _explorerService.storeConnectedWallet(_selectedWallet);
      final walletName = _selectedWallet!.listing.name;
      final walletId = _selectedWallet!.listing.id;
      _analyticsService.sendEvent(ConnectSuccessEvent(
        name: walletName,
        explorerId: walletId,
        method: AnalyticsPlatform.mobile,
      ));
    }
    return session;
  }

  void _oneSIWEFinish(ReownAppKitModalSession updatedSession) async {
    _appKit.core.logger.d(
      '[$runtimeType] _oneSIWEFinish ${updatedSession.toJson()}',
    );
    await _storeSession(updatedSession);
    try {
      await _storage.set(
        StorageConstants.selectedChainId,
        {'chainId': _selectedChainID!},
      );
    } catch (e, s) {
      _appKit.core.logger.e(
        '[$runtimeType] _oneSIWEFinish error: $e',
        stackTrace: s,
      );
    }
    onModalUpdate.broadcast(ModalConnect(updatedSession));
    closeModal();
    _analyticsService.sendEvent(SiweAuthSuccess(network: _selectedChainID!));
  }

  void _onSessionEvent(SessionEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onSessionEvent $args');
    if (args?.name == 'reown_updateEmail') {
      if (_currentSession?.topic == args?.topic) {
        try {
          final newEmail = args!.data['email'];
          await _storeSession(ReownAppKitModalSession(
            sessionData:
                SessionData.fromJson(_currentSession!.toJson()).copyWith(
              sessionProperties: {
                ..._currentSession!.sessionProperties,
                'email': newEmail,
              },
            ),
          ));
          _notify();
          return;
        } catch (e) {
          _appKit.core.logger.e('[$runtimeType] _onSessionEvent error: $e');
        }
      }
    }

    onSessionEventEvent.broadcast(args);
    if (args?.name == EventsConstants.chainChanged) {
      _selectedChainID = args?.chainId;
    }
    if (args?.name == EventsConstants.accountsChanged) {
      if (_siweService.enabled && _siweService.signOutOnAccountChange) {
        try {
          await _siweService.signOut();
        } catch (e) {
          _appKit.core.logger.e('[$runtimeType] _onSessionEvent error: $e');
        }
      }
    }
    _notify();
  }

  void _onSessionUpdate(SessionUpdate? args) async {
    _appKit.core.logger.d('[$runtimeType] _onSessionUpdate $args');
    if (args != null) {
      final wcSessions = _appKit.sessions.getAll();
      if (wcSessions.isEmpty) return;
      //
      final session = _appKit.sessions.get(args.topic);
      final updatedSession = ReownAppKitModalSession(
        sessionData: session!.copyWith(
          namespaces: args.namespaces,
        ),
      );
      await _setSesionAndChainData(updatedSession);
      onSessionUpdateEvent.broadcast(args);
      onModalUpdate.broadcast(ModalConnect(updatedSession));
    }
  }

  void _onSessionExpire(SessionExpire? args) {
    onSessionExpireEvent.broadcast(args);
  }

  void _onSessionDelete(SessionDelete? args) {
    _cleanSession(args: args);
  }

  void _onRelayClientConnect(EventArgs? args) {
    _appKit.core.logger.i('[$runtimeType] relay client connected');
    final service =
        _currentSession?.sessionService ?? ReownAppKitModalConnector.wc;
    if (service.isWC && _relayConnected) {
      _status = ReownAppKitModalStatus.initialized;
      _notify();
    }
    if (!_awaitRelayOnce.isCompleted) {
      _awaitRelayOnce.complete(true);
    }
  }

  void _connectivityListener() {
    final isOnline = _appKit.core.connectivity.isOnline.value;
    _appKit.core.logger.i('[$runtimeType] connectivity isOnline: $isOnline');
    if (isOnline && !_appKit.core.relayClient.isConnected) {
      reconnectRelay();
    }
  }

  void _onRelayClientDisconnect(EventArgs? args) {
    _appKit.core.logger.i('[$runtimeType] relay client disconnected');
    // final service =
    //     _currentSession?.sessionService ?? ReownAppKitModalConnector.wc;
    // if (service.isWC && _relayConnected) {
    //   _status = ReownAppKitModalStatus.idle;
    //   _notify();
    // }
  }

  void _onRelayClientError(ErrorEvent? args) {
    _appKit.core.logger.i('[$runtimeType] relay client error: ${args?.error}');
    // final service =
    //     _currentSession?.sessionService ?? ReownAppKitModalConnector.wc;
    // if (service.isWC) {
    //   _status = ReownAppKitModalStatus.error;
    //   _notify();
    // }
  }
}
