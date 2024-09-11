import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/i_sign_common.dart';
import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_sign/models/basic_models.dart';

import '../shared/shared_test_values.dart';

void signPair({
  required Future<IReownSignDapp> Function(PairingMetadata) clientACreator,
  required Future<IReownSignWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('pair', () {
    late IReownSignDapp clientA;
    late IReownSignWallet clientB;
    List<IReownSignCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
      clientB = await clientBCreator(RESPONDER);
      clients.add(clientA);
      clients.add(clientB);
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    test('throws with v1 url', () {
      const String uri = TEST_URI_V1;

      expect(
        () async => await clientB.pair(uri: Uri.parse(uri)),
        throwsA(
          isA<ReownSignError>().having(
            (e) => e.message,
            'message',
            'Missing or invalid. URI is not WalletConnect version 2 URI',
          ),
        ),
      );
    });

    test('throws with invalid methods', () {
      const String uriWithMethods = '$TEST_URI&methods=[wc_swag]';

      expect(
        () async => await clientB.pair(uri: Uri.parse(uriWithMethods)),
        throwsA(
          isA<ReownSignError>().having(
            (e) => e.message,
            'message',
            'Unsupported wc_ method. The following methods are not registered: wc_swag.',
          ),
        ),
      );
    });
  });
}
