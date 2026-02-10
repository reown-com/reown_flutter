import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/bottom_sheet_listener.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/key_service.dart';
import 'package:reown_walletkit_wallet/dependencies/walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/page_data.dart';
import 'package:reown_walletkit_wallet/pages/balances_page.dart';
import 'package:reown_walletkit_wallet/pages/apps_page.dart';
import 'package:reown_walletkit_wallet/pages/settings_page.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_theme.dart';
import 'package:reown_walletkit_wallet/theme/theme_provider.dart';
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';
import 'package:reown_walletkit_wallet/utils/string_constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final themeProvider = ThemeProvider();
      await themeProvider.init();
      GetIt.I.registerSingleton<ThemeProvider>(themeProvider);

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

class _MyAppState extends State<MyApp> {
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
    } catch (e, s) {
      Sentry.captureException(e, stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = GetIt.I<ThemeProvider>();
    return ListenableBuilder(
      listenable: themeProvider,
      builder: (context, _) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          navigatorObservers: [SentryNavigatorObserver()],
          title: StringConstants.appTitle,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeProvider.themeMode,
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

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
          .subscribe(_setState);
      walletKitService.walletKit.core.relayClient.onRelayClientDisconnect
          .subscribe(_setState);
      walletKitService.walletKit.core.connectivity.isOnline.addListener(
        _onLine,
      );

      _setPages();

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
            page: BalancesPage(),
            title: 'Balances',
            icon: Icons.account_balance_wallet_outlined,
          ),
          PageData(
            page: AppsPage(),
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
      return Material(
        child: Center(
          child: CircularProgressIndicator(color: context.colors.accent),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDatas[_selectedIndex].title),
      ),
      body: Stack(
        children: [
          BottomSheetListener(
            child: _pageDatas[_selectedIndex].page,
          ),
          ValueListenableBuilder(
            valueListenable: DeepLinkHandler.waiting,
            builder: (context, value, _) {
              return Visibility(
                visible: value,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.overlay,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(
                      color: context.colors.onAccent,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      unselectedItemColor: context.colors.textSecondary,
      selectedItemColor: context.colors.accent,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) => setState(() => _selectedIndex = index),
      items: _pageDatas
          .map(
            (e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title),
          )
          .toList(),
    );
  }
}
