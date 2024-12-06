import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/models/page_data.dart';
import 'package:reown_appkit_dapp/pages/connect_page.dart';
import 'package:reown_appkit_dapp/pages/pairings_page.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit_dapp/utils/dart_defines.dart';
import 'package:reown_appkit_dapp/utils/deep_link_handler.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:reown_appkit_dapp/widgets/event_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DeepLinkHandler.initListener();
  runApp(const MyApp());
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
      child: MaterialApp(
        title: StringConstants.appTitle,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ReownAppKit? _appKit;
  ReownAppKitModal? _appKitModal;

  List<PageData> _pageDatas = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeService();
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

  Redirect _constructRedirect() {
    return Redirect(
      native: 'wcflutterdapp$_flavor://',
      universal: _universalLink(),
      // enable linkMode on Wallet so Dapps can use relay-less connection
      // universal: value must be set on cloud config as well
      linkMode: true,
    );
  }

  PairingMetadata _pairingMetadata() {
    return PairingMetadata(
      name: 'Flutter AppKit Sample',
      description: 'Reown\'s sample dapp with Flutter',
      url: _universalLink(),
      icons: [
        'https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/appkit-icon$_flavor.png',
      ],
      redirect: _constructRedirect(),
    );
  }

  Future<void> initializeService() async {
    _appKit = ReownAppKit(
      core: ReownCore(
        projectId: DartDefines.projectId,
        logLevel: LogLevel.all,
      ),
      metadata: _pairingMetadata(),
    );

    // Register event handlers
    _appKit!.core.relayClient.onRelayClientError.subscribe(
      _relayClientError,
    );
    _appKit!.core.relayClient.onRelayClientConnect.subscribe(_setState);
    _appKit!.core.relayClient.onRelayClientDisconnect.subscribe(_setState);
    _appKit!.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayMessage,
    );

    _appKit!.onSessionPing.subscribe(_onSessionPing);
    _appKit!.onSessionEvent.subscribe(_onSessionEvent);
    _appKit!.onSessionUpdate.subscribe(_onSessionUpdate);
    _appKit!.onSessionConnect.subscribe(_onSessionConnect);
    _appKit!.onSessionAuthResponse.subscribe(_onSessionAuthResponse);

    // See https://docs.reown.com/appkit/flutter/core/custom-chains
    // final extraChains = ReownAppKitModalNetworks.extra['eip155']!;
    // ReownAppKitModalNetworks.addSupportedNetworks('eip155', extraChains);
    // ReownAppKitModalNetworks.removeSupportedNetworks('solana');
    // ReownAppKitModalNetworks.removeTestNetworks();

    final prefs = await SharedPreferences.getInstance();
    final linkMode = prefs.getBool('appkit_sample_linkmode') ?? false;
    if (!linkMode) {
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
    } else {
      ReownAppKitModalNetworks.removeSupportedNetworks('solana');
    }

    _appKitModal = ReownAppKitModal(
      context: context,
      appKit: _appKit,
      siweConfig: _siweConfig(linkMode),
      enableAnalytics: true,
      featuresConfig: FeaturesConfig(
        email: true,
        socials: [
          AppKitSocialOption.Farcaster,
          AppKitSocialOption.X,
          AppKitSocialOption.Apple,
          AppKitSocialOption.Discord,
        ],
        showMainWallets: false, // OPTIONAL - true by default
      ),
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
      // excludedWalletIds: {
      //   'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa', // Coinbase
      // },
      // MORE WALLETS https://explorer.walletconnect.com/?type=wallet&chains=eip155%3A1
      optionalNamespaces: !linkMode
          ? {
              // This is needed if more chains besides EVM and Solana are supported
              // mostly because we can not define internally every possible method for every possible chain
              'eip155': RequiredNamespace.fromJson({
                'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
                  namespace: 'eip155',
                ).map((chain) => 'eip155:${chain.chainId}').toList(),
                'methods':
                    NetworkUtils.defaultNetworkMethods['eip155']!.toList(),
                'events': NetworkUtils.defaultNetworkEvents['eip155']!.toList(),
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
                'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
                  namespace: 'polkadot',
                ).map((chain) => 'polkadot:${chain.chainId}').toList(),
                'methods': [
                  'polkadot_signMessage',
                  'polkadot_signTransaction',
                ],
                'events': []
              }),
            }
          : null,
    );

    _appKitModal!.onModalConnect.subscribe(_onModalConnect);
    _appKitModal!.onModalUpdate.subscribe(_onModalUpdate);
    _appKitModal!.onModalNetworkChange.subscribe(_onModalNetworkChange);
    _appKitModal!.onModalDisconnect.subscribe(_onModalDisconnect);
    _appKitModal!.onModalError.subscribe(_onModalError);

    _pageDatas = [
      PageData(
        page: ConnectPage(
          appKitModal: _appKitModal!,
          linkMode: linkMode,
          reinitialize: (bool linkMode) async {
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
              await prefs.setBool('appkit_sample_linkmode', linkMode);
              if (!kDebugMode) {
                exit(0);
              }
            }
          },
        ),
        title: StringConstants.connectPageTitle,
        icon: Icons.home,
      ),
      PageData(
        page: PairingsPage(appKitModal: _appKitModal!),
        title: StringConstants.pairingsPageTitle,
        icon: Icons.vertical_align_center_rounded,
      ),
      // PageData(
      //   page: SessionsPage(appKitModal: _appKitModal!),
      //   title: StringConstants.sessionsPageTitle,
      //   icon: Icons.workspaces_filled,
      // ),
    ];

    await _appKitModal!.init();
    await _registerEventHandlers();

    DeepLinkHandler.init(_appKitModal!);
    DeepLinkHandler.checkInitialLink();

    final allChains = ReownAppKitModalNetworks.getAllSupportedNetworks();
    // Loop through all the chain data
    for (final chain in allChains) {
      // Loop through the events for that chain
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        chain.chainId,
      );
      for (final event in getChainEvents(namespace)) {
        _appKit!.registerEventHandler(
          chainId: chain.chainId,
          event: event,
        );
      }
    }
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
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        chain.chainId,
      );
      for (final event in getChainEvents(namespace)) {
        _appKit!.registerEventHandler(
          chainId: chain.chainId,
          event: event,
        );
      }
    }
  }

  void _onSessionConnect(SessionConnect? event) {
    log('[SampleDapp] _onSessionConnect ${jsonEncode(event?.session.toJson())}');
  }

  void _onSessionAuthResponse(SessionAuthResponse? response) {
    debugPrint('[SampleDapp] _onSessionAuthResponse $response');
  }

  void _setState(_) => setState(() {});

  void _relayClientError(ErrorEvent? event) {
    debugPrint('[SampleDapp] _relayClientError ${event?.error}');
    _setState('');
  }

  @override
  void dispose() {
    // Unregister event handlers
    _appKit!.core.relayClient.onRelayClientError.unsubscribe(
      _relayClientError,
    );
    _appKit!.core.relayClient.onRelayClientConnect.unsubscribe(_setState);
    _appKit!.core.relayClient.onRelayClientDisconnect.unsubscribe(_setState);
    _appKit!.core.relayClient.onRelayClientMessage.unsubscribe(
      _onRelayMessage,
    );
    //
    _appKit!.onSessionPing.unsubscribe(_onSessionPing);
    _appKit!.onSessionEvent.unsubscribe(_onSessionEvent);
    _appKit!.onSessionUpdate.unsubscribe(_onSessionUpdate);
    _appKit!.onSessionConnect.subscribe(_onSessionConnect);
    _appKit!.onSessionAuthResponse.subscribe(_onSessionAuthResponse);
    //
    _appKitModal!.onModalConnect.unsubscribe(_onModalConnect);
    _appKitModal!.onModalUpdate.unsubscribe(_onModalUpdate);
    _appKitModal!.onModalNetworkChange.unsubscribe(_onModalNetworkChange);
    _appKitModal!.onModalDisconnect.unsubscribe(_onModalDisconnect);
    _appKitModal!.onModalError.unsubscribe(_onModalError);
    //
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
    navRail.add(
      Expanded(
        child: _pageDatas[_selectedIndex].page,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDatas[_selectedIndex].title),
        centerTitle: true,
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
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Constants.smallScreen.toDouble(),
          ),
          child: Row(
            children: navRail,
          ),
        ),
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
      selectedItemColor: Colors.indigoAccent,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      // called when one tab is selected
      onTap: (index) => setState(() => _selectedIndex = index),
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

  void _onSessionPing(SessionPing? args) {
    debugPrint('[SampleDapp] _onSessionPing $args');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EventWidget(
          title: StringConstants.receivedPing,
          content: 'Topic: ${args!.topic}',
        );
      },
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
        },
        getSession: () async {
          // Return proper session from your Web Service
          final chainId = _appKitModal!.selectedChain?.chainId ?? '1';
          final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
            chainId,
          );
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
  }
}
