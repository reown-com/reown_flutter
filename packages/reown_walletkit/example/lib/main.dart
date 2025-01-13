import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/bottom_sheet_listener.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/cosmos_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/kadena_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/polkadot_service.dart';
// ignore: unused_import
import 'package:reown_walletkit_wallet/dependencies/chain_services/solana_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/solana_service_2.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/key_service.dart';
import 'package:reown_walletkit_wallet/dependencies/walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/page_data.dart';
import 'package:reown_walletkit_wallet/pages/apps_page.dart';
import 'package:reown_walletkit_wallet/pages/settings_page.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/utils/string_constants.dart';

Future<void> main() async {
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _initializing = true;

  List<PageData> _pageDatas = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    GetIt.I.registerSingleton<IBottomSheetService>(BottomSheetService());
    GetIt.I.registerSingleton<IKeyService>(KeyService());

    final walletKitService = WalletKitService();
    await walletKitService.create();
    GetIt.I.registerSingleton<IWalletKitService>(walletKitService);

    // Support EVM Chains
    for (final chainData in ChainsDataList.eip155Chains) {
      GetIt.I.registerSingleton<EVMService>(
        EVMService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Kadena Chains
    for (final chainData in ChainsDataList.kadenaChains) {
      GetIt.I.registerSingleton<KadenaService>(
        KadenaService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Polkadot Chains
    for (final chainData in ChainsDataList.polkadotChains) {
      GetIt.I.registerSingleton<PolkadotService>(
        PolkadotService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Solana Chains
    // Change SolanaService2 to SolanaService to switch between solana_web3: ^0.1.3 to solana: ^0.30.4
    for (final chainData in ChainsDataList.solanaChains) {
      GetIt.I.registerSingleton<SolanaService2>(
        SolanaService2(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Cosmos Chains
    for (final chainData in ChainsDataList.cosmosChains) {
      GetIt.I.registerSingleton<CosmosService>(
        CosmosService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    await walletKitService.init();

    walletKitService.walletKit.core.relayClient.onRelayClientConnect.subscribe(
      _setState,
    );
    walletKitService.walletKit.core.relayClient.onRelayClientDisconnect
        .subscribe(
      _setState,
    );

    setState(() {
      _pageDatas = [
        PageData(
          page: AppsPage(),
          title: StringConstants.connectPageTitle,
          icon: Icons.swap_vert_circle_outlined,
        ),
        // PageData(
        //   page: const Center(
        //     child: Text(
        //       'Inbox (Not Implemented)',
        //       style: StyleConstants.bodyText,
        //     ),
        //   ),
        //   title: 'Inbox',
        //   icon: Icons.inbox_rounded,
        // ),
        PageData(
          page: const SettingsPage(),
          title: 'Settings',
          icon: Icons.settings_outlined,
        ),
      ];

      _initializing = false;
    });
  }

  void _setState(dynamic args) => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (_initializing) {
      return const Material(
        child: Center(
          child: CircularProgressIndicator(
            color: StyleConstants.primaryColor,
          ),
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

    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageDatas[_selectedIndex].title,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          const Text('Relay '),
          CircleAvatar(
            radius: 6.0,
            backgroundColor: walletKit.core.relayClient.isConnected
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: BottomSheetListener(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: navRail,
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
      selectedItemColor: Colors.black,
      // called when one tab is selected
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
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
      // backgroundColor: StyleConstants.backgroundColor,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
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
}
