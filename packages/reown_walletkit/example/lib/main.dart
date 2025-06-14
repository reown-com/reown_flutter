import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/bottom_sheet_listener.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/cosmos_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/kadena_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/polkadot_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/solana_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/tron_service.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/key_service.dart';
import 'package:reown_walletkit_wallet/dependencies/walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/page_data.dart';
import 'package:reown_walletkit_wallet/pages/apps_page.dart';
import 'package:reown_walletkit_wallet/pages/settings_page.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';
import 'package:reown_walletkit_wallet/utils/string_constants.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
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

      await SentryFlutter.init(
        (options) {
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
        },
        appRunner: () => runApp(
          SentryWidget(
            child: const MyApp(),
          ),
        ),
      );
    }
  }, (error, stackTrace) async {
    if (!kDebugMode) {
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
    debugPrint('Uncaught error: $error');
    debugPrint('Stack trace: $stackTrace');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    try {
      DeepLinkHandler.errorStream.listen(
        (message) => showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text(message)),
        ),
      );
      WidgetsBinding.instance.addObserver(this);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          final platformDispatcher = View.of(context).platformDispatcher;
          final platformBrightness = platformDispatcher.platformBrightness;
          _isDarkMode = platformBrightness == Brightness.dark;
        });
      });
    } catch (e, s) {
      Sentry.captureException(e, stackTrace: s);
    }
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
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [
        SentryNavigatorObserver(),
      ],
      title: StringConstants.appTitle,
      theme: ThemeData(
        colorScheme: _isDarkMode
            ? ColorScheme.dark(
                primary: Color(0xFF667DFF),
              )
            : ColorScheme.light(
                primary: Color(0xFF667DFF),
              ),
      ),
      home: MyHomePage(
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.isDarkMode});
  final bool isDarkMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PageData> _pageDatas = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      GetIt.I.registerSingleton<IBottomSheetService>(BottomSheetService());
      GetIt.I.registerSingletonAsync<IKeyService>(() async {
        final keyService = KeyService();
        await keyService.init();
        return keyService;
      });
      GetIt.I.registerSingleton<IWalletKitService>(WalletKitService());
      await GetIt.I.allReady(timeout: Duration(seconds: 1));

      final walletKitService = GetIt.I<IWalletKitService>();
      await walletKitService.create();
      await walletKitService.setUpAccounts();
      await walletKitService.init();

      walletKitService.walletKit.core.relayClient.onRelayClientConnect
          .subscribe(
        _setState,
      );
      walletKitService.walletKit.core.relayClient.onRelayClientDisconnect
          .subscribe(
        _setState,
      );

      walletKitService.walletKit.core.connectivity.isOnline.addListener(
        _onLine,
      );

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

      _setPages();

      // TODO _walletKit.core.echo.register(firebaseAccessToken);
      DeepLinkHandler.checkInitialLink();
    } catch (e, s) {
      debugPrint('[$runtimeType] ❌ crash during initialize, $e, $s');
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  void _setState(dynamic args) => setState(() {});

  void _onLine() => setState(() {});

  void _setPages() => setState(() {
        _pageDatas = [
          PageData(
            page: AppsPage(isDarkMode: widget.isDarkMode),
            title: StringConstants.connectPageTitle,
            icon: Icons.swap_vert_circle_outlined,
          ),
          PageData(
            page: const SettingsPage(),
            title: 'Settings',
            icon: Icons.settings_outlined,
          ),
        ];
      });

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final serviceRegistered = GetIt.I.isRegistered<IWalletKitService>();
    if (serviceRegistered) {
      _setPages();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pageDatas.isEmpty) {
      return const Material(
        child: Center(
          child: CircularProgressIndicator(
            color: StyleConstants.primaryColor,
          ),
        ),
      );
    }

    final List<Widget> navRail = [];
    if (MediaQuery.of(context).size.width >= Constants.smallScreen) {
      navRail.add(_buildNavigationRail());
    }
    navRail.add(
      Expanded(
        child: _pageDatas[_selectedIndex].page,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDatas[_selectedIndex].title),
        actions: [
          const Text('Relay '),
          Builder(
            builder: (context) {
              final walletKit = GetIt.I<IWalletKitService>().walletKit;
              return CircleAvatar(
                radius: 6.0,
                backgroundColor: walletKit.core.relayClient.isConnected &&
                        walletKit.core.connectivity.isOnline.value
                    ? Colors.green
                    : Colors.red,
              );
            },
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: Stack(
        children: [
          BottomSheetListener(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: navRail,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: DeepLinkHandler.waiting,
            builder: (context, value, _) {
              return Visibility(
                visible: value,
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
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
      onTap: (int index) => setState(
        () => _selectedIndex = index,
      ),
      // bottom tab items
      items: _pageDatas
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e.icon),
              label: e.title,
            ),
          )
          .toList(),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) => setState(
        () => _selectedIndex = index,
      ),
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
}
