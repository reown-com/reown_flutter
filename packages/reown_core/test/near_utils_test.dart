import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_core/utils/near_utils.dart';
import 'package:reown_core/utils/utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('extractSolanaSignature', () {
    test('should extract the transaction id from a solana transaction', () {
      final txBytes = base64.decode(
          'AXcAam9obm55LnRlc3QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAABwb25nLnRlc3QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAECAxIGr8P0qFUJ97EjhQhtbFxv3rcKJFxvVUolazShIjvPSwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEDAQEBAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fAQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHw==');

      final hashBytes = SHA256Digest().process(txBytes).toList();
      final computedHash = NearChainUtils.computeNearHashFromTxBytes(
        hashBytes,
      );
      expect(computedHash, 'C3NaLMQgq6WJMTYYuKhCJyfdZspRMGoU4RjYfwbCPDqa');
    });

    test('after near_signTransaction response', () {
      final jsonRPCResponse = {
        'jsonrpc': '2.0',
        'id': 1,
        'result': {
          'data': [
            131,
            65,
            0,
            242,
            90,
            30,
            125,
            99,
            136,
            155,
            214,
            139,
            135,
            1,
            72,
            37,
            125,
            237,
            224,
            13,
            167,
            78,
            235,
            229,
            119,
            110,
            226,
            170,
            66,
            31,
            5,
            207
          ],
        }
      };
      final response = JsonRpcResponse.fromJson(jsonRPCResponse);
      final result = (response.result as Map<String, dynamic>);

      final txData = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'data',
      );
      final computedHash = NearChainUtils.computeNearHashFromTxBytes(
        txData as List,
      );
      expect(computedHash, 'C3NaLMQgq6WJMTYYuKhCJyfdZspRMGoU4RjYfwbCPDqa');
    });
  });
}
