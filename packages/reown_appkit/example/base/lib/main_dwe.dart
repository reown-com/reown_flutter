import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/dart_defines.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
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
              radiuses: ReownAppKitModalRadiuses.circular,
            )
          : null,
      child: MaterialApp(
        title: 'DwE Demo',
        theme: ThemeData(
          colorScheme: _isDarkMode
              ? ColorScheme.dark(
                  primary: ReownAppKitModalThemeData().darkColors.accent100,
                )
              : ColorScheme.light(
                  primary: ReownAppKitModalThemeData().lightColors.accent100,
                ),
        ),
        home: const MyHomePage(title: 'DwE Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final IReownAppKitModal _appKitModal;
  bool _initialized = false;

  final Map<ExchangeAsset, String> _params = {
    ethereumUSDC: '0xD6d14.....',
    ethereumUSDT: '0xD6d14.....',
    solanaUSDC: '3ZFT4Cwvy17q....',
    arbitrumUSDT: '0xD6d14.....',
    solanaUSDT: '3ZFT4Cwvy17q....',
    arbitrumUSDC: '0xD6d14.....',
    optimismUSDT: '0xD6d14.....',
    polygonUSDC: '0xD6d14.....',
    solanaSOL: '3ZFT4Cwvy17q....',
  };

  ExchangeAsset? _lastPicked;

  @override
  void initState() {
    super.initState();
    _initSDK();
  }

  void _initSDK() async {
    final appKit = ReownAppKit(
      core: ReownCore(
        projectId: DartDefines.projectId,
        logLevel: LogLevel.all,
      ),
      metadata: PairingMetadata(
        name: 'Example',
        description: 'Deposit With Exchange Example',
        url: 'https://example.com/',
        icons: ['https://example.com/icon.png'],
        redirect: Redirect(native: 'exampleapp://'),
      ),
    );
    _appKitModal = ReownAppKitModal(context: context, appKit: appKit);
    await _appKitModal.init();
    setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Scaffold(
      backgroundColor: themeColors.background175,
      appBar: AppBar(
        backgroundColor: themeColors.background250,
        title: Text(widget.title),
      ),
      body: Center(
        child: _initialized
            ? PrimaryButton(
                onTap: () async {
                  try {
                    final randomEntry = _params.entries
                        .where((e) => e.key != _lastPicked)
                        .elementAt(
                          Random().nextInt(_params.length),
                        );
                    _lastPicked = randomEntry.key;
                    await _appKitModal.openModalView(
                      ReownAppKitModalDepositScreen(
                        preselectedRecipient: randomEntry.value,
                        preselectedAsset: randomEntry.key,
                      ),
                    );
                  } catch (_) {}
                },
                title: 'Deposit from Exchange',
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

// // headless implementation example
// final appKit = ReownAppKit(
//   core: ReownCore(
//     // Project ID retrieved from Reown Dashboard
//     projectId: '876c62..........',
//   ),
//   metadata: PairingMetadata(
//     name: 'Example',
//     description: 'Deposit With Exchange Example',
//     url: 'https://example.com/',
//     icons: ['https://example.com/icon.png'],
//     redirect: Redirect(native: 'exampleapp://'),
//   ),
// );
// await appKit.init();

// // 1 GET ASSETS
// final List<ExchangeAsset> assets = appKit.getPaymentAssetsForNetwork(
//   chainId: 'eip155:1',
// );

// // GET EXCHANGES
// final getExchangesParams = GetExchangesParams(page: 1, asset: assets.first);
// final GetExchangesResult exchangesResult = await appKit.getExchanges(
//   params: getExchangesParams,
// );
// // exchangesResult.exchanges;
// // exchangesResult.total;

// // 2 GET PAYMENT URL
// final getExchangeUrlParams = GetExchangeUrlParams(
//   exchangeId: exchangesResult.exchanges.first.id,
//   asset: assets.first,
//   amount: '1.0',
//   recipient: '${assets.first.network}:0x1234567890ABCDEF',
// );
// final GetExchangeUrlResult urlResult = await appKit.getExchangeUrl(
//   params: getExchangeUrlParams,
// );
// // urlResult.url (to be launched in the user's device);
// // urlResult.sessionId

// // 3 GET PAYMENT STATUS
// // loop every 5 seconds
// int maxAttempts = 30;
// int currentAttempt = 0;
// while (currentAttempt < maxAttempts) {
//   try {
//     final params = GetExchangeDepositStatusParams(
//       exchangeId: exchangesResult.exchanges.first.id,
//       sessionId: urlResult.sessionId,
//     );
//     final GetExchangeDepositStatusResult status = await appKit
//         .getExchangeDepositStatus(params: params);
//     if (status.status == 'CONFIRMED' || status.status == 'FAILED') {
//       debugPrint(status.txHash);
//       break;
//     }
//     currentAttempt++;
//     if (currentAttempt < maxAttempts) {
//       await Future.delayed(Duration(seconds: 5));
//     } else {
//       // Max attempts reached, complete with timeout status
//       break;
//     }
//   } catch (e) {
//     break;
//   }
// }
