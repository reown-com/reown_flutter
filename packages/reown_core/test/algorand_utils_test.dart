import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/utils/algorand_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('compute algorand hash', () {
    test('after algo_signTxn response', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': [
          'gqNzaWfEQNGPgbxS9pTu0sTikT3cJVO48WFltc8MM8meFR+aAnGwOo3FO+0nFkAludT0jNqHRM6E65gW6k/m92sHVCxVnQWjdHhuiaNhbXTOAAehIKNmZWXNA+iiZnbOAv0CO6NnZW6sbWFpbm5ldC12MS4womdoxCDAYcTY/B293tLXYEvkVo4/bQQZh6w3veS2ILWrOSSK36Jsds4C/QYjo3JjdsQgeqRNTBEXudHx2kO9Btq289aRzj5DlNUw0jwX9KEnaZqjc25kxCDH1s5tvgARbjtHceUG07Sj5IDfqzn7Zwx0P+XuvCYMz6R0eXBlo3BheQ==',
        ],
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as List);
      expect(result.length, 1);
      final txHashesList = AlgorandChainUtils.calculateTxIDs(result);
      expect(
        txHashesList.first,
        'OM5JS3AE4HVAT5ZMCIMY32HPD6KJAQVPFS2LL2ZW2R5JKUKZFVNA',
      );
    });
  });
}
