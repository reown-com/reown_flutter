import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('compute polkadot tx hash', () {
    test('derive hash from unsigned payload', () {
// senderWallet: 15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM
// receiverWallet: 15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H
// payloadToSign: {"method":[5,3,0,192,125,33,29,60,24,29,247,104,217,217,212,29,246,241,79,157,17,109,156,25,6,243,129,83,178,8,37,156,49,91,75,2,40,107,238],"specVersion":"c9550f00","transactionVersion":"1a000000","genesisHash":"91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3","blockHash":"d53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b","era":"e500","nonce":"18","tip":"00","mode":"00","metadataHash":"00"}
// Payload hex: 050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286beee500180000c9550f001a00000091b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3d53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b00
// Signature hex: 7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d
// srExtrinsic Hex: 3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808de500180000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee
// utilExtrinsic Hex: 3d0284be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d029403006000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee
// Sr25519 extrinsic hash: d0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f

      final method = [
        5,
        3,
        0,
        192,
        125,
        33,
        29,
        60,
        24,
        29,
        247,
        104,
        217,
        217,
        212,
        29,
        246,
        241,
        79,
        157,
        17,
        109,
        156,
        25,
        6,
        243,
        129,
        83,
        178,
        8,
        37,
        156,
        49,
        91,
        75,
        2,
        40,
        107,
        238
      ];
      final payloadToSign = {
        'specVersion': 'c9550f00',
        'transactionVersion': '1a000000',
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'genesisHash':
            '91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3',
        'blockHash':
            'd53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b',
        'era': 'e500',
        'method': hex.encode(method),
        'nonce': '18',
        'tip': '00',
        'mode': '00',
        'metadataHash': '00',
        'version': 4,
      };

      final jsonRPCResponse = {
        'id': 1,
        'jsonrpc': '2.0',
        'result': {
          'id': 123456789,
          'signature':
              '7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d'
        },
      };

      const expectedSignedExtrinsicHex =
          '3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808de500180000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee';

      const expectedHash =
          'd0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f';

      //
      final expectedDerivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        expectedSignedExtrinsicHex,
      );
      print('expected 1');
      // by succeeding this, it means that deriveExtrinsicHash() is correct
      expect(expectedDerivedHash, expectedHash);

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final signature = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      print('expected 2');
      expect(
        signature,
        '7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d',
      );

      final address = ReownCoreUtils.recursiveSearchForMapKey(
        payloadToSign,
        'address',
      );
      print('expected 3');
      expect(address, '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM');
      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(address);
      final utilsExtrinsicBytes = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: signature,
        payload: payloadToSign,
      );

      final utilsSignedExtrinsicHex = hex.encode(utilsExtrinsicBytes);
      print('expected 4');
      expect(utilsSignedExtrinsicHex, expectedSignedExtrinsicHex);

      final utilsDerivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        utilsSignedExtrinsicHex,
      );
      print('expected 5');
      expect(utilsDerivedHash, expectedHash);
    });
  });
}
