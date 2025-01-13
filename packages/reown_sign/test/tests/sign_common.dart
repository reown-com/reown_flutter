// ignore: library_annotations
@Timeout(Duration(seconds: 45))

import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/i_sign_common.dart';
import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_sign/models/basic_models.dart';

import '../shared/shared_test_values.dart';
import 'sign_approve_session.dart';
import '../utils/sign_client_constants.dart';
import 'sign_approve_session_authenticate.dart';
import 'sign_authenticate.dart';
import 'sign_connect.dart';
import 'sign_disconnect.dart';
import 'sign_emit_session_event.dart';
import 'sign_expiration.dart';
import 'sign_extend_session.dart';
import 'sign_happy_path.dart';
import 'sign_pair.dart';
import 'sign_ping.dart';
import 'sign_reject_session.dart';
import 'sign_request_and_handler.dart';
import 'sign_update_session.dart';

void signEngineTests({
  required String context,
  required Future<IReownSignDapp> Function(PairingMetadata) clientACreator,
  required Future<IReownSignWallet> Function(PairingMetadata) clientBCreator,
}) {
  group(context, () {
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

    signExpiration(
      clientACreator: clientACreator,
    );

    signHappyPath(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signConnect(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signAuthenticate(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signPair(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signApproveSession(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signApproveSessionAuthenticate(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signRejectSession(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signUpdateSession(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signExtendSession(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signRequestAndHandler(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signEmitSessionEvent(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signPing(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    signDisconnect(
      clientACreator: clientACreator,
      clientBCreator: clientBCreator,
    );

    group('find', () {
      test('works', () async {
        await clientB.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );

        final sessionData = clientB.find(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        );
        expect(sessionData != null, true);
        expect(sessionData!.topic, TEST_SESSION_VALID_TOPIC);

        final sessionData2 = clientB.find(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
        );
        expect(sessionData2, null);
      });
    });

    group('pairings', () {
      test('works', () async {
        expect(clientA.pairings, clientA.core.pairing.getStore());
        expect(clientB.pairings, clientB.core.pairing.getStore());
      });
    });

    group('registerEventEmitter', () {
      test('fails properly', () {
        expect(
          () => clientB.registerEventEmitter(
            chainId: TEST_CHAIN_INVALID_1,
            event: TEST_EVENT_1,
          ),
          throwsA(
            isA<ReownSignError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. registerEventEmitter, chain $TEST_CHAIN_INVALID_1 should conform to "CAIP-2" format',
            ),
          ),
        );

        expect(
          () => clientB.registerEventEmitter(
            chainId: TEST_ETHEREUM_CHAIN,
            event: TEST_ACCOUNT_INVALID_2,
          ),
          throwsA(
            isA<ReownSignError>().having(
              (e) => e.message,
              'message',
              'Unsupported accounts. registerEventEmitter, account $TEST_ETHEREUM_CHAIN:$TEST_ACCOUNT_INVALID_2 should conform to "namespace:chainId:address" format',
            ),
          ),
        );
      });
    });

    group('registerAccounts', () {
      test('fails properly', () {
        expect(
          () => clientB.registerAccount(
            chainId: TEST_CHAIN_INVALID_1,
            accountAddress: TEST_ETHEREUM_ACCOUNT,
          ),
          throwsA(
            isA<ReownSignError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. registerAccount, chain $TEST_CHAIN_INVALID_1 should conform to "CAIP-2" format',
            ),
          ),
        );

        expect(
          () => clientB.registerAccount(
            chainId: TEST_ETHEREUM_CHAIN,
            accountAddress: TEST_ACCOUNT_INVALID_2,
          ),
          throwsA(
            isA<ReownSignError>().having(
              (e) => e.message,
              'message',
              'Unsupported accounts. registerAccount, account $TEST_ETHEREUM_CHAIN:$TEST_ACCOUNT_INVALID_2 should conform to "namespace:chainId:address" format',
            ),
          ),
        );
      });
    });
  });
}
