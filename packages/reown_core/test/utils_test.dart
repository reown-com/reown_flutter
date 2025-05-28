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
  });
}
