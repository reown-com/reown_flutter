import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('recursiveSearchForMapKey', () {
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
  });
}
