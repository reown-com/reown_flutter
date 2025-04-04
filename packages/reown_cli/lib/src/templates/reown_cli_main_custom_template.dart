import 'package:reown_cli/src/templates/shared_template.dart';

const String customTemplate = '''
$myApp

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ReownAppKitModal _appKitModal;

  {{#if-chains-specified}}
    void _configureChains() {
      {{#if-not-chain:eip155}}
        ReownAppKitModalNetworks.removeSupportedNetworks('eip155');
      {{/if-not-chain}}
      {{#if-not-chain:solana}}
        ReownAppKitModalNetworks.removeSupportedNetworks('solana');
      {{/if-not-chain}}
      {{#if-chain-not-in:eip155,solana}}
        // Additional blockchain support detected: {{additional_chains}}
        {{#each-additional-chain}}
          // TODO Add support for your supported networks by following this doc https://docs.reown.com/appkit/flutter/core/custom-chains
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
    }
  {{/if-chains-specified}}

  {{#if-chains-specified}}
    Map<String, RequiredNamespace>? _configureNamespaces() {
      // These are the namespaces configured based on your supported chains
      // You can add more methods/events if you need to
      return {
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
      };
    }
  {{/if-chains-specified}}
  
  @override
  void initState() {
    super.initState();
    // TODO check the docs at https://docs.reown.com/appkit/flutter/core/installation

    {{#if-chains-specified}}
    _configureChains();
    {{/if-chains-specified}}

    _appKitModal = ReownAppKitModal(
      $instanceParams
      {{#if-chains-specified}}
      optionalNamespaces: _configureNamespaces(),
      {{/if-chains-specified}}
    );

    _appKitModal.init().then((value) => setState(() {}));

    // More events at https://docs.reown.com/appkit/flutter/core/events
    _appKitModal.onModalConnect.subscribe(_onModalConnect);
    _appKitModal.onModalDisconnect.subscribe(_onModalDisconnect);
  }

  $body
}
''';
