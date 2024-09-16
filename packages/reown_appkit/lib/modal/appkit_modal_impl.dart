import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reown_appkit/modal/services/uri_service/launch_url_exception.dart';
import 'package:reown_appkit/modal/services/uri_service/url_utils.dart';
import 'package:reown_appkit/modal/services/uri_service/url_utils_singleton.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_core/store/i_store.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';

import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/pages/account_page.dart';
import 'package:reown_appkit/modal/pages/approve_magic_request_page.dart';
import 'package:reown_appkit/modal/pages/approve_siwe.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service_singleton.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/coinbase_service/coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/coinbase_service_singleton.dart';
import 'package:reown_appkit/modal/services/coinbase_service/i_coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_data.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_events.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service_singleton.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/redirect.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_data.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/services/siwe_service/siwe_service.dart';
import 'package:reown_appkit/modal/services/siwe_service/siwe_service_singleton.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/services/blockchain_service/blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/blockchain_service_singleton.dart';
import 'package:reown_appkit/modal/services/network_service/network_service_singleton.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/widgets/modal_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service_singleton.dart';

/// Either a [projectId] and [metadata] must be provided or an already created [appKit].
/// optionalNamespaces is mostly not needed, if you use it, the values set here will override every optionalNamespaces set in evey chain
class ReownAppKitModal with ChangeNotifier implements IReownAppKitModal {
  String _projectId = '';

  Map<String, RequiredNamespace> _requiredNamespaces = {};
  Map<String, RequiredNamespace> _optionalNamespaces = {};
  String? _lastChainEmitted;
  bool _supportsOneClickAuth = false;

  ReownAppKitModalStatus _status = ReownAppKitModalStatus.idle;
  @override
  ReownAppKitModalStatus get status => _status;

