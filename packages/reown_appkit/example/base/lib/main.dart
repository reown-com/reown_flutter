import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit_dapp/models/chain_metadata.dart';
import 'package:reown_appkit_dapp/models/page_data.dart';
import 'package:reown_appkit_dapp/pages/connect_page.dart';
import 'package:reown_appkit_dapp/pages/pairings_page.dart';
import 'package:reown_appkit_dapp/pages/sessions_page.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/crypto/chain_data.dart';
import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit_dapp/utils/dart_defines.dart';
import 'package:reown_appkit_dapp/utils/deep_link_handler.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:reown_appkit_dapp/widgets/event_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DeepLinkHandler.initListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _initializing = true;

  ReownAppKit? _appKit;

  List<PageData> _pageDatas = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  String get _flavor {
    String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    return flavor.replaceAll('-production', '');
  }

  String _universalLink() {
    Uri link = Uri.parse('https://lab.web3modal.com/flutter_appkit');
    if (_flavor.isNotEmpty) {
      return link
          .replace(path: '${link.path}_internal')
          .replace(host: 'dev.${link.host}')
          .toString();
    }
    return link.toString();
  }

  Redirect _constructRedirect() {
    return Redirect(
      native: 'wcflutterdapp$_flavor://',
      // universal: _universalLink(),
      // // enable linkMode on Wallet so Dapps can use relay-less connection
      // // universal: value must be set on cloud config as well
      // linkMode: true,
    );
  }

  Future<void> initialize() async {
    _appKit = ReownAppKit(
      core: ReownCore(
        projectId: DartDefines.projectId,
        logLevel: LogLevel.error,
      ),
      metadata: PairingMetadata(
        name: 'Flutter Dapp Sample',
        description: 'Reown\'s sample dapp with Flutter',
        url: _universalLink(),
        icons: [
          'https://images.prismic.io/wallet-connect/65785a56531ac2845a260732_WalletConnect-App-Logo-1024X1024.png'
        ],
        redirect: _constructRedirect(),
      ),
    );

    _appKit!.core.addLogListener(_logListener);

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

    await _appKit!.init();
    await _registerEventHandlers();

    DeepLinkHandler.init(_appKit!);
    DeepLinkHandler.checkInitialLink();

    // Loop through all the chain data
    for (final ChainMetadata chain in ChainData.allChains) {
      // Loop through the events for that chain
      for (final event in getChainEvents(chain.type)) {
        _appKit!.registerEventHandler(
          chainId: chain.chainId,
          event: event,
        );
      }
    }

    setState(() {
      _pageDatas = [
        PageData(
          page: ConnectPage(appKit: _appKit!),
          title: StringConstants.connectPageTitle,
          icon: Icons.home,
        ),
        PageData(
          page: PairingsPage(appKit: _appKit!),
          title: StringConstants.pairingsPageTitle,
          icon: Icons.vertical_align_center_rounded,
        ),
        PageData(
          page: SessionsPage(appKit: _appKit!),
          title: StringConstants.sessionsPageTitle,
          icon: Icons.workspaces_filled,
        ),
      ];

      _initializing = false;
    });
  }

  Future<void> _registerEventHandlers() async {
    final onLine = _appKit!.core.connectivity.isOnline.value;
    if (!onLine) {
      await Future.delayed(const Duration(milliseconds: 500));
      _registerEventHandlers();
      return;
    }

    // Loop through all the chain data
    for (final ChainMetadata chain in ChainData.allChains) {
      // Loop through the events for that chain
      for (final event in getChainEvents(chain.type)) {
        _appKit!.registerEventHandler(
          chainId: chain.chainId,
          event: event,
        );
      }
    }
  }

  void _onSessionConnect(SessionConnect? event) {
    debugPrint('[SampleDapp] _onSessionConnect $event');
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _selectedIndex = 2);
    });
  }

  void _onSessionAuthResponse(SessionAuthResponse? response) {
    debugPrint('[SampleDapp] _onSessionAuthResponse $response');
    if (response?.session != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() => _selectedIndex = 2);
      });
    }
  }

  void _setState(dynamic args) => setState(() {});

  void _relayClientError(ErrorEvent? event) {
    debugPrint('[SampleDapp] _relayClientError ${event?.error}');
    _setState('');
  }

  @override
  void dispose() {
    // Unregister event handlers
    _appKit!.core.removeLogListener(_logListener);

    _appKit!.core.relayClient.onRelayClientError.unsubscribe(
      _relayClientError,
    );
    _appKit!.core.relayClient.onRelayClientConnect.unsubscribe(_setState);
    _appKit!.core.relayClient.onRelayClientDisconnect.unsubscribe(_setState);
    _appKit!.core.relayClient.onRelayClientMessage.unsubscribe(
      _onRelayMessage,
    );

    _appKit!.onSessionPing.unsubscribe(_onSessionPing);
    _appKit!.onSessionEvent.unsubscribe(_onSessionEvent);
    _appKit!.onSessionUpdate.unsubscribe(_onSessionUpdate);
    _appKit!.onSessionConnect.subscribe(_onSessionConnect);
    _appKit!.onSessionAuthResponse.subscribe(_onSessionAuthResponse);

    super.dispose();
  }

  void _logListener(LogEvent event) {
    if (event.level == Level.debug) {
      // TODO send to mixpanel
      log('${event.message}');
    } else {
      debugPrint('${event.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initializing) {
      return const Center(
        child: CircularProgressIndicator(
          color: StyleConstants.primaryColor,
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
}
