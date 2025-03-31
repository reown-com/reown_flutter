const String customTemplate = '''import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ReownAppKitModalTheme(
      // isDarkMode: false | true,
      // themeData: ReownAppKitModalThemeData(
      //   lightColors: ReownAppKitModalColors.lightMode.copyWith(),
      //   darkColors: ReownAppKitModalColors.darkMode.copyWith(),
      //   radiuses: ReownAppKitModalRadiuses.circular,
      // ),
      child: MaterialApp(
        title: '{{project_name}}',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ReownAppKitModal _appKitModal;
  @override
  void initState() {
    super.initState();
    // check the docs at https://docs.reown.com/appkit/flutter/core/installation

    {{#if-chains-specified}}
      {{#if-not-chain:eip155}}
        ReownAppKitModalNetworks.removeSupportedNetworks('eip155');
      {{/if-not-chain}}
      {{#if-not-chain:solana}}
        ReownAppKitModalNetworks.removeSupportedNetworks('solana');
      {{/if-not-chain}}
      {{#if-chain-not-in:eip155,solana}}
        // Additional blockchain support detected: {{additional_chains}}
        {{#each-additional-chain}}
          // Add support for your supported networks by following this doc https://docs.reown.com/appkit/flutter/core/custom-chains
          ReownAppKitModalNetworks.addSupportedNetworks('{{chain}}', [
            // TODO add your {{chain}} networks here
            // ReownAppKitModalNetworkInfo(
            //   name: '{{chain}}',
            //   chainId: 'chain_id',
            //   chainIcon: 'https://example.com/icon.png',
            //   currency: 'CURRENCY',
            //   rpcUrl: 'https://rpc.example.com',
            //   explorerUrl: 'https://explorer.example.com',
            // ),
          ]);
        {{/each-additional-chain}}
      {{/if-chain-not-in}}
    {{/if-chains-specified}}

    _appKitModal = ReownAppKitModal(
      context: context,
      logLevel: LogLevel.all,
      projectId: '{{project_id}}',
      metadata: const PairingMetadata(
        name: '{{project_name}}',
        description: '{{project_name}} description',
        url: 'https://{{project_name}}.com',
        icons: ['https://{{project_name}}.com/logo.png'],
        redirect: Redirect(
          native: '{{project_name}}://',
          universal: 'https://{{project_name}}.com/app',
        ),
      ),
      // If you enable social features you will have to whitelist your bundleId/packageName under the Mobile Application IDs secion in https://cloud.reown.com/app
      // Please also follow carefully the relevant doc section https://docs.reown.com/appkit/flutter/core/email
      // featuresConfig: FeaturesConfig(
      //   email: true,
      //   socials: [
      //     AppKitSocialOption.X,
      //     AppKitSocialOption.Apple,
      //     AppKitSocialOption.Discord,
      //     AppKitSocialOption.Farcaster,
      //   ],
      // ),
      {{#if-chains-specified}}
      optionalNamespaces: {
        {{#if-chain:eip155}}
        'eip155': RequiredNamespace.fromJson({
          'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
            namespace: 'eip155',
          ).map((chain) => chain.chainId).toList(),
          'methods': NetworkUtils.defaultNetworkMethods['eip155']!.toList(),
          'events': NetworkUtils.defaultNetworkEvents['eip155']!.toList(),
        }){{#if-chain:solana || additional_chains}},{{/if-chain}}
        {{/if-chain}}
        {{#if-chain:solana}}
        'solana': RequiredNamespace.fromJson({
          'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
            namespace: 'solana',
          ).map((chain) => chain.chainId).toList(),
          'methods': NetworkUtils.defaultNetworkMethods['solana']!.toList(),
          'events': [],
        }){{#if-chain-not-in:eip155,solana}},{{/if-chain-not-in}}
        {{/if-chain}}
        {{#if-chain-not-in:eip155,solana}}
        {{#each-additional-chain}}
        '{{chain}}': RequiredNamespace.fromJson({
          'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
            namespace: '{{chain}}',
          ).map((chain) => chain.chainId).toList(),
          'methods': [
            '{{chain}}_signMessage',
            '{{chain}}_signTransaction',
          ],
          'events': []
        }){{#if-not-last}},{{/if-not-last}}
        {{/each-additional-chain}}
        {{/if-chain-not-in}}
      },
      {{/if-chains-specified}}
    );

    _appKitModal.init().then((value) => setState(() {}));

    // More events at https://docs.reown.com/appkit/flutter/core/events
    _appKitModal.onModalConnect.subscribe((ModalConnect? event) {
      setState(() {});
    });
    _appKitModal.onModalDisconnect.subscribe((ModalDisconnect? event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{project_name}}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            AppKitModalNetworkSelectButton(
              appKit: _appKitModal,
              context: context,
            ),
            AppKitModalConnectButton(
              appKit: _appKitModal,
              context: context,
            ),
            Visibility(
              visible: _appKitModal.isConnected,
              child: Column(
                children: [
                  AppKitModalAccountButton(
                    appKitModal: _appKitModal,
                    context: context,
                  ),
                  AppKitModalAddressButton(
                    appKitModal: _appKitModal,
                    onTap: () {},
                  ),
                  AppKitModalBalanceButton(
                    appKitModal: _appKitModal,
                    onTap: () {},
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: _appKitModal.balanceNotifier,
                    builder: (_, balance, __) {
                      return Text('My balance: \$balance');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
''';
