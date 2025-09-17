import 'dart:convert';

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
      title: 'DWE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Deposit With Exchange Demo'),
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
  String? selectedNetwork;
  ExchangeAsset? selectedAsset;
  final List<Exchange> exchanges = [];
  Exchange? selectedExchange;
  String? sessionId;

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

  void _restart() {
    _breadcrambs = '';
    selectedNetwork = null;
    selectedAsset = null;
    exchanges.clear();
    selectedExchange = null;
    sessionId = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(_breadcrambs, textAlign: TextAlign.left),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NetworksWrap(
                      visible: selectedNetwork == null,
                      onNetwork: (n) {
                        _breadcrambs += 'Network selected: $n\n';
                        setState(() => selectedNetwork = n);
                      },
                    ),
                    AssetsWrap(
                      appKitModal: _appKitModal,
                      visible: selectedAsset == null,
                      network: selectedNetwork,
                      onAsset: (a) {
                        _breadcrambs += 'Asset selected: ${a.toCaip19()}\n';
                        setState(() => selectedAsset = a);
                      },
                    ),
                    GetExchangesButton(
                      appKitModal: _appKitModal,
                      visible: exchanges.isEmpty,
                      asset: selectedAsset,
                      exchanges: (e) {
                        setState(
                          () => exchanges
                            ..clear()
                            ..addAll(e),
                        );
                      },
                    ),
                    ExchangesWrap(
                      appKitModal: _appKitModal,
                      visible: selectedExchange == null,
                      selectedAsset: selectedAsset,
                      exchanges: exchanges,
                      onExchange: (exchange, urlResult) async {
                        selectedExchange = exchange;
                        sessionId = urlResult.sessionId;
                        _breadcrambs += 'Selected exchange: ${exchange.name}\n';
                        _breadcrambs += 'Session id: $sessionId\n';
                        setState(() {});
                        await ReownCoreUtils.openURL(urlResult.url);
                      },
                    ),
                    CheckStatusWidget(
                      appKitModal: _appKitModal,
                      exchangeId: selectedExchange?.id,
                      sessionId: sessionId,
                      onStatus: (status) {
                        _restart();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(jsonEncode(status?.toJson())),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _breadcrambs.isNotEmpty,
              child: TextButton(
                onPressed: _restart,
                child: Text(
                  'RESTART',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
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

    return GestureDetector(
      onTap: () async {
        try {
          final result = await appKitModal.appKit!.getExchanges(
            params: GetExchangesParams(page: 1, asset: asset),
          );
          exchanges.call(result.exchanges);
        } catch (e) {
          debugPrint(e.toString());
        }
      },
      child: Chip(
        label: Text(
          'GET EXCHANGES',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ExchangesWrap extends StatelessWidget {
  final ReownAppKitModal appKitModal;
  final bool visible;
  final List<Exchange> exchanges;
  final ExchangeAsset? selectedAsset;
  final Function(Exchange, GetExchangeUrlResult) onExchange;
  const ExchangesWrap({
    super.key,
    required this.appKitModal,
    required this.visible,
    required this.selectedAsset,
    required this.exchanges,
    required this.onExchange,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedAsset == null || exchanges.isEmpty || !visible) {
      return const SizedBox.shrink();
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      // runSpacing: 10,
      children: exchanges.map((Exchange exchange) {
        exchange.id;
        exchange.imageUrl;
        return GestureDetector(
          onTap: () async {
            try {
              final result = await appKitModal.appKit!.getExchangeUrl(
                params: GetExchangeUrlParams(
                  exchangeId: exchange.id,
                  asset: selectedAsset!,
                  amount: '1.0',
                  recipient:
                      '${selectedAsset!.network}:0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
                ),
              );
              onExchange.call(exchange, result);
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          child: Chip(
            avatar: CircleAvatar(
              backgroundImage: NetworkImage(exchange.imageUrl),
            ),
            label: Text(exchange.name),
          ),
        );
      }).toList(),
    );
  }
}

class CheckStatusWidget extends StatefulWidget {
  final ReownAppKitModal appKitModal;
  final String? exchangeId;
  final String? sessionId;
  final Function(GetExchangeByStatusResult?) onStatus;
  const CheckStatusWidget({
    super.key,
    required this.appKitModal,
    required this.exchangeId,
    required this.sessionId,
    required this.onStatus,
  });

  @override
  State<CheckStatusWidget> createState() => _CheckStatusWidgetState();
}

class _CheckStatusWidgetState extends State<CheckStatusWidget> {
  @override
  void didUpdateWidget(covariant CheckStatusWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.sessionId != null && widget.exchangeId != null) {
      _loopOnStatusCheck(
        widget.exchangeId!,
        widget.sessionId!,
        widget.onStatus,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sessionId == null || widget.exchangeId == null) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: 20.0,
          child: CircularProgressIndicator(strokeWidth: 1.5),
        ),
      ],
    );
  }

  void _loopOnStatusCheck(
    String exchangeId,
    String sessionId,
    Function(GetExchangeByStatusResult?) completer,
  ) async {
    int maxAttempts = 30;
    int currentAttempt = 0;

    while (currentAttempt < maxAttempts) {
      try {
        final response = await widget.appKitModal.appKit!.getExchangeByStatus(
          params: GetExchangeByStatusParams(
            exchangeId: exchangeId,
            sessionId: sessionId,
          ),
        );
        debugPrint(jsonEncode(response));
        if (response.status == 'UNKNOWN' || response.status == 'IN_PROGRESS') {
          currentAttempt++;
          if (currentAttempt < maxAttempts) {
            // Keep trying
            await Future.delayed(Duration(seconds: 5));
          } else {
            // Max attempts reached, complete with timeout status
            completer.call(response);
            break;
          }
        } else {
          // Either SUCCESS or FAILED received
          completer.call(response);
          break;
        }
      } catch (e) {
        debugPrint(e.toString());
        completer.call(null);
        break;
      }
    }
  }
}
