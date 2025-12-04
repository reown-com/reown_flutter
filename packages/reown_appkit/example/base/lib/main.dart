import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/pages/settings_page.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:reown_appkit_dapp/models/page_data.dart';
import 'package:reown_appkit_dapp/pages/connect_page.dart';
import 'package:reown_appkit_dapp/pages/pairings_page.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit_dapp/utils/dart_defines.dart';
import 'package:reown_appkit_dapp/utils/deep_link_handler.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:reown_appkit_dapp/widgets/event_widget.dart';
import 'package:reown_appkit_dapp/widgets/log_overlay.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DeepLinkHandler.initListener();

      if (kDebugMode) {
        runApp(MyApp());
      } else {
        // Catch Flutter framework errors
        FlutterError.onError = (FlutterErrorDetails details) {
          FlutterError.presentError(details);
          Sentry.captureException(details.exception, stackTrace: details.stack);
        };

        await SentryFlutter.init((options) {
          options.dsn = DartDefines.sentryDSN;
          options.environment = kDebugMode ? 'debug_app' : 'deployed_app';
          options.attachScreenshot = true;
          // Adds request headers and IP for users,
          // visit: https://docs.sentry.io/platforms/dart/data-management/data-collected/ for more info
          options.sendDefaultPii = true;
          // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
          // We recommend adjusting this value in production.
          options.tracesSampleRate = 1.0;
          // The sampling rate for profiling is relative to tracesSampleRate
          // Setting to 1.0 will profile 100% of sampled transactions:
          options.profilesSampleRate = 1.0;
        }, appRunner: () => runApp(SentryWidget(child: const MyApp())));
      }
    },
    (error, stackTrace) async {
      if (!kDebugMode) {
        await Sentry.captureException(error, stackTrace: stackTrace);
      }
      debugPrint('Uncaught error: $error');
      debugPrint('Stack trace: $stackTrace');
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _isDarkMode = false;
  bool _isCustomTheme = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final platformDispatcher = View.of(context).platformDispatcher;
        final platformBrightness = platformDispatcher.platformBrightness;
        _isDarkMode = platformBrightness == Brightness.dark;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        final platformDispatcher = View.of(context).platformDispatcher;
        final platformBrightness = platformDispatcher.platformBrightness;
        _isDarkMode = platformBrightness == Brightness.dark;
      });
    }
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return ReownAppKitModalTheme(
      isDarkMode: _isDarkMode,
      themeData: _isCustomTheme
          ? ReownAppKitModalThemeData(
              darkColors: ReownAppKitModalColors.darkMode.copyWith(
                accent100: const Color.fromARGB(255, 55, 186, 149),
                accent090: const Color.fromARGB(255, 55, 186, 149),
                accent080: const Color.fromARGB(255, 55, 186, 149),
                grayGlass100: const Color.fromARGB(255, 55, 186, 149),
                // Main Modal's background color
                background125: const Color.fromARGB(255, 0, 0, 0),
                // Main Modal's text
                foreground100: const Color.fromARGB(255, 55, 186, 149),
                // Secondary Modal's text
                foreground125: const Color.fromARGB(255, 255, 255, 255),
                foreground200: const Color.fromARGB(255, 255, 255, 255),
                foreground300: const Color.fromARGB(255, 255, 255, 255),
              ),
              lightColors: ReownAppKitModalColors.darkMode.copyWith(
                accent100: const Color.fromARGB(255, 55, 186, 149),
                accent090: const Color.fromARGB(255, 55, 186, 149),
                accent080: const Color.fromARGB(255, 55, 186, 149),
                grayGlass100: const Color.fromARGB(255, 55, 186, 149),
                // Main Modal's background color
                background125: const Color.fromARGB(255, 255, 255, 255),
                // Main Modal's text
                foreground100: const Color.fromARGB(255, 55, 186, 149),
                // Secondary Modal's text
                foreground125: const Color.fromARGB(255, 0, 0, 0),
                foreground200: const Color.fromARGB(255, 0, 0, 0),
                foreground300: const Color.fromARGB(255, 0, 0, 0),
              ),
              radiuses: ReownAppKitModalRadiuses.square,
            )
          : null,
      child: MaterialApp(
        navigatorObservers: [SentryNavigatorObserver()],
        title: StringConstants.appTitle,
        theme: ThemeData(
          colorScheme: _isDarkMode
              ? ColorScheme.dark(
                  primary: ReownAppKitModalThemeData().darkColors.accent100,
                )
              : ColorScheme.light(
                  primary: ReownAppKitModalThemeData().lightColors.accent100,
                ),
        ),
        home: MyHomePage(
          isCustomTheme: _isCustomTheme,
          toggleTheme: () {
            setState(() {
              _isCustomTheme = !_isCustomTheme;
            });
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.isCustomTheme,
    required this.toggleTheme,
  });
  final VoidCallback toggleTheme;
  final bool isCustomTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ReownAppKit? _appKit;
  ReownAppKitModal? _appKitModal;

  List<PageData> _pageDatas = [];
  int _selectedIndex = 0;
  bool _showLogOverlay = false;
  final LogManager _logManager = LogManager();

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  String get _flavor {
    String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    return flavor.replaceAll('-production', '');
  }

  String _universalLink() {
    Uri link = Uri.parse('https://appkit-lab.reown.com/flutter_appkit');
    if (_flavor.isNotEmpty || kDebugMode) {
      return link.replace(path: '${link.path}_internal').toString();
    }
    return link.toString();
  }

  Redirect _constructRedirect(bool linkModeEnabled) {
    return Redirect(
      native: 'wcflutterdapp$_flavor://',
      universal: _universalLink(),
      // enable linkMode on Wallet so Dapps can use relay-less connection
      // universal: value must be set on cloud config as well
      linkMode: linkModeEnabled,
    );
  }

  PairingMetadata _pairingMetadata(bool linkModeEnabled) {
    return PairingMetadata(
      name: 'Reown\'s AppKit ${_flavor.replaceFirst('-', '')}',
      description: 'Reown\'s sample dApp with Flutter SDK',
      url: _universalLink(),
      icons: [
        'https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/appkit-icon$_flavor.png',
      ],
      redirect: _constructRedirect(linkModeEnabled),
    );
  }

  FeaturesConfig? _featuresConfig() {
    return FeaturesConfig(
      socials: [
        AppKitSocialOption.Email,
        AppKitSocialOption.X,
        AppKitSocialOption.Google,
        AppKitSocialOption.Apple,
        AppKitSocialOption.Discord,
        AppKitSocialOption.GitHub,
        AppKitSocialOption.Facebook,
        AppKitSocialOption.Twitch,
        AppKitSocialOption.Telegram,
        // AppKitSocialOption.Farcaster,
      ],
      showMainWallets: true, // OPTIONAL - true by default
    );
  }

  // ignore: unused_element
  Set<String>? _specificsWalletIds() {
    return {
      // '2c81da3add65899baeac53758a07e652eea46dbb5195b8074772c62a77bbf568', // Ambire Wallet
      'a797aa35c0fadbfc1a53e7f675162ed5226968b44a19ee3d24385c64d1d3c393', // Phantom
      'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa', // Coinbase
      '18450873727504ae9315a084fa7624b5297d2fe5880f0982979c17345a138277', // Kraken Wallet
      'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // Metamask
      '1ae92b26df02f0abca6304df07debccd18262fdf5fe82daa81593582dac9a369', // Rainbow
      'c03dfee351b6fcc421b4494ea33b9d4b92a984f87aa76d1663bb28705e95034a', // Uniswap
      '38f5d18bd8522c244bdd70cb4a68e0e718865155811c043f052fb9f1c51de662', // Bitget
    };
  }

  void _logListener(String event) => _logManager.addLog(event);

  Future<double> _getBalanceFallback() async {
    try {
      final chainId = _appKitModal!.selectedChain!.chainId;
      final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
      final address = _appKitModal!.session!.getAddress(namespace)!;
      if (namespace != 'eip155') return 0.0;

      final JsonRpcResponse response = await _appKitModal!.rpcRequest(
        chainId: chainId,
        method: 'eth_getBalance',
        params: [address, 'latest'],
      );
      debugPrint('[$runtimeType] _getBalance ${response.result}');
      // parse hex balance
      final parsedBalance = hexToInt(response.result);
      final balance = EtherAmount.fromBigInt(EtherUnit.wei, parsedBalance);
      return balance.getValueInUnit(EtherUnit.ether);
    } catch (e) {
      debugPrint('[$runtimeType] _getBalance error: $e');
    }
    return 0.0;
  }

  Future<void> _initializeService() async {
    final prefs = await SharedPreferences.getInstance();
    final linkModeEnabled = prefs.getBool('appkit_sample_linkmode') ?? false;
    final analyticsEnabled = prefs.getBool('appkit_sample_analytics') ?? true;
    final socialsEnabled = prefs.getBool('appkit_sample_socials') ?? true;

    _appKit = ReownAppKit(
      core: ReownCore(projectId: DartDefines.projectId, logLevel: LogLevel.all),
      metadata: _pairingMetadata(linkModeEnabled),
    );

    // Register event handlers
    _appKit!.core.relayClient.onRelayClientError.subscribe(_relayClientError);
    _appKit!.core.relayClient.onRelayClientConnect.subscribe(_setState);
    _appKit!.core.relayClient.onRelayClientDisconnect.subscribe(_setState);
    _appKit!.core.relayClient.onRelayClientMessage.subscribe(_onRelayMessage);

    // See https://docs.reown.com/appkit/flutter/core/custom-chains
    // final extraChains = ReownAppKitModalNetworks.extra['eip155']!;
    // ReownAppKitModalNetworks.addSupportedNetworks('eip155', extraChains);
    // ReownAppKitModalNetworks.removeSupportedNetworks('solana');
    // ReownAppKitModalNetworks.removeTestNetworks();

    _removeChainsIfNecessary(linkModeEnabled);

    _appKitModal = ReownAppKitModal(
      context: context,
      appKit: _appKit,
      logLevel: LogLevel.all,
      enableAnalytics: analyticsEnabled,
      siweConfig: _siweConfig(linkModeEnabled),
      featuresConfig: socialsEnabled ? _featuresConfig() : null,
      optionalNamespaces: _namespacesBasedOnChains(),
      // featuredWalletIds: _specificsWalletIds(),
      // excludedWalletIds: _specificsWalletIds(),
      // includedWalletIds: _specificsWalletIds(),
      // MORE WALLETS https://explorer.walletconnect.com/?type=wallet&chains=eip155%3A1
      getBalanceFallback: _getBalanceFallback,
      // `getBalanceFallback` will be triggered if getting the balance from our blockchain API fails. You could place here your own getBalance method
      disconnectOnDispose: true,
      customWallets: [
        ReownAppKitModalWalletInfo(
          listing: AppKitModalWalletListing(
            id: '00001',
            name: 'Reown Web Sample',
            homepage: 'https://react-wallet.walletconnect.com',
            imageId:
                'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
            order: 1,
            webappLink: 'https://react-wallet.walletconnect.com',
          ),
        ),
      ],
    );

    _appKitModal!.appKit!.core.addLogListener(_logListener);

    _appKitModal!.onModalConnect.subscribe(_onModalConnect);
    _appKitModal!.onModalUpdate.subscribe(_onModalUpdate);
    _appKitModal!.onModalNetworkChange.subscribe(_onModalNetworkChange);
    _appKitModal!.onModalDisconnect.subscribe(_onModalDisconnect);
    _appKitModal!.onModalError.subscribe(_onModalError);
    _appKitModal!.onSessionEventEvent.subscribe(_onSessionEvent);
    _appKitModal!.onSessionUpdateEvent.subscribe(_onSessionUpdate);

    _pageDatas = [
      PageData(
        page: ConnectPage(appKitModal: _appKitModal!),
        title: StringConstants.connectPageTitle,
        icon: Icons.home,
      ),
      PageData(
        page: PairingsPage(appKitModal: _appKitModal!),
        title: StringConstants.pairingsPageTitle,
        icon: Icons.vertical_align_center_rounded,
      ),
      PageData(
        page: SettingsPage(
          appKitModal: _appKitModal!,
          analytics: analyticsEnabled,
          linkMode: linkModeEnabled,
          socials: socialsEnabled,
          toggleLogs: () => setState(() => _showLogOverlay = !_showLogOverlay),
          toggleTheme: () => widget.toggleTheme.call(),
          reinitialize: (String storageKey, bool value) async {
            final result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('App will be closed to apply changes'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Ok'),
                    ),
                  ],
                );
              },
            );
            if (result == true) {
              await prefs.setBool(storageKey, value);
              if (storageKey == 'appkit_sample_linkmode' && !value) {
                await _appKitModal!.appKit!.core.storage.deleteAll();
              }
              if (!kDebugMode) {
                exit(0);
              }
            }
          },
        ),
        title: StringConstants.settingsPageTitle,
        icon: Icons.settings,
      ),
    ];

    await _appKitModal!.init();
    await _registerEventHandlers();

    DeepLinkHandler.init(_appKitModal!);
    DeepLinkHandler.checkInitialLink();

    final allChains = ReownAppKitModalNetworks.getAllSupportedNetworks();
    // Loop through all the chain data
    for (final chain in allChains) {
      // Loop through the events for that chain
      final namespace = NamespaceUtils.getNamespaceFromChain(chain.chainId);
      for (final event in getChainEvents(namespace)) {
        _appKit!.registerEventHandler(chainId: chain.chainId, event: event);
      }
    }
  }

  // Adds or remove supported networks based on linkMode
  void _removeChainsIfNecessary(bool linkMode) {
    if (linkMode) {
      // When linkMode is true, the application operates in "Link Mode",
      // which is designed to support only EVM-compatible networks.
      // As a result, non-EVM networks like Solana should be removed
      final namespaces = ReownAppKitModalNetworks.getAllSupportedNamespaces()
          .where((ns) => ns != 'eip155');
      for (var ns in namespaces) {
        ReownAppKitModalNetworks.removeSupportedNetworks(ns);
      }
    }
  }

  // Updates namespaces based on supported networks list
  Map<String, RequiredNamespace>? _namespacesBasedOnChains() {
    Map<String, RequiredNamespace> namespaces = {};

    final supportedNS = ReownAppKitModalNetworks.getAllSupportedNamespaces();
    for (var ns in supportedNS) {
      final chains = ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: ns,
      );
      if (chains.isNotEmpty) {
        namespaces[ns] = RequiredNamespace(
          chains: chains.map((c) => c.chainId).toList(),
          methods: getChainMethods(ns),
          events: getChainEvents(ns),
        );
      }
    }

    return namespaces;
  }

  Future<void> _registerEventHandlers() async {
    final onLine = _appKit!.core.connectivity.isOnline.value;
    if (!onLine) {
      await Future.delayed(const Duration(milliseconds: 500));
      _registerEventHandlers();
      return;
    }

    // Loop through all the chain data
    final allChains = ReownAppKitModalNetworks.getAllSupportedNetworks();
    for (final chain in allChains) {
      // Loop through the events for that chain
      final namespace = NamespaceUtils.getNamespaceFromChain(chain.chainId);
      for (final event in getChainEvents(namespace)) {
        _appKit!.registerEventHandler(chainId: chain.chainId, event: event);
      }
    }
  }

  void _relayClientError(ErrorEvent? event) {
    debugPrint('[SampleDapp] _relayClientError ${event?.error}');
    _setState('');
  }

  void _setState(_) => setState(() {});

  @override
  void dispose() {
    // Unregister event handlers
    _appKitModal!.appKit!.core.removeLogListener(_logListener);

    _appKit!.core.relayClient.onRelayClientError.unsubscribe(_relayClientError);
    _appKit!.core.relayClient.onRelayClientConnect.unsubscribe(_setState);
    _appKit!.core.relayClient.onRelayClientDisconnect.unsubscribe(_setState);
    _appKit!.core.relayClient.onRelayClientMessage.unsubscribe(_onRelayMessage);
    //
    _appKitModal!.onModalConnect.unsubscribe(_onModalConnect);
    _appKitModal!.onModalUpdate.unsubscribe(_onModalUpdate);
    _appKitModal!.onModalNetworkChange.unsubscribe(_onModalNetworkChange);
    _appKitModal!.onModalDisconnect.unsubscribe(_onModalDisconnect);
    _appKitModal!.onModalError.unsubscribe(_onModalError);
    _appKitModal!.onSessionEventEvent.unsubscribe(_onSessionEvent);
    _appKitModal!.onSessionUpdateEvent.unsubscribe(_onSessionUpdate);
    //
    _logManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_pageDatas.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    final List<Widget> navRail = [];
    if (MediaQuery.of(context).size.width >= Constants.smallScreen) {
      navRail.add(_buildNavigationRail());
    }
    navRail.add(Expanded(child: _pageDatas[_selectedIndex].page));

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDatas[_selectedIndex].title),
        actions: [
          const Text('Relay '),
          CircleAvatar(
            radius: 6.0,
            backgroundColor: _appKit!.core.relayClient.isConnected
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: Constants.smallScreen.toDouble(),
              ),
              child: Row(children: navRail),
            ),
          ),
          if (_showLogOverlay)
            StreamBuilder<List<String>>(
              stream: _logManager.logsStream,
              initialData: _logManager.logs,
              builder: (context, snapshot) {
                return LogOverlay(
                  logs: snapshot.data ?? [],
                  onClear: () => _logManager.clearLogs(),
                  onToggle: () => setState(() => _showLogOverlay = false),
                );
              },
            ),
        ],
      ),
      bottomNavigationBar:
          MediaQuery.of(context).size.width < Constants.smallScreen
              ? _buildBottomNavBar()
              : null,
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Color(0xFF667DFF),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      // called when one tab is selected
      onTap: (index) => setState(() => _selectedIndex = index),
      // bottom tab items
      items: _pageDatas.map((e) {
        return BottomNavigationBarItem(
          icon: Semantics(
            label: '${e.title} page button',
            child: Icon(e.icon, semanticLabel: '${e.title} page icon'),
          ),
          label: e.title,
        );
      }).toList(),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      labelType: NavigationRailLabelType.selected,
      destinations: _pageDatas
          .map(
            (e) => NavigationRailDestination(
              icon: Icon(e.icon),
              label: Text(e.title),
            ),
          )
          .toList(),
    );
  }

  void _onSessionEvent(SessionEvent? args) {
    debugPrint('[SampleDapp] _onSessionEvent $args');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EventWidget(
          title: StringConstants.receivedEvent,
          content:
              'Topic: ${args!.topic}\nEvent Name: ${args.name}\nEvent Data: ${args.data}',
        );
      },
    );
  }

  void _onSessionUpdate(SessionUpdate? args) {
    debugPrint('[SampleDapp] _onSessionUpdate $args');
  }

  void _onRelayMessage(MessageEvent? args) async {
    if (args != null) {
      try {
        final payloadString = await _appKit!.core.crypto.decode(
          args.topic,
          args.message,
        );
        final data = jsonDecode(payloadString ?? '{}') as Map<String, dynamic>;
        debugPrint('[SampleDapp] _onRelayMessage data $data');
      } catch (e) {
        debugPrint('[SampleDapp] _onRelayMessage error $e');
      }
    }
  }

  SIWEConfig _siweConfig(bool enabled) => SIWEConfig(
        getNonce: () async {
          // this has to be called at the very moment of creating the pairing uri
          return SIWEUtils.generateNonce();
        },
        getMessageParams: () async {
          // Provide everything that is needed to construct the SIWE message
          debugPrint('[SIWEConfig] getMessageParams()');
          final url = _appKitModal!.appKit!.metadata.url;
          final uri = Uri.parse(url);
          return SIWEMessageArgs(
            domain: uri.authority,
            uri: 'https://${uri.authority}/login',
            statement: 'Welcome to AppKit $packageVersion for Flutter.',
            methods: MethodsConstants.allMethods,
          );
        },
        createMessage: (SIWECreateMessageArgs args) {
          // Create SIWE message to be signed.
          // You can use our provided formatMessage() method of implement your own
          debugPrint('[SIWEConfig] createMessage()');
          return SIWEUtils.formatMessage(args);
        },
        verifyMessage: (SIWEVerifyMessageArgs args) async {
          // Implement your verifyMessage to authenticate the user after it.
          debugPrint('[SIWEConfig] verifyMessage()');
          final chainId = SIWEUtils.getChainIdFromMessage(args.message);
          final address = SIWEUtils.getAddressFromMessage(args.message);
          final cacaoSignature = args.cacao != null
              ? args.cacao!.s
              : CacaoSignature(t: CacaoSignature.EIP191, s: args.signature);
          return await SIWEUtils.verifySignature(
            address,
            args.message,
            cacaoSignature,
            chainId,
            DartDefines.projectId,
          );
        },
        getSession: () async {
          // Return proper session from your Web Service
          final chainId = _appKitModal!.selectedChain!.chainId;
          final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
          final address = _appKitModal!.session!.getAddress(namespace)!;
          return SIWESession(address: address, chains: [chainId]);
        },
        onSignIn: (SIWESession session) {
          // Called after SIWE message is signed and verified
          debugPrint('[SIWEConfig] onSignIn()');
        },
        signOut: () async {
          // Called when user taps on disconnect button
          return true;
        },
        onSignOut: () {
          // Called when disconnecting WalletConnect session was successfull
          debugPrint('[SIWEConfig] onSignOut()');
        },
        enabled: enabled,
        signOutOnDisconnect: true,
        signOutOnAccountChange: false,
        signOutOnNetworkChange: false,
        // nonceRefetchIntervalMs: 300000,
        // sessionRefetchIntervalMs: 300000,
      );

  void _onModalConnect(ModalConnect? event) async {
    debugPrint('[ExampleApp] _onModalConnect ${event?.session.toJson()}');
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('AppKit is connected'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onModalUpdate(ModalConnect? event) {
    debugPrint('[ExampleApp] _onModalUpdate ${event?.session.toJson()}');
    setState(() {});
  }

  void _onModalNetworkChange(ModalNetworkChange? event) {
    debugPrint('[ExampleApp] _onModalNetworkChange ${event?.toString()}');
    setState(() {});
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    debugPrint('[ExampleApp] _onModalDisconnect ${event?.toString()}');
    setState(() {});
  }

  void _onModalError(ModalError? event) {
    debugPrint('[ExampleApp] _onModalError ${event?.toString()}');
    // When user connected to Coinbase Wallet but Coinbase Wallet does not have a session anymore
    // (for instance if user disconnected the dapp directly within Coinbase Wallet)
    // Then Coinbase Wallet won't emit any event
    if ((event?.message ?? '').contains('Coinbase Wallet Error')) {
      _appKitModal!.disconnect();
    }
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          event?.message ?? event?.description ?? 'An error occurred',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
