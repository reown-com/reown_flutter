import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/network_service/i_network_service.dart';
import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service.dart';
import 'package:reown_appkit/modal/services/uri_service/i_url_utils.dart';

import 'package:reown_core/store/i_store.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/services/network_service/network_service.dart';
import 'package:reown_appkit/modal/services/uri_service/launch_url_exception.dart';
import 'package:reown_appkit/modal/services/uri_service/url_utils.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/pages/account_page.dart';
import 'package:reown_appkit/modal/pages/approve_magic_request_page.dart';
import 'package:reown_appkit/modal/pages/approve_siwe.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/coinbase_service/coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/i_coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_data.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_events.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/redirect.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_data.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/services/siwe_service/siwe_service.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/services/blockchain_service/blockchain_service.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/widgets/modal_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

/// Either a [projectId] and [metadata] must be provided or an already created [appKit].
/// optionalNamespaces is mostly not needed, if you use it, the values set here will override every optionalNamespaces set in evey chain
class ReownAppKitModal with ChangeNotifier implements IReownAppKitModal {
  String _projectId = '';

  Map<String, RequiredNamespace> _requiredNamespaces = {};
  Map<String, RequiredNamespace> _optionalNamespaces = {};
  String? _lastChainEmitted;
  bool _supportsOneClickAuth = false;
  bool _relayConnected = false;

  ReownAppKitModalStatus _status = ReownAppKitModalStatus.idle;
  @override
  ReownAppKitModalStatus get status => _status;

