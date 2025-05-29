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

      final signedHex = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: publicKey,
        hexSignature: signature,
        payload: payload,
      );
      final computedHash = PolkadotChainUtils.deriveExtrinsicHash(signedHex);
      expect(
        computedHash,
        '0xa041b1ebfdec0afbebfb81a3264f47eeca4802efe602040fa11c253eb4e1d04b',
      );
    });
    //
    test('after polkadot_signTransaction response 2', () {
      final destAddress = '15orXHPrtzLixVnWVnruQ7jiWyn154StUR7S92BhHfJ8XmCh';
      final amount = BigInt.parse('6000000000000');
      final method = PolkadotChainUtils.constructHexMethod(destAddress, amount);

      final jsonRPCRequest = {
        'address': '16BEdLwHwhCLvaDExWSWMT4bbJ9NoNWmeT9VzCDBdn1WAD74',
        'transactionPayload': {
          'specVersion': '0x000004e3', // Replace with actual specVersion in hex
          'transactionVersion':
              '0x0000000e', // Replace with actual transactionVersion in hex
          'address': '16BEdLwHwhCLvaDExWSWMT4bbJ9NoNWmeT9VzCDBdn1WAD74',
          'blockHash':
              '0xc27330f2b5fc41d1a3cd77cd13d8b82794a2349dcb40813e7e2993e4d7f77ff1', // Replace with actual block hash
          'blockNumber':
              '0x00000000', // Replace with actual block number in hex
          'era':
              '0x402a', // Mortal era bytes; replace with actual value if different
          'genesisHash':
              '0x91b171bb158e2d3848fa23a9f1c25182c35d08e6a2aef40c1a54f8c36c8e17f0', // Replace with actual genesis hash
          'method': method,
          'nonce': '0x0e', // Nonce 14 in hex
          'signedExtensions': [
            'CheckNonZeroSender',
            'CheckSpecVersion',
            'CheckTxVersion',
            'CheckGenesis',
            'CheckMortality',
            'CheckNonce',
            'CheckWeight',
            'ChargeTransactionPayment',
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
              '0x96f740b9fa6c8ee308fd45fbe1906797665706b85ab1ca74f9c8e358e797f72b9e36cc70c27e6ad6a52e043f5218a81cd962fe6dee062cfdfde8e7d49d63ce8e'
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
        '0x96f740b9fa6c8ee308fd45fbe1906797665706b85ab1ca74f9c8e358e797f72b9e36cc70c27e6ad6a52e043f5218a81cd962fe6dee062cfdfde8e7d49d63ce8e',
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
      expect(ss58Address, '16BEdLwHwhCLvaDExWSWMT4bbJ9NoNWmeT9VzCDBdn1WAD74');
      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        ss58Address,
      );

      final signedHex = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: publicKey,
        hexSignature: signature,
        payload: payload,
      );
      final computedHash = PolkadotChainUtils.deriveExtrinsicHash(signedHex);
      expect(
        computedHash,
        '0x48ea609de9eb8fa68dca201569e244fd9b01e054ff55db1637ed8062fde201f0',
      );
    });
  });
}
