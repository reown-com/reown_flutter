import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/i_sign_common.dart';
import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_sign/reown_sign.dart';

import '../shared/engine_constants.dart';
import '../shared/shared_test_values.dart';
import '../utils/engine_constants.dart';

void signApproveSessionAuthenticate({
  required Future<IReownSignDapp> Function(PairingMetadata) clientACreator,
  required Future<IReownSignWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('approveSessionAuthenticate', () {
    late IReownSignDapp clientA;
    late IReownSignWallet clientB;
    List<IReownSignCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(
        PROPOSER.copyWith(
          redirect: Redirect(
            native: 'clientA://',
            universal: 'https://lab.web3modal.com/dapp',
            linkMode: true,
          ),
        ),
      );
      clientB = await clientBCreator(
        RESPONDER.copyWith(
          redirect: Redirect(
            native: 'clientB://',
            universal: 'https://lab.web3modal.com/wallet',
            linkMode: true,
          ),
        ),
      );
      await clientA.core.addLinkModeSupportedApp(
        'https://lab.web3modal.com/wallet',
      );
      await clientB.core.addLinkModeSupportedApp(
        'https://lab.web3modal.com/dapp',
      );
      clients.add(clientA);
      clients.add(clientB);

      await clientB.sessionAuthRequests.set(
        TEST_PROPOSAL_VALID_ID.toString(),
        PendingSessionAuthRequest(
          id: TEST_PROPOSAL_VALID_ID,
          pairingTopic: TEST_PAIRING_TOPIC,
          requester: TEST_CONNECTION_METADATA_REQUESTER.copyWith(
            publicKey: TEST_KEY_PAIRS['A']!.publicKey,
          ),
          authPayload: CacaoRequestPayload.fromCacaoPayload(testCacaoPayload),
          expiryTimestamp: 1000000000000,
          verifyContext: VerifyContext(
            origin: 'test.com',
            validation: Validation.VALID,
            verifyUrl: ReownConstants.VERIFY_SERVER,
          ),
          transportType: TransportType.linkMode,
        ),
      );
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });
  });
}
