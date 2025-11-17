import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit_dapp/utils/dart_defines.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

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
                        KastMockedModal(appKitModal: _appKitModal),
                  );
                },
                title: 'Open Kast Mocked Modal',
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

class KastMockedModal extends StatefulWidget {
  const KastMockedModal({super.key, required this.appKitModal});
  final IReownAppKitModal appKitModal;

  @override
  State<KastMockedModal> createState() => _KastMockedModalState();
}

class _KastMockedModalState extends State<KastMockedModal>
    with StatusCheckUtils {
  // IT CAN FAIRLY BE ADDRESS FOR CHAINID INSTEAD OF NAMESPACE
  final Map<String, String> _kastDepositAddressForChain = {
    'eip155':
        '0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340', // KAST deposit address on EVM
    'solana':
        '3ZFT4Cwvy17qzEvjvjyVhgQDYrkzfaXHe8wrpFX8Z5tL', // KAST deposit address on SOLANA
  };

  bool _loading = false;
  // bool _loading2 = false;

  Future<void> topUpNativeFromWallet(int finney) async {
    try {
      setState(() => _loading = true);
      final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
        'eip155',
        '11155111', // Sepolia
      );
      await widget.appKitModal.selectChain(workingChain);
      final walletAddress = widget.appKitModal.session!.getAddress('eip155')!;
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
      final chainId = widget.appKitModal.selectedChain!.chainId;
      checkTxStatus(widget.appKitModal, chainId, response, 30, (status) {
        setState(() => _loading = false);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(status),
              content: Text(jsonEncode(response)),
              actions: [
                TextButton(
                  onPressed: () {
                    widget.appKitModal.disconnect();
                    Navigator.of(context).pop();
                  },
                  child: Text('Disconnect wallet'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      });
    } on JsonRpcError catch (e) {
      setState(() => _loading = false);
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
      setState(() => _loading = false);
      debugPrint('❌ Internal Error: $e');
    }
  }

  Future<void> topUpStablecoinFromWallet(BigInt amount) async {
    try {
      setState(() => _loading = true);
      final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
        'eip155',
        '42161', // Arbitrum
      );
      await widget.appKitModal.selectChain(workingChain);
      final walletAddress = widget.appKitModal.session!.getAddress('eip155')!;

      final contract = ARBUSDCContract();
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(contract.contractABI), contract.name),
        EthereumAddress.fromHex(contract.contractAddress),
      );

      final response = await widget.appKitModal.requestWriteContract(
        topic: widget.appKitModal.session!.topic!,
        chainId: widget.appKitModal.selectedChain!.chainId,
        deployedContract: deployedContract,
        functionName: 'transfer',
        transaction: Transaction(from: EthereumAddress.fromHex(walletAddress)),
        parameters: [
          // should be the Kast recipient address instead
          EthereumAddress.fromHex(walletAddress),
          amount,
        ],
      );
      final chainId = widget.appKitModal.selectedChain!.chainId;
      checkTxStatus(widget.appKitModal, chainId, response, 30, (status) {
        setState(() => _loading = false);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(status),
              content: Text(jsonEncode(response)),
              actions: [
                TextButton(
                  onPressed: () {
                    widget.appKitModal.disconnect();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Disconnect ${widget.appKitModal.session?.connectedWalletName}',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      });
    } on JsonRpcError catch (e) {
      setState(() => _loading = false);
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
      setState(() => _loading = false);
      debugPrint('❌ Internal Error: $e');
    }
  }

  Future<void> topUpFromExchange() async {
    try {
      // CONFIGURE NETWORK YOU WANT TO RECEIVE FUNDS ON
      // Since AppKit defines some EVM and Solana Mainnet by default, you can do this as well
      final workingChain = ReownAppKitModalNetworks.getNetworkInfo(
        'eip155',
        '11155111', // Sepolia
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
        ReownAppKitModalDepositScreen(titleOverride: 'Deposit on Kast'),
      );
      // await widget.appKitModal.selectChain(null);
    } catch (e) {
      debugPrint('❌ Internal Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // widget.appKitModal.onModalConnect.subscribe(_eventListener);
    // widget.appKitModal.onModalDisconnect.subscribe(_eventListener);
    widget.appKitModal.onModalConnect.subscribe(_onConnectHandler);
    widget.appKitModal.onModalDisconnect.subscribe(_onDisconnectHandler);
    widget.appKitModal.onModalError.subscribe(_onErrorHandler);
    widget.appKitModal.onModalUpdate.subscribe(_onUpdateHandler);
    widget.appKitModal.onDepositSuccess.subscribe(_onDepositSuccess);
  }

  void _onConnectHandler(ModalConnect event) {
    if (!mounted) return;
    setState(() {});
    debugPrint('onModalConnect: ${jsonEncode(event.session.toJson())}');
  }

  void _onConnectAndTopUpHandler(ModalConnect event) {
    if (!mounted) return;
    topUpNativeFromWallet(10);
    widget.appKitModal.onModalConnect.unsubscribe(_onConnectAndTopUpHandler);
  }

  void _onDisconnectHandler(ModalDisconnect event) {
    if (!mounted) return;
    setState(() {});
    debugPrint('onModalDisconnect: ${event.toString()}');
  }

  void _onErrorHandler(ModalError event) {
    if (!mounted) return;
    setState(() {});
    debugPrint('onModalError: ${event.toString()}');
  }

  void _onUpdateHandler(ModalConnect event) {
    if (!mounted) return;
    setState(() {});
    debugPrint('onModalUpdate: ${jsonEncode(event.session.toJson())}');
  }

  void _onDepositSuccess(DepositSuccessEvent event) {
    if (!mounted) return;
    debugPrint('onDepositSuccess: ${jsonEncode(event.exchange.toJson())}');
    // {"id":"reown_test","imageUrl":"https://pay-assets.reown.com/reown_test_128_128.webp","name":"Reown Test Exchange"}
  }

  @override
  void dispose() {
    super.dispose();
    widget.appKitModal.onModalConnect.unsubscribe(_onConnectHandler);
    widget.appKitModal.onModalDisconnect.unsubscribe(_onDisconnectHandler);
    widget.appKitModal.onModalError.unsubscribe(_onErrorHandler);
    widget.appKitModal.onModalUpdate.unsubscribe(_onUpdateHandler);
    widget.appKitModal.onDepositSuccess.unsubscribe(_onDepositSuccess);
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
      if (!widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title: 'Connect and Top up 0.01 ETH',
          onTap: () {
            widget.appKitModal.openModalView();
            widget.appKitModal.onModalConnect.subscribe(
              _onConnectAndTopUpHandler,
            );
          },
          // loading: _loading2,
        ),
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title:
              'Top up 0.01 ETH from ${widget.appKitModal.session?.connectedWalletName}',
          onTap: () {
            topUpNativeFromWallet(10);
          },
          // loading: _loading1,
        ),
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title:
              'Top up 1.00 ETH from ${widget.appKitModal.session?.connectedWalletName}',
          onTap: () {
            topUpNativeFromWallet(1000);
          },
          // loading: _loading1,
        ),
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title:
              'Top up 1 USDC from ${widget.appKitModal.session?.connectedWalletName}',
          onTap: () {
            topUpStablecoinFromWallet(BigInt.from(1000000));
          },
          // loading: _loading2,
        ),
      if (widget.appKitModal.isConnected)
        _ReceiveItem(
          icon: Icons.wallet,
          title:
              'Top up 100 USDC from ${widget.appKitModal.session?.connectedWalletName}',
          onTap: () {
            topUpStablecoinFromWallet(BigInt.from(100000000));
          },
          // loading: _loading2,
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
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Padding(
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
            Visibility(
              visible: _loading,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: themeColors.background150,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircularProgressIndicator(
                  color: themeColors.foreground100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiveItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  // final bool loading;

  const _ReceiveItem({
    required this.icon,
    required this.title,
    required this.onTap,
    // this.loading = false,
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
            Icon(Icons.chevron_right, color: themeColors.foreground100),
            const SizedBox.square(dimension: 10.0),
          ],
        ),
      ),
    );
  }
}

mixin StatusCheckUtils {
  Future<void> checkTxStatus(
    IReownAppKitModal appKitModal,
    String chainId,
    String txHash,
    int count,
    Function(String) callback,
  ) async {
    count--;
    String status = 'PENDING';
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    if (namespace == 'eip155') {
      status = await _getEvmTxStatus(appKitModal, chainId, txHash);
    }
    if (namespace == 'solana') {
      status = await _getSolanaTxStatus(appKitModal, chainId, txHash);
    }
    if (namespace == 'tron') {
      status = await _getTronTxStatus(chainId, txHash);
    }

    if (status == 'PENDING') {
      if (count > 0) {
        // retry
        await Future.delayed(Duration(seconds: 1));
        return checkTxStatus(appKitModal, chainId, txHash, count, callback);
      }

      status = 'TIMEOUT';
    }

    callback.call(status);
  }

  Future<String> _getEvmTxStatus(
    IReownAppKitModal appKitModal,
    String chainId,
    String txHash,
  ) async {
    try {
      final response = await appKitModal.rpcRequest(
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
    IReownAppKitModal appKitModal,
    String chainId,
    String txHash,
  ) async {
    try {
      final response = await appKitModal.rpcRequest(
        chainId: chainId,
        method: 'getTransaction',
        params: [
          txHash,
          {'encoding': 'json', 'maxSupportedTransactionVersion': 0},
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

  Future<String> _getTronTxStatus(String chainId, String txHash) async {
    try {
      final tronApi = 'https://api.trongrid.io';
      final url = Uri.parse('$tronApi/wallet/gettransactioninfobyid');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'value': txHash}),
      );

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final receiptResult = data['receipt']?['result'] ?? data['result'];

      if (receiptResult == 'SUCCESS') return 'CONFIRMED';
      if (receiptResult == 'FAILED') return 'FAILED';

      return 'PENDING';
    } catch (error) {
      debugPrint('❌ _getTronTxStatus error: ${error.toString()}');
      rethrow;
    }
  }
}

class ARBUSDCContract {
  String get name => 'USDC-ARB';

  // https://arbiscan.io/address/0xaf88d065e77c8cC2239327C5EDb3A432268e5831
  String get contractAddress => '0xaf88d065e77c8cC2239327C5EDb3A432268e5831';

  List<Map<String, dynamic>> get contractABI => [
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'owner',
              'type': 'address',
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'spender',
              'type': 'address',
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256',
            },
          ],
          'name': 'Approval',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address',
            },
            {
              'indexed': true,
              'internalType': 'bytes32',
              'name': 'nonce',
              'type': 'bytes32',
            },
          ],
          'name': 'AuthorizationCanceled',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address',
            },
            {
              'indexed': true,
              'internalType': 'bytes32',
              'name': 'nonce',
              'type': 'bytes32',
            },
          ],
          'name': 'AuthorizationUsed',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': '_account',
              'type': 'address',
            },
          ],
          'name': 'Blacklisted',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newBlacklister',
              'type': 'address',
            },
          ],
          'name': 'BlacklisterChanged',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'burner',
              'type': 'address',
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'amount',
              'type': 'uint256',
            },
          ],
          'name': 'Burn',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newMasterMinter',
              'type': 'address',
            },
          ],
          'name': 'MasterMinterChanged',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'minter',
              'type': 'address',
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address',
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'amount',
              'type': 'uint256',
            },
          ],
          'name': 'Mint',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'minter',
              'type': 'address',
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'minterAllowedAmount',
              'type': 'uint256',
            },
          ],
          'name': 'MinterConfigured',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'oldMinter',
              'type': 'address',
            },
          ],
          'name': 'MinterRemoved',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': false,
              'internalType': 'address',
              'name': 'previousOwner',
              'type': 'address',
            },
            {
              'indexed': false,
              'internalType': 'address',
              'name': 'newOwner',
              'type': 'address',
            },
          ],
          'name': 'OwnershipTransferred',
          'type': 'event',
        },
        {'anonymous': false, 'inputs': [], 'name': 'Pause', 'type': 'event'},
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newAddress',
              'type': 'address',
            },
          ],
          'name': 'PauserChanged',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newRescuer',
              'type': 'address',
            },
          ],
          'name': 'RescuerChanged',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'from',
              'type': 'address',
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address',
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256',
            },
          ],
          'name': 'Transfer',
          'type': 'event',
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': '_account',
              'type': 'address',
            },
          ],
          'name': 'UnBlacklisted',
          'type': 'event',
        },
        {'anonymous': false, 'inputs': [], 'name': 'Unpause', 'type': 'event'},
        {
          'inputs': [],
          'name': 'CANCEL_AUTHORIZATION_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'DOMAIN_SEPARATOR',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'PERMIT_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'RECEIVE_WITH_AUTHORIZATION_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'TRANSFER_WITH_AUTHORIZATION_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
          ],
          'name': 'allowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
          ],
          'name': 'approve',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
          ],
          'name': 'authorizationState',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
          ],
          'name': 'balanceOf',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_account', 'type': 'address'},
          ],
          'name': 'blacklist',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'blacklister',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': '_amount', 'type': 'uint256'},
          ],
          'name': 'burn',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'},
          ],
          'name': 'cancelAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'bytes', 'name': 'signature', 'type': 'bytes'},
          ],
          'name': 'cancelAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'minter', 'type': 'address'},
            {
              'internalType': 'uint256',
              'name': 'minterAllowedAmount',
              'type': 'uint256',
            },
          ],
          'name': 'configureMinter',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'currency',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'decimals',
          'outputs': [
            {'internalType': 'uint8', 'name': '', 'type': 'uint8'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'decrement', 'type': 'uint256'},
          ],
          'name': 'decreaseAllowance',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'increment', 'type': 'uint256'},
          ],
          'name': 'increaseAllowance',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'string', 'name': 'tokenName', 'type': 'string'},
            {'internalType': 'string', 'name': 'tokenSymbol', 'type': 'string'},
            {
              'internalType': 'string',
              'name': 'tokenCurrency',
              'type': 'string'
            },
            {'internalType': 'uint8', 'name': 'tokenDecimals', 'type': 'uint8'},
            {
              'internalType': 'address',
              'name': 'newMasterMinter',
              'type': 'address',
            },
            {'internalType': 'address', 'name': 'newPauser', 'type': 'address'},
            {
              'internalType': 'address',
              'name': 'newBlacklister',
              'type': 'address',
            },
            {'internalType': 'address', 'name': 'newOwner', 'type': 'address'},
          ],
          'name': 'initialize',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'string', 'name': 'newName', 'type': 'string'},
          ],
          'name': 'initializeV2',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'lostAndFound',
              'type': 'address'
            },
          ],
          'name': 'initializeV2_1',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address[]',
              'name': 'accountsToBlacklist',
              'type': 'address[]',
            },
            {'internalType': 'string', 'name': 'newSymbol', 'type': 'string'},
          ],
          'name': 'initializeV2_2',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_account', 'type': 'address'},
          ],
          'name': 'isBlacklisted',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
          ],
          'name': 'isMinter',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'masterMinter',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_to', 'type': 'address'},
            {'internalType': 'uint256', 'name': '_amount', 'type': 'uint256'},
          ],
          'name': 'mint',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'minter', 'type': 'address'},
          ],
          'name': 'minterAllowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'name',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
          ],
          'name': 'nonces',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'owner',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'pause',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'paused',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'pauser',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            {'internalType': 'bytes', 'name': 'signature', 'type': 'bytes'},
          ],
          'name': 'permit',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'},
          ],
          'name': 'permit',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {
              'internalType': 'uint256',
              'name': 'validAfter',
              'type': 'uint256'
            },
            {
              'internalType': 'uint256',
              'name': 'validBefore',
              'type': 'uint256'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'bytes', 'name': 'signature', 'type': 'bytes'},
          ],
          'name': 'receiveWithAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {
              'internalType': 'uint256',
              'name': 'validAfter',
              'type': 'uint256'
            },
            {
              'internalType': 'uint256',
              'name': 'validBefore',
              'type': 'uint256'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'},
          ],
          'name': 'receiveWithAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'minter', 'type': 'address'},
          ],
          'name': 'removeMinter',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'contract IERC20',
              'name': 'tokenContract',
              'type': 'address',
            },
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'},
          ],
          'name': 'rescueERC20',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'rescuer',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'symbol',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'totalSupply',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'},
          ],
          'stateMutability': 'view',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
          ],
          'name': 'transfer',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
          ],
          'name': 'transferFrom',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'},
          ],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'newOwner', 'type': 'address'},
          ],
          'name': 'transferOwnership',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {
              'internalType': 'uint256',
              'name': 'validAfter',
              'type': 'uint256'
            },
            {
              'internalType': 'uint256',
              'name': 'validBefore',
              'type': 'uint256'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'bytes', 'name': 'signature', 'type': 'bytes'},
          ],
          'name': 'transferWithAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {
              'internalType': 'uint256',
              'name': 'validAfter',
              'type': 'uint256'
            },
            {
              'internalType': 'uint256',
              'name': 'validBefore',
              'type': 'uint256'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'},
          ],
          'name': 'transferWithAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_account', 'type': 'address'},
          ],
          'name': 'unBlacklist',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'unpause',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': '_newBlacklister',
              'type': 'address',
            },
          ],
          'name': 'updateBlacklister',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': '_newMasterMinter',
              'type': 'address',
            },
          ],
          'name': 'updateMasterMinter',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': '_newPauser',
              'type': 'address'
            },
          ],
          'name': 'updatePauser',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'newRescuer',
              'type': 'address'
            },
          ],
          'name': 'updateRescuer',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function',
        },
        {
          'inputs': [],
          'name': 'version',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'},
          ],
          'stateMutability': 'pure',
          'type': 'function',
        },
      ];
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
