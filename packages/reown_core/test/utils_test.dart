import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('recursiveSearchForMapKey', () {
    test('should extract the proper key/value', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'txID':
              '66e79c6993f29b02725da54ab146ffb0453ee6a43b4083568ad9585da305374a',
          'signature': [
            '7e760cef94bc82a7533bc1e8d4ab88508c6e13224cd50cc8da62d3f4d4e19b99514f...'
          ],
          'raw_data': {
            'expiration': 1745849082000,
            'contract': [
              {
                'parameter': {
                  'type_url':
                      'type.googleapis.com/protocol.TriggerSmartContract',
                  'value': {
                    'data':
                        '095ea7b30000000000000000000000001cb0b7348eded93b8d0816bbeb819fc1d7a51f310000000000000000000000000000000000000000000000000000000000000000',
                    'contract_address':
                        '41a614f803b6fd780986a42c78ec9c7f77e6ded13c',
                    'owner_address':
                        '411cb0b7348eded93b8d0816bbeb819fc1d7a51f31'
                  }
                },
                'type': 'TriggerSmartContract'
              }
            ],
            'ref_block_hash': 'baa1c278fd0a309f',
            'fee_limit': 200000000,
            'timestamp': 1745849022978,
            'ref_block_bytes': '885b'
          },
          'visible': false,
          'raw_data_hex':
              '0a02885b2208baa1c278fd0a309f4090c1dbe5e7325aae01081f12a9010a31747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e54726967676572536d617274436f6e747261637412740a15411cb0b7348eded93b8d0816bbeb819fc1d7a51f31121541a614f803b6fd780986a42c78ec9c7f77e6ded13c2244095ea7b30000000000000000000000001cb0b7348eded93b8d0816bbeb819fc1d7a51f3100000000000000000000000000000000000000000000000000000000000000007082f4d7e5e73290018084af5f'
        },
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final txID = ReownCoreUtils.recursiveSearchForMapKey(result, 'txID');
      expect(
        txID,
        '66e79c6993f29b02725da54ab146ffb0453ee6a43b4083568ad9585da305374a',
      );
    });
  });
}
