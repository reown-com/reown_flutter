import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit_dapp/utils/dart_defines.dart';
import 'package:reown_appkit_dapp/utils/deep_link_handler.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:reown_appkit_dapp/widgets/event_widget.dart';

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
        navigatorObservers: [
          SentryNavigatorObserver(),
        ],
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
            }),
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

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  String get _flavor {
    String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    return flavor.replaceAll('-production', '');
  }

  PairingMetadata _pairingMetadata() {
    final flavor = _flavor.replaceFirst('-', '');
    return PairingMetadata(
      name: 'Reown\'s AppKit $flavor',
      description: 'Reown\'s sample dApp with Flutter SDK',
      url: 'https://appkit-lab.reown.com/flutter_appkit',
      icons: [
        'https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/appkit-icon$_flavor.png',
      ],
      redirect: Redirect(
        native: 'wcflutterdapp$_flavor://',
      ),
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

  Future<void> _initializeService() async {
    _appKit = ReownAppKit(
      core: ReownCore(
        projectId: DartDefines.projectId,
        logLevel: LogLevel.all,
      ),
      metadata: _pairingMetadata(),
    );

    _appKitModal = ReownAppKitModal(
      context: context,
      appKit: _appKit,
      logLevel: LogLevel.all,
      enableAnalytics: true,
      siweConfig: _siweConfig(),
      featuresConfig: _featuresConfig(),
      featuredWalletIds: _specificsWalletIds(),
      // excludedWalletIds: {},
      // includedWalletIds: _specificsWalletIds(),
      // MORE WALLETS https://explorer.walletconnect.com/?type=wallet&chains=eip155%3A1
      getBalanceFallback: () async {
        // This method will be triggered if getting the balance from our blockchain API fails
        // You could place here your own getBalance method
        return 0.0;
      },
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

    // Register event handlers
    _appKit!.core.relayClient.onRelayClientError.subscribe(
      _relayClientError,
    );
    _appKit!.core.relayClient.onRelayClientConnect.subscribe(_setState);
    _appKit!.core.relayClient.onRelayClientDisconnect.subscribe(_setState);
    _appKit!.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayMessage,
    );

    _appKitModal!.onModalConnect.subscribe(_onModalConnect);
    _appKitModal!.onModalUpdate.subscribe(_onModalUpdate);
    _appKitModal!.onModalNetworkChange.subscribe(_onModalNetworkChange);
    _appKitModal!.onModalDisconnect.subscribe(_onModalDisconnect);
    _appKitModal!.onModalError.subscribe(_onModalError);
    _appKitModal!.onSessionEventEvent.subscribe(_onSessionEvent);
    _appKitModal!.onSessionUpdateEvent.subscribe(_onSessionUpdate);

    DeepLinkHandler.init(_appKitModal!);
    DeepLinkHandler.checkInitialLink();
  }

  void _initSDKandOpen() async {
    await _appKitModal!.init();
    _registerEventHandlers();
    setState(() {});
    await _appKitModal!.openModalView();
    await _appKitModal!.dispose();
    setState(() {});
  }

  Future<void> _registerEventHandlers() async {
    // Loop through all the chain data
    final allChains = ReownAppKitModalNetworks.getAllSupportedNetworks();
    for (final chain in allChains) {
      // Loop through the events for that chain
      final namespace = NamespaceUtils.getNamespaceFromChain(chain.chainId);
      for (final event in getChainEvents(namespace)) {
        _appKit!.registerEventHandler(
          chainId: chain.chainId,
          event: event,
        );
      }
    }
  }

  void _relayClientError(ErrorEvent? event) {
    debugPrint('[SampleDapp] _relayClientError ${event?.error}');
    _setState('');
  }

  void _setState(_) {
    print(
      '_appKit!.core.relayClient.isConnected ${_appKit!.core.relayClient.isConnected}',
    );
    setState(() {});
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
    _appKitModal!.onModalConnect.unsubscribe(_onModalConnect);
    _appKitModal!.onModalUpdate.unsubscribe(_onModalUpdate);
    _appKitModal!.onModalNetworkChange.unsubscribe(_onModalNetworkChange);
    _appKitModal!.onModalDisconnect.unsubscribe(_onModalDisconnect);
    _appKitModal!.onModalError.unsubscribe(_onModalError);
    _appKitModal!.onSessionEventEvent.unsubscribe(_onSessionEvent);
    _appKitModal!.onSessionUpdateEvent.unsubscribe(_onSessionUpdate);
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dealyed Init Demo'),
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
        child: _appKitModal!.status.isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _initSDKandOpen,
                child: Text('Init and Open'),
              ),
      ),
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

  SIWEConfig _siweConfig() => SIWEConfig(
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
        enabled: true,
        signOutOnDisconnect: true,
        signOutOnAccountChange: false,
        signOutOnNetworkChange: false,
        // nonceRefetchIntervalMs: 300000,
        // sessionRefetchIntervalMs: 300000,
      );

  void _onModalConnect(ModalConnect? event) async {
    debugPrint('[ExampleApp] _onModalConnect ${event?.session.toJson()}');
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('AppKit is connected'),
      duration: Duration(seconds: 2),
    ));
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        event?.message ?? event?.description ?? 'An error occurred',
      ),
      duration: Duration(seconds: 2),
    ));
  }
}