  String? _currentSelectedChainId;
  @override
  ReownAppKitModalNetworkInfo? get selectedChain {
    if (_currentSelectedChainId != null) {
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        _currentSelectedChainId!,
      );
      return ReownAppKitModalNetworks.getNetworkById(
        namespace,
        _currentSelectedChainId!,
      );
    }
    return null;
  }

  ReownAppKitModalWalletInfo? _selectedWallet;
  @override
  ReownAppKitModalWalletInfo? get selectedWallet => _selectedWallet;

  @override
  bool get hasNamespaces =>
      _requiredNamespaces.isNotEmpty || _optionalNamespaces.isNotEmpty;

  String _wcUri = '';
  @override
  String? get wcUri => _wcUri;

  late IReownAppKit _appKit;
  @override
  IReownAppKit? get appKit => _appKit;

  String? _avatarUrl;
  @override
  String? get avatarUrl => _avatarUrl;

  double? _chainBalance;
  @Deprecated('Use balanceNotifier')
  @override
  String get chainBalance => CoreUtils.formatChainBalance(_chainBalance);

  @override
  final balanceNotifier = ValueNotifier<String>('-.--');

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

  ReownAppKitModal({
    required BuildContext context,
    IReownAppKit? appKit,
    String? projectId,
    PairingMetadata? metadata,
    bool? enableAnalytics,
    SIWEConfig? siweConfig,
    FeaturesConfig? featuresConfig,
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Set<String>? featuredWalletIds,
    Set<String>? includedWalletIds,
    Set<String>? excludedWalletIds,
    Future<double> Function()? getBalanceFallback,
    LogLevel logLevel = LogLevel.nothing,
  }) {
    if (appKit == null) {
      if (projectId == null) {
        throw ReownAppKitModalException(
          'Either a `projectId` and `metadata` must be provided or an already created `appKit`',
        );
      }
      if (metadata == null) {
        throw ReownAppKitModalException(
          '`metadata:` parameter is required when using `projectId:`',
        );
      }
    }

    this.featuresConfig = featuresConfig ?? FeaturesConfig(email: false);

    _context = context;
    _getBalance = getBalanceFallback;

    _appKit = appKit ??
        ReownAppKit(
          core: ReownCore(
            projectId: projectId!,
            logLevel: logLevel,
          ),
          metadata: metadata!,
        );
    _projectId = _appKit.core.projectId;

    // TODO should be moved to init()
    _setRequiredNamespaces(requiredNamespaces);
    _setOptionalNamespaces(optionalNamespaces);

    GetIt.I.registerSingletonIfAbsent<IUriService>(
      () => UriService(core: _appKit.core),
    );
    GetIt.I.registerSingletonIfAbsent<IAnalyticsService>(
      () => AnalyticsService(
        core: _appKit.core,
        enableAnalytics: enableAnalytics,
      ),
    );
    // TODO should be moved to init()
    _analyticsService.init().then(
          (_) => _analyticsService.sendEvent(ModalLoadedEvent()),
        );
    GetIt.I.registerSingletonIfAbsent<IExplorerService>(
      () => ExplorerService(
        core: _appKit.core,
        referer: _appKit.metadata.name.replaceAll(' ', ''),
        featuredWalletIds: featuredWalletIds,
        includedWalletIds: includedWalletIds,
        excludedWalletIds: excludedWalletIds,
        namespaces: {..._requiredNamespaces, ..._optionalNamespaces},
      ),
    );
    GetIt.I.registerSingletonIfAbsent<INetworkService>(() => NetworkService());
    GetIt.I.registerSingletonIfAbsent<IToastService>(() => ToastService());
    GetIt.I.registerSingletonIfAbsent<IBlockChainService>(
      () => BlockChainService(
        core: _appKit.core,
      ),
    );
    GetIt.I.registerSingletonIfAbsent<IMagicService>(
      () => MagicService(
        core: _appKit.core,
        metadata: _appKit.metadata,
        featuresConfig: this.featuresConfig,
      ),
    );
    GetIt.I.registerSingletonIfAbsent<ICoinbaseService>(
      () => CoinbaseService(
        core: _appKit.core,
        metadata: _appKit.metadata,
        enabled: _initializeCoinbaseSDK,
      ),
    );
    GetIt.I.registerSingletonIfAbsent<ISiweService>(
      () => SiweService(
        appKit: _appKit,
        siweConfig: siweConfig,
        namespaces: {..._requiredNamespaces, ..._optionalNamespaces},
      ),
    );
  }

  IUriService get _uriService => GetIt.I<IUriService>();
  IToastService get _toastService => GetIt.I<IToastService>();
  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();
  IExplorerService get _explorerService => GetIt.I<IExplorerService>();
  INetworkService get _networkService => GetIt.I<INetworkService>();
  IMagicService get _magicService => GetIt.I<IMagicService>();
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  ICoinbaseService get _coinbaseService => GetIt.I<ICoinbaseService>();
  ISiweService get _siweService => GetIt.I<ISiweService>();

  ////////* PUBLIC METHODS */////////

  @override
  Future<bool> dispatchEnvelope(String url) async {
    _appKit.core.logger.d('[$runtimeType] dispatchEnvelope $url');
    final envelope = ReownCoreUtils.getSearchParamFromURL(url, 'wc_ev');
    if (envelope.isNotEmpty) {
      await _appKit.dispatchEnvelope(url);
      return true;
    }

    final state = ReownCoreUtils.getSearchParamFromURL(url, 'state');
    if (state.isNotEmpty) {
      _magicService.completeSocialLogin(url: url);
      return true;
    }

    return false;
  }

  @override
  Future<void> init() async {
    _relayConnected = false;
    _awaitRelayOnce = Completer<bool>();

    if (!CoreUtils.isValidProjectID(_projectId)) {
      throw 'Please provide a valid projectId ($_projectId).'
          'See ${UrlConstants.docsUrl}/appkit/flutter/core/usage for details.';
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
    await _blockchainService.init();

    _currentSession = await _getStoredSession();
    _currentSelectedChainId = _getStoredChainId(null);
    final isMagic = _currentSession?.sessionService.isMagic == true;
    final isCoinbase = _currentSession?.sessionService.isCoinbase == true;
    if (isMagic || isCoinbase) {
      _currentSelectedChainId ??= _currentSession!.chainId;
      await _setSesionAndChainData(_currentSession!);
      if (isMagic) {
        final caip2Chain = ReownAppKitModalNetworks.getCaip2Chain(
          _currentSelectedChainId!,
        );
        await _magicService.init(chainId: caip2Chain);
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
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        chain.chainId,
      );
      final requiredEvents = _requiredNamespaces[namespace]?.events ?? [];
      final optionalEvents = _optionalNamespaces[namespace]?.events ?? [];
      final events = [...requiredEvents, ...optionalEvents];
      for (final event in events) {
        _appKit.registerEventHandler(
          chainId: '$namespace:${chain.chainId}',
          event: event,
        );
      }
    }

    // There's a session stored
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
          final isCbConnected = await _coinbaseService.isConnected();
          if (!isCbConnected) {
            await _cleanSession();
          }
        } else if (_currentSession!.sessionService.isMagic) {
          // Every time the app gets killed Magic service will treat the user as disconnected
          // So we will need to treat magic session differently
          final email = _currentSession!.email;
          _magicService.setEmail(email);
          final provider = _currentSession!.socialProvider;
          _magicService.setProvider(provider);
        } else {
          await _cleanSession();
        }
      }
    }

    // Get the chainId of the chain we are connected to.
    await _selectChainFromStoredId();

    onModalNetworkChange.subscribe(_onNetworkChainRequireSIWE);
    onModalConnect.subscribe(_loadAccountData);

    _relayConnected = _appKit.core.relayClient.isConnected;
    if (!_relayConnected) {
      _relayConnected = await _awaitRelayOnce.future;
    } else {
      if (!_awaitRelayOnce.isCompleted) {
        _awaitRelayOnce.complete(_relayConnected);
      }
    }
    _status = _relayConnected
        ? ReownAppKitModalStatus.initialized
        : ReownAppKitModalStatus.initializing;
    _appKit.core.logger.i('[$runtimeType] status $_status');
    _notify();
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
      _currentSelectedChainId = _currentSelectedChainId ?? mSession.chainId;
      await _setLocalEthChain(_currentSelectedChainId!, logEvent: false);
    } catch (e) {
      _appKit.core.logger.e('[$runtimeType] _setSesionAndChainData error $e');
    }
  }

  Future<ReownAppKitModalSession?> _getStoredSession() async {
    try {
      if (_storage.has(StorageConstants.modalSession)) {
        final storedSession = _storage.get(StorageConstants.modalSession);
        _appKit.core.logger.i(
          '[$runtimeType] _getStoredSession, storedSession: $storedSession, key: ${StorageConstants.modalSession}',
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
      final chainId = _getStoredChainId(null);
      if (chainId != null) {
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainId,
        );
        final chain = ReownAppKitModalNetworks.getNetworkById(
          namespace,
          chainId,
        );
        if (chain != null) {
          await _setLocalEthChain(chainId, logEvent: false);
        }
      } else {
        _currentSelectedChainId = chainId;
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

    if (chainInfo?.chainId == _currentSelectedChainId) {
      return;
    }

    // If the chain is null, disconnect and stop.
    if (chainInfo == null) {
      await disconnect();
      return;
    }

    try {
      _chainBalance = null;
      final formattedBalance = CoreUtils.formatChainBalance(_chainBalance);
      balanceNotifier.value = '$formattedBalance ${chainInfo.currency}';

      final hasValidSession = _isConnected && _currentSession != null;
      if (switchChain && hasValidSession && _currentSelectedChainId != null) {
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainInfo.chainId,
        );
        final approvedChains = _currentSession!.getApprovedChains(
          namespace: namespace,
        );
        final newCaip2Chain = ReownAppKitModalNetworks.getCaip2Chain(
          chainInfo.chainId,
        );
        final hasChainAlready = (approvedChains ?? []).contains(newCaip2Chain);
        if (!hasChainAlready) {
          requestSwitchToChain(chainInfo);
          final hasSwitchMethod = _currentSession!.hasSwitchMethod();
          if (hasSwitchMethod) {
            launchConnectedWallet();
          }
        } else {
          await _setLocalEthChain(chainInfo.chainId, logEvent: logEvent);
        }
      } else {
        await _setLocalEthChain(chainInfo.chainId, logEvent: logEvent);
      }
    } on JsonRpcError catch (e) {
      onModalError.broadcast(ModalError(e.message ?? 'An error occurred'));
    } on ReownAppKitModalException catch (e) {
      onModalError.broadcast(ModalError(e.message));
    } catch (e) {
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
    if (isMagic || isCoinbase) {
      return getApprovedChains();
    }

    List<String> availableChains = [];
    final namespaces = ReownAppKitModalNetworks.getAllSupportedNamespaces();
    for (var ns in namespaces) {
      final chains =
          ReownAppKitModalNetworks.getAllSupportedNetworks(namespace: ns)
              .map((e) => '$ns:${e.chainId}')
              .toList();
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
    _currentSelectedChainId = chainId;
    final caip2Chain = ReownAppKitModalNetworks.getCaip2Chain(chainId);
    _appKit.core.logger.d('[$runtimeType] _setLocalEthChain $caip2Chain');
    _notify();
    try {
      if (isConnected) {
        await _storage.set(
          StorageConstants.selectedChainId,
          {'chainId': _currentSelectedChainId ?? '1'},
        );
      }
    } catch (e) {
      _appKit.core.logger.e('[$runtimeType] _setLocalEthChain error: $e');
    }
    if (_isConnected && logEvent == true) {
      _analyticsService.sendEvent(SwitchNetworkEvent(
        network: _currentSelectedChainId!,
      ));
    }
    if (_lastChainEmitted != caip2Chain && _isConnected) {
      if (_lastChainEmitted != null) {
        onModalNetworkChange.broadcast(ModalNetworkChange(
          chainId: caip2Chain,
        ));
      }
      _lastChainEmitted = caip2Chain;
    }
    loadAccountData();
  }

  @override
  Future<void> openNetworksView() {
    return _showModalView(
      startWidget: ReownAppKitModalSelectNetworkPage(
        onTapNetwork: (info) {
          selectChain(info);
          widgetStack.instance.addDefault();
        },
      ),
    );
  }

  @override
  Future<void> openModalView([Widget? startWidget]) {
    final keyString = startWidget?.key?.toString() ?? '';
    if (_isConnected) {
      final connectedKeys =
          _allowedScreensWhenConnected.map((e) => e.toString()).toList();
      if (startWidget == null) {
        startWidget = const AccountPage();
      } else {
        if (!connectedKeys.contains(keyString)) {
          startWidget = const AccountPage();
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
    KeyConstants.accountPage,
    KeyConstants.socialLoginPage,
  ];

  final List<Key> _allowedScreensWhenDisconnected = [
    KeyConstants.qrCodePageKey,
    KeyConstants.walletListLongPageKey,
    KeyConstants.walletListShortPageKey,
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
    widgetStack.instance.clear();

    final isBottomSheet = PlatformUtils.isBottomSheet();
    final theme = ReownAppKitModalTheme.maybeOf(_context!);
    await _magicService.syncTheme(theme);
    final themeData = theme?.themeData ?? const ReownAppKitModalThemeData();

    Widget? showWidget = startWidget;
    if (_isConnected && showWidget == null) {
      showWidget = const AccountPage();
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

    final isApprovePage = startWidget is ApproveTransactionPage;
    final isTabletSize = PlatformUtils.isTablet(_context!);

    if (isBottomSheet && !isTabletSize) {
      final mqData = MediaQueryData.fromView(View.of(_context!));
      final safeGap = mqData.viewPadding.bottom;
      final maxHeight = mqData.size.height - safeGap - 20.0;
      final modalHeight = isApprovePage ? 600.0 : maxHeight;
      await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: !isApprovePage,
        isScrollControlled: true,
        enableDrag: false,
        elevation: 0.0,
        useRootNavigator: true,
        constraints: BoxConstraints(maxHeight: modalHeight),
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
    final walletName = _selectedWallet!.listing.name;
    final event = SelectWalletEvent(
      name: walletName,
      platform: inBrowser ? AnalyticsPlatform.web : AnalyticsPlatform.mobile,
    );
    _analyticsService.sendEvent(event);
  }

  @override
  Future<void> connectSelectedWallet({bool inBrowser = false}) async {
    _checkInitialized();

    final walletRedirect = _explorerService.getWalletRedirect(
      selectedWallet,
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
        await _explorerService.storeConnectedWallet(_selectedWallet);
      } else {
        await buildConnectionUri();
        final linkMode = walletRedirect.linkMode ?? '';
        if (linkMode.isNotEmpty && _wcUri.startsWith(linkMode)) {
          await ReownCoreUtils.openURL(_wcUri);
        } else {
          await _uriService.openRedirect(
            walletRedirect,
            wcURI: _wcUri,
            pType: pType,
          );
        }
      }
    } on LaunchUrlException catch (e) {
      if (e is CanNotLaunchUrl) {
        onModalError.broadcast(WalletNotInstalled());
      } else {
        onModalError.broadcast(ErrorOpeningWallet());
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
      } else if (_isUserRejectedError(e)) {
        onModalError.broadcast(UserRejectedConnection());
        _analyticsService.sendEvent(ConnectErrorEvent(
          message: 'User declined connection',
        ));
      } else {
        _appKit.core.logger.e(
          '[$runtimeType] connectSelectedWallet error: $e',
          stackTrace: s,
        );
        onModalError.broadcast(ErrorOpeningWallet());
      }
    }
  }

  @override
  Future<void> buildConnectionUri() async {
    if (!_isConnected) {
      /// TODO Qs: How do I handle SIWE if non-EVM chains are included?
      /// TODO Qs: How do I handle switch to Solana from EVM chain?
      try {
        if (_siweService.enabled) {
          final walletRedirect = _explorerService.getWalletRedirect(
            selectedWallet,
          );
          final nonce = await _siweService.getNonce();
          final p1 = await _siweService.config!.getMessageParams();
          final methods =
              p1.methods ?? NetworkUtils.defaultNetworkMethods['eip155'];
          //
          final networks = ReownAppKitModalNetworks.getAllSupportedNetworks();
          final chains = networks.map((chain) {
            return ReownAppKitModalNetworks.getCaip2Chain(chain.chainId);
          }).toList();
          final p2 = {'nonce': nonce, 'chains': chains, 'methods': methods};
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
            requiredNamespaces: _requiredNamespaces,
            optionalNamespaces: _optionalNamespaces,
          );
          _wcUri = connectResponse.uri?.toString() ?? '';
          _notify();
          _awaitConnectionCallback(connectResponse);
        }
      } catch (e) {
        _appKit.core.logger.e('[$runtimeType] buildConnectionUri error: $e');
      }
    }
  }

  void _awaitConnectionCallback(ConnectResponse connectResponse) async {
    try {
      final _ = await connectResponse.session.future;
    } on TimeoutException {
      _appKit.core.logger.i('[$runtimeType] Rebuilding session, ending future');
      return;
    } catch (e) {
      await _connectionErrorHandler(e);
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
    } catch (e) {
      await disconnect();
      await _connectionErrorHandler(e);
    }
  }

  Future<void> _connectionErrorHandler(dynamic e) async {
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
    return await expirePreviousInactivePairings();
  }

  @override
  void launchConnectedWallet() async {
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
      // Coinbase Wallet is getting launched at every request by it's own SDK
      // SO no need to do it here.
      return;
    }

    if (_currentSession!.sessionService.isMagic) {
      // There's no wallet to launch when connected with Email
      return;
    }

    final metadataRedirect = _currentSession!.peer?.metadata.redirect;

    final appLink = (metadataRedirect?.universal ?? '');
    final supportedApps = _appKit.core.getLinkModeSupportedApps();
    final isLinkMode = appLink.isNotEmpty && supportedApps.contains(appLink);
    if (isLinkMode) {
      // Opening peers during Link Mode requests is handled in Sign Engine
      return;
    }

    final walletRedirect = _explorerService.getWalletRedirect(
      walletInfo,
    );

    if (walletRedirect == null) {
      return;
    }

    try {
      final link = metadataRedirect?.native ?? metadataRedirect?.universal;
      _uriService.openRedirect(
        walletRedirect.copyWith(mobile: link),
        pType: PlatformUtils.getPlatformType(),
      );
    } catch (e) {
      onModalError.broadcast(ErrorOpeningWallet());
    }
  }

  @override
  Future<void> reconnectRelay() async {
    if (!_appKit.core.relayClient.isConnected) {
      await _appKit.core.relayClient.connect();
    }
  }

  @override
  Future<void> disconnect({bool disconnectAllSessions = true}) async {
    _checkInitialized();

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
    final currentKey = widgetStack.instance.getCurrent().key;
    if (_disconnectOnClose) {
      _disconnectOnClose = false;
      if (currentKey == KeyConstants.approveSiwePageKey) {
        _analyticsService.sendEvent(ClickCancelSiwe(
          network: _currentSelectedChainId ?? '',
        ));
      }
      await disconnect();
      selectWallet(null);
    }
    _toastService.clear();
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
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        selectedChain!.chainId,
      );
      final address = _currentSession?.getAddress(namespace) ?? '';
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
    EthereumAddress? sender,
    List parameters = const [],
  }) async {
    if (_currentSession == null) {
      throw ReownAppKitModalException('Session is null');
    }
    String reqChainId = chainId;
    final isValidChainId = NamespaceUtils.isValidChainId(chainId);
    if (!isValidChainId) {
      if (selectedChain!.chainId == chainId) {
        reqChainId = ReownAppKitModalNetworks.getCaip2Chain(chainId);
      } else {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context: 'chainId should conform to "CAIP-2" format',
        );
      }
    }
    //
    _appKit.core.logger.i(
      '[$runtimeType] requestReadContract, chainId: $reqChainId',
    );

    final networkInfo = ReownAppKitModalNetworks.getNetworkById(
      reqChainId.split(':').first,
      reqChainId.split(':').last,
    )!;

    try {
      if (selectedChain == null) {
        throw ReownAppKitModalException(
          'You must select a chain before reading a contract',
        );
      }
      return await _appKit.requestReadContract(
        deployedContract: deployedContract,
        functionName: functionName,
        rpcUrl: networkInfo.rpcUrl,
        sender: sender,
        parameters: parameters,
      );
    } catch (e) {
      rethrow;
    }
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
    String reqChainId = chainId;
    final isValidChainId = NamespaceUtils.isValidChainId(chainId);
    if (!isValidChainId) {
      if (selectedChain!.chainId == chainId) {
        reqChainId = ReownAppKitModalNetworks.getCaip2Chain(chainId);
      } else {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context: 'chainId should conform to "CAIP-2" format',
        );
      }
    }
    //
    _appKit.core.logger.i(
      '[$runtimeType] requestWriteContract, chainId: $reqChainId',
    );

    try {
      return await _appKit.requestWriteContract(
        topic: topic ?? '',
        chainId: reqChainId,
        deployedContract: deployedContract,
        functionName: functionName,
        transaction: transaction,
        parameters: parameters,
        method: method,
      );
    } catch (e) {
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
    String reqChainId = chainId;
    final isValidChainId = NamespaceUtils.isValidChainId(chainId);
    if (!isValidChainId) {
      if (selectedChain!.chainId == chainId) {
        reqChainId = ReownAppKitModalNetworks.getCaip2Chain(chainId);
      } else {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context: 'chainId should conform to "CAIP-2" format',
        );
      }
    }
    //
    _appKit.core.logger.d(
      '[$runtimeType] request, chainId: $reqChainId, '
      '${jsonEncode(request.toJson())}',
    );
    try {
      if (_currentSession!.sessionService.isMagic) {
        return await _magicService.request(
          chainId: reqChainId,
          request: request,
        );
      }
      if (_currentSession!.sessionService.isCoinbase) {
        return await await _coinbaseService.request(
          chainId: switchToChainId ?? reqChainId,
          request: request,
        );
      }
      return await _appKit.request(
        topic: topic!,
        chainId: reqChainId,
        request: request,
      );
    } catch (e) {
      if (_isUserRejectedError(e)) {
        onModalError.broadcast(UserRejectedConnection());
        if (request.method == MethodsConstants.walletSwitchEthChain ||
            request.method == MethodsConstants.walletAddEthChain) {
          rethrow;
        }
        return 'User rejected';
      } else {
        if (e is CoinbaseServiceException) {
          // If the error is due to no session on Coinbase Wallet we disconnnect the session on Modal.
          // This is the only way to detect a missing session since Coinbase Wallet is not sending any event.
          // disconnect();
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
      await expirePreviousInactivePairings();
      await disconnect();
      await _appKit.core.relayClient.disconnect();
      _relayConnected = false;
      _isConnected = false;
      _currentSelectedChainId = null;
      _requiredNamespaces = {};
      _optionalNamespaces = {};
      _lastChainEmitted = null;
      _supportsOneClickAuth = false;
      _status = ReownAppKitModalStatus.idle;
      await Future.delayed(Duration(milliseconds: 500));
      _notify();
    }
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

  void _notify() => notifyListeners();

  bool get _initializeCoinbaseSDK {
    final cbId = CoinbaseService.defaultWalletData.listing.id;
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

  void _setRequiredNamespaces(Map<String, RequiredNamespace>? requiredNSpaces) {
    if (requiredNSpaces != null) {
      // Set the required namespaces declared by the user on ReownAppKitModal object
      _requiredNamespaces = requiredNSpaces.map(
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
      // Set the required namespaces to everything in our chain presets
      _requiredNamespaces = {};
    }
    _appKit.core.logger.d(
      '[$runtimeType] required namespaces ${jsonEncode(_requiredNamespaces)}',
    );
  }

  void _setOptionalNamespaces(Map<String, RequiredNamespace>? optionalNSpaces) {
    if (optionalNSpaces != null) {
      // Set the optional namespaces declared by the user on ReownAppKitModal object
      _optionalNamespaces = optionalNSpaces.map(
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
        _optionalNamespaces[ns] = RequiredNamespace(
          chains: networks.map((e) => '$ns:${e.chainId}').toList(),
          methods: NetworkUtils.defaultNetworkMethods[ns] ?? [],
          events: NetworkUtils.defaultNetworkEvents[ns] ?? [],
        );
      }
    }

    _appKit.core.logger.d(
      '[$runtimeType] optional namespaces ${jsonEncode(_optionalNamespaces)}',
    );
  }

  /// Loads account balance and avatar.
  /// Returns true if it was able to actually load data (i.e. there is a selected chain and session)
  @override
  Future<void> loadAccountData() async {
    // If there is no selected chain or session, stop. No account to load in.
    if (_currentSelectedChainId == null || _currentSession == null) {
      return;
    }

    // Get the chain balance.
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      _currentSelectedChainId!,
    );

    try {
      _chainBalance = await _blockchainService.getBalance(
        address: _currentSession!.getAddress(namespace)!,
        namespace: namespace,
        chainId: _currentSelectedChainId!,
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
        final blockchainId = await _blockchainService.getIdentity(
          _currentSession!.getAddress(namespace)!,
        );
        _avatarUrl = blockchainId.avatar;
      } catch (_) {}
    }
    _notify();
  }

  @override
  Future<void> requestSwitchToChain(
    ReownAppKitModalNetworkInfo newChain,
  ) async {
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      newChain.chainId,
    );
    if (namespace != NetworkUtils.eip155) {
      // If chain is not EVM then there's no need to request a switch since it doesn't exist such method for non-EVM chains
      // Therefor at this point the selected non-EVM chain is either already approved, invalidating the need of a switch call, or not approved, failing with the following error.
      throw ReownAppKitModalException('Chain namespace is not supported');
    }
    if (_currentSession?.sessionService.isMagic == true) {
      await selectChain(newChain);
      return;
    }
    final currentCaip2Chain = ReownAppKitModalNetworks.getCaip2Chain(
      _currentSelectedChainId!,
    );
    final newCaip2Chain = ReownAppKitModalNetworks.getCaip2Chain(
      newChain.chainId,
    );
    _appKit.core.logger.i(
      '[$runtimeType] requesting switch to chain $newCaip2Chain',
    );
    try {
      await request(
        topic: _currentSession?.topic ?? '',
        chainId: currentCaip2Chain,
        switchToChainId: newCaip2Chain,
        request: SessionRequestParams(
          method: MethodsConstants.walletSwitchEthChain,
          params: [
            {'chainId': newChain.chainHexId}
          ],
        ),
      );
      _currentSelectedChainId = newChain.chainId;
      await _setSesionAndChainData(_currentSession!);
      return;
    } catch (e) {
      // if request errors due to user rejection then set the previous chain
      if (_isUserRejectedError(e)) {
        // fallback to current chain if rejected by user
        await _setLocalEthChain(_currentSelectedChainId!);
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
    final currentCaip2Chain = ReownAppKitModalNetworks.getCaip2Chain(
      _currentSelectedChainId!,
    );
    final newCaip2Chain = ReownAppKitModalNetworks.getCaip2Chain(
      newChain.chainId,
    );
    _appKit.core.logger.i('[$runtimeType] requesting add chain $newCaip2Chain');
    try {
      await request(
        topic: topic,
        chainId: currentCaip2Chain,
        switchToChainId: newCaip2Chain,
        request: SessionRequestParams(
          method: MethodsConstants.walletAddEthChain,
          params: [newChain.toJson()],
        ),
      );
      _currentSelectedChainId = newChain.chainId;
      await _setSesionAndChainData(_currentSession!);
      return;
    } on JsonRpcError {
      await _setLocalEthChain(_currentSelectedChainId!);
      rethrow;
    } catch (e, s) {
      await _setLocalEthChain(_currentSelectedChainId!);
      throw ReownAppKitModalException(e.toString(), s);
    }
  }

  bool _isUserRejectedError(dynamic e) {
    if (e is JsonRpcError) {
      final stringError = e.toJson().toString().toLowerCase();
      final userRejected = stringError.contains('rejected');
      final userDisapproved = stringError.contains('user disapproved');
      return userRejected || userDisapproved;
    }
    if (e is CoinbaseServiceException) {
      final stringError = e.message.toLowerCase();
      final userDenied = stringError.contains('user denied');
      return userDenied;
    }
    return false;
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
    try {
      final storedWalletId = _storage.get(StorageConstants.recentWalletId);
      final walletId = storedWalletId?['walletId'];
      await _deleteStorage();
      await _explorerService.storeRecentWalletId(walletId);
    } catch (_) {
      await _deleteStorage();
    }
    if (event) {
      onModalDisconnect.broadcast(ModalDisconnect(
        topic: args?.topic ?? _currentSession?.topic,
        id: args?.id,
      ));
    }
    _currentSelectedChainId = null;
    _isConnected = false;
    _currentSession = null;
    _lastChainEmitted = null;
    _supportsOneClickAuth = false;
    _status = ReownAppKitModalStatus.initialized;
    _notify();
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
        final caip2chain = ReownAppKitModalNetworks.getCaip2Chain(
          _currentSelectedChainId!,
        );
        await _magicService.getUser(chainId: caip2chain, isUpdate: true);
        await _siweService.signOut();
        _disconnectOnClose = true;
        widgetStack.instance.push(ApproveSIWEPage(
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

  void _loadAccountData(ModalConnect? event) {
    loadAccountData();
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
    onModalError.subscribe(_onModalError);
    // Magic
    _magicService.onMagicConnect.subscribe(_onMagicConnectEvent);
    _magicService.onMagicLoginSuccess.subscribe(_onMagicLoginEvent);
    _magicService.onMagicError.subscribe(_onMagicErrorEvent);
    _magicService.onMagicUpdate.subscribe(_onMagicSessionUpdateEvent);
    _magicService.onMagicRpcRequest.subscribe(_onMagicRequest);
    //
    // Coinbase
    _coinbaseService.onCoinbaseConnect.subscribe(_onCoinbaseConnectEvent);
    _coinbaseService.onCoinbaseError.subscribe(_onCoinbaseErrorEvent);
    _coinbaseService.onCoinbaseSessionUpdate.subscribe(
      _onCoinbaseSessionUpdateEvent,
    );
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
  }

  void _unregisterListeners() {
    onModalError.unsubscribe(_onModalError);

    // Magic
    _magicService.onMagicLoginSuccess.unsubscribe(_onMagicLoginEvent);
    _magicService.onMagicError.unsubscribe(_onMagicErrorEvent);
    _magicService.onMagicUpdate.unsubscribe(_onMagicSessionUpdateEvent);
    _magicService.onMagicRpcRequest.unsubscribe(_onMagicRequest);
    //
    // Coinbase
    _coinbaseService.onCoinbaseConnect.unsubscribe(_onCoinbaseConnectEvent);
    _coinbaseService.onCoinbaseError.unsubscribe(_onCoinbaseErrorEvent);
    _coinbaseService.onCoinbaseSessionUpdate.unsubscribe(
      _onCoinbaseSessionUpdateEvent,
    );
    //
    _appKit.onSessionAuthResponse.unsubscribe(_onSessionAuthResponse);
    _appKit.onSessionConnect.unsubscribe(_onSessionConnect);
    _appKit.onSessionDelete.unsubscribe(_onSessionDelete);
    _appKit.onSessionEvent.unsubscribe(_onSessionEvent);
    _appKit.onSessionUpdate.unsubscribe(_onSessionUpdate);
    // Core
    _appKit.core.relayClient.onRelayClientConnect.unsubscribe(
      _onRelayClientConnect,
    );
    _appKit.core.relayClient.onRelayClientError.unsubscribe(
      _onRelayClientError,
    );
    _appKit.core.relayClient.onRelayClientDisconnect.unsubscribe(
      _onRelayClientDisconnect,
    );
  }

  String? _getStoredChainId(String? defaultValue) {
    if (_storage.has(StorageConstants.selectedChainId)) {
      final storedChain = _storage.get(StorageConstants.selectedChainId);
      return storedChain?['chainId'] as String? ?? defaultValue;
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
      final newChainId = _getStoredChainId(args.data!.chainId)!;
      _currentSelectedChainId = newChainId;
      //
      final email = args.data?.email ?? _currentSession?.toRawJson()['email'];
      final userName =
          args.data?.userName ?? _currentSession?.toRawJson()['userName'];
      final magicData = args.data?.copytWith(
        chainId: newChainId,
        email: email,
        userName: userName,
      );

      final session = ReownAppKitModalSession(magicData: magicData);
      await _setSesionAndChainData(session);
      onModalConnect.broadcast(ModalConnect(session));
      if (_selectedWallet == null) {
        await _storage.delete(StorageConstants.recentWalletId);
        await _storage.delete(StorageConstants.connectedWalletData);
      }
      //
      if (_siweService.enabled) {
        if (!_isOpen) {
          await _checkSIWEStatus();
          onModalUpdate.broadcast(ModalConnect(_currentSession!));
        } else {
          _disconnectOnClose = true;
          final theme = ReownAppKitModalTheme.maybeOf(_context!);
          await _magicService.syncTheme(theme);
          widgetStack.instance.push(ApproveSIWEPage(
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
        final currentUsername = _currentSession?.userName;
        final currentEmail = _currentSession?.email;
        final newEmail = args.email ?? currentEmail ?? currentUsername;
        final newUsername = args.userName ?? currentUsername;
        final newProvider = args.provider ?? _currentSession?.socialProvider;
        final newChainId = args.chainId?.toString() ?? _currentSession!.chainId;
        final ns = ReownAppKitModalNetworks.getNamespaceForChainId(newChainId);
        final newAddress = args.address ?? _currentSession!.getAddress(ns)!;
        _currentSelectedChainId = newChainId;
        //
        final magicData = MagicData(
          email: newEmail,
          address: newAddress,
          userName: newUsername,
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

  Future<void> _onMagicErrorEvent(MagicErrorEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onMagicErrorEvent: $args');
    final errorMessage = args?.error ?? 'Something went wrong';
    if (!errorMessage.toLowerCase().contains('user denied')) {
      onModalError.broadcast(ModalError(errorMessage));
    }
    _notify();
  }

  void _onMagicRequest(MagicRequestEvent? args) {
    if (args?.result != null) {
      if (args!.result is JsonRpcError && widgetStack.instance.canPop()) {
        widgetStack.instance.pop();
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
  void _onCoinbaseConnectEvent(CoinbaseConnectEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onCoinbaseConnectEvent: $args');
    if (args?.data != null) {
      final newChainId = _getStoredChainId('${args!.data!.chainId}')!;
      _currentSelectedChainId = newChainId;
      //
      final session = ReownAppKitModalSession(coinbaseData: args.data!);
      await _setSesionAndChainData(session);
      onModalConnect.broadcast(ModalConnect(session));
      //
      if (_siweService.enabled) {
        _disconnectOnClose = true;
        widgetStack.instance.push(ApproveSIWEPage(
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
        final ns = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
        final address = args.address ?? _currentSession!.getAddress(ns)!;
        final chainInfo = ReownAppKitModalNetworks.getNetworkById(ns, chainId);
        _currentSelectedChainId = chainId;
        final session = _currentSession!.copyWith(
          coinbaseData: CoinbaseData(
            address: address,
            chainName: chainInfo?.name ?? '',
            chainId: int.parse(chainId),
            peer: _coinbaseService.metadata,
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

  void _onCoinbaseErrorEvent(CoinbaseErrorEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onCoinbaseErrorEvent: $args');
    final errorMessage = args?.error ?? 'Something went wrong';
    if (!errorMessage.toLowerCase().contains('user denied')) {
      onModalError.broadcast(ModalError(errorMessage));
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
    final debugString = jsonEncode(args?.session.toJson());
    _appKit.core.logger.d('[$runtimeType] _onSessionConnect: $debugString');
    if (_supportsOneClickAuth && _siweService.enabled) {
      return;
    }
    if (args != null) {
      // IF SIWE CALLBACK (1-CA NOT SUPPORTED) SIWECONGIF METHODS ARE CALLED ON ApproveSIWEPage
      final session = await _settleSession(args.session);
      onModalConnect.broadcast(ModalConnect(session));
      //
      if (_siweService.enabled) {
        _disconnectOnClose = true;
        widgetStack.instance.push(ApproveSIWEPage(
          onSiweFinish: _oneSIWEFinish,
        ));
      } else {
        if (_isOpen) {
          closeModal();
        }
      }
    }
  }

  // HAS TO BE CALLED JUST ONCE ON CONNECTION
  Future<ReownAppKitModalSession> _settleSession(SessionData mSession) async {
    if (_currentSelectedChainId == null) {
      final chains = NamespaceUtils.getChainIdsFromNamespaces(
        namespaces: mSession.namespaces,
      );
      final chainId = chains.first.split(':').last.toString();
      _currentSelectedChainId = chainId;
    }
    final session = ReownAppKitModalSession(sessionData: mSession);
    await _setSesionAndChainData(session);
    if (_selectedWallet == null) {
      _analyticsService.sendEvent(ConnectSuccessEvent(
        name: 'WalletConnect',
        method: AnalyticsPlatform.qrcode,
      ));
      await _storage.delete(StorageConstants.recentWalletId);
      await _storage.delete(StorageConstants.connectedWalletData);
    } else {
      _explorerService.storeConnectedWallet(_selectedWallet);
      final walletName = _selectedWallet!.listing.name;
      _analyticsService.sendEvent(ConnectSuccessEvent(
        name: walletName,
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
        {'chainId': _currentSelectedChainId!},
      );
    } catch (e, s) {
      _appKit.core.logger.e(
        '[$runtimeType] _oneSIWEFinish error: $e',
        stackTrace: s,
      );
    }
    onModalUpdate.broadcast(ModalConnect(updatedSession));
    closeModal();
    _analyticsService.sendEvent(SiweAuthSuccess(
      network: _currentSelectedChainId!,
    ));
  }

  void _onSessionEvent(SessionEvent? args) async {
    _appKit.core.logger.d('[$runtimeType] _onSessionEvent $args');
    onSessionEventEvent.broadcast(args);
    if (args?.name == EventsConstants.chainChanged) {
      _currentSelectedChainId = args?.data?.toString();
    }
    if (args?.name == EventsConstants.accountsChanged) {
      if (_siweService.enabled && _siweService.signOutOnAccountChange) {
        try {
          await _siweService.signOut();
        } catch (e, s) {
          _appKit.core.logger.e(
            '[$runtimeType] _onSessionEvent error: $e',
            stackTrace: s,
          );
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

  void _onRelayClientDisconnect(EventArgs? args) {
    _appKit.core.logger.i('[$runtimeType] relay client disconnected');
    final service =
        _currentSession?.sessionService ?? ReownAppKitModalConnector.wc;
    if (service.isWC && _relayConnected) {
      _status = ReownAppKitModalStatus.idle;
      _notify();
    }
  }

  void _onRelayClientError(ErrorEvent? args) {
    _appKit.core.logger.i('[$runtimeType] relay client error: ${args?.error}');
    final service =
        _currentSession?.sessionService ?? ReownAppKitModalConnector.wc;
    if (service.isWC) {
      _status = ReownAppKitModalStatus.error;
      _notify();
    }
  }
}
