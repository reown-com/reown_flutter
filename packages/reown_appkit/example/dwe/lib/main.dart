import 'package:flutter/material.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';
import 'package:reown_appkit/base/services/models/query_models.dart';
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

  // final ethUSDC = 'eip155:1/erc20:0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48';
  // final baseUSDC = 'eip155:8453/erc20:0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913';
  // final nativeETH = 'eip155:1/slip44:60';
  // final nativeSOL = 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp/slip44:501';
  // final unsupportedAsset = 'eip155:999/erc20:0x1234567890123456789012345678901234567890';

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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                final result = await _appKitModal.appKit!.getExchanges(
                  params: GetExchangesParams(page: 1),
                );
                debugPrint(result.exchanges.toString());
                debugPrint(result.total.toString());
                final result2 = await _appKitModal.appKit!.getExchangeUrl(
                  params: GetExchangeUrlParams(
                    exchangeId: 'reown_test',
                    asset: sepoliaETH,
                    amount: '1.0',
                    recipient:
                        'eip155:1:0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
                  ),
                );
                debugPrint(result2.sessionId.toString());
                debugPrint(result2.url.toString());
                final result3 = await _appKitModal.appKit!.getExchangeByStatus(
                  params: GetExchangeByStatusParams(
                    exchangeId: 'reown_test',
                    sessionId: result2.sessionId,
                  ),
                );
                debugPrint(result3.toString());
              },
              child: Text('Get Exchanges'),
            ),
          ],
        ),
      ),
    );
  }
}
