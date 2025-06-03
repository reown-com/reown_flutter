import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('compute polkadot tx hash', () {
    test('derive hash from unsigned payload after transfer_keep_alive', () {
      // Request params

      final transactionPayload = {
        'specVersion': 'c9550f00',
        'transactionVersion': '1a000000',
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'genesisHash':
            '91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3',
        'blockHash':
            'd53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b',
        'era': 'e500',
        'method':
            '050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee',
        'nonce': '18',
        'tip': '00',
        'mode': '00',
        'metadataHash': '00',
        'version': 4
      };

      final requestParams = {
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'transactionPayload': transactionPayload,
      };

      debugPrint(jsonEncode(requestParams));

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

      debugPrint(jsonEncode(jsonRPCResponse));

      // Expected values

      const realSignedExtrinsicHex =
          '3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808de500180000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee';

      // https://polkadot.subscan.io/extrinsic/0xd0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f
      const realTxHash =
          'd0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f';

      //
      final txHashFromUtils = PolkadotChainUtils.deriveExtrinsicHash(
        realSignedExtrinsicHex,
      );
      // by succeeding this, it means that deriveExtrinsicHash() is correct
      expect(txHashFromUtils, realTxHash);

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final signatureFromResponse = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signatureFromResponse,
        '7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d',
      );

      final originalTxPayload = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'transactionPayload',
      );
      final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'address',
      );
      final senderPublicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );
      final signedExtrinsicUtils = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(senderPublicKey),
        hexSignature: signatureFromResponse,
        payload: originalTxPayload,
      );
      final signedExtrinsicUtilsHex = hex.encode(signedExtrinsicUtils);
      expect(signedExtrinsicUtilsHex, realSignedExtrinsicHex);

      final derivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        signedExtrinsicUtilsHex,
      );
      expect(derivedHash, realTxHash);
    });

    test('derive hash from unsigned payload after transferAll', () {
      // Request params

      final transactionPayload = {
        'method':
            '050400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb6301',
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
        'version': 4
      };

      final requestParams = {
        'address': '15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H',
        'transactionPayload': transactionPayload,
      };

      debugPrint(jsonEncode(requestParams));

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

      debugPrint(jsonEncode(jsonRPCResponse));

      // Expected values

      const realSignedExtrinsicHex =
          '31028400c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b01e8831aa739643d5eae42ee2c4cf5d9aea46cc67cf32230b177154e683b360e28b5cbf71919a286fb67f3c0cf6a22fff6c8b33cb0e5ad6e3b2f85dc09a426c2898502000000050400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb6301';

      // https://polkadot.subscan.io/extrinsic/0xb70583e87e95e8ede02b19801843e7ecf759000f27147f8e17310ea4987ee6c7
      const realTxHash =
          'b70583e87e95e8ede02b19801843e7ecf759000f27147f8e17310ea4987ee6c7';

      //
      final txHashFromUtils = PolkadotChainUtils.deriveExtrinsicHash(
        realSignedExtrinsicHex,
      );
      // by succeeding this, it means that deriveExtrinsicHash() is correct
      expect(txHashFromUtils, realTxHash);

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final signatureFromResponse = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signatureFromResponse,
        'e8831aa739643d5eae42ee2c4cf5d9aea46cc67cf32230b177154e683b360e28b5cbf71919a286fb67f3c0cf6a22fff6c8b33cb0e5ad6e3b2f85dc09a426c289',
      );

      final originalTxPayload = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'transactionPayload',
      );
      final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'address',
      );
      final senderPublicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );
      final signedExtrinsicUtils = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(senderPublicKey),
        hexSignature: signatureFromResponse,
        payload: originalTxPayload,
      );
      final signedExtrinsicUtilsHex = hex.encode(signedExtrinsicUtils);
      expect(signedExtrinsicUtilsHex, realSignedExtrinsicHex);

      final derivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        signedExtrinsicUtilsHex,
      );
      expect(derivedHash, realTxHash);
    });

    test(
        'derive hash from unsigned payload after transfer with signed extensions',
        () {
      // Request params

      final transactionPayload = {
        'method':
            '050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee',
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
        'version': 4
      };

      final requestParams = {
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'transactionPayload': transactionPayload,
      };

      debugPrint(jsonEncode(requestParams));

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

      debugPrint(jsonEncode(jsonRPCResponse));

      // Expected values

      const realSignedExtrinsicHex =
          '3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb6301362cef5dff66aee851a5d8c5100a53590eddd7c75c1a53553b08861fb28ce80b96d53279f52a27c866639954c5efa32b52c148fefe78dbdad1f9d3be4f44538f15021c0000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee';

      // https://polkadot.subscan.io/extrinsic/0xb70583e87e95e8ede02b19801843e7ecf759000f27147f8e17310ea4987ee6c7
      const realTxHash =
          '48016b3c80b7b61d32d1db6f52038de70d7d30ef948da047442cc9c952b92e84';

      //
      final txHashFromUtils = PolkadotChainUtils.deriveExtrinsicHash(
        realSignedExtrinsicHex,
      );
      // by succeeding this, it means that deriveExtrinsicHash() is correct
      expect(txHashFromUtils, realTxHash);

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final signatureFromResponse = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signatureFromResponse,
        '362cef5dff66aee851a5d8c5100a53590eddd7c75c1a53553b08861fb28ce80b96d53279f52a27c866639954c5efa32b52c148fefe78dbdad1f9d3be4f44538f',
      );

      final originalTxPayload = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'transactionPayload',
      );
      final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'address',
      );
      final senderPublicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );
      final signedExtrinsicUtils = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(senderPublicKey),
        hexSignature: signatureFromResponse,
        payload: originalTxPayload,
      );
      final signedExtrinsicUtilsHex = hex.encode(signedExtrinsicUtils);
      expect(signedExtrinsicUtilsHex, realSignedExtrinsicHex);

      final derivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        signedExtrinsicUtilsHex,
      );
      expect(derivedHash, realTxHash);
    });

    test(
        'derive hash from unsigned payload after transfer with signed extensions',
        () {
      final transactionPayload = {
        'method':
            '050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee',
        'specVersion': 'c9550f00',
        'transactionVersion': '1a000000',
        'genesisHash':
            '91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3',
        'blockHash':
            '988f712f8268d73ee8c8dcf596062c40ce3535f74a5a204895613b03f87094ba',
        'era': '9502',
        'nonce': '20',
        'tip': '00',
        'mode': '00',
        'metadataHash': '00',
        'address': '15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H',
        'version': 4
      };

      final requestParams = {
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'transactionPayload': transactionPayload,
      };

      debugPrint(jsonEncode(requestParams));

      // Wallet response

      final jsonRPCResponse = {
        'id': 1,
        'jsonrpc': '2.0',
        'result': {
          'id': 123456789,
          'signature':
              '926c22be4158edd2ccefdadd0e951c12da439661fc4e6bf259140f208d3fb815441ad8de4a393809b634643b857c247ea39f3d7bb2e1d3be70af920e2fbdbe84'
        },
      };
      debugPrint(jsonEncode(jsonRPCResponse));

      // Expected values

      const realSignedExtrinsicHex =
          '3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb6301926c22be4158edd2ccefdadd0e951c12da439661fc4e6bf259140f208d3fb815441ad8de4a393809b634643b857c247ea39f3d7bb2e1d3be70af920e2fbdbe849502200000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee';

      // https://polkadot.subscan.io/extrinsic/0xb70583e87e95e8ede02b19801843e7ecf759000f27147f8e17310ea4987ee6c7
      const realTxHash =
          '5a1d54f26a850ac1637a9bb657172507912133dd003246262303dce2a1a2e45e';

      // Utils tests

      final txHashFromUtils = PolkadotChainUtils.deriveExtrinsicHash(
        realSignedExtrinsicHex,
      );
      // by succeeding this, it means that deriveExtrinsicHash() is correct
      expect(txHashFromUtils, realTxHash);

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final signatureFromResponse = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signatureFromResponse,
        '926c22be4158edd2ccefdadd0e951c12da439661fc4e6bf259140f208d3fb815441ad8de4a393809b634643b857c247ea39f3d7bb2e1d3be70af920e2fbdbe84',
      );

      final originalTxPayload = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'transactionPayload',
      );
      final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        requestParams,
        'address',
      );
      final senderPublicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );
      final signedExtrinsicUtils = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(senderPublicKey),
        hexSignature: signatureFromResponse,
        payload: originalTxPayload,
      );
      final signedExtrinsicUtilsHex = hex.encode(signedExtrinsicUtils);
      expect(signedExtrinsicUtilsHex, realSignedExtrinsicHex);

      final derivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        signedExtrinsicUtilsHex,
      );
      expect(derivedHash, realTxHash);
    });
  });
}
