import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/dart_defines.dart';
import 'package:reown_appkit_dapp/utils/smart_contracts.dart';

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
        // radiuses: ReownAppKitModalRadiuses.square,
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

  String get _flavor {
    String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    return flavor.replaceAll('-production', '');
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
        redirect: Redirect(native: 'wcflutterdapp$_flavor://'),
      ),
      // featuresConfig: FeaturesConfig(
      //   socials: [
      //     AppKitSocialOption.Email,
      //     AppKitSocialOption.X,
      //     AppKitSocialOption.Google,
      //     AppKitSocialOption.Apple,
      //     // AppKitSocialOption.Discord,
      //     // AppKitSocialOption.GitHub,
      //     // AppKitSocialOption.Facebook,
      //     // AppKitSocialOption.Twitch,
      //     // AppKitSocialOption.Telegram,
      //   ],
      //   showMainWallets: false, // OPTIONAL - true by default
      // ),
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
            ? SecondaryButton(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) =>
                        ReceiveMoneySheet(appKitModal: _appKitModal),
                  );
                },
                title: 'Open Kast Mocked Modal',
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
    'eip155': '0xD6d146ec0FA9...', // KAST deposit address on EVM
    'solana': '3ZFT4Cwvy17qzE...', // KAST deposit address on SOLANA
  };

  bool _loading1 = false;
  bool _loading2 = false;

  Future<String> _getEvmTxStatus(
    String chainId,
    String txHash,
  ) async {
    try {
      final response = await widget.appKitModal.rpcRequest(
        chainId: chainId,
        method: 'eth_getTransactionReceipt',
        params: [txHash],
      );

      if (response.result == null) {
        return 'PENDING';
      }

      final result = response.result as Map<String, dynamic>;
      final hexStatus = result['status'] as String;
      if (hexStatus == '0x0') {
        return 'FAILED';
      }

      return 'CONFIRMED';
    } catch (error) {
      debugPrint('❌ _getEvmTxStatus error: ${error.toString()}');
      rethrow;
    }
  }

  Future<String> _getSolanaTxStatus(
    String chainId,
    String txHash,
  ) async {
    try {
      final response = await widget.appKitModal.rpcRequest(
        chainId: chainId,
        method: 'getTransaction',
        params: [
          txHash,
          {'encoding': 'json'} // or 'jsonParsed'
        ],
      );

      if (response.result == null) {
        return 'PENDING';
      }

      final result = response.result as Map<String, dynamic>;
      final meta = result['meta'];
      final error = meta?['err'];
      if (error != null) return 'FAILED';

      return 'CONFIRMED';
    } catch (error) {
      debugPrint('❌ _getSolanaTxStatus error: ${error.toString()}');
      rethrow;
    }
  }

  int _tryCount = 30;

  Future<String> checkTxStatus(
    ReownAppKitModalNetworkInfo network,
    String txHash,
  ) async {
    _tryCount--;
    String status = 'PENDING';
    final namespace = NamespaceUtils.getNamespaceFromChain(network.chainId);
    if (namespace == 'eip155') {
      status = await _getEvmTxStatus(network.chainId, txHash);
    }
    if (namespace == 'solana') {
      status = await _getSolanaTxStatus(network.chainId, txHash);
    }

    if (status == 'PENDING' && _tryCount > 0) {
      // retry
      await Future.delayed(Duration(seconds: 1));
      return checkTxStatus(network, txHash);
    }

    setState(() => _loading1 = false);
    setState(() => _loading2 = false);
    _tryCount = 30;
    return status;
  }

  Future<void> topUpNativeFromWallet(int finney) async {
    try {
      setState(() => _loading1 = true);
      final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
        'eip155',
        '11155111', // Sepolia
      );
      await widget.appKitModal.selectChain(workingChain);
      final walletAddress = widget.appKitModal.session!.getAddress(
        'eip155',
      )!;
      final response = await widget.appKitModal.request(
        topic: widget.appKitModal.session!.topic!,
        chainId: widget.appKitModal.selectedChain!.chainId,
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [
            Transaction(
              from: EthereumAddress.fromHex(walletAddress),
              // should be Kast custodial address
              to: EthereumAddress.fromHex(walletAddress),
              // 10 finney = 0.01 ETHs in WEI
              value: EtherAmount.fromInt(EtherUnit.finney, finney),
            ).toJson(),
          ],
        ),
      );
      checkTxStatus(workingChain!, response).then(
        (value) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(value),
              content: Text(jsonEncode(response)),
              actions: [
                TextButton(
                  onPressed: () {
                    // widget.appKitModal.disconnect();
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        ),
      );
    } on JsonRpcError catch (e) {
      setState(() => _loading1 = false);
      // errors such as user rejected, insufficient funds and more
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error ${e.code}'),
            content: Text(e.message ?? 'An error occurred'),
          );
        },
      );
    } catch (e) {
      setState(() => _loading1 = false);
      debugPrint('❌ Internal Error: $e');
    }
  }

  Future<void> topUpStablecoinFromWallet(BigInt amount) async {
    try {
      setState(() => _loading2 = true);
      final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
        'eip155',
        '42161', // Arbitrum
      );
      await widget.appKitModal.selectChain(workingChain);
      final walletAddress = widget.appKitModal.session!.getAddress(
        'eip155',
      )!;

      final contract = ARBUSDCContract();
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(contract.contractABI),
          contract.name,
        ),
        EthereumAddress.fromHex(contract.contractAddress),
      );

      final response = await widget.appKitModal.requestWriteContract(
        topic: widget.appKitModal.session!.topic!,
        chainId: widget.appKitModal.selectedChain!.chainId,
        deployedContract: deployedContract,
        functionName: 'transfer',
        transaction: Transaction(
          from: EthereumAddress.fromHex(walletAddress),
        ),
        parameters: [
          // should be the Kast recipient address instead
          EthereumAddress.fromHex(walletAddress),
          amount,
        ],
      );
      checkTxStatus(workingChain!, response).then(
        (value) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(value),
              content: Text(jsonEncode(response)),
              actions: [
                TextButton(
                  onPressed: () {
                    // widget.appKitModal.disconnect();
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        ),
      );
    } on JsonRpcError catch (e) {
      setState(() => _loading2 = false);
      // errors such as user rejected, insufficient funds and more
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error ${e.code}'),
            content: Text(e.message ?? 'An error occurred'),
          );
        },
      );
    } catch (e) {
      setState(() => _loading2 = false);
      debugPrint('❌ Internal Error: $e');
    }
  }

  Future<void> topUpFromExchange() async {
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
      widget.appKitModal.openDepositView();
      // widget.appKitModal.openModalView(
      //   ReownAppKitModalDepositScreen(titleOverride: 'Kast Deposit'),
      // );
      // await widget.appKitModal.selectChain(null);
    } catch (e) {
      debugPrint('❌ Internal Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    widget.appKitModal.onModalConnect.subscribe(_eventListener);
    widget.appKitModal.onModalDisconnect.subscribe(_eventListener);
  }

  void _eventListener(EventArgs event) {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    widget.appKitModal.onModalConnect.unsubscribe(_eventListener);
    widget.appKitModal.onModalDisconnect.unsubscribe(_eventListener);
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _ReceiveItem(icon: Icons.blur_on_rounded, title: 'Pix', onTap: () {}),
      if (!widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title: 'Connect Wallet',
          onTap: () {
            widget.appKitModal.openModalView();
          },
        ),
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title:
              'Top up 0.01 ETH from ${widget.appKitModal.session?.connectedWalletName}',
          onTap: () {
            topUpNativeFromWallet(10);
          },
          loading: _loading1,
        ),
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title:
              'Top up 1.00 ETH from ${widget.appKitModal.session?.connectedWalletName}',
          onTap: () {
            topUpNativeFromWallet(1000);
          },
          loading: _loading1,
        ),
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title:
              'Top up 1 USDC from ${widget.appKitModal.session?.connectedWalletName}',
          onTap: () {
            topUpStablecoinFromWallet(BigInt.from(1000000));
          },
          loading: _loading2,
        ),
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title:
              'Top up 100 USDC from ${widget.appKitModal.session?.connectedWalletName}',
          onTap: () {
            topUpStablecoinFromWallet(BigInt.from(100000000));
          },
          loading: _loading2,
        ),
      _ReceiveItem(
        icon: Icons.swap_vert_circle_outlined,
        title: 'Top up from Exchanges',
        onTap: () {
          topUpFromExchange();
        },
      ),
      // _ReceiveItem(
      //   icon: Icons.currency_exchange_rounded,
      //   title: 'Stablecoin',
      //   onTap: () {},
      // ),
      // _ReceiveItem(icon: Icons.token_outlined, title: 'Crypto', onTap: () {}),
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
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title: 'Disconnect wallet',
          onTap: () async {
            widget.appKitModal.disconnect();
          },
        ),
    ];

    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Container(
      decoration: BoxDecoration(
        color: themeColors.background125,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
        border: Border(top: BorderSide(color: themeColors.background150)),
      ),
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
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Items
              ...items.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: e,
                ),
              ),
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
  final bool loading;

  const _ReceiveItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.loading = false,
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
            loading
                ? CircularProgressIndicator.adaptive()
                : Icon(Icons.chevron_right, color: themeColors.foreground100),
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
