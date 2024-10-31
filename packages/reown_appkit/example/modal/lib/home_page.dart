import 'dart:convert';
import 'dart:developer';

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reown_appkit_example/services/deep_link_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_example/widgets/debug_drawer.dart';
import 'package:reown_appkit_example/utils/constants.dart';
import 'package:reown_appkit_example/services/siwe_service.dart';
import 'package:reown_appkit_example/widgets/logger_widget.dart';
import 'package:reown_appkit_example/widgets/session_widget.dart';
import 'package:reown_appkit_example/utils/dart_defines.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.prefs,
    required this.bundleId,
    required this.toggleBrightness,
    required this.toggleTheme,
  });

  final VoidCallback toggleBrightness;
  final VoidCallback toggleTheme;
  final SharedPreferences prefs;
  final String bundleId;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late OverlayController overlay;
  late ReownAppKitModal _appKitModal;
  late SIWESampleWebService _siweTestService;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _siweTestService = SIWESampleWebService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeService(widget.prefs);
    });
  }

  void _toggleOverlay() {
    overlay.show(context);
  }

  String get _flavor {
    final internal = widget.bundleId.endsWith('.internal');
    final debug = widget.bundleId.endsWith('.debug');
    if (internal || debug || kDebugMode) {
      return '-internal';
    }
    return '';
  }

  String _universalLink() {
    Uri link = Uri.parse('https://appkit-lab.reown.com/flutter_appkit_modal');
    if (_flavor.isNotEmpty && !kDebugMode) {
      return link.replace(path: '${link.path}_internal').toString();
    }
    return link.toString();
  }

  Redirect _constructRedirect() {
    return Redirect(
      native: 'web3modalflutter://',
      universal: _universalLink(),
      // enable linkMode on Wallet so Dapps can use relay-less connection
      // universal: value must be set on cloud config as well
      linkMode: true,
    );
  }

  PairingMetadata _pairingMetadata() {
    return PairingMetadata(
      name: StringConstants.pageTitle,
      description: StringConstants.pageTitle,
      url: _universalLink(),
      icons: [
        'https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/appkit_logo.png',
      ],
      redirect: _constructRedirect(),
    );
  }

  SIWEConfig _siweConfig(bool enabled) => SIWEConfig(
        getNonce: () async {
          // this has to be called at the very moment of creating the pairing uri
          try {
            debugPrint('[SIWEConfig] getNonce()');
            final response = await _siweTestService.getNonce();
            return response['nonce'] as String;
          } catch (error) {
            debugPrint('[SIWEConfig] getNonce error: $error');
            // Fallback patch for testing purposes in case SIWE backend has issues
            return SIWEUtils.generateNonce();
          }
        },
        getMessageParams: () async {
          // Provide everything that is needed to construct the SIWE message
          debugPrint('[SIWEConfig] getMessageParams()');
          final url = _pairingMetadata().url;
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
          try {
            debugPrint('[SIWEConfig] verifyMessage()');
            final payload = args.toJson();
            final url = _pairingMetadata().url;
            final uri = Uri.parse(url);
            final result = await _siweTestService.verifyMessage(
              payload,
              domain: uri.authority,
            );
            return result['token'] != null;
          } catch (error) {
            debugPrint('[SIWEConfig] verifyMessage error: $error');
            // Fallback patch for testing purposes in case SIWE backend has issues
            final chainId = SIWEUtils.getChainIdFromMessage(args.message);
            final address = SIWEUtils.getAddressFromMessage(args.message);
            final cacaoSignature = args.cacao != null
                ? args.cacao!.s
                : CacaoSignature(
                    t: CacaoSignature.EIP191,
                    s: args.signature,
                  );
            return await SIWEUtils.verifySignature(
              address,
              args.message,
              cacaoSignature,
              chainId,
              DartDefines.projectId,
            );
          }
        },
        getSession: () async {
          // Return proper session from your Web Service
          try {
            debugPrint('[SIWEConfig] getSession()');
            final session = await _siweTestService.getSession();
            final address = session['address']!.toString();
            final chainId = session['chainId']!.toString();
            return SIWESession(address: address, chains: [chainId]);
          } catch (error) {
            debugPrint('[SIWEConfig] getSession error: $error');
            // Fallback patch for testing purposes in case SIWE backend has issues
            final chainId = _appKitModal.selectedChain?.chainId ?? '1';
            final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
              chainId,
            );
            final address = _appKitModal.session!.getAddress(namespace)!;
            return SIWESession(address: address, chains: [chainId]);
          }
        },
        onSignIn: (SIWESession session) {
          // Called after SIWE message is signed and verified
          debugPrint('[SIWEConfig] onSignIn()');
        },
        signOut: () async {
          // Called when user taps on disconnect button
          try {
            debugPrint('[SIWEConfig] signOut()');
            final _ = await _siweTestService.signOut();
            return true;
          } catch (error) {
            debugPrint('[SIWEConfig] signOut error: $error');
            // Fallback patch for testing purposes in case SIWE backend has issues
            return true;
          }
        },
        onSignOut: () {
          // Called when disconnecting WalletConnect session was successfull
          debugPrint('[SIWEConfig] onSignOut()');
        },
        enabled: enabled,
        signOutOnDisconnect: true,
        signOutOnAccountChange: true,
        signOutOnNetworkChange: false,
        // nonceRefetchIntervalMs: 300000,
        // sessionRefetchIntervalMs: 300000,
      );

  void _initializeService(SharedPreferences prefs) async {
    final analyticsValue = prefs.getBool('appkit_analytics') ?? true;
    final emailWalletValue = prefs.getBool('appkit_email_wallet') ?? true;
    final siweAuthValue = prefs.getBool('appkit_siwe_auth') ?? true;

    // See https://docs.reown.com/appkit/flutter/core/custom-chains
    // Add extra chains
    // final extraChains = ReownAppKitModalNetworks.extra['eip155']!;
    // ReownAppKitModalNetworks.addSupportedNetworks('eip155', extraChains);
    // Remove every test network
    // ReownAppKitModalNetworks.removeTestNetworks();
    if (siweAuthValue) {
      // Remove Solana support
      ReownAppKitModalNetworks.removeSupportedNetworks('solana');
    } else {
      // Add custom chains
      ReownAppKitModalNetworks.addSupportedNetworks('polkadot', [
        ReownAppKitModalNetworkInfo(
          name: 'Polkadot',
          chainId: '91b171bb158e2d3848fa23a9f1c25182',
          chainIcon: 'https://cryptologos.cc/logos/polkadot-new-dot-logo.png',
          currency: 'DOT',
          rpcUrl: 'https://rpc.polkadot.io',
          explorerUrl: 'https://polkadot.subscan.io',
        ),
        ReownAppKitModalNetworkInfo(
          name: 'Westend',
          chainId: 'e143f23803ac50e8f6f8e62695d1ce9e',
          currency: 'DOT',
          rpcUrl: 'https://westend-rpc.polkadot.io',
          explorerUrl: 'https://westend.subscan.io',
          isTestNetwork: true,
        ),
      ]);
    }

    try {
      _appKitModal = ReownAppKitModal(
        context: context,
        projectId: DartDefines.projectId,
        logLevel: LogLevel.all,
        metadata: _pairingMetadata(),
        siweConfig: _siweConfig(siweAuthValue),
        enableAnalytics: analyticsValue, // OPTIONAL - null by default
        featuresConfig: emailWalletValue
            ? FeaturesConfig(
                email: true,
                socials: [
                  AppKitSocialOption.Farcaster,
                  AppKitSocialOption.X,
                  AppKitSocialOption.Apple,
                  AppKitSocialOption.Discord,
                ],
                // showMainWallets: false, // OPTIONAL - true by default
              )
            : null,
        // requiredNamespaces: {},
        // optionalNamespaces: {},
        // includedWalletIds: {},
        featuredWalletIds: {
          'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa', // Coinbase
          '18450873727504ae9315a084fa7624b5297d2fe5880f0982979c17345a138277', // Kraken Wallet
          'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // Metamask
          '1ae92b26df02f0abca6304df07debccd18262fdf5fe82daa81593582dac9a369', // Rainbow
          'c03dfee351b6fcc421b4494ea33b9d4b92a984f87aa76d1663bb28705e95034a', // Uniswap
          '38f5d18bd8522c244bdd70cb4a68e0e718865155811c043f052fb9f1c51de662', // Bitget
        },
        // excludedWalletIds: {},
        // MORE WALLETS https://explorer.walletconnect.com/?type=wallet&chains=eip155%3A1
        // getBalanceFallback: () async {
        //   // This method will be triggered if getting the balance from our blockchain API fails
        //   // You could place here your own getBalance method
        //   return 0.123;
        // },
        optionalNamespaces: siweAuthValue
            ? null
            : {
                'eip155': RequiredNamespace.fromJson({
                  'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
                    namespace: 'eip155',
                  ).map((chain) => 'eip155:${chain.chainId}').toList(),
                  'methods':
                      NetworkUtils.defaultNetworkMethods['eip155']!.toList(),
                  'events':
                      NetworkUtils.defaultNetworkEvents['eip155']!.toList(),
                }),
                'solana': RequiredNamespace.fromJson({
                  'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
                    namespace: 'solana',
                  ).map((chain) => 'solana:${chain.chainId}').toList(),
                  'methods':
                      NetworkUtils.defaultNetworkMethods['solana']!.toList(),
                  'events': [],
                }),
                'polkadot': RequiredNamespace.fromJson({
                  'chains': [
                    'polkadot:91b171bb158e2d3848fa23a9f1c25182',
                    'polkadot:e143f23803ac50e8f6f8e62695d1ce9e'
                  ],
                  'methods': [
                    'polkadot_signMessage',
                    'polkadot_signTransaction',
                  ],
                  'events': []
                }),
              },
      );
      overlay = OverlayController(
        const Duration(milliseconds: 200),
        appKitModal: _appKitModal,
      );
      _toggleOverlay();
      setState(() => _initialized = true);
    } on ReownAppKitModalException catch (e) {
      debugPrint('⛔️ ${e.message}');
      return;
    }
    // modal specific subscriptions
    _appKitModal.onModalConnect.subscribe(_onModalConnect);
    _appKitModal.onModalUpdate.subscribe(_onModalUpdate);
    _appKitModal.onModalNetworkChange.subscribe(_onModalNetworkChange);
    _appKitModal.onModalDisconnect.subscribe(_onModalDisconnect);
    _appKitModal.onModalError.subscribe(_onModalError);
    // session related subscriptions
    _appKitModal.onSessionExpireEvent.subscribe(_onSessionExpired);
    _appKitModal.onSessionUpdateEvent.subscribe(_onSessionUpdate);
    _appKitModal.onSessionEventEvent.subscribe(_onSessionEvent);
    // relayClient subscriptions
    _appKitModal.appKit!.core.relayClient.onRelayClientConnect.subscribe(
      _onRelayClientConnect,
    );
    _appKitModal.appKit!.core.relayClient.onRelayClientError.subscribe(
      _onRelayClientError,
    );
    _appKitModal.appKit!.core.relayClient.onRelayClientDisconnect.subscribe(
      _onRelayClientDisconnect,
    );
    //
    await _appKitModal.init();

    DeepLinkHandler.init(_appKitModal);
    DeepLinkHandler.checkInitialLink();

    setState(() {});
  }

  @override
  void dispose() {
    //
    _appKitModal.appKit!.core.relayClient.onRelayClientConnect.unsubscribe(
      _onRelayClientConnect,
    );
    _appKitModal.appKit!.core.relayClient.onRelayClientError.unsubscribe(
      _onRelayClientError,
    );
    _appKitModal.appKit!.core.relayClient.onRelayClientDisconnect.unsubscribe(
      _onRelayClientDisconnect,
    );
    //
    _appKitModal.onModalConnect.unsubscribe(_onModalConnect);
    _appKitModal.onModalUpdate.unsubscribe(_onModalUpdate);
    _appKitModal.onModalNetworkChange.unsubscribe(_onModalNetworkChange);
    _appKitModal.onModalDisconnect.unsubscribe(_onModalDisconnect);
    _appKitModal.onModalError.unsubscribe(_onModalError);
    //
    _appKitModal.onSessionExpireEvent.unsubscribe(_onSessionExpired);
    _appKitModal.onSessionUpdateEvent.unsubscribe(_onSessionUpdate);
    _appKitModal.onSessionEventEvent.unsubscribe(_onSessionEvent);
    //
    super.dispose();
  }

  void _onModalConnect(ModalConnect? event) async {
    setState(() {});
    log('[ExampleApp] _onModalConnect ${jsonEncode(event?.session.toJson())}');
  }

  void _onModalUpdate(ModalConnect? event) {
    setState(() {});
  }

  void _onModalNetworkChange(ModalNetworkChange? event) {
    log('[ExampleApp] _onModalNetworkChange ${event?.toString()}');
    setState(() {});
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    log('[ExampleApp] _onModalDisconnect ${event?.toString()}');
    setState(() {});
  }

  void _onModalError(ModalError? event) {
    log('[ExampleApp] _onModalError ${event?.toString()}');
    // When user connected to Coinbase Wallet but Coinbase Wallet does not have a session anymore
    // (for instance if user disconnected the dapp directly within Coinbase Wallet)
    // Then Coinbase Wallet won't emit any event
    if ((event?.message ?? '').contains('Coinbase Wallet Error')) {
      _appKitModal.disconnect();
    }
    setState(() {});
  }

  void _onSessionExpired(SessionExpire? event) {
    debugPrint('[ExampleApp] _onSessionExpired ${event?.toString()}');
    setState(() {});
  }

  void _onSessionUpdate(SessionUpdate? event) {
    debugPrint('[ExampleApp] _onSessionUpdate ${event?.toString()}');
    setState(() {});
  }

  void _onSessionEvent(SessionEvent? event) {
    debugPrint('[ExampleApp] _onSessionEvent ${event?.toString()}');
    setState(() {});
  }

  void _onRelayClientConnect(EventArgs? event) {
    setState(() {});
    showTextToast(text: 'Relay connected', context: context);
  }

  void _onRelayClientError(ErrorEvent? event) {
    setState(() {});
    showTextToast(text: 'Relay disconnected', context: context);
  }

  void _onRelayClientDisconnect(EventArgs? event) {
    setState(() {});
    showTextToast(
      text: 'Relay disconnected: ${event?.toString()}',
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return SizedBox.shrink();
    }
    return Scaffold(
      backgroundColor: ReownAppKitModalTheme.colorsOf(context).background125,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(StringConstants.pageTitle),
        backgroundColor: ReownAppKitModalTheme.colorsOf(context).background175,
        foregroundColor: ReownAppKitModalTheme.colorsOf(context).foreground100,
      ),
      body: !_initialized
          ? const SizedBox.shrink()
          : RefreshIndicator(
              onRefresh: () => _refreshData(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox.square(dimension: 6.0),
                    _ButtonsView(appKit: _appKitModal),
                    _ConnectedView(appKit: _appKitModal),
                  ],
                ),
              ),
            ),
      endDrawer: Drawer(
        backgroundColor: ReownAppKitModalTheme.colorsOf(context).background125,
        child: DebugDrawer(
          toggleOverlay: _toggleOverlay,
          toggleBrightness: widget.toggleBrightness,
          toggleTheme: widget.toggleTheme,
          appKitModal: _appKitModal,
        ),
      ),
      onEndDrawerChanged: (isOpen) {
        // write your callback implementation here
        if (isOpen) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Text(
                'If you made changes you\'ll need to restart the app',
              ),
            );
          },
        );
      },
      // floatingActionButton: CircleAvatar(
      //   radius: 6.0,
      //   backgroundColor: _initialized &&
      //           _appKitModal.appKit?.core.relayClient.isConnected == true
      //       ? Colors.green
      //       : Colors.red,
      // ),
    );
  }

  Future<void> _refreshData() async {
    await _appKitModal.reconnectRelay();
    await _appKitModal.loadAccountData();
    setState(() {});
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView({required this.appKit});
  final ReownAppKitModal appKit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppKitModalNetworkSelectButton(
          appKit: appKit,
          // UNCOMMENT TO USE A CUSTOM BUTTON
          // custom: ElevatedButton(
          //   onPressed: () {
          //     appKit.openNetworksView();
          //   },
          //   child: Text(appKit.selectedChain?.name ?? 'OPEN CHAINS'),
          // ),
        ),
        const SizedBox.square(dimension: 6.0),
        AppKitModalConnectButton(
          appKit: appKit,
          // UNCOMMENT TO USE A CUSTOM BUTTON
          // TO HIDE AppKitModalConnectButton BUT STILL RENDER IT (NEEDED) JUST USE SizedBox.shrink()
          // custom: ElevatedButton(
          //   onPressed: () {
          //     // appKit.openModalView(ReownAppKitModalQRCodePage());
          //     // appKit.openModalView(ReownAppKitModalSelectNetworkPage());
          //     // appKit.openModalView(ReownAppKitModalAllWalletsPage());
          //     // appKit.openModalView(ReownAppKitModalMainWalletsPage());
          //   },
          //   child: appKit.isConnected
          //       ? Text('${appKit.session!.address!.substring(0, 7)}...')
          //       : const Text('CONNECT WALLET'),
          // ),
        ),
      ],
    );
  }
}

class _ConnectedView extends StatelessWidget {
  const _ConnectedView({required this.appKit});
  final ReownAppKitModal appKit;

  @override
  Widget build(BuildContext context) {
    if (!appKit.isConnected) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppKitModalAccountButton(
          appKitModal: appKit,
          // custom: ValueListenableBuilder<String>(
          //   valueListenable: appKit.balanceNotifier,
          //   builder: (_, balance, __) {
          //     return ElevatedButton(
          //       onPressed: () {
          //         appKit.openModalView();
          //       },
          //       child: Text(balance),
          //     );
          //   },
          // ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppKitModalBalanceButton(
              appKitModal: appKit,
              onTap: appKit.openNetworksView,
            ),
            const SizedBox.square(dimension: 8.0),
            AppKitModalAddressButton(
              appKitModal: appKit,
              onTap: appKit.openModalView,
            ),
          ],
        ),
        SessionWidget(appKit: appKit),
        const SizedBox.square(dimension: 12.0),
      ],
    );
  }
}
