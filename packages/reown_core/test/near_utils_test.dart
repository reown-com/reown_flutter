import 'dart:convert';
import 'dart:typed_data';

import 'package:bs58/bs58.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:reown_core/utils/near_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('extractSolanaSignature', () {
    test('should extract the transaction id from a solana transaction', () {
      // final txBytes = base64.decode(
      //     'AXcAam9obm55LnRlc3QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAABwb25nLnRlc3QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAECAxIGr8P0qFUJ97EjhQhtbFxv3rcKJFxvVUolazShIjvPSwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEDAQEBAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fAQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHw==');

      // final hashBytes = SHA256Digest().process(txBytes).toList();
      // print(base58.encode(Uint8List.fromList(hashBytes)));

      // final result = {
      //   'result': {'data': txBytes}
      // };
      // final computedHash = NearChainUtils.computeNearTxHashFromWalletResponse(
      //   result,
      // );
      // expect(computedHash, 'C3NaLMQgq6WJMTYYuKhCJyfdZspRMGoU4RjYfwbCPDqa');
    });
  });
}
