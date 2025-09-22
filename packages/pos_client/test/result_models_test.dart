import 'package:flutter_test/flutter_test.dart';
import 'package:pos_client/services/models/result_models.dart';

void main() {
  group('EvmTransactionParams', () {
    test('should parse from JSON correctly', () {
      final json = {
        "data":
            "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
        "from": "0xd6d146ec0fa91c790737cfb4ee3d7e965a51c340",
        "gas": "0x9f03",
        "input":
            "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
        "maxFeePerGas": "0xfc200",
        "maxPriorityFeePerGas": "0xf4414",
        "to": "0x1c7d4b196cb0c7b01d743fbc6116a902379c7238",
        "value": "0x0",
      };

      final params = EvmTransactionParams.fromJson(json);

      expect(params.from, "0xd6d146ec0fa91c790737cfb4ee3d7e965a51c340");
      expect(params.to, "0x1c7d4b196cb0c7b01d743fbc6116a902379c7238");
      expect(params.value, "0x0");
      expect(params.gas, "0x9f03");
      expect(
        params.data,
        "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
      );
      expect(
        params.input,
        "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
      );
      expect(params.maxFeePerGas, "0xfc200");
      expect(params.maxPriorityFeePerGas, "0xf4414");
    });

    test('should convert to JSON correctly', () {
      final params = EvmTransactionParams(
        from: "0xd6d146ec0fa91c790737cfb4ee3d7e965a51c340",
        to: "0x1c7d4b196cb0c7b01d743fbc6116a902379c7238",
        value: "0x0",
        gas: "0x9f03",
        data:
            "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
        input:
            "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
        maxFeePerGas: "0xfc200",
        maxPriorityFeePerGas: "0xf4414",
      );

      final json = params.toJson();

      expect(json['from'], "0xd6d146ec0fa91c790737cfb4ee3d7e965a51c340");
      expect(json['to'], "0x1c7d4b196cb0c7b01d743fbc6116a902379c7238");
      expect(json['value'], "0x0");
      expect(json['gas'], "0x9f03");
      expect(
        json['data'],
        "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
      );
      expect(
        json['input'],
        "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
      );
      expect(json['maxFeePerGas'], "0xfc200");
      expect(json['maxPriorityFeePerGas'], "0xf4414");
    });
  });

  group('TransactionRpc', () {
    test('should parse EVM transaction from JSON correctly', () {
      final json = {
        "chainId": "eip155:11155111",
        "id":
            "djF8ZWlwMTU1OjExMTU1MTExfGNkNWZmYWQ0LTE2YTItNDY4ZC05N2E1LTMxNjEyY2Y4YWRmNQ",
        "method": "eth_sendTransaction",
        "params": [
          {
            "data":
                "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
            "from": "0xd6d146ec0fa91c790737cfb4ee3d7e965a51c340",
            "gas": "0x9f03",
            "input":
                "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
            "maxFeePerGas": "0xfc200",
            "maxPriorityFeePerGas": "0xf4414",
            "to": "0x1c7d4b196cb0c7b01d743fbc6116a902379c7238",
            "value": "0x0",
          },
        ],
      };

      final transaction = TransactionRpc.fromJson(json);

      expect(transaction, isA<EvmTransactionRpc>());
      transaction.when(
        evm: (id, chainId, method, params) {
          expect(
            id,
            "djF8ZWlwMTU1OjExMTU1MTExfGNkNWZmYWQ0LTE2YTItNDY4ZC05N2E1LTMxNjEyY2Y4YWRmNQ",
          );
          expect(method, "eth_sendTransaction");
          expect(chainId, "eip155:11155111");
          expect(params.length, 1);
          expect(
            params.first.from,
            "0xd6d146ec0fa91c790737cfb4ee3d7e965a51c340",
          );
          expect(params.first.to, "0x1c7d4b196cb0c7b01d743fbc6116a902379c7238");
          expect(params.first.value, "0x0");
        },
        solana: (id, method, chainId, params) =>
            fail('Expected EVM transaction'),
        tron: (id, method, chainId, params) => fail('Expected EVM transaction'),
      );
    });

    test('should parse Solana transaction from JSON correctly', () {
      final json = {
        "chainId": "solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp",
        "id": "solana-tx-123",
        "method": "solana_signAndSendTransaction",
        "params": {
          "transaction": "base64-encoded-transaction",
          "pubkey": "9WzDXwBbmkg8ZTbNMqUxvQRAyrZzDsGYdLVL9zYtAWWM",
        },
      };

      final transaction = TransactionRpc.fromJson(json);

      expect(transaction, isA<SolanaTransactionRpc>());
      transaction.when(
        evm: (id, chainId, method, params) =>
            fail('Expected Solana transaction'),
        solana: (id, chainId, method, params) {
          expect(id, "solana-tx-123");
          expect(method, "solana_signAndSendTransaction");
          expect(chainId, "solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp");
          expect(params.transaction, "base64-encoded-transaction");
          expect(params.pubkey, "9WzDXwBbmkg8ZTbNMqUxvQRAyrZzDsGYdLVL9zYtAWWM");
        },
        tron: (id, chainId, method, params) =>
            fail('Expected Solana transaction'),
      );
    });

    test('should parse Tron transaction from JSON correctly', () {
      final json = {
        "chainId": "tron:0x2b6653dc",
        "id": "tron-tx-456",
        "method": "tron_signTransaction",
        "params": {
          "transaction": {
            "result": {"result": true},
            "transaction": {
              "raw_data": {"contract": []},
              "raw_data_hex": "0a02...",
              "signature": ["abc123"],
              "txID": "tron-tx-hash",
              "visible": true,
            },
          },
          "address": "TLyqzVGLV1srkB7dToTAEqgDSfPtXRJZYH",
        },
      };

      final transaction = TransactionRpc.fromJson(json);

      expect(transaction, isA<TronTransactionRpc>());
      transaction.when(
        evm: (id, chainId, method, params) => fail('Expected Tron transaction'),
        solana: (id, chainId, method, params) =>
            fail('Expected Tron transaction'),
        tron: (id, chainId, method, params) {
          expect(id, "tron-tx-456");
          expect(method, "tron_signTransaction");
          expect(chainId, "tron:0x2b6653dc");
          expect(params.address, "TLyqzVGLV1srkB7dToTAEqgDSfPtXRJZYH");
          expect(params.transaction.result.result, true);
          expect(params.transaction.transaction.raw_data_hex, "0a02...");
        },
      );
    });

    test('should throw error for unknown transaction type', () {
      final json = {
        "chainId": "unknown:123",
        "id": "unknown-tx",
        "method": "unknown_method",
        "params": {},
      };

      expect(() => TransactionRpc.fromJson(json), throwsA(isA<Exception>()));
    });
  });

  group('BuildTransactionResult', () {
    test('should parse EVM transaction from JSON correctly', () {
      final json = {
        "transactions": [
          {
            "chainId": "eip155:11155111",
            "id":
                "djF8ZWlwMTU1OjExMTU1MTExfGNkNWZmYWQ0LTE2YTItNDY4ZC05N2E1LTMxNjEyY2Y4YWRmNQ",
            "method": "eth_sendTransaction",
            "params": [
              {
                "data":
                    "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
                "from": "0xd6d146ec0fa91c790737cfb4ee3d7e965a51c340",
                "gas": "0x9f03",
                "input":
                    "0xa9059cbb000000000000000000000000d6d146ec0fa91c790737cfb4ee3d7e965a51c34000000000000000000000000000000000000000000000000000000000000f4240",
                "maxFeePerGas": "0xfc200",
                "maxPriorityFeePerGas": "0xf4414",
                "to": "0x1c7d4b196cb0c7b01d743fbc6116a902379c7238",
                "value": "0x0",
              },
            ],
          },
        ],
      };

      final result = BuildTransactionResult.fromJson(json);

      expect(result.transactions.length, 1);
      expect(result.transactions.first, isA<EvmTransactionRpc>());
    });

    test('should parse Solana transaction from JSON correctly', () {
      final json = {
        "transactions": [
          {
            "chainId": "solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp",
            "id": "solana-tx-123",
            "method": "solana_signAndSendTransaction",
            "params": {
              "transaction": "base64-encoded-transaction",
              "pubkey": "9WzDXwBbmkg8ZTbNMqUxvQRAyrZzDsGYdLVL9zYtAWWM",
            },
          },
        ],
      };

      final result = BuildTransactionResult.fromJson(json);

      expect(result.transactions.length, 1);
      expect(result.transactions.first, isA<SolanaTransactionRpc>());
    });

    test('should parse Tron transaction from JSON correctly', () {
      final json = {
        "transactions": [
          {
            "chainId": "tron:0x2b6653dc",
            "id": "tron-tx-456",
            "method": "tron_signTransaction",
            "params": {
              "transaction": {
                "result": {"result": true},
                "transaction": {
                  "raw_data": {"contract": []},
                  "raw_data_hex": "0a02...",
                  "signature": ["abc123"],
                  "txID": "tron-tx-hash",
                  "visible": true,
                },
              },
              "address": "TLyqzVGLV1srkB7dToTAEqgDSfPtXRJZYH",
            },
          },
        ],
      };

      final result = BuildTransactionResult.fromJson(json);

      expect(result.transactions.length, 1);
      expect(result.transactions.first, isA<TronTransactionRpc>());
    });

    test('should parse mixed transaction types from JSON correctly', () {
      final json = {
        "transactions": [
          {
            "chainId": "eip155:11155111",
            "id": "evm-tx-1",
            "method": "eth_sendTransaction",
            "params": [
              {"from": "0x123", "to": "0x456", "value": "0x0"},
            ],
          },
          {
            "chainId": "solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp",
            "id": "solana-tx-2",
            "method": "solana_signAndSendTransaction",
            "params": {
              "transaction": "base64-tx",
              "pubkey": "9WzDXwBbmkg8ZTbNMqUxvQRAyrZzDsGYdLVL9zYtAWWM",
            },
          },
        ],
      };

      final result = BuildTransactionResult.fromJson(json);

      expect(result.transactions.length, 2);
      expect(result.transactions.first, isA<EvmTransactionRpc>());
      expect(result.transactions.last, isA<SolanaTransactionRpc>());
    });

    test('should convert to JSON correctly', () {
      final result = BuildTransactionResult(
        transactions: [
          TransactionRpc.evm(
            id: "test-id",
            chainId: "eip155:1",
            method: "eth_sendTransaction",
            params: [
              EvmTransactionParams(from: "0x123", to: "0x456", value: "0x0"),
            ],
          ),
        ],
      );

      final json = result.toJson();

      expect(json['transactions'], isA<List>());
      expect(json['transactions'].length, 1);
    });
  });
}
