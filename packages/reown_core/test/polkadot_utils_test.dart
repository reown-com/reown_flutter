import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('compute polkadot tx hash', () {
    test('derive hash from unsigned payload after transfer_keep_alive', () {
      // senderWallet: 15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM
      // receiverWallet: 15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H
      // payloadToSign: {"method":[5,3,0,192,125,33,29,60,24,29,247,104,217,217,212,29,246,241,79,157,17,109,156,25,6,243,129,83,178,8,37,156,49,91,75,2,40,107,238],"specVersion":"c9550f00","transactionVersion":"1a000000","genesisHash":"91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3","blockHash":"d53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b","era":"e500","nonce":"18","tip":"00","mode":"00","metadataHash":"00"}
      // Payload hex: 050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286beee500180000c9550f001a00000091b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3d53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b00
      // Signature hex: 7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d
      // srExtrinsic Hex: 3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808de500180000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee
      // utilExtrinsic Hex: 3d0284be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d029403006000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee
      // extrinsic hash: d0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f

      // Request params

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

      final transactionPayload = {
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

      final requestParams = {
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'transactionPayload': transactionPayload,
      };

      // Wallet response

      final jsonRPCResponse = {
        'id': 1,
        'jsonrpc': '2.0',
        'result': {
          'id': 123456789,
          'signature':
              '7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d'
        },
      };

      // Expected values

      const expectedSignedExtrinsicHex =
          '3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808de500180000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee';

      // https://polkadot.subscan.io/extrinsic/0xd0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f
      const expectedHash =
          'd0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f';

      //
      final expectedDerivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        expectedSignedExtrinsicHex,
      );
      // by succeeding this, it means that deriveExtrinsicHash() is correct
      expect(expectedDerivedHash, expectedHash);

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final signature = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signature,
        '7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d',
      );

      final payload = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'transactionPayload',
      );
      final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'address',
      );
      expect(ss58Address, '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM');
      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );
      final extrinsic = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: signature,
        payload: payload,
      );
      final signedExtrinsic = hex.encode(extrinsic);
      expect(signedExtrinsic, expectedSignedExtrinsicHex);

      final hash = PolkadotChainUtils.deriveExtrinsicHash(signedExtrinsic);
      expect(hash, expectedHash);
    });

    test('derive hash from unsigned payload after transferAll', () {
      // Request params

      final method = [
        5,
        4,
        0,
        190,
        10,
        159,
        25,
        254,
        99,
        107,
        75,
        26,
        46,
        250,
        235,
        117,
        234,
        169,
        120,
        207,
        243,
        137,
        96,
        201,
        253,
        160,
        245,
        50,
        254,
        73,
        97,
        184,
        133,
        203,
        99,
        1
      ];

      final transactionPayload = {
        'method': hex.encode(method),
        'specVersion': 'c9550f00',
        'transactionVersion': '1a000000',
        'genesisHash':
            '91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3',
        'blockHash':
            '9ad1b3c4356032ac8b1a203794f12c2bdf2d29048cb8bf8a68af8b8b02cf5087',
        'era': '8502',
        'nonce': '00',
        'tip': '00',
        'mode': '00',
        'metadataHash': '00',
        'address': '15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H',
        'version': 4,
      };

      final requestParams = {
        'address': '15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H',
        'transactionPayload': transactionPayload,
      };

      // Wallet response

      final jsonRPCResponse = {
        'id': 1,
        'jsonrpc': '2.0',
        'result': {
          'id': 123456789,
          'signature':
              'e8831aa739643d5eae42ee2c4cf5d9aea46cc67cf32230b177154e683b360e28b5cbf71919a286fb67f3c0cf6a22fff6c8b33cb0e5ad6e3b2f85dc09a426c289'
        },
      };

      // Expected values

      const expectedSignedExtrinsicHex =
          '31028400c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b01e8831aa739643d5eae42ee2c4cf5d9aea46cc67cf32230b177154e683b360e28b5cbf71919a286fb67f3c0cf6a22fff6c8b33cb0e5ad6e3b2f85dc09a426c2898502000000050400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb6301';

      // https://polkadot.subscan.io/extrinsic/0xb70583e87e95e8ede02b19801843e7ecf759000f27147f8e17310ea4987ee6c7
      const expectedHash =
          'b70583e87e95e8ede02b19801843e7ecf759000f27147f8e17310ea4987ee6c7';

      //
      final expectedDerivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        expectedSignedExtrinsicHex,
      );
      // by succeeding this, it means that deriveExtrinsicHash() is correct
      expect(expectedDerivedHash, expectedHash);

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final signature = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signature,
        'e8831aa739643d5eae42ee2c4cf5d9aea46cc67cf32230b177154e683b360e28b5cbf71919a286fb67f3c0cf6a22fff6c8b33cb0e5ad6e3b2f85dc09a426c289',
      );

      final payload = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'transactionPayload',
      );
      final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'address',
      );
      expect(ss58Address, '15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H');
      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );
      final extrinsic = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: signature,
        payload: payload,
      );
      final signedExtrinsic = hex.encode(extrinsic);
      expect(signedExtrinsic, expectedSignedExtrinsicHex);

      final hash = PolkadotChainUtils.deriveExtrinsicHash(signedExtrinsic);
      expect(hash, expectedHash);
    });

    test(
        'derive hash from unsigned payload after transfer with signed extensions',
        () {
// [+7013 ms] flutter: [PolkadotTest] senderWallet: 15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM
// [  +66 ms] flutter: [PolkadotTest] receiverWallet: 15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H
// [+2070 ms] flutter: [PolkadotTest] payloadToSign: {"method":[5,3,0,192,125,33,29,60,24,29,247,104,217,217,212,29,246,241,79,157,17,109,156,25,6,243,129,83,178,8,37,156,49,91,75,2,40,107,238],"specVersion":"c9550f00","transactionVersion":"1a000000","genesisHash":"91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3","blockHash":"130d8c27af0e0adfa85d370af89746f229780b677c81da97d11a4921cdb86df5","era":"1502","nonce":"1c","tip":"00","mode":"00","metadataHash":"00"}
// [   +3 ms] flutter: [PolkadotTest] Payload hex: 050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee15021c0000c9550f001a00000091b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3130d8c27af0e0adfa85d370af89746f229780b677c81da97d11a4921cdb86df500
// [  +79 ms] flutter: [PolkadotTest] Signature hex: 362cef5dff66aee851a5d8c5100a53590eddd7c75c1a53553b08861fb28ce80b96d53279f52a27c866639954c5efa32b52c148fefe78dbdad1f9d3be4f44538f
// [        ] flutter: [PolkadotTest] srExtrinsic Hex: 3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb6301362cef5dff66aee851a5d8c5100a53590eddd7c75c1a53553b08861fb28ce80b96d53279f52a27c866639954c5efa32b52c148fefe78dbdad1f9d3be4f44538f15021c0000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee
// [        ] flutter: [PolkadotTest] utilExtrinsic Hex: 3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb6301362cef5dff66aee851a5d8c5100a53590eddd7c75c1a53553b08861fb28ce80b96d53279f52a27c866639954c5efa32b52c148fefe78dbdad1f9d3be4f44538f15021c0000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee
// [        ] flutter: [PolkadotTest] true
// [  +42 ms] flutter: [PolkadotTest] Sr25519 extrinsic hash: 48016b3c80b7b61d32d1db6f52038de70d7d30ef948da047442cc9c952b92e84

      // Request params

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

      final transactionPayload = {
        'method': hex.encode(method),
        'specVersion': 'c9550f00',
        'transactionVersion': '1a000000',
        'genesisHash':
            '91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3',
        'blockHash':
            '130d8c27af0e0adfa85d370af89746f229780b677c81da97d11a4921cdb86df5',
        'era': '1502',
        'nonce': '1c',
        'tip': '00',
        'mode': '00',
        'metadataHash': '00',
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'version': 4,
      };

      final requestParams = {
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'transactionPayload': transactionPayload,
      };

      // Wallet response

      final jsonRPCResponse = {
        'id': 1,
        'jsonrpc': '2.0',
        'result': {
          'id': 123456789,
          'signature':
              '362cef5dff66aee851a5d8c5100a53590eddd7c75c1a53553b08861fb28ce80b96d53279f52a27c866639954c5efa32b52c148fefe78dbdad1f9d3be4f44538f'
        },
      };

      // Expected values

      const expectedSignedExtrinsicHex =
          '3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb6301362cef5dff66aee851a5d8c5100a53590eddd7c75c1a53553b08861fb28ce80b96d53279f52a27c866639954c5efa32b52c148fefe78dbdad1f9d3be4f44538f15021c0000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee';

      // https://polkadot.subscan.io/extrinsic/0xb70583e87e95e8ede02b19801843e7ecf759000f27147f8e17310ea4987ee6c7
      const expectedHash =
          '48016b3c80b7b61d32d1db6f52038de70d7d30ef948da047442cc9c952b92e84';

      //
      final expectedDerivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        expectedSignedExtrinsicHex,
      );
      // by succeeding this, it means that deriveExtrinsicHash() is correct
      expect(expectedDerivedHash, expectedHash);

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final signature = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signature,
        '362cef5dff66aee851a5d8c5100a53590eddd7c75c1a53553b08861fb28ce80b96d53279f52a27c866639954c5efa32b52c148fefe78dbdad1f9d3be4f44538f',
      );

      final payload = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'transactionPayload',
      );
      final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'address',
      );
      expect(ss58Address, '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM');
      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );
      final extrinsic = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: signature,
        payload: payload,
      );
      final signedExtrinsic = hex.encode(extrinsic);
      expect(signedExtrinsic, expectedSignedExtrinsicHex);

      final hash = PolkadotChainUtils.deriveExtrinsicHash(signedExtrinsic);
      expect(hash, expectedHash);
    });
  });
}
