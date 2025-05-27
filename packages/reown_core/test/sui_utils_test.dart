import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/utils/sui_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('compute sui tx hash', () {
    test('after sui_signTransaction/sui_signAndExecuteTransaction response',
        () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'transactionBytes':
              'AAACAAhkAAAAAAAAAAAg1fZH7bd9T9ox0DBFBkR/s8kuVar3e8XtS3fDMt1GBfoCAgABAQAAAQEDAAAAAAEBANX2R+23fU/aMdAwRQZEf7PJLlWq93vF7Ut3wzLdRgX6At/pRJzj2VpZgqXpSvEtd3GzPvt99hR8e/yOCGz/8nbRmA7QFAAAAAAgBy5vStJizn76LmJTBlDiONdR/2rSuzzS4L+Tp/Zs4hZ8cBxYkcSlxBD6QXvgS11E6d+DNek8LiA/beba6iH3l5gO0BQAAAAAIMpdmZjiqJ5GG9di1MAgD4S3uRr2gaMC7S1WsaeBwNIx1fZH7bd9T9ox0DBFBkR/s8kuVar3e8XtS3fDMt1GBfroAwAAAAAAAECrPAAAAAAAAA==',
          'signature':
              'AGte9GqgPwHIzFSr/A4RdYqcgk2QJof0m8pHt06+WsIrw3vU40B+HGpQS/KaA9nPh12i/A7tIp6j5DGPoKM44AEZXLv/ORduxMYX0fw8dbHlnWC8WG0ymrlAmARpEibbhw=='
        }
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);

      final signature = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      expect(
        signature,
        'AGte9GqgPwHIzFSr/A4RdYqcgk2QJof0m8pHt06+WsIrw3vU40B+HGpQS/KaA9nPh12i/A7tIp6j5DGPoKM44AEZXLv/ORduxMYX0fw8dbHlnWC8WG0ymrlAmARpEibbhw==',
      );
      final transactionBytes = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'transactionBytes',
      );
      final computedHash = SuiChainUtils.getSuiDigestFromEncodedTx(
        transactionBytes,
      );
      expect(computedHash, 'C98G1Uwh5soPMtZZmjUFwbVzWLMoAHzi5jrX2BtABe8v');
    });
  });
}
