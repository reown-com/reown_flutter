import 'package:flutter_test/flutter_test.dart';
import 'package:reown_appkit/reown_appkit.dart';

// Mock responses moved from exchange_service.dart
const getExchangesMockResponse = {
  'id': 1,
  'jsonrpc': '2.0',
  'result': {
    'exchanges': [
      {
        'id': 'binance',
        'imageUrl': 'https://pay-assets.reown.com/binance_128_128.webp',
        'name': 'Binance',
      },
      {
        'id': 'coinbase',
        'imageUrl': 'https://pay-assets.reown.com/coinbase_128_128.webp',
        'name': 'Coinbase',
      },
      {
        'id': 'reown_test',
        'imageUrl': 'https://pay-assets.reown.com/reown_test_128_128.webp',
        'name': 'Reown Test Exchange',
      },
    ],
    'total': 3,
  },
};

const getExchangeUrlMockResponse = {
  'id': 1,
  'jsonrpc': '2.0',
  'result': {
    'sessionId': '57a5ac338fc4470abb069c34a2228711',
    'url':
        'https://appkit-pay-test-exchange.reown.com/?asset=eip155:84532/slip44:60&amount=0.00001&recipient=0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340&sessionId=6f938cd753aa4f9b9cc413f1e407adf6&projectId=702e2d45d9debca66795614cddb5c1ca',
  },
};

const getExchangeBuyStatusMockResponse = {
  'id': 1,
  'jsonrpc': '2.0',
  'result': {
    'status': 'UNKNOWN',
    'txHash':
        null, // 'UNKNOWN' | 'IN_PROGRESS' | 'FAILED' | 'SUCCESS' (with txHash)
  },
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ExchangeService Mock Responses', () {
    group('getExchanges', () {
      test('mock response has correct structure', () {
        // Verify the mock response structure is correct
        final mockResponse = JsonRpcResponse.fromJson(getExchangesMockResponse);

        expect(mockResponse.result, isA<Map>());
        expect(mockResponse.result['exchanges'], isA<List>());
        expect(mockResponse.result['exchanges'].length, 3);
        expect(mockResponse.result['total'], 3);
        expect(mockResponse.result['exchanges'][0]['id'], 'binance');
        expect(mockResponse.result['exchanges'][1]['id'], 'coinbase');
        expect(mockResponse.result['exchanges'][2]['id'], 'reown_test');
      });

      test('mock response has correct exchange structure', () {
        final mockResponse = JsonRpcResponse.fromJson(getExchangesMockResponse);
        final exchanges = mockResponse.result['exchanges'] as List;

        for (final exchange in exchanges) {
          expect(exchange, isA<Map>());
          expect(exchange['id'], isA<String>());
          expect(exchange['imageUrl'], isA<String>());
          expect(exchange['name'], isA<String>());
        }
      });
    });

    group('getExchangeUrl', () {
      test('mock response has correct structure', () {
        // Verify the mock response structure
        final mockResponse = JsonRpcResponse.fromJson(
          getExchangeUrlMockResponse,
        );

        expect(mockResponse.result, isA<Map>());
        expect(mockResponse.result['sessionId'], isA<String>());
        expect(mockResponse.result['url'], isA<String>());
        expect(
          mockResponse.result['sessionId'],
          '57a5ac338fc4470abb069c34a2228711',
        );
        expect(
          mockResponse.result['url'],
          contains('appkit-pay-test-exchange.reown.com'),
        );
      });

      test('mock response URL contains expected parameters', () {
        final mockResponse = JsonRpcResponse.fromJson(
          getExchangeUrlMockResponse,
        );
        final url = mockResponse.result['url'] as String;

        expect(url, contains('asset=eip155:84532/slip44:60'));
        expect(url, contains('amount=0.00001'));
        expect(
          url,
          contains('recipient=0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340'),
        );
        expect(url, contains('sessionId='));
        expect(url, contains('projectId='));
      });
    });

    group('getExchangeDepositStatus', () {
      test('mock response has correct structure', () {
        // Verify the mock response structure
        final mockResponse = JsonRpcResponse.fromJson(
          getExchangeBuyStatusMockResponse,
        );

        expect(mockResponse.result, isA<Map>());
        expect(mockResponse.result['status'], isA<String>());
        expect(mockResponse.result['status'], 'UNKNOWN');
        expect(mockResponse.result['txHash'], isNull);
      });

      test('mock response handles different status values', () {
        // Test UNKNOWN status
        final unknownResponse = JsonRpcResponse.fromJson(
          getExchangeBuyStatusMockResponse,
        );
        expect(unknownResponse.result['status'], 'UNKNOWN');

        // Test IN_PROGRESS status
        final inProgressResponse = JsonRpcResponse.fromJson({
          'id': 1,
          'jsonrpc': '2.0',
          'result': {'status': 'IN_PROGRESS', 'txHash': null},
        });
        expect(inProgressResponse.result['status'], 'IN_PROGRESS');

        // Test SUCCESS status with txHash
        final successResponse = JsonRpcResponse.fromJson({
          'id': 1,
          'jsonrpc': '2.0',
          'result': {'status': 'SUCCESS', 'txHash': '0x1234567890abcdef'},
        });
        expect(successResponse.result['status'], 'SUCCESS');
        expect(successResponse.result['txHash'], '0x1234567890abcdef');

        // Test FAILED status
        final failedResponse = JsonRpcResponse.fromJson({
          'id': 1,
          'jsonrpc': '2.0',
          'result': {'status': 'FAILED', 'txHash': null},
        });
        expect(failedResponse.result['status'], 'FAILED');
      });
    });

    group('Mock Response Validation', () {
      test('getExchangesMockResponse has valid JSON structure', () {
        expect(
          () => JsonRpcResponse.fromJson(getExchangesMockResponse),
          returnsNormally,
        );
      });

      test('getExchangeUrlMockResponse has valid JSON structure', () {
        expect(
          () => JsonRpcResponse.fromJson(getExchangeUrlMockResponse),
          returnsNormally,
        );
      });

      test('getExchangeBuyStatusMockResponse has valid JSON structure', () {
        expect(
          () => JsonRpcResponse.fromJson(getExchangeBuyStatusMockResponse),
          returnsNormally,
        );
      });

      test('all mock responses have correct jsonrpc version', () {
        expect(getExchangesMockResponse['jsonrpc'], '2.0');
        expect(getExchangeUrlMockResponse['jsonrpc'], '2.0');
        expect(getExchangeBuyStatusMockResponse['jsonrpc'], '2.0');
      });

      test('all mock responses have result field', () {
        expect(getExchangesMockResponse.containsKey('result'), true);
        expect(getExchangeUrlMockResponse.containsKey('result'), true);
        expect(getExchangeBuyStatusMockResponse.containsKey('result'), true);
      });
    });
  });
}
