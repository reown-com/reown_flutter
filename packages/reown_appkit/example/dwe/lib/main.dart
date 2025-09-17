import 'package:flutter/material.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';
import 'package:reown_appkit/base/services/models/query_models.dart';
import 'package:reown_appkit/base/services/models/result_models.dart';
import 'package:reown_appkit/reown_appkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late final ReownAppKitModal _appKitModal;
  String _breadcrambs = '';
  String? network;
  ExchangeAsset? asset;
  final List<Exchange> exchanges = [];

  @override
  void initState() {
    super.initState();
    _appKitModal = ReownAppKitModal(
      context: context,
      projectId: '876c626bd43841c04f50fc96ea1e31a2',
      logLevel: LogLevel.all,
      disconnectOnDispose: false,
      metadata: PairingMetadata(
        name: 'DWE',
        description: 'Deposit With Exchange Demo',
        url: 'https://appkit-pay-ecommerce-demo.reown.com',
        icons: [
          'https://pbs.twimg.com/profile_images/1832911695947223040/uStftanD_400x400.jpg',
        ],
        redirect: Redirect(native: 'dwedemo://'),
      ),
      featuresConfig: FeaturesConfig(socials: [AppKitSocialOption.Email]),
      enableAnalytics: true, // OPTIONAL - null by default
    );

    _appKitModal.init().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(_breadcrambs, textAlign: TextAlign.center),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NetworksWrap(
                    visible: network == null,
                    onNetwork: (n) {
                      _breadcrambs += 'Network: $n\n';
                      setState(() => network = n);
                    },
                  ),
                  AssetsWrap(
                    appKitModal: _appKitModal,
                    visible: asset == null,
                    network: network,
                    onAsset: (a) {
                      _breadcrambs += 'Asset: ${a.toCaip19()}\n';
                      setState(() => asset = a);
                    },
                  ),
                  GetExchangesButton(
                    appKitModal: _appKitModal,
                    visible: exchanges.isEmpty,
                    asset: asset,
                    exchanges: (e) {
                      setState(
                        () => exchanges
                          ..clear()
                          ..addAll(e),
                      );
                    },
                  ),
                  // ExchangesWrap(
                  //   exchanges: exchanges,
                  //   onExchange: (e) async {
                  //     // final result = await _appKitModal.appKit!.getExchangeUrl(
                  //     //   params: GetExchangeUrlParams(
                  //     //     exchangeId: e.id,
                  //     //     asset: sepoliaETH,
                  //     //     amount: '1.0',
                  //     //     recipient:
                  //     //         'eip155:1:0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
                  //     //   ),
                  //     // );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NetworksWrap extends StatelessWidget {
  final bool visible;
  final Function(String chainId) onNetwork;
  const NetworksWrap({
    super.key,
    required this.visible,
    required this.onNetwork,
  });

  @override
  Widget build(BuildContext context) {
    final networks = allExchangeAssets.map((asset) => asset.network).toSet();
    return Visibility(
      visible: visible,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        // runSpacing: 10,
        children: networks.map((e) {
          return GestureDetector(
            onTap: () {
              onNetwork.call(e);
            },
            child: Chip(label: Text(e.toUpperCase())),
          );
        }).toList(),
      ),
    );
  }
}

class AssetsWrap extends StatelessWidget {
  final ReownAppKitModal appKitModal;
  final bool visible;
  final String? network;
  final Function(ExchangeAsset) onAsset;
  const AssetsWrap({
    super.key,
    required this.visible,
    required this.appKitModal,
    required this.network,
    required this.onAsset,
  });

  @override
  Widget build(BuildContext context) {
    if (network == null || !visible) {
      return const SizedBox.shrink();
    }

    final assets = appKitModal.appKit!.getPaymentAssetsForNetwork(
      chainId: network!,
    );
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      // runSpacing: 10,
      children: assets.map((asset) {
        final namespace = NamespaceUtils.getNamespaceFromChain(asset.network);
        final name = namespace == 'solana'
            ? 'SOLANA'
            : asset.network.toUpperCase();
        return GestureDetector(
          onTap: () {
            onAsset.call(asset);
          },
          child: Chip(label: Text('${asset.metadata.symbol} ($name)')),
        );
      }).toList(),
    );
  }
}

class GetExchangesButton extends StatelessWidget {
  final ReownAppKitModal appKitModal;
  final bool visible;
  final ExchangeAsset? asset;
  final Function(List<Exchange>) exchanges;
  const GetExchangesButton({
    super.key,
    required this.visible,
    required this.appKitModal,
    required this.asset,
    required this.exchanges,
  });

  @override
  Widget build(BuildContext context) {
    if (asset == null || !visible) {
      return const SizedBox.shrink();
    }

    // final namespace = NamespaceUtils.getNamespaceFromChain(asset!.network);
    // final name = namespace == 'solana'
    //     ? 'SOLANA'
    //     : asset!.network.toUpperCase();
    return Column(
      children: [
        // Chip(label: Text('${asset!.metadata.symbol} ($name)')),
        // TextButton(
        //   onPressed: () async {
        //     final result = await appKitModal.appKit!.getExchanges(
        //       params: GetExchangesParams(page: 1, asset: asset),
        //     );
        //     exchanges.call(result.exchanges);
        //   },
        //   child: Text('Get Exchanges'),
        // ),
        GestureDetector(
          onTap: () async {
            final result = await appKitModal.appKit!.getExchanges(
              params: GetExchangesParams(page: 1, asset: asset),
            );
            exchanges.call(result.exchanges);
          },
          child: Chip(label: Text('GET EXCHANGES')),
        ),
      ],
    );
  }
}

class ExchangesWrap extends StatelessWidget {
  final List<Exchange> exchanges;
  final Function(Exchange) onExchange;
  const ExchangesWrap({
    super.key,
    required this.exchanges,
    required this.onExchange,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: exchanges.isNotEmpty,
      child: Wrap(
        spacing: 10,
        // runSpacing: 10,
        children: exchanges.map((Exchange exchange) {
          exchange.id;
          exchange.imageUrl;
          return GestureDetector(
            onTap: () {
              // onExchange.call(exchange);
              // final result = await _appKitModal.appKit!.getExchangeUrl(
              //   params: GetExchangeUrlParams(
              //     exchangeId: e.id,
              //     asset: sepoliaETH,
              //     amount: '1.0',
              //     recipient:
              //         'eip155:1:0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
              //   ),
              // );
            },
            child: Chip(
              avatar: CircleAvatar(
                backgroundImage: NetworkImage(exchange.imageUrl),
              ),
              label: Text(exchange.name),
            ),
          );
        }).toList(),
      ),
    );
  }
}
