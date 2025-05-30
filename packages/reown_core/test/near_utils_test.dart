import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_core/utils/near_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const responseTypeList = [
    16,
    0,
    0,
    0,
    48,
    120,
    103,
    97,
    110,
    99,
    104,
    111,
    46,
    116,
    101,
    115,
    116,
    110,
    101,
    116,
    0,
    243,
    74,
    204,
    31,
    29,
    80,
    146,
    149,
    102,
    175,
    8,
    83,
    231,
    187,
    5,
    120,
    41,
    115,
    247,
    22,
    197,
    120,
    182,
    242,
    120,
    135,
    73,
    137,
    166,
    246,
    171,
    103,
    77,
    243,
    34,
    42,
    212,
    180,
    0,
    0,
    16,
    0,
    0,
    0,
    48,
    120,
    103,
    97,
    110,
    99,
    104,
    111,
    46,
    116,
    101,
    115,
    116,
    110,
    101,
    116,
    5,
    233,
    95,
    227,
    45,
    10,
    101,
    176,
    111,
    124,
    190,
    86,
    106,
    27,
    143,
    54,
    148,
    125,
    132,
    252,
    25,
    71,
    125,
    78,
    60,
    242,
    100,
    219,
    40,
    168,
    65,
    3,
    1,
    0,
    0,
    0,
    3,
    0,
    0,
    0,
    161,
    237,
    204,
    206,
    27,
    194,
    211,
    0,
    0,
    0,
    0,
    0,
    0
  ];

  Map<String, int> toJsonTypeResponse(List<int> input) {
    return {
      for (int i = 0; i < input.length; i++) i.toString(): input[i],
    };
  }

  group('computeNearHashFromTxBytes', () {
    test('after near_signTransaction response type list', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': responseTypeList,
      };

      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final txData = NearChainUtils.parseResponse(response.result);
      final computedHash = NearChainUtils.computeNearHashFromTxBytes(txData);
      expect(computedHash, 'EpHx79wKAn6br4G9aKaCGLpdzNc8YjrthiFonXQgskAx');
    });

    test('after near_signTransaction response type 1', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': toJsonTypeResponse(responseTypeList),
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final txData = NearChainUtils.parseResponse(response.result);
      final computedHash = NearChainUtils.computeNearHashFromTxBytes(txData);
      expect(computedHash, 'EpHx79wKAn6br4G9aKaCGLpdzNc8YjrthiFonXQgskAx');
    });
  });
}
