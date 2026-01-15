import 'package:flutter_test/flutter_test.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_results.dart';

void main() {
  group('GetQuoteStatusResult', () {
    test('creates instance correctly', () {
      final result = GetQuoteStatusResult(status: QuoteStatus.success);

      expect(result.status, QuoteStatus.success);
    });

    test('serializes to JSON correctly', () {
      final result = GetQuoteStatusResult(status: QuoteStatus.pending);

      final json = result.toJson();
      expect(json['status'], 'pending');
    });

    test('deserializes from JSON correctly', () {
      final json = {'status': 'success'};

      final result = GetQuoteStatusResult.fromJson(json);
      expect(result.status, QuoteStatus.success);
    });

    test('handles all status types', () {
      final statuses = [
        QuoteStatus.waiting,
        QuoteStatus.pending,
        QuoteStatus.success,
        QuoteStatus.submitted,
        QuoteStatus.failure,
        QuoteStatus.refund,
        QuoteStatus.timeout,
      ];

      for (final status in statuses) {
        final result = GetQuoteStatusResult(status: status);
        expect(result.status, status);
      }
    });
  });

  group('GetExchangeAssetsResult', () {
    test('creates instance correctly', () {
      final result = GetExchangeAssetsResult(
        exchangeId: 'binance',
        assets: {
          'eip155:1': [ethereumETH, ethereumUSDC],
          'eip155:137': [polygonUSDC],
        },
      );

      expect(result.exchangeId, 'binance');
      expect(result.assets.length, 2);
      expect(result.assets['eip155:1']?.length, 2);
      expect(result.assets['eip155:137']?.length, 1);
    });

    test('serializes to JSON correctly', () {
      final result = GetExchangeAssetsResult(
        exchangeId: 'binance',
        assets: {
          'eip155:1': [ethereumETH],
        },
      );

      final json = result.toJson();
      expect(json['exchangeId'], 'binance');
      expect(json['assets'], isA<Map>());
      expect(json['assets']['eip155:1'], isA<List>());
    });

    test('deserializes from JSON correctly', () {
      final json = {
        'exchangeId': 'binance',
        'assets': {
          'eip155:1': [
            {
              'network': 'eip155:1',
              'asset': 'native',
              'metadata': {'name': 'Ethereum', 'symbol': 'ETH', 'decimals': 18},
            },
          ],
        },
      };

      final result = GetExchangeAssetsResult.fromJson(json);
      expect(result.exchangeId, 'binance');
      expect(result.assets['eip155:1']?.length, 1);
      expect(result.assets['eip155:1']?.first.metadata.symbol, 'ETH');
    });

    test('handles empty assets map', () {
      final result = GetExchangeAssetsResult(
        exchangeId: 'coinbase',
        assets: {},
      );

      expect(result.assets.isEmpty, true);
    });
  });

  group('GetQuoteResult (Quote)', () {
    test('creates quote instance correctly', () {
      final quote = Quote(
        type: QuoteType.directTransfer,
        origin: QuoteAmount(
          amount: '1000000000000000000',
          currency: ethereumETH,
        ),
        destination: QuoteAmount(amount: '1000000000', currency: solanaSOL),
        steps: [
          QuoteStep.deposit(
            requestId: 'test-id',
            deposit: QuoteDeposit(
              amount: '1000000000000000000',
              currency: 'native',
              receiver: '0x123',
            ),
          ),
        ],
        fees: [
          QuoteFee(
            id: 'service',
            label: 'Service Fee',
            amount: '0',
            currency: solanaSOL,
          ),
        ],
        timeInSeconds: 60,
      );

      expect(quote.type, QuoteType.directTransfer);
      expect(quote.origin.currency, ethereumETH);
      expect(quote.destination.currency, solanaSOL);
      expect(quote.steps.length, 1);
      expect(quote.fees.length, 1);
      expect(quote.timeInSeconds, 60);
    });

    test('serializes to JSON correctly', () {
      final quote = Quote(
        type: QuoteType.directTransfer,
        origin: QuoteAmount(
          amount: '1000000000000000000',
          currency: ethereumETH,
        ),
        destination: QuoteAmount(amount: '1000000000', currency: solanaSOL),
        steps: [],
        fees: [],
        timeInSeconds: 60,
      );

      final json = quote.toJson();
      expect(json['type'], 'direct-transfer');
      expect(json['timeInSeconds'], 60);
      expect(json['origin'], isA<Map>());
      expect(json['destination'], isA<Map>());
    });

    test('deserializes from JSON correctly', () {
      final json = {
        'type': 'direct-transfer',
        'origin': {
          'amount': '1000000000000000000',
          'currency': {
            'network': 'eip155:1',
            'asset': 'native',
            'metadata': {'name': 'Ethereum', 'symbol': 'ETH', 'decimals': 18},
          },
        },
        'destination': {
          'amount': '1000000000',
          'currency': {
            'network': 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
            'asset': 'native',
            'metadata': {'name': 'Solana', 'symbol': 'SOL', 'decimals': 9},
          },
        },
        'steps': [
          {
            'type': 'deposit',
            'requestId': 'test-id',
            'deposit': {
              'amount': '1000000000000000000',
              'currency': 'native',
              'receiver': '0x123',
            },
          },
        ],
        'fees': [
          {
            'id': 'service',
            'label': 'Service Fee',
            'amount': '0',
            'currency': {
              'network': 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
              'asset': 'native',
              'metadata': {'name': 'Solana', 'symbol': 'SOL', 'decimals': 9},
            },
          },
        ],
        'timeInSeconds': 60,
      };

      final quote = Quote.fromJson(json);
      expect(quote.type, QuoteType.directTransfer);
      expect(quote.origin.currency.metadata.symbol, 'ETH');
      expect(quote.destination.currency.metadata.symbol, 'SOL');
      expect(quote.steps.length, 1);
      expect(quote.fees.length, 1);
      expect(quote.timeInSeconds, 60);
    });
  });
}
