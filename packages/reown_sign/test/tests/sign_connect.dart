import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/i_sign_common.dart';
import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_sign/reown_sign.dart';

import '../shared/shared_test_values.dart';
import '../utils/engine_constants.dart';
import '../utils/sign_client_constants.dart';

void signConnect({
  required Future<IReownSignDapp> Function(PairingMetadata) clientACreator,
  required Future<IReownSignWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('happy path', () {
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

    test('Initializes', () async {
      expect(clientA.core.pairing.getPairings().length, 0);
      expect(clientB.core.pairing.getPairings().length, 0);
    });

    test('creates correct URI', () async {
      ConnectResponse response = await clientA.connect(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
      );

      expect(response.uri != null, true);
      URIParseResult parsed = ReownCoreUtils.parseUri(response.uri!);
      expect(parsed.protocol, 'wc');
      expect(parsed.version, URIVersion.v2);
      expect(parsed.topic, response.pairingTopic);
      expect(parsed.v2Data!.relay.protocol, 'irn');
      expect(parsed.v2Data!.methods.length, 2);
      expect(parsed.v2Data!.methods[0], MethodConstants.WC_SESSION_PROPOSE);
      expect(parsed.v2Data!.methods[1], MethodConstants.WC_SESSION_REQUEST);

      response = await clientA.connect(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        methods: [],
      );

      expect(response.uri != null, true);
      parsed = ReownCoreUtils.parseUri(response.uri!);
      expect(parsed.protocol, 'wc');
      expect(parsed.version, URIVersion.v2);
      expect(parsed.v2Data!.relay.protocol, 'irn');
      expect(parsed.v2Data!.methods.length, 0);
    });

    test('invalid topic', () {
      expect(
        () async => await clientA.connect(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
          pairingTopic: TEST_TOPIC_INVALID,
        ),
        throwsA(
          isA<ReownSignError>().having(
            (e) => e.message,
            'message',
            'No matching key. pairing topic doesn\'t exist: abc',
          ),
        ),
      );
    });

    test('invalid required and optional namespaces', () {
      expect(
        () async => await clientA.connect(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
        ),
        throwsA(
          isA<ReownSignError>().having(
            (e) => e.message,
            'message',
            'Unsupported chains. connect() check requiredNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
          ),
        ),
      );
      expect(
        () async => await clientA.connect(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
          optionalNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
        ),
        throwsA(
          isA<ReownSignError>().having(
            (e) => e.message,
            'message',
            'Unsupported chains. connect() check optionalNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
          ),
        ),
      );
    });
  });
}
