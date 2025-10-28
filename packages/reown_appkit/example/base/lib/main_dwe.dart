import 'dart:async';

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
      themeData: ReownAppKitModalThemeData(
        darkColors: ReownAppKitModalColors.darkMode.copyWith(
          background100: const Color.fromARGB(255, 12, 15, 14),
          background125: const Color.fromARGB(255, 12, 15, 14),
        ),
        radiuses: ReownAppKitModalRadiuses.circular,
      ),
      child: MaterialApp(
        title: 'Kast DwE Demo',
        theme: ThemeData(
          colorScheme: _isDarkMode
              ? ColorScheme.dark(
                  primary: ReownAppKitModalThemeData().darkColors.accent100,
                )
              : ColorScheme.light(
                  primary: ReownAppKitModalThemeData().lightColors.accent100,
                ),
        ),
        home: const MyHomePage(title: 'Kast DwE Demo'),
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

  @override
  void initState() {
    super.initState();
    _initSDK();
  }

  void _initSDK() async {
    _appKitModal = ReownAppKitModal(
      projectId: DartDefines.projectId,
      logLevel: LogLevel.all,
      context: context,
      metadata: PairingMetadata(
        name: 'Kast',
        description: 'Banking without the bank',
        url: 'https://www.kast.xyz',
      ),
    );

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
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => ReceiveMoneySheet(
                          appKitModal: _appKitModal,
                        ),
                      );
                    },
                    title: 'Receive Money',
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

class ReceiveMoneySheet extends StatefulWidget {
  const ReceiveMoneySheet({super.key, required this.appKitModal});
  final IReownAppKitModal appKitModal;

  @override
  State<ReceiveMoneySheet> createState() => _ReceiveMoneySheetState();
}

class _ReceiveMoneySheetState extends State<ReceiveMoneySheet> {
  // IT CAN FAIRLY BE ADDRESS FOR CHAINID INSTEAD OF NAMESPACE
  final Map<String, String> _kastDepositAddressForChain = {
    'eip155': '0xD6d146ec0FA9...',
    'solana': '3ZFT4Cwvy17qzE...',
  };

  @override
  Widget build(BuildContext context) {
    final items = [
      _ReceiveItem(
        icon: Icons.blur_on_rounded,
        title: 'Pix',
        onTap: () {},
      ),
      _ReceiveItem(
        icon: Icons.swap_vert_circle_outlined,
        title: 'Top up from Exchanges',
        onTap: () async {
          try {
            // CONFIGURE NETWORK YOU WANT TO RECEIVE FUNDS ON
            // Since AppKit defines some EVM and Solana Mainnet by default, you can do this as well
            final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
              'solana',
              '5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp', // Solana Mainnet
            );
            // Other examples...
            // final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
            //   'eip155',
            //   '10', // Optimism
            // );
            // final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
            //   'eip155',
            //   '42161', // Arbitrum
            // );
            // final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
            //   'eip155',
            //   '137', // Polygon
            // );

            // If you wan't to use some custom chain that is not included in `ReownAppKitModalNetworks` you will have to configure it as follows...
            // final solanaNetwork = ReownAppKitModalNetworkInfo(
            //   name: 'Solana',
            //   chainId: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
            //   currency: 'SOL',
            //   rpcUrl: 'https://rpc.walletconnect.org/v1',
            //   explorerUrl: 'https://solscan.io',
            // );
            // and then include it in supported networks. See docs https://docs.reown.com/appkit/flutter/core/custom-chains
            // ReownAppKitModalNetworks.addSupportedNetworks('solana', [
            //   solanaNetwork,
            // ]);

            // Just a util to get the namespace out of the chainId
            final namespace = NamespaceUtils.getNamespaceFromChain(
              workingChain!.chainId,
            );
            // Get the proper address for the chain/namespace
            final depositAddress = _kastDepositAddressForChain[namespace]!;

            // PRESELECT THE CONFIGURED NETWORK SO THE USER DOESN'T HAVE TO
            await widget.appKitModal.selectChain(workingChain);

            // INCLUDE ALL ASSETS BUT NATIVES
            // this call is only necessary if you want to exclude native tokens such as SOL, ETH
            final assets = widget.appKitModal.getPaymentAssetsForNetwork(
              chainId: workingChain.chainId,
              includeNative: false,
            );

            // CONFIGURE THE FEATURE BEFORE USING IT
            widget.appKitModal.configDeposit(
              supportedAssets: assets,
              preselectedRecipient: depositAddress,
              showNetworkIcon: false,
            );

            // OPEN MODAL
            // widget.appKitModal.openDepositView();
            widget.appKitModal.openModalView(
              ReownAppKitModalDepositScreen(
                titleOverride: 'Kast Deposit',
              ),
            );
            // await widget.appKitModal.selectChain(null);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
      ),
      _ReceiveItem(
        icon: Icons.currency_exchange_rounded,
        title: 'Stablecoin',
        onTap: () {},
      ),
      _ReceiveItem(
        icon: Icons.token_outlined,
        title: 'Crypto',
        onTap: () {},
      ),
      _ReceiveItem(
        icon: Icons.account_balance_outlined,
        title: 'USD bank transfer',
        onTap: () {},
      ),
      _ReceiveItem(
        icon: Icons.link_outlined,
        title: 'Payment link',
        onTap: () {},
      ),
    ];

    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Container(
      decoration: BoxDecoration(
          color: themeColors.background125,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
          border: Border(
              top: BorderSide(
            color: themeColors.background150,
          ))),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ===== GRAB HANDLE =====
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 6, bottom: 12),
                decoration: BoxDecoration(
                  color: themeColors.foreground300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.square(dimension: 8.0),
                  Text(
                    'Receive money',
                    style: TextStyle(
                      color: themeColors.foreground100,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: themeColors.foreground100,
                      size: 28.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const SizedBox(height: 8),
              // Items
              ...items.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: e,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiveItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ReceiveItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const SizedBox.square(dimension: 8.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: themeColors.grayGlass005,
              ),
              child: Icon(icon, color: themeColors.foreground100),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: themeColors.foreground100,
                  fontSize: 15,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: themeColors.foreground100,
            ),
            const SizedBox.square(dimension: 10.0),
          ],
        ),
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
