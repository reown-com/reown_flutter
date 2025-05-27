// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_sign/reown_sign.dart';

import '../shared/shared_test_values.dart';
import '../utils/sign_client_constants.dart';
import 'sign_client_helpers.dart';

void signTVFCollection({
  required Future<IReownSignDapp> Function(PairingMetadata) dappClientCreator,
  required Future<IReownSignWallet> Function(PairingMetadata)
      walletClientCreator,
}) {
  group('tvf collection', () {
    late IReownSignDapp dappClient;
    late IReownSignWallet walletClient;

    setUp(() async {
      dappClient = await dappClientCreator(PROPOSER);
      walletClient = await walletClientCreator(RESPONDER);
    });

    tearDown(() async {
      await dappClient.core.relayClient.disconnect();
      await walletClient.core.relayClient.disconnect();
    });

    test('register a request handler and receive method calls with it',
        () async {
      final connectionInfo = await SignClientHelpers.testConnectPairApprove(
        dappClient,
        walletClient,
      );
      final sessionTopic = connectionInfo.session.topic;

      expect(walletClient.getPendingSessionRequests().length, 0);

      // Valid handler
      ethSignTransactionHandler(
        String topic,
        dynamic request,
      ) async {
        expect(topic, sessionTopic);
        // expect(request, TEST_MESSAGE_1);
        // print(walletClient.getPendingSessionRequests());
        expect(walletClient.getPendingSessionRequests().length, 1);
        final pRequest = walletClient.pendingRequests.getAll().last;
        return await walletClient.respondSessionRequest(
          topic: sessionTopic,
          response: JsonRpcResponse(
            id: pRequest.id,
            result: request,
          ),
        );
      }

      walletClient.registerRequestHandler(
        chainId: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
        method: 'solana_signTransaction',
        handler: ethSignTransactionHandler,
      );

      Completer walletClientReady = Completer();
      walletClient.pendingRequests.onSync.subscribe((args) {
        if (walletClient.getPendingSessionRequests().isEmpty &&
            !walletClientReady.isCompleted) {
          walletClientReady.complete();
        }
      });

      try {
        dappClient.core.logger.i('Request handler 1');
        final Map<String, dynamic> response = await dappClient.request(
          topic: connectionInfo.session.topic,
          chainId: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
          request: const SessionRequestParams(
            method: 'solana_signTransaction',
            params: {
              'feePayer': 'AqP3MyNwDP4L1GJKYhzmaAUdrjzpqJUZjahM7kHpgavm',
              'instructions': [
                {
                  'programId': 'Vote111111111111111111111111111111111111111',
                  'data':
                      '37u9WtQpcm6ULa3VtWDFAWoQc1hUvybPrA3dtx99tgHvvcE7pKRZjuGmn7VX2tC3JmYDYGG7',
                  'keys': [
                    {
                      'isSigner': true,
                      'isWritable': true,
                      'pubkey': 'AqP3MyNwDP4L1GJKYhzmaAUdrjzpqJUZjahM7kHpgavm'
                    }
                  ]
                }
              ],
              'recentBlockhash': '2bUz6wu3axM8cDDncLB5chWuZaoscSjnoMD2nVvC1swe',
              'signatures': [
                {
                  'pubkey': 'AqP3MyNwDP4L1GJKYhzmaAUdrjzpqJUZjahM7kHpgavm',
                  'signature':
                      '2Lb1KQHWfbV3pWMqXZveFWqneSyhH95YsgCENRWnArSkLydjN1M42oB82zSd6BBdGkM9pE6sQLQf1gyBh8KWM2c4'
                }
              ],
              'transaction': 'r32f2..FD33r'
            },
          ),
        );

        expect(response, TEST_MESSAGE_1);

        dappClient.core.logger
            .i('Request handler 1, waiting for walletClientReady');
        if (walletClientReady.isCompleted) {
          walletClientReady = Completer();
        } else {
          await walletClientReady.future;
          walletClientReady = Completer();
        }

        // // print('swag 3');
        // dappClient.core.logger.i('Request handler 2');
        // final String response2 = await dappClient.request(
        //   topic: connectionInfo.session.topic,
        //   chainId: TEST_ETHEREUM_CHAIN,
        //   request: const SessionRequestParams(
        //     method: TEST_METHOD_1,
        //     params: TEST_MESSAGE_2,
        //   ),
        // );

        // expect(response2, TEST_MESSAGE_2);

        // dappClient.core.logger
        //     .i('Request handler 2, waiting for walletClientReady');
        // if (!walletClientReady.isCompleted) {
        //   await walletClientReady.future;
        // }

        walletClient.sessions.onSync.unsubscribeAll();
      } on JsonRpcError catch (e) {
        print(e);
        expect(false, true);
      }
    });
  });
}
