import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('compute polkadot tx hash', () {
    test('after polkadot_signTransaction response', () {
      final jsonRPCRequest = {
        'address': '5GMt7MxkA59WAtFPFFhqtLykW6XKXh8ukvjtzqT6yz2FT5wa',
        'transactionPayload': {
          'specVersion': '0x00002468',
          'transactionVersion': '0x0000000e',
          'address': '5GMt7MxkA59WAtFPFFhqtLykW6XKXh8ukvjtzqT6yz2FT5wa',
          'blockHash':
              '0x554d682a74099d05e8b7852d19c93b527b5fae1e9e1969f6e1b82a2f09a14cc9',
          'blockNumber': '0x00cb539c',
          'era': '0xc501',
          'genesisHash':
              '0xe143f23803ac50e8f6f8e62695d1ce9e4e1d68aa36c1cd2cfd15340213f3423e',
          'method':
              '0x0001784920616d207369676e696e672074686973207472616e73616374696f6e21',
          'nonce': '0x00000000',
          'signedExtensions': [
            'CheckNonZeroSender',
            'CheckSpecVersion',
            'CheckTxVersion',
            'CheckGenesis',
            'CheckMortality',
            'CheckNonce',
            'CheckWeight',
            'ChargeTransactionPayment'
          ],
          'tip': '0x00000000000000000000000000000000',
          'version': 4
        },
      };

      final jsonRPCResponse = {
        'id': 1,
        'jsonrpc': '2.0',
        'result': {
          'signature':
              '0xac116ab507d75215d59ca3f2993a2af6caef1a561e9273506c6287bca9aa3551939f7329b269572b243c7de5b9939a017961f99aebf1c5e6ab24106bd082b887'
        },
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);

      final signature = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signature,
        '0xac116ab507d75215d59ca3f2993a2af6caef1a561e9273506c6287bca9aa3551939f7329b269572b243c7de5b9939a017961f99aebf1c5e6ab24106bd082b887',
      );
      final params = jsonRPCRequest as Map<String, dynamic>;
      final payload = ReownCoreUtils.recursiveSearchForMapKey(
        params,
        'transactionPayload',
      );
      final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        params,
        'address',
      );
      expect(ss58Address, '5GMt7MxkA59WAtFPFFhqtLykW6XKXh8ukvjtzqT6yz2FT5wa');
      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );

      final extrinsic = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: signature,
        payload: payload,
      );
      final hexExtrinsic = hex.encode(extrinsic);
      final computedHash = PolkadotChainUtils.deriveExtrinsicHash(hexExtrinsic);
      expect(
        computedHash,
        '0xa041b1ebfdec0afbebfb81a3264f47eeca4802efe602040fa11c253eb4e1d04b',
      );
    });
    //
    // test('after polkadot_signTransaction response 2', () {
    //   final destAddress = '15orXHPrtzLixVnWVnruQ7jiWyn154StUR7S92BhHfJ8XmCh';
    //   final amount = BigInt.parse('6000000000000');
    //   final method = PolkadotChainUtils.constructHexMethod(destAddress, amount);

    //   final jsonRPCRequest = {
    //     'address': '16BEdLwHwhCLvaDExWSWMT4bbJ9NoNWmeT9VzCDBdn1WAD74',
    //     'transactionPayload': {
    //       'specVersion': '0x000004e3', // Replace with actual specVersion in hex
    //       'transactionVersion':
    //           '0x0000000e', // Replace with actual transactionVersion in hex
    //       'address': '16BEdLwHwhCLvaDExWSWMT4bbJ9NoNWmeT9VzCDBdn1WAD74',
    //       'blockHash':
    //           '0xc27330f2b5fc41d1a3cd77cd13d8b82794a2349dcb40813e7e2993e4d7f77ff1', // Replace with actual block hash
    //       'blockNumber':
    //           '0x00000000', // Replace with actual block number in hex
    //       'era':
    //           '0x402a', // Mortal era bytes; replace with actual value if different
    //       'genesisHash':
    //           '0x91b171bb158e2d3848fa23a9f1c25182c35d08e6a2aef40c1a54f8c36c8e17f0', // Replace with actual genesis hash
    //       'method': method,
    //       'nonce': '0x0e', // Nonce 14 in hex
    //       'signedExtensions': [
    //         'CheckNonZeroSender',
    //         'CheckSpecVersion',
    //         'CheckTxVersion',
    //         'CheckGenesis',
    //         'CheckMortality',
    //         'CheckNonce',
    //         'CheckWeight',
    //         'ChargeTransactionPayment',
    //       ],
    //       'tip': '0x00000000000000000000000000000000',
    //       'version': 4
    //     },
    //   };

    //   final jsonRPCResponse = {
    //     'id': 1,
    //     'jsonrpc': '2.0',
    //     'result': {
    //       'signature':
    //           '0x96f740b9fa6c8ee308fd45fbe1906797665706b85ab1ca74f9c8e358e797f72b9e36cc70c27e6ad6a52e043f5218a81cd962fe6dee062cfdfde8e7d49d63ce8e'
    //     },
    //   };
    //   final response = JsonRpcResponse.fromJson(jsonRPCResponse);
    //   final result = (response.result as Map<String, dynamic>);

    //   final signature = ReownCoreUtils.recursiveSearchForMapKey(
    //     result,
    //     'signature',
    //   );
    //   expect(
    //     signature,
    //     '0x96f740b9fa6c8ee308fd45fbe1906797665706b85ab1ca74f9c8e358e797f72b9e36cc70c27e6ad6a52e043f5218a81cd962fe6dee062cfdfde8e7d49d63ce8e',
    //   );
    //   final params = jsonRPCRequest as Map<String, dynamic>;
    //   final payload = ReownCoreUtils.recursiveSearchForMapKey(
    //     params,
    //     'transactionPayload',
    //   );
    //   final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
    //     params,
    //     'address',
    //   );
    //   expect(ss58Address, '16BEdLwHwhCLvaDExWSWMT4bbJ9NoNWmeT9VzCDBdn1WAD74');
    //   final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
    //     ss58Address,
    //   );

    //   final extrinsic = PolkadotChainUtils.addSignatureToExtrinsic(
    //     publicKey: Uint8List.fromList(publicKey),
    //     hexSignature: signature,
    //     payload: payload,
    //   );
    //   final hexExtrinsic = hex.encode(extrinsic);
    //   final computedHash = PolkadotChainUtils.deriveExtrinsicHash(hexExtrinsic);
    //   expect(
    //     computedHash,
    //     '0x48ea609de9eb8fa68dca201569e244fd9b01e054ff55db1637ed8062fde201f0',
    //   );
    // });

    test('derive hash from unsigned payload', () {
// senderWallet: 15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM
// receiverWallet: 15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H
// payloadToSign: {"method":[5,3,0,192,125,33,29,60,24,29,247,104,217,217,212,29,246,241,79,157,17,109,156,25,6,243,129,83,178,8,37,156,49,91,75,2,40,107,238],"specVersion":"c9550f00","transactionVersion":"1a000000","genesisHash":"91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3","blockHash":"d53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b","era":"e500","nonce":"18","tip":"00","mode":"00","metadataHash":"00"}
// Payload hex: 050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286beee500180000c9550f001a00000091b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3d53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b00
// Signature hex: 7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d
// srExtrinsic Hex: 3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808de500180000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee
// utilExtrinsic Hex: 3d0284be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d029403006000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee
// Sr25519 extrinsic hash: d0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f
      final payloadToSign = {
        'method': hex.encode([
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
        ]),
        'specVersion': 'c9550f00',
        'transactionVersion': '1a000000',
        'genesisHash':
            '91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3',
        'blockHash':
            'd53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b',
        'era': 'e500',
        'nonce': '18',
        'tip': '00',
        'mode': '00',
        'metadataHash': '00'
      };
      print(jsonEncode(payloadToSign));

      final signatureFromWallet =
          '7e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808d';

      final expectedSignedExtrinsicHex =
          '3d028400be0a9f19fe636b4b1a2efaeb75eaa978cff38960c9fda0f532fe4961b885cb63017e991d9bb5c47c4d2a44a125d410854835afec24ae58f30ee6fa0f764757b4409bde94c559567aeba33f9bd190209f6d2121afe32f267b593aa6cef2a87a808de500180000050300c07d211d3c181df768d9d9d41df6f14f9d116d9c1906f38153b208259c315b4b02286bee';

      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
      );
      final extrinsicBytes = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: signatureFromWallet,
        payload: payloadToSign,
      );

      final signedExtrinsicHex = hex.encode(extrinsicBytes);
      expect(signedExtrinsicHex, expectedSignedExtrinsicHex);

      final expectedHash =
          'd0856fc78eb845761b1f60691a5cba2321ca514ab0b76912d617b8cf7fe5060f';

      final derivedHash = PolkadotChainUtils.deriveExtrinsicHash(
        signedExtrinsicHex,
      );

      expect('0x$derivedHash', '0x$expectedHash');
    });
  });
}