  String? _currentSelectedChainId;
  @override
  ReownAppKitModalNetworkInfo? get selectedChain {
    if (_currentSelectedChainId != null) {
      return ReownAppKitModalNetworks.getNetworkById(
        CoreConstants.namespace,
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
  @override
  String get chainBalance {
    return CoreUtils.formatChainBalance(_chainBalance);
  }

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

  Logger get _logger => _appKit.core.logger;

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

  ReownAppKitModal({
    required BuildContext context,
    IReownAppKit? appKit,
    String? projectId,
    PairingMetadata? metadata,
    SIWEConfig? siweConfig,
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Set<String>? featuredWalletIds,
    Set<String>? includedWalletIds,
    Set<String>? excludedWalletIds,
    bool? enableAnalytics,
    bool enableEmail = false,
    List<ReownAppKitModalNetworkInfo> blockchains = const [],
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
    // if (siweConfig?.enabled == true && context == null) {
    //   throw ReownAppKitModalException(
    //     '`context:` parameter is required if using `siweConfig:`. Also, `context:` parameter will be enforced in future versions.',
    //   );
    // }

    _context = context;

    _appKit = appKit ??
        ReownAppKit(
          core: ReownCore(projectId: projectId!),
          metadata: metadata!,
        );
    _projectId = _appKit.core.projectId;

    _setRequiredNamespaces(requiredNamespaces);
    _setOptionalNamespaces(optionalNamespaces);

    uriService.instance = UriService(
      core: _appKit.core,
    );

    analyticsService.instance = AnalyticsService(
      core: _appKit.core,
      enableAnalytics: enableAnalytics,
    )..init().then((_) {
        analyticsService.instance.sendEvent(ModalLoadedEvent());
      });

    explorerService.instance = ExplorerService(
      core: _appKit.core,
      referer: _appKit.metadata.name.replaceAll(' ', ''),
      featuredWalletIds: featuredWalletIds,
      includedWalletIds: includedWalletIds,
      excludedWalletIds: excludedWalletIds,
    );

    blockchainService.instance = BlockChainService(
      core: _appKit.core,
    );

    magicService.instance = MagicService(
      core: _appKit.core,
      metadata: _appKit.metadata,
      enabled: enableEmail,
    );

    coinbaseService.instance = CoinbaseService(
      core: _appKit.core,
      metadata: _appKit.metadata,
      enabled: _initializeCoinbaseSDK,
    );

    siweService.instance = SiweService(
      appKit: _appKit,
      siweConfig: siweConfig,
    );
  }

  ////////* PUBLIC METHODS */////////

  bool _serviceInitialized = false;

  @override
  Future<void> init() async {
    _serviceInitialized = false;
    if (!CoreUtils.isValidProjectID(_projectId)) {
      _logger.e(
        '[$runtimeType] projectId $_projectId is invalid. '
        'Please provide a valid projectId. '
        'See ${UrlConstants.docsUrl}/appkit/flutter/core/options for details.',
      );
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
    await networkService.instance.init();
    await explorerService.instance.init();
    await coinbaseService.instance.init();
    await blockchainService.instance.init();

    _currentSession = await _getStoredSession();
    _currentSelectedChainId = _getStoredChainId(null);
    final isMagic = _currentSession?.sessionService.isMagic == true;
    final isCoinbase = _currentSession?.sessionService.isCoinbase == true;
    if (isMagic || isCoinbase) {
      _currentSelectedChainId ??= _currentSession!.chainId;
      await _setSesionAndChainData(_currentSession!);
      if (isMagic) {
        await magicService.instance.init();
      }
    } else {
      magicService.instance.init();
    }

    await expirePreviousInactivePairings();

    final wcPairings = _appKit.pairings.getAll();
    final wcSessions = _appKit.sessions.getAll();

    // Loop through all the chain data
    final allNetworks = ReownAppKitModalNetworks.getNetworks(
      CoreConstants.namespace,
    );
    for (final chain in allNetworks) {
      for (final event in EventsConstants.allEvents) {
        _appKit.registerEventHandler(
          chainId: '${CoreConstants.namespace}:${chain.chainId}',
          event: event,
        );
      }
    }

    // There's a session stored
    if (wcSessions.isNotEmpty) {
      await _storeSession(
          ReownAppKitModalSession(sessionData: wcSessions.first));
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
          final isCbConnected = await coinbaseService.instance.isConnected();
          if (!isCbConnected) {
            await _cleanSession();
          }
        } else if (_currentSession!.sessionService.isMagic) {
          // Every time the app gets killed Magic service will treat the user as disconnected
          // So we will need to treat magic session differently
          final email = _currentSession!.email;
          magicService.instance.setEmail(email);
        } else {
          await _cleanSession();
        }
      }
    }

    // Get the chainId of the chain we are connected to.
    await _selectChainFromStoredId();

    onModalNetworkChange.subscribe(_onNetworkChainRequireSIWE);

    final connected = _appKit.core.relayClient.isConnected;
    _serviceInitialized = connected;
    _status = connected
        ? ReownAppKitModalStatus.initialized
        : ReownAppKitModalStatus.error;
    _logger.i('[$runtimeType] initialized');
    _notify();
  }

  Future<void> _checkSIWEStatus() async {
    // check if SIWE is enabled and should still sign the message
    if (siweService.instance!.enabled) {
      try {
        // If getSession() throws it means message has not been signed and
        // we should present modal with ApproveSIWEPage
        final siweSession = await siweService.instance!.getSession();
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

  Future<void> _setSesionAndChainData(
      ReownAppKitModalSession modalSession) async {
    try {
      await _storeSession(modalSession);
      _currentSelectedChainId = _currentSelectedChainId ?? modalSession.chainId;
      await _setLocalEthChain(_currentSelectedChainId!, logEvent: false);
    } catch (e, s) {
      _logger.e(
        '[$runtimeType] _setSesionAndChainData error $e',
        stackTrace: s,
      );
    }
  }

  Future<ReownAppKitModalSession?> _getStoredSession() async {
    try {
      if (_storage.has(StorageConstants.modalSession)) {
        final storedSession = _storage.get(StorageConstants.modalSession);
        if (storedSession != null) {
          return ReownAppKitModalSession.fromMap(storedSession);
        }
      }
    } catch (e) {
      _logger.e('[$runtimeType] _getStoredSession error: $e');
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
      _logger.e('[$runtimeType] _storeSession error: $e');
    }
    // _isConnected shoudl probably go at the very end of the connection
    _isConnected = true;
  }

  Future<void> _selectChainFromStoredId() async {
    if (_currentSession != null) {
      final chainId = _getStoredChainId(null);
      if (chainId != null) {
        final chain = ReownAppKitModalNetworks.getNetworkById(
          CoreConstants.namespace,
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

    _chainBalance = null;

    if (_currentSession?.sessionService.isMagic == true) {
      await magicService.instance.switchNetwork(chainId: chainInfo.chainId);
      // onModalNetworkChange.broadcast(ModalNetworkChange(
      //   chainId: chainInfo.namespace,
      // ));
    } else {
      final hasValidSession = _isConnected && _currentSession != null;
      if (switchChain && hasValidSession && _currentSelectedChainId != null) {
        final approvedChains = _currentSession!.getApprovedChains() ?? [];
        final hasChainAlready = approvedChains.contains(
          '${CoreConstants.namespace}:${chainInfo.chainId}',
        );
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
    }
  }

  /// Will get the list of available chains to add
  @override
  List<String>? getAvailableChains() {
    // if there's no session or if supportsAddChain method then every chain can be used
    if (_currentSession == null || _currentSession!.hasSwitchMethod()) {
      return null;
    }
    return getApprovedChains();
  }

  /// Will get the list of already approved chains by the wallet (to switch to)
  @override
  List<String>? getApprovedChains() {
    if (_currentSession == null) {
      return null;
    }
    return _currentSession!.getApprovedChains();
  }

  @override
  List<String>? getApprovedMethods() {
    if (_currentSession == null) {
      return null;
    }
    return _currentSession!.getApprovedMethods();
  }

  @override
  List<String>? getApprovedEvents() {
    if (_currentSession == null) {
      return null;
    }
    return _currentSession!.getApprovedEvents();
  }

  Future<void> _setLocalEthChain(String chainId, {bool? logEvent}) async {
    _currentSelectedChainId = chainId;
    final caip2Chain = '${CoreConstants.namespace}:$_currentSelectedChainId';
    _logger.i('[$runtimeType] set local chain $caip2Chain');
    _currentSelectedChainId = chainId;
    _notify();
    try {
      await _storage.set(
        StorageConstants.selectedChainId,
        {'chainId': _currentSelectedChainId!},
      );
    } catch (e) {
      _logger.e('[$runtimeType] _setLocalEthChain error: $e');
    }
    if (_isConnected && logEvent == true) {
      analyticsService.instance.sendEvent(SwitchNetworkEvent(
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
    ApproveTransactionPage();

    if (_isOpen) {
      closeModal();
      return;
    }
    _isOpen = true;
    _context = context ?? modalContext;

    if (_context == null) {
      _logger.e(
        'No context was found. '
        'Try adding `context:` parameter in ReownAppKitModal class',
      );
      return;
    }

    analyticsService.instance.sendEvent(ModalOpenEvent(
      connected: _isConnected,
    ));

    // Reset the explorer
    explorerService.instance.search(query: null);
    widgetStack.instance.clear();

    final isBottomSheet = PlatformUtils.isBottomSheet();
    final theme = ReownAppKitModalTheme.maybeOf(_context!);
    await magicService.instance.syncTheme(theme);
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
    analyticsService.instance.sendEvent(event);
  }

  @override
  Future<void> connectSelectedWallet({bool inBrowser = false}) async {
    _checkInitialized();

    final walletRedirect = explorerService.instance.getWalletRedirect(
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
        await coinbaseService.instance.getAccount();
        await explorerService.instance.storeConnectedWallet(_selectedWallet);
      } else {
        await buildConnectionUri();
        await uriService.instance.openRedirect(
          walletRedirect,
          wcURI: wcUri!,
          pType: pType,
        );
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
            _logger.i('[$runtimeType] User declined connection');
            onModalError.broadcast(UserRejectedConnection());
            analyticsService.instance.sendEvent(ConnectErrorEvent(
              message: 'User declined connection',
            ));
          } else {
            onModalError.broadcast(ErrorOpeningWallet());
            analyticsService.instance.sendEvent(ConnectErrorEvent(
              message: e.message,
            ));
          }
        }
      } else if (_isUserRejectedError(e)) {
        _logger.i('[$runtimeType] User declined connection');
        onModalError.broadcast(UserRejectedConnection());
        analyticsService.instance.sendEvent(ConnectErrorEvent(
          message: 'User declined connection',
        ));
      } else {
        _logger.e(
          '[$runtimeType] Error connecting wallet',
          error: e,
          stackTrace: s,
        );
        onModalError.broadcast(ErrorOpeningWallet());
      }
    }
  }

  @override
  Future<void> buildConnectionUri() async {
    if (!_isConnected) {
      try {
        if (siweService.instance!.enabled) {
          final walletRedirect = explorerService.instance.getWalletRedirect(
            selectedWallet,
          );
          final nonce = await siweService.instance!.getNonce();
          final p1 = await siweService.instance!.config!.getMessageParams();
          final methods = p1.methods ?? MethodsConstants.allMethods;
          //
          final supportedNetworks = ReownAppKitModalNetworks.getNetworks(
            CoreConstants.namespace,
          );
          final chains = supportedNetworks
              .map((e) => '${CoreConstants.namespace}:${e.chainId}')
              .toList();
          final p2 = {'nonce': nonce, 'chains': chains, 'methods': methods};
          final authParams = SessionAuthRequestParams.fromJson({
            ...p1.toJson(),
            ...p2,
          });
          // One-Click Auth
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
        _logger.e('[$runtimeType] buildConnectionUri $e');
      }
    }
  }

  void _awaitConnectionCallback(ConnectResponse connectResponse) async {
    try {
      final _ = await connectResponse.session.future;
    } on TimeoutException {
      _logger.i('[$runtimeType] Rebuilding session, ending future');
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
      _logger.i('[$runtimeType] Rebuilding session, ending future');
      return;
    } catch (e) {
      await disconnect();
      await _connectionErrorHandler(e);
    }
  }

  Future<void> _connectionErrorHandler(dynamic e) async {
    if (_isUserRejectedError(e)) {
      _logger.i('[$runtimeType] User declined connection');
      onModalError.broadcast(UserRejectedConnection());
      analyticsService.instance.sendEvent(ConnectErrorEvent(
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
        analyticsService.instance.sendEvent(ConnectErrorEvent(
          message: message,
        ));
        _logger.e('[$runtimeType] $message', error: e);
      }
      if (e is ReownSignError || e is ReownCoreError) {
        onModalError.broadcast(ModalError(e.message));
        analyticsService.instance.sendEvent(ConnectErrorEvent(
          message: e.message,
        ));
        _logger.e('[$runtimeType] ${e.message}', error: e);
      }
    }
    return await expirePreviousInactivePairings();
  }

  @override
  void launchConnectedWallet() async {
    _checkInitialized();

    final walletInfo = explorerService.instance.getConnectedWallet();
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

    final walletRedirect = explorerService.instance.getWalletRedirect(
      walletInfo,
    );

    if (walletRedirect == null) {
      return;
    }

    try {
      final link = metadataRedirect?.native ?? metadataRedirect?.universal;
      uriService.instance.openRedirect(
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
        await coinbaseService.instance.resetSession();
      } catch (_) {
        _status = ReownAppKitModalStatus.initialized;
        _notify();
        return;
      }
    }
    if (_currentSession?.sessionService.isMagic == true) {
      await Future.delayed(Duration(milliseconds: 300));
      final disconnected = await magicService.instance.disconnect();
      if (!disconnected) {
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
        if (siweService.instance!.signOutOnDisconnect) {
          await siweService.instance!.signOut();
        }
      } catch (_) {}

      analyticsService.instance.sendEvent(DisconnectSuccessEvent());
      if (!(_currentSession?.sessionService.isWC == true)) {
        // if sessionService.isWC then _cleanSession() is being called on sessionDelete event
        return await _cleanSession();
      }
      return;
    } catch (e) {
      analyticsService.instance.sendEvent(DisconnectErrorEvent());
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
    if (_disconnectOnClose) {
      _disconnectOnClose = false;
      final currentKey = widgetStack.instance.getCurrent().key;
      if (currentKey == KeyConstants.approveSiwePageKey) {
        analyticsService.instance.sendEvent(ClickCancelSiwe(
          network: _currentSelectedChainId ?? '',
        ));
      }
      await disconnect();
      selectWallet(null);
    }
    toastService.instance.clear();
    analyticsService.instance.sendEvent(ModalCloseEvent(
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
      final address = _currentSession?.address ?? '';
      final explorerUrl = '$blockExplorer/address/$address';
      await uriService.instance.launchUrl(
        Uri.parse(explorerUrl),
        mode: LaunchMode.externalApplication,
      );
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
        reqChainId = '${CoreConstants.namespace}:$chainId';
      } else {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context: 'chainId should conform to "CAIP-2" format',
        );
      }
    }
    //
    _logger.d('[$runtimeType] requestWriteContract, chainId: $reqChainId');

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
        reqChainId = '${CoreConstants.namespace}:$chainId';
      } else {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context: 'chainId should conform to "CAIP-2" format',
        );
      }
    }
    //
    _logger.d('[$runtimeType] requestWriteContract, chainId: $reqChainId');

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
        reqChainId = '${CoreConstants.namespace}:$chainId';
      } else {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context: 'chainId should conform to "CAIP-2" format',
        );
      }
    }
    //
    _logger.d(
      '[$runtimeType] request, chainId: $reqChainId, '
      '${jsonEncode(request.toJson())}',
    );
    try {
      if (_currentSession!.sessionService.isMagic) {
        return await magicService.instance.request(
          chainId: reqChainId,
          request: request,
        );
      }
      if (_currentSession!.sessionService.isCoinbase) {
        return await await coinbaseService.instance.request(
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
        _logger.i('[$runtimeType] User declined request');
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
      await disconnect();
      await expirePreviousInactivePairings();
      _unregisterListeners();
      _status = ReownAppKitModalStatus.idle;
      _logger.d('[$runtimeType] dispose');
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
    final included = (explorerService.instance.includedWalletIds ?? <String>{});
    final excluded = (explorerService.instance.excludedWalletIds ?? <String>{});

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

    final wrongNamespace = _requiredNamespaces.keys.firstWhereOrNull(
      (k) => k != CoreConstants.namespace,
    );
    if (wrongNamespace != null) {
      throw ReownAppKitModalException('Only eip155 blockains are supported');
    }

    _logger.d('[$runtimeType] _requiredNamespaces $_requiredNamespaces');
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
      final namespaces = ReownAppKitModalNetworks.supported.keys;
      for (var ns in namespaces) {
        final chains = ReownAppKitModalNetworks.supported[ns] ?? [];
        _optionalNamespaces[ns] = RequiredNamespace(
          chains: chains.map((e) => '$ns:${e.chainId}').toList(),
          methods: MethodsConstants.allMethods.toSet().toList(),
          events: EventsConstants.allEvents.toSet().toList(),
        );
      }
    }

    final wrongNamespace = _optionalNamespaces.keys.firstWhereOrNull(
      (k) => k != CoreConstants.namespace,
    );
    if (wrongNamespace != null) {
      throw ReownAppKitModalException(
        'Only ${CoreConstants.namespace} networks are supported',
      );
    }

    _logger.d('[$runtimeType] _optionalNamespaces $_optionalNamespaces');
  }

  /// Loads account balance and avatar.
  /// Returns true if it was able to actually load data (i.e. there is a selected chain and session)
  @override
  Future<void> loadAccountData() async {
    // If there is no selected chain or session, stop. No account to load in.
    if (_currentSelectedChainId == null ||
        _currentSession == null ||
        _currentSession?.address == null) {
      return;
    }

    // Get the chain balance.
    _chainBalance = await blockchainService.instance.rpcRequest(
      chainId: '${CoreConstants.namespace}:$_currentSelectedChainId',
      request: SessionRequestParams(
        method: 'eth_getBalance',
        params: [_currentSession!.address!, 'latest'],
      ),
    );
    final tokenName = selectedChain?.currency ?? '';
    balanceNotifier.value = '$_chainBalance $tokenName';

    // Get the avatar, each chainId is just a number in string form.
    try {
      final blockchainId = await blockchainService.instance.getIdentity(
        _currentSession!.address!,
      );
      _avatarUrl = blockchainId.avatar;
      _logger.i('[$runtimeType] loadAccountData');
    } catch (e) {
      _logger.e('[$runtimeType] loadAccountData $e');
    }
    _notify();
  }

  @override
  Future<void> requestSwitchToChain(
      ReownAppKitModalNetworkInfo newChain) async {
    if (_currentSession?.sessionService.isMagic == true) {
      await selectChain(newChain);
      return;
    }
    final currentChain = '${CoreConstants.namespace}:$_currentSelectedChainId';
    final newChainId = '${CoreConstants.namespace}:${newChain.chainId}';
    _logger.i('[$runtimeType] requesting switch to chain $newChainId');
    try {
      await request(
        topic: _currentSession?.topic ?? '',
        chainId: currentChain,
        switchToChainId: newChainId,
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
      _logger.i('[$runtimeType] requestSwitchToChain error $e');
      // if request errors due to user rejection then set the previous chain
      if (_isUserRejectedError(e)) {
        // fallback to current chain if rejected by user
        await _setLocalEthChain(_currentSelectedChainId!);
        throw JsonRpcError(code: 5002, message: 'User rejected methods.');
      } else {
        try {
          // Otherwise it meas chain has to be added.
          return await requestAddChain(newChain);
        } catch (e) {
          rethrow;
        }
      }
    }
  }

  @override
  Future<void> requestAddChain(ReownAppKitModalNetworkInfo newChain) async {
    final topic = _currentSession?.topic ?? '';
    final chainId = '${CoreConstants.namespace}:$_currentSelectedChainId';
    final newChainId = '${CoreConstants.namespace}:${newChain.chainId}';
    _logger.i('[$runtimeType] requesting switch to add chain $newChainId');
    try {
      await request(
        topic: topic,
        chainId: chainId,
        switchToChainId: newChainId,
        request: SessionRequestParams(
          method: MethodsConstants.walletAddEthChain,
          params: [newChain.toJson()],
        ),
      );
      _currentSelectedChainId = newChain.chainId;
      await _setSesionAndChainData(_currentSession!);
      return;
    } catch (e) {
      _logger.i('[$runtimeType] requestAddChain error $e');
      await _setLocalEthChain(_currentSelectedChainId!);
      throw JsonRpcError(code: 5002, message: 'User rejected methods.');
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

  Future<void> _cleanSession({SessionDelete? args, bool event = true}) async {
    try {
      final storedWalletId = _storage.get(StorageConstants.recentWalletId);
      final walletId = storedWalletId?['walletId'];
      await _storage.deleteAll();
      await explorerService.instance.storeRecentWalletId(walletId);
    } catch (_) {
      await _storage.deleteAll();
    }
    if (event) {
      onModalDisconnect.broadcast(ModalDisconnect(
        topic: args?.topic,
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

  void _checkInitialized() {
    if (_status != ReownAppKitModalStatus.initialized &&
        _status != ReownAppKitModalStatus.initializing) {
      throw ReownAppKitModalException(
        'ReownAppKitModal must be initialized before calling this method.',
      );
    }
  }

  void _registerListeners() {
    // Magic
    magicService.instance.onMagicConnect.subscribe(_onMagicConnectEvent);
    magicService.instance.onMagicLoginSuccess.subscribe(_onMagicLoginEvent);
    magicService.instance.onMagicError.subscribe(_onMagicErrorEvent);
    magicService.instance.onMagicUpdate.subscribe(_onMagicSessionUpdateEvent);
    magicService.instance.onMagicRpcRequest.subscribe(_onMagicRequest);
    //
    // Coinbase
    coinbaseService.instance.onCoinbaseConnect.subscribe(
      _onCoinbaseConnectEvent,
    );
    coinbaseService.instance.onCoinbaseError.subscribe(
      _onCoinbaseErrorEvent,
    );
    coinbaseService.instance.onCoinbaseSessionUpdate.subscribe(
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

  void _onNetworkChainRequireSIWE(ModalNetworkChange? args) async {
    try {
      if (siweService.instance!.signOutOnNetworkChange) {
        await siweService.instance!.signOut();
        _disconnectOnClose = true;
        widgetStack.instance.push(ApproveSIWEPage(
          onSiweFinish: _oneSIWEFinish,
        ));
      }
    } catch (e) {
      _logger.e('[$runtimeType] _onNetworkChainRequireSIWE $e');
    }
  }

  void _unregisterListeners() {
    // Magic
    magicService.instance.onMagicLoginSuccess.unsubscribe(_onMagicLoginEvent);
    magicService.instance.onMagicError.unsubscribe(_onMagicErrorEvent);
    magicService.instance.onMagicUpdate.unsubscribe(_onMagicSessionUpdateEvent);
    magicService.instance.onMagicRpcRequest.unsubscribe(_onMagicRequest);
    //
    // Coinbase
    coinbaseService.instance.onCoinbaseConnect.unsubscribe(
      _onCoinbaseConnectEvent,
    );
    coinbaseService.instance.onCoinbaseError.unsubscribe(
      _onCoinbaseErrorEvent,
    );
    coinbaseService.instance.onCoinbaseSessionUpdate.unsubscribe(
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
      debugPrint('storedChain $storedChain');
      return storedChain?['chainId'] as String? ?? defaultValue;
    }
    return defaultValue;
  }
}

extension _EmailConnectorExtension on ReownAppKitModal {
  // Login event should be treated like Connect event for regular wallets
  Future<void> _onMagicLoginEvent(MagicLoginEvent? args) async {
    final debugString = jsonEncode(args?.data?.toJson());
    _logger.i('[$runtimeType] _onMagicLoginEvent: $debugString');
    if (args!.data != null) {
      final newChainId = _getStoredChainId('${args.data!.chainId}')!;
      _currentSelectedChainId = newChainId;
      //
      final magicData = args.data?.copytWith(chainId: int.tryParse(newChainId));
      final session = ReownAppKitModalSession(magicData: magicData);
      await _setSesionAndChainData(session);
      onModalConnect.broadcast(ModalConnect(session));
      if (_selectedWallet == null) {
        await _storage.delete(StorageConstants.recentWalletId);
        await _storage.delete(StorageConstants.connectedWalletData);
      }
      //
      if (siweService.instance!.enabled) {
        if (!_isOpen) {
          await _checkSIWEStatus();
          onModalUpdate.broadcast(ModalConnect(_currentSession!));
        } else {
          _disconnectOnClose = true;
          final theme = ReownAppKitModalTheme.maybeOf(_context!);
          await magicService.instance.syncTheme(theme);
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
    _logger.d('[$runtimeType] _onMagicUpdateEvent: $args');
    if (args != null) {
      try {
        final newEmail = args.email ?? _currentSession!.email;
        final address = args.address ?? _currentSession!.address!;
        final chainId = args.chainId?.toString() ?? _currentSession!.chainId;
        _currentSelectedChainId = chainId;
        //
        final session = _currentSession!.copyWith(
          magicData: MagicData(
            email: newEmail,
            address: address,
            chainId: int.parse(chainId),
            peer: magicService.instance.metadata,
            self: ConnectionMetadata(
              metadata: _appKit.metadata,
              publicKey: '',
            ),
          ),
        );
        await _setSesionAndChainData(session);
        onModalUpdate.broadcast(ModalConnect(session));
      } catch (e, s) {
        _logger.d(
          '[$runtimeType] _onMagicUpdateEvent: $e',
          stackTrace: s,
        );
      }
    }
  }

  Future<void> _onMagicErrorEvent(MagicErrorEvent? args) async {
    _logger.d('[$runtimeType] _onMagicErrorEvent ${args?.error}');
    final errorMessage = args?.error ?? 'Something went wrong';
    if (!errorMessage.toLowerCase().contains('user denied')) {
      onModalError.broadcast(ModalError(errorMessage));
    }
    _notify();
  }

  void _onMagicRequest(MagicRequestEvent? args) {
    _logger.d('[$runtimeType] _onMagicRequest ${args?.toString()}');
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
    final debugString = jsonEncode(args?.data?.toJson());
    _logger.i('[$runtimeType] _onCoinbaseConnectEvent: $debugString');
    if (args?.data != null) {
      final newChainId = _getStoredChainId('${args!.data!.chainId}')!;
      _currentSelectedChainId = newChainId;
      //
      final session = ReownAppKitModalSession(coinbaseData: args.data!);
      await _setSesionAndChainData(session);
      onModalConnect.broadcast(ModalConnect(session));
      //
      if (siweService.instance!.enabled) {
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
    _logger.i('[$runtimeType] _onCoinbaseSessionUpdateEvent $args');
    if (args != null) {
      try {
        final address = args.address ?? _currentSession!.address!;
        final chainId = args.chainId ?? _currentSession!.chainId;
        _currentSelectedChainId = chainId;
        //
        final chain = ReownAppKitModalNetworks.getNetworkById(
          CoreConstants.namespace,
          chainId,
        );
        final session = _currentSession!.copyWith(
          coinbaseData: CoinbaseData(
            address: address,
            chainName: chain?.name ?? '',
            chainId: int.parse(chainId),
            peer: coinbaseService.instance.metadata,
            self: ConnectionMetadata(
              metadata: _appKit.metadata,
              publicKey: await coinbaseService.instance.ownPublicKey,
            ),
          ),
        );
        await _setSesionAndChainData(session);
        onModalUpdate.broadcast(ModalConnect(session));
      } catch (e, s) {
        _logger.d(
          '[$runtimeType] _onCoinbaseSessionUpdateEvent: $e',
          stackTrace: s,
        );
      }
    }
  }

  void _onCoinbaseErrorEvent(CoinbaseErrorEvent? args) async {
    _logger.d('[$runtimeType] _onCoinbaseErrorEvent ${args?.error}');
    final errorMessage = args?.error ?? 'Something went wrong';
    if (!errorMessage.toLowerCase().contains('user denied')) {
      onModalError.broadcast(ModalError(errorMessage));
    }
  }
}

extension _AppKitModalExtension on ReownAppKitModal {
  void _onSessionAuthResponse(SessionAuthResponse? args) async {
    final debugString = jsonEncode(args?.toJson());
    dev.log('[$runtimeType] _onSessionAuthResponse: $debugString');
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
        await siweService.instance!.verifyMessage(
          message: message,
          signature: cacao.s.s,
          clientId: clientId,
        );
      } catch (e) {
        _logger.e('[$runtimeType] _onSessionAuthResponse $e');
        await disconnect();
        return;
      }
      //
      final siweSession = await siweService.instance!.getSession();
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
    dev.log('[$runtimeType] _onSessionConnect: $debugString');
    final siweEnabled = siweService.instance!.enabled;
    if (_supportsOneClickAuth && siweEnabled) return;
    if (args != null) {
      // IF SIWE CALLBACK (1-CA NOT SUPPORTED) SIWECONGIF METHODS ARE CALLED ON ApproveSIWEPage
      final session = await _settleSession(args.session);
      onModalConnect.broadcast(ModalConnect(session));
      //
      if (siweService.instance!.enabled) {
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
  Future<ReownAppKitModalSession> _settleSession(
      SessionData sessionData) async {
    if (_currentSelectedChainId == null) {
      final chains = NamespaceUtils.getChainIdsFromNamespaces(
        namespaces: sessionData.namespaces,
      )..sort((a, b) => a.compareTo(b));
      final chainId = chains.first.split(':').last.toString();
      _currentSelectedChainId = chainId;
    }
    final session = ReownAppKitModalSession(sessionData: sessionData);
    await _setSesionAndChainData(session);
    if (_selectedWallet == null) {
      analyticsService.instance.sendEvent(ConnectSuccessEvent(
        name: 'WalletConnect',
        method: AnalyticsPlatform.qrcode,
      ));
      await _storage.delete(StorageConstants.recentWalletId);
      await _storage.delete(StorageConstants.connectedWalletData);
    } else {
      explorerService.instance.storeConnectedWallet(_selectedWallet);
      final walletName = _selectedWallet!.listing.name;
      analyticsService.instance.sendEvent(ConnectSuccessEvent(
        name: walletName,
        method: AnalyticsPlatform.mobile,
      ));
    }
    return session;
  }

  void _oneSIWEFinish(ReownAppKitModalSession updatedSession) async {
    await _storeSession(updatedSession);
    try {
      await _storage.set(
        StorageConstants.selectedChainId,
        {'chainId': _currentSelectedChainId!},
      );
      debugPrint('_oneSIWEFinish {\'chainId\': $_currentSelectedChainId}');
    } catch (e) {
      _logger.e('[$runtimeType] _setLocalEthChain error: $e');
    }
    onModalUpdate.broadcast(ModalConnect(updatedSession));
    closeModal();
    analyticsService.instance.sendEvent(SiweAuthSuccess(
      network: _currentSelectedChainId!,
    ));
  }

  void _onSessionEvent(SessionEvent? args) async {
    _logger.i('[$runtimeType] session event $args');
    onSessionEventEvent.broadcast(args);
    if (args?.name == EventsConstants.chainChanged) {
      _currentSelectedChainId = args?.data?.toString();
    } else if (args?.name == EventsConstants.accountsChanged) {
      try {
        // TODO implement account change
        if (siweService.instance!.signOutOnAccountChange) {
          await siweService.instance!.signOut();
        }
      } catch (_) {}
    }
    _notify();
  }

  void _onSessionUpdate(SessionUpdate? args) async {
    _logger.i('[$runtimeType] session update $args');
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
    _logger.i('[$runtimeType] session expire $args');
    onSessionExpireEvent.broadcast(args);
  }

  void _onSessionDelete(SessionDelete? args) {
    _logger.i('[$runtimeType] session delete $args');
    _cleanSession(args: args);
  }

  void _onRelayClientConnect(EventArgs? args) {
    _logger.i('[$runtimeType] relay client connected');
    final service =
        _currentSession?.sessionService ?? ReownAppKitModalConnector.wc;
    if (service.isWC && _serviceInitialized) {
      _status = ReownAppKitModalStatus.initialized;
      _notify();
    }
  }

  void _onRelayClientDisconnect(EventArgs? args) {
    _logger.i('[$runtimeType] relay client disconnected');
    final service =
        _currentSession?.sessionService ?? ReownAppKitModalConnector.wc;
    if (service.isWC && _serviceInitialized) {
      _status = ReownAppKitModalStatus.idle;
      _notify();
    }
  }

  void _onRelayClientError(ErrorEvent? args) {
    _logger.i('[$runtimeType] relay client error: ${args?.error}');
    final service =
        _currentSession?.sessionService ?? ReownAppKitModalConnector.wc;
    if (service.isWC) {
      _status = ReownAppKitModalStatus.error;
      _notify();
    }
  }
}
