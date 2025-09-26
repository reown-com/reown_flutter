import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

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
  bool _isCustomTheme = true;

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
      isDarkMode: true,
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
        home: const DWEHomePage(),
      ),
    );
  }
}

class DWEHomePage extends StatefulWidget {
  const DWEHomePage({super.key});

  @override
  State<DWEHomePage> createState() => _DWEHomePageState();
}

class _DWEHomePageState extends State<DWEHomePage> {
  ReownAppKitModal? _appKitModal;

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    _appKitModal = ReownAppKitModal(
      context: context,
      projectId: '876c626bd43841c04f50fc96ea1e31a2',
      logLevel: LogLevel.all,
      metadata: PairingMetadata(
        name: 'DwE Demo',
        description: 'Deposit With Exchange Demo',
        // url: _universalLink(),
        icons: ['https://avatars.githubusercontent.com/u/37784886?s=200&v=4'],
        // redirect: _constructRedirect(linkModeEnabled),
      ),
    );
    _appKitModal!.onModalConnect.subscribe(_eventHandler);
    _appKitModal!.onModalDisconnect.subscribe(_eventHandler);
    await _appKitModal!.init();
    setState(() {});
  }

  void _eventHandler(dynamic event) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DwE Demo', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      ),
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      body: _appKitModal?.status.isInitialized == true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                AppKitModalConnectButton(
                  appKit: _appKitModal!,
                  context: context,
                ),
                Visibility(
                  visible: _appKitModal!.isConnected,
                  child: Column(
                    children: [
                      AppKitModalNetworkSelectButton(
                        appKit: _appKitModal!,
                        context: context,
                        closeAfterPick: true,
                      ),
                      AppKitModalAccountButton(
                        appKitModal: _appKitModal!,
                        context: context,
                        custom: SecondaryButton(
                          title: 'Deposit with Exchange',
                          size: BaseButtonSize.regular,
                          onTap: () {
                            _appKitModal!.openModalView(
                              ReownAppKitModalDepositScreen(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
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
