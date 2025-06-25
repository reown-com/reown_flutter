import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('recursiveSearchForMapKey', () {
    test(
        'should parse solana_signTransaction/solana_signAndSendTransaction and extract signature',
        () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'signature':
              '2Lb1KQHWfbV3pWMqXZveFWqneSyhH95YsgCENRWnArSkLydjN1M42oB82zSd6BBdGkM9pE6sQLQf1gyBh8KWM2c4'
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
        '2Lb1KQHWfbV3pWMqXZveFWqneSyhH95YsgCENRWnArSkLydjN1M42oB82zSd6BBdGkM9pE6sQLQf1gyBh8KWM2c4',
      );
    });

    test(
        'should parse solana_signTransaction/solana_signAndSendTransaction error',
        () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'error': Errors.getSdkError(Errors.USER_REJECTED).toJson(),
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>?);
      final signature = ReownCoreUtils.recursiveSearchForMapKey(
        result ?? {},
        'signature',
      );
      expect(signature, isNull);
    });

    test('should parse solana_signAllTransactions and extract signature', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'transactions': [
            'AeJw688VKMWEeOHsYhe03By/2rqJHTQeq6W4L1ZLdbT2l/Nim8ctL3erMyH9IWPsQP73uaarRmiVfanEJHx7uQ4BAAIDb3ObYkq6BFd46JrMFy1h0Q+dGmyRGtpelqTKkIg82isAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAtIy17v5fs39LuoitzpBhVrg8ZIQF/3ih1N9dQ+X3shEDAgAFAlgCAAABAgAADAIAAACghgEAAAAAAAIACQMjTgAAAAAAAA=='
          ],
        },
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final transactions = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'transactions',
      );
      expect(transactions, isA<List<String>>());
      expect((transactions as List).first,
          'AeJw688VKMWEeOHsYhe03By/2rqJHTQeq6W4L1ZLdbT2l/Nim8ctL3erMyH9IWPsQP73uaarRmiVfanEJHx7uQ4BAAIDb3ObYkq6BFd46JrMFy1h0Q+dGmyRGtpelqTKkIg82isAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAtIy17v5fs39LuoitzpBhVrg8ZIQF/3ih1N9dQ+X3shEDAgAFAlgCAAABAgAADAIAAACghgEAAAAAAAIACQMjTgAAAAAAAA==');
    });

    test('should parse xrpl_signTransaction and extract hash', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'tx_json': {
            'Account': 'rMBzp8CgpE441cp5PVyA9rpVV7oT8hP3ys',
            'Expiration': 595640108,
            'Fee': '10',
            'Flags': 524288,
            'OfferSequence': 1752791,
            'Sequence': 1752792,
            'LastLedgerSequence': 7108682,
            'SigningPubKey':
                '03EE83BB432547885C219634A1BC407A9DB0474145D69737D09CCDC63E1DEE7FE3',
            'TakerGets': '15000000000',
            'TakerPays': {
              'currency': 'USD',
              'issuer': 'rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B',
              'value': '7072.8'
            },
            'TransactionType': 'OfferCreate',
            'TxnSignature':
                '30440220143759437C04F7B61F012563AFE90D8DAFC46E86035E1D965A9CED282C97D4CE02204CFD241E86F17E011298FC1A39B63386C74306A5DE047E213B0F29EFA4571C2C',
            'hash':
                '73734B611DDA23D3F5F62E20A173B78AB8406AC5015094DA53F53D39B9EDB06C'
          }
        },
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final hash = ReownCoreUtils.recursiveSearchForMapKey(result, 'hash');
      expect(
        hash,
        '73734B611DDA23D3F5F62E20A173B78AB8406AC5015094DA53F53D39B9EDB06C',
      );
    });

    test('should extract tron txID after tron_signTransaction response', () {
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

    test(
        'should parse hedera_signAndExecuteTransaction/hedera_executeTransaction and extract transactionId',
        () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'nodeId': '0.0.3',
          'transactionHash': '252b8fd...',
          'transactionId': '0.0.12345678@1689281510.675369303'
        },
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final transactionId = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'transactionId',
      );
      expect(transactionId, '0.0.12345678@1689281510.675369303');
    });

    test('should parse bitcoin\'s sendTransfer and extract txid', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'txid':
              'f007551f169722ce74104d6673bd46ce193c624b8550889526d1b93820d725f7'
        },
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final txid = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'txid',
      );
      expect(txid,
          'f007551f169722ce74104d6673bd46ce193c624b8550889526d1b93820d725f7');
    });

    test('should parse stx_transferStx and extract txid', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'txid': 'stack_tx_id',
          'transaction': 'raw_tx_hex',
        },
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);
      final txid = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'txid',
      );
      expect(txid, 'stack_tx_id');
    });
  });
}
