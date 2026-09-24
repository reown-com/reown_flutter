import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/reown_sign.dart';

import '../shared/engine_constants.dart';
import '../shared/shared_test_utils.dart';
import '../shared/shared_test_values.dart';
import '../shared/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  final lowercaseAddress = TEST_ADDRESS_EIP191.toLowerCase();
  final lowercaseIssuer = 'did:pkh:$TEST_ETHEREUM_CHAIN:$lowercaseAddress';

  String sign(String message) {
    final signature = EthPrivateKey.fromHex(
      TEST_PRIVATE_KEY_EIP191,
    ).signPersonalMessageToUint8List(Uint8List.fromList(message.codeUnits));
    return '0x${hex.encode(signature)}';
  }

  Cacao cacaoFor({required String issuer, required String signature}) {
    return Cacao(
      h: const CacaoHeader(t: CacaoHeader.CAIP122),
      p: CacaoPayload.fromRequestPayload(
        issuer: issuer,
        payload: testCacaoRequestPayload,
      ),
      s: CacaoSignature(t: CacaoSignature.EIP191, s: signature),
    );
  }

  late ReownSignClient client;

  setUp(() {
    // formatAuthMessage / validateSignedCacao are pure: no init() or relay.
    client = ReownSignClient(
      core: ReownCore(projectId: TEST_PROJECT_ID, memoryStore: true),
      metadata: const PairingMetadata(
        name: 'test',
        description: 'test',
        url: 'https://reown.com',
        icons: [],
      ),
    );
  });

  group('SIWE message EIP-55', () {
    test('formatAuthMessage checksums a lowercase issuer address', () {
      final message = client.formatAuthMessage(
        iss: lowercaseIssuer,
        cacaoPayload: testCacaoRequestPayload,
      );

      expect(message, TEST_FORMATTED_MESSAGE);
    });

    test('formatAuthMessage keeps a checksummed issuer unchanged', () {
      final message = client.formatAuthMessage(
        iss: TEST_ISSUER_EIP191,
        cacaoPayload: testCacaoRequestPayload,
      );

      expect(message, TEST_FORMATTED_MESSAGE);
    });

    test('buildAuthObject checksums the issuer', () {
      final cacao = AuthSignature.buildAuthObject(
        requestPayload: testCacaoRequestPayload,
        signature: TEST_CACAO_SIGNATURE,
        iss: lowercaseIssuer,
      );

      expect(cacao.p.iss, TEST_ISSUER_EIP191);
    });

    test('validateSignedCacao accepts a canonical signature', () async {
      final message = client.formatAuthMessage(
        iss: lowercaseIssuer,
        cacaoPayload: testCacaoRequestPayload,
      );
      final cacao = AuthSignature.buildAuthObject(
        requestPayload: testCacaoRequestPayload,
        signature: CacaoSignature(t: CacaoSignature.EIP191, s: sign(message)),
        iss: lowercaseIssuer,
      );

      expect(
        await client.validateSignedCacao(
          cacao: cacao,
          projectId: TEST_PROJECT_ID,
        ),
        true,
      );
    });

    test('validateSignedCacao accepts a legacy lowercase signature', () async {
      // Older SDKs signed the SIWE message with the address as received.
      final legacyMessage = TEST_FORMATTED_MESSAGE.replaceAll(
        TEST_ADDRESS_EIP191,
        lowercaseAddress,
      );
      final cacao = cacaoFor(
        issuer: lowercaseIssuer,
        signature: sign(legacyMessage),
      );

      expect(
        await client.validateSignedCacao(
          cacao: cacao,
          projectId: TEST_PROJECT_ID,
        ),
        true,
      );
    });

    test('validateSignedCacao accepts a real-world lowercase CACAO', () async {
      final cacao = Cacao.fromJson(
        Map<String, dynamic>.from(TEST_VALID_EIP191_SIGNATURE['cacao'] as Map),
      );

      expect(
        await client.validateSignedCacao(
          cacao: cacao,
          projectId: TEST_PROJECT_ID,
        ),
        true,
      );
    });

    test('validateSignedCacao rejects an invalid signature', () async {
      final cacao = cacaoFor(
        issuer: lowercaseIssuer,
        signature: TEST_SIGNATURE_FAIL,
      );

      expect(
        await client.validateSignedCacao(
          cacao: cacao,
          projectId: TEST_PROJECT_ID,
        ),
        false,
      );
    });
  });
}
