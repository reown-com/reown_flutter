const String myApp = '''import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO Check out the docs on how to tweak the modal theme https://docs.reown.com/appkit/flutter/core/theming
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
''';

const String body = '''
  void _onModalConnect(ModalConnect? event) {
    setState(() {});
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    setState(() {});
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
  ''';

const String instanceParams = '''
  context: context,
  logLevel: LogLevel.all,
  projectId: '{{project_id}}',
  metadata: const PairingMetadata(
    name: '{{project_name}}',
    description: '{{project_name}} description',
    url: 'https://{{project_name}}.com',
    icons: ['https://{{project_name}}.com/logo.png'],
    // TODO check the docs on how to configure the redirect object https://docs.reown.com/appkit/flutter/core/usage#redirect-to-your-dapp
    redirect: Redirect(
      native: '{{project_name}}://',
      universal: 'https://{{project_name}}.com/app',
      // See https://docs.reown.com/appkit/flutter/core/link-mode on how to enable Link Mode
      // linkMode: true,
    ),
  ),
  // enableAnalytics: true,
  // See https://docs.reown.com/appkit/flutter/core/siwe on how to enable SIWE
  // siweConfig: SIWEConfig(...),
  // If you enable social features you will have to whitelist your bundleId/packageName under the Mobile Application IDs secion in https://cloud.reown.com/app
  // Please also follow carefully the relevant doc section https://docs.reown.com/appkit/flutter/core/email
  // You can delete this commented section if you don't want to enable Email/Social login
  // featuresConfig: FeaturesConfig(
  //   socials: [
  //     AppKitSocialOption.Email,
  //     AppKitSocialOption.X,
  //     AppKitSocialOption.Google,
  //     AppKitSocialOption.Apple,
  //     AppKitSocialOption.Discord,
  //     AppKitSocialOption.Facebook,
  //     AppKitSocialOption.GitHub,
  //     AppKitSocialOption.Telegram,
  //     AppKitSocialOption.Twitch,
  //   ],
  // ),
  // https://docs.reown.com/appkit/flutter/core/options#getbalancefallback%3A
  // getBalanceFallback: () async {},
  // disconnectOnDispose: true,
''';
