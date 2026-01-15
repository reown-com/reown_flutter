import 'package:flutter_test/flutter_test.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_params.dart';

void main() {
  group('GetQuoteParams', () {
    test('creates instance correctly', () {
      final params = GetQuoteParams(
        sourceToken: ethereumETH,
        toToken: solanaSOL,
        recipient: '0x1234567890123456789012345678901234567890',
        amount: '1.0',
        address: '0x9876543210987654321098765432109876543210',
      );

      expect(params.sourceToken, ethereumETH);
      expect(params.toToken, solanaSOL);
      expect(params.recipient, '0x1234567890123456789012345678901234567890');
      expect(params.amount, '1.0');
      expect(params.address, '0x9876543210987654321098765432109876543210');
    });

    test('creates instance without optional address', () {
      final params = GetQuoteParams(
        sourceToken: ethereumETH,
        toToken: ethereumUSDC,
        recipient: '0x1234567890123456789012345678901234567890',
        amount: '100.0',
      );

      expect(params.address, isNull);
    });

    test('serializes to JSON correctly', () {
      final params = GetQuoteParams(
        sourceToken: ethereumETH,
        toToken: ethereumUSDC,
        recipient: '0x1234567890123456789012345678901234567890',
        amount: '1.0',
        address: '0x9876543210987654321098765432109876543210',
      );

      final json = params.toJson();
      expect(json['sourceToken'], isNotNull);
      expect(json['toToken'], isNotNull);
      expect(json['recipient'], '0x1234567890123456789012345678901234567890');
      expect(json['amount'], '1.0');
      expect(json['address'], '0x9876543210987654321098765432109876543210');
    });

    test('deserializes from JSON correctly', () {
      final json = {
        'sourceToken': {
          'network': 'eip155:1',
          'asset': 'native',
          'metadata': {'name': 'Ethereum', 'symbol': 'ETH', 'decimals': 18},
        },
        'toToken': {
          'network': 'eip155:1',
          'asset': '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
          'metadata': {'name': 'USD Coin', 'symbol': 'USDC', 'decimals': 6},
        },
        'recipient': '0x1234567890123456789012345678901234567890',
        'amount': '1.0',
        'address': '0x9876543210987654321098765432109876543210',
      };

      final params = GetQuoteParams.fromJson(json);
      expect(params.sourceToken.network, 'eip155:1');
      expect(params.toToken.metadata.symbol, 'USDC');
      expect(params.recipient, '0x1234567890123456789012345678901234567890');
      expect(params.amount, '1.0');
      expect(params.address, '0x9876543210987654321098765432109876543210');
    });
  });

  group('GetTransfersQuoteParams', () {
    test('creates instance correctly', () {
      final params = GetTransfersQuoteParams(
        user: '0x1234567890123456789012345678901234567890',
        originChainId: '1',
        originCurrency: 'native',
        destinationChainId: '137',
        destinationCurrency: '0x2791bca1f2de4661ed88a30c99a7a9449aa84174',
        recipient: '0x9876543210987654321098765432109876543210',
        amount: '1000000000000000000',
      );

      expect(params.user, '0x1234567890123456789012345678901234567890');
      expect(params.originChainId, '1');
      expect(params.originCurrency, 'native');
      expect(params.destinationChainId, '137');
      expect(
        params.destinationCurrency,
        '0x2791bca1f2de4661ed88a30c99a7a9449aa84174',
      );
      expect(params.recipient, '0x9876543210987654321098765432109876543210');
      expect(params.amount, '1000000000000000000');
    });

    test('creates instance without optional user', () {
      final params = GetTransfersQuoteParams(
        originChainId: '1',
        originCurrency: 'native',
        destinationChainId: '137',
        destinationCurrency: '0x2791bca1f2de4661ed88a30c99a7a9449aa84174',
        recipient: '0x9876543210987654321098765432109876543210',
        amount: '1000000000000000000',
      );

      expect(params.user, isNull);
    });

    test('serializes to JSON correctly', () {
      final params = GetTransfersQuoteParams(
        user: '0x1234567890123456789012345678901234567890',
        originChainId: '1',
        originCurrency: 'native',
        destinationChainId: '137',
        destinationCurrency: '0x2791bca1f2de4661ed88a30c99a7a9449aa84174',
        recipient: '0x9876543210987654321098765432109876543210',
        amount: '1000000000000000000',
      );

      final json = params.toJson();
      expect(json['user'], '0x1234567890123456789012345678901234567890');
      expect(json['originChainId'], '1');
      expect(json['originCurrency'], 'native');
      expect(json['destinationChainId'], '137');
      expect(
        json['destinationCurrency'],
        '0x2791bca1f2de4661ed88a30c99a7a9449aa84174',
      );
      expect(json['recipient'], '0x9876543210987654321098765432109876543210');
      expect(json['amount'], '1000000000000000000');
    });

    test('excludes null user from JSON', () {
      final params = GetTransfersQuoteParams(
        originChainId: '1',
        originCurrency: 'native',
        destinationChainId: '137',
        destinationCurrency: '0x2791bca1f2de4661ed88a30c99a7a9449aa84174',
        recipient: '0x9876543210987654321098765432109876543210',
        amount: '1000000000000000000',
      );

      final json = params.toJson();
      expect(json.containsKey('user'), false);
    });
  });

  group('GetQuoteStatusParams', () {
    test('creates instance correctly', () {
      final params = GetQuoteStatusParams(requestId: 'test-request-id-123');

      expect(params.requestId, 'test-request-id-123');
    });

    test('serializes to JSON correctly', () {
      final params = GetQuoteStatusParams(requestId: 'test-request-id-123');

      final json = params.toJson();
      expect(json['requestId'], 'test-request-id-123');
    });

    test('deserializes from JSON correctly', () {
      final json = {'requestId': 'test-request-id-123'};

      final params = GetQuoteStatusParams.fromJson(json);
      expect(params.requestId, 'test-request-id-123');
    });
  });
}
