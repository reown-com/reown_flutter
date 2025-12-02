import 'shared_template.dart';

const String defaultTemplate = '''
$myApp

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
    // TODO check the docs at https://docs.reown.com/appkit/flutter/core/installation

    {{#if-chains-specified}}
    {{#if-not-chain:eip155}}
      ReownAppKitModalNetworks.removeSupportedNetworks('eip155');
    {{/if-not-chain}}
    {{#if-not-chain:solana}}
      ReownAppKitModalNetworks.removeSupportedNetworks('solana');
    {{/if-not-chain}}
    {{/if-chains-specified}}

    _appKitModal = ReownAppKitModal(
      $instanceParams
    );

    _appKitModal.init().then((value) => setState(() {}));

    // More events at https://docs.reown.com/appkit/flutter/core/events
    _appKitModal.onModalConnect.subscribe(_onModalConnect);
    _appKitModal.onModalDisconnect.subscribe(_onModalDisconnect);
  }

  $body
}
''';
