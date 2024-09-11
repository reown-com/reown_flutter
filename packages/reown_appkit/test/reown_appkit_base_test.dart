import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'shared/shared_test_utils.dart';
import 'shared/shared_test_values.dart';

import '../../reown_sign/test/tests/sign_common.dart';
import '../../reown_walletkit/test/walletkit_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  signEngineTests(
    context: 'ReownAppKit/ReownWalletKit',
    clientACreator: (PairingMetadata metadata) async =>
        await ReownAppKit.createInstance(
      projectId: TEST_PROJECT_ID,
      relayUrl: TEST_RELAY_URL,
      metadata: metadata,
      memoryStore: true,
      logLevel: LogLevel.info,
      httpClient: getHttpWrapper(),
    ),
    clientBCreator: (PairingMetadata metadata) async =>
        await ReownWalletKit.createInstance(
      projectId: TEST_PROJECT_ID,
      relayUrl: TEST_RELAY_URL,
      metadata: metadata,
      memoryStore: true,
      logLevel: LogLevel.info,
      httpClient: getHttpWrapper(),
    ),
  );

  final List<Future<IReownAppKit> Function(PairingMetadata)> appCreators = [
    (PairingMetadata metadata) async => await ReownAppKit.createInstance(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          memoryStore: true,
          metadata: metadata,
          logLevel: LogLevel.info,
          httpClient: getHttpWrapper(),
        ),
  ];
  final List<Future<IReownWalletKit> Function(PairingMetadata)> walletCreators =
      [
    (PairingMetadata metadata) async => await ReownWalletKit.createInstance(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          memoryStore: true,
          metadata: metadata,
          logLevel: LogLevel.info,
          httpClient: getHttpWrapper(),
        ),
  ];

  final List<String> contexts = ['ReownAppKit'];

  for (int i = 0; i < walletCreators.length; i++) {
    runTests(
      context: contexts[i],
      appKitCreator: appCreators[i],
      walletKitCreator: walletCreators[i],
    );
  }
}

void runTests({
  required String context,
  required Future<IReownAppKit> Function(PairingMetadata) appKitCreator,
  required Future<IReownWalletKit> Function(PairingMetadata) walletKitCreator,
}) {
  group(context, () {
    late IReownAppKit clientA;
    late IReownWalletKit clientB;

    setUp(() async {
      clientA = await appKitCreator(
        const PairingMetadata(
          name: 'App A (Proposer, dapp)',
          description: 'Description of Proposer App run by client A',
          url: 'https://reown.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
      clientB = await walletKitCreator(
        const PairingMetadata(
          name: 'App B (Responder, Wallet)',
          description: 'Description of Proposer App run by client B',
          url: 'https://reown.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
    });

    tearDown(() async {
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    group('happy path', () {
      test('connects, reconnects, and emits proper events', () async {
        Completer completer = Completer();
        Completer completerBSign = Completer();
        // Completer completerBAuth = Completer();
        int counterA = 0;
        int counterBSign = 0;
        // int counterBAuth = 0;
        clientA.onSessionConnect.subscribe((args) {
          counterA++;
          completer.complete();
        });
        clientB.onSessionProposal.subscribe((args) {
          counterBSign++;
          completerBSign.complete();
        });
        // clientB.onAuthRequest.subscribe((args) {
        //   counterBAuth++;
        //   completerBAuth.complete();
        // });

        final connectionInfo = await ReownWalletKitHelpers.testWalletKit(
          clientA,
          clientB,
          qrCodeScanLatencyMs: 1000,
        );

        // print('swag 1');
        await completer.future;
        // print('swag 2');
        await completerBSign.future;
        // print('swag 3');
        // await completerBAuth.future;

        expect(counterA, 1);
        expect(counterBSign, 1);
        // expect(counterBAuth, 1);

        expect(
          clientA.pairings.getAll().length,
          clientB.pairings.getAll().length,
        );
        expect(
          clientA.getActiveSessions().length,
          1,
        );
        expect(
          clientA.getActiveSessions().length,
          clientB.getActiveSessions().length,
        );

        completer = Completer();
        completerBSign = Completer();
        // completerBAuth = Completer();

        final _ = await ReownWalletKitHelpers.testWalletKit(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
        );

        // print('swag 4');
        await completer.future;
        // print('swag 5');
        await completerBSign.future;
        // print('swag 6');
        // await completerBAuth.future;

        expect(counterA, 2);
        expect(counterBSign, 2);
        // expect(counterBAuth, 2);

        clientA.onSessionConnect.unsubscribeAll();
        clientB.onSessionProposal.unsubscribeAll();
      });

      test('connects, and reconnects with scan latency', () async {
        final connectionInfo = await ReownWalletKitHelpers.testWalletKit(
          clientA,
          clientB,
          qrCodeScanLatencyMs: 1000,
        );
        expect(
          clientA.pairings.getAll().length,
          clientB.pairings.getAll().length,
        );
        final _ = await ReownWalletKitHelpers.testWalletKit(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
          qrCodeScanLatencyMs: 1000,
        );
      });
    });
  });
}
