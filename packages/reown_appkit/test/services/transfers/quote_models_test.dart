import 'package:flutter_test/flutter_test.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';

void main() {
  group('QuoteStatus', () {
    group('fromStatus', () {
      test('converts "waiting" correctly', () {
        expect(QuoteStatus.fromStatus('waiting'), QuoteStatus.waiting);
      });

      test('converts "pending" correctly', () {
        expect(QuoteStatus.fromStatus('pending'), QuoteStatus.pending);
      });

      test('converts "success" correctly', () {
        expect(QuoteStatus.fromStatus('success'), QuoteStatus.success);
      });

      test('converts "submitted" correctly', () {
        expect(QuoteStatus.fromStatus('submitted'), QuoteStatus.submitted);
      });

      test('converts "failure" correctly', () {
        expect(QuoteStatus.fromStatus('failure'), QuoteStatus.failure);
      });

      test('converts "refund" correctly', () {
        expect(QuoteStatus.fromStatus('refund'), QuoteStatus.refund);
      });

      test('converts "timeout" correctly', () {
        expect(QuoteStatus.fromStatus('timeout'), QuoteStatus.timeout);
      });

      test('converts "in_progress" to waiting', () {
        expect(QuoteStatus.fromStatus('in_progress'), QuoteStatus.waiting);
      });

      test('converts "unknown" to waiting', () {
        expect(QuoteStatus.fromStatus('unknown'), QuoteStatus.waiting);
      });

      test('converts "failed" to failure', () {
        expect(QuoteStatus.fromStatus('failed'), QuoteStatus.failure);
      });

      test('handles case insensitive input', () {
        expect(QuoteStatus.fromStatus('WAITING'), QuoteStatus.waiting);
        expect(QuoteStatus.fromStatus('PENDING'), QuoteStatus.pending);
        expect(QuoteStatus.fromStatus('SUCCESS'), QuoteStatus.success);
      });

      test('defaults to waiting for unknown status', () {
        expect(QuoteStatus.fromStatus('unknown_status'), QuoteStatus.waiting);
      });
    });

    group('isError', () {
      test('returns true for failure', () {
        expect(QuoteStatus.failure.isError, true);
      });

      test('returns true for refund', () {
        expect(QuoteStatus.refund.isError, true);
      });

      test('returns true for timeout', () {
        expect(QuoteStatus.timeout.isError, true);
      });

      test('returns false for success', () {
        expect(QuoteStatus.success.isError, false);
      });

      test('returns false for submitted', () {
        expect(QuoteStatus.submitted.isError, false);
      });

      test('returns false for waiting', () {
        expect(QuoteStatus.waiting.isError, false);
      });

      test('returns false for pending', () {
        expect(QuoteStatus.pending.isError, false);
      });
    });

    group('isSuccess', () {
      test('returns true for success', () {
        expect(QuoteStatus.success.isSuccess, true);
      });

      test('returns true for submitted', () {
        expect(QuoteStatus.submitted.isSuccess, true);
      });

      test('returns false for failure', () {
        expect(QuoteStatus.failure.isSuccess, false);
      });

      test('returns false for waiting', () {
        expect(QuoteStatus.waiting.isSuccess, false);
      });

      test('returns false for pending', () {
        expect(QuoteStatus.pending.isSuccess, false);
      });
    });
  });

  group('QuoteFeeExtension', () {
    test('formats fee correctly', () {
      final fee = QuoteFee(
        id: 'service',
        label: 'Service Fee',
        amount: '1000000000000000000', // 1 ETH with 18 decimals
        currency: ethereumETH,
      );

      final formatted = fee.formattedFee;
      expect(formatted, contains('ETH'));
      expect(formatted, contains('1'));
    });

    test('formats small fee correctly', () {
      final fee = QuoteFee(
        id: 'service',
        label: 'Service Fee',
        amount: '1000000', // 1 USDC with 6 decimals
        currency: ethereumUSDC,
      );

      final formatted = fee.formattedFee;
      expect(formatted, contains('USDC'));
      expect(formatted, contains('1'));
    });
  });

  group('QuoteExtension', () {
    test('formats amount with symbol', () {
      final quote = Quote(
        type: QuoteType.directTransfer,
        origin: QuoteAmount(
          amount: '1000000000000000000', // 1 ETH
          currency: ethereumETH,
        ),
        destination: QuoteAmount(
          amount: '1000000000000000000',
          currency: ethereumETH,
        ),
        steps: [],
        fees: [],
        timeInSeconds: 60,
      );

      final formatted = quote.formattedAmount(withSymbol: true);
      expect(formatted, contains('ETH'));
      expect(formatted, contains('1'));
    });

    test('formats amount without symbol', () {
      final quote = Quote(
        type: QuoteType.directTransfer,
        origin: QuoteAmount(
          amount: '1000000000000000000', // 1 ETH
          currency: ethereumETH,
        ),
        destination: QuoteAmount(
          amount: '1000000000000000000',
          currency: ethereumETH,
        ),
        steps: [],
        fees: [],
        timeInSeconds: 60,
      );

      final formatted = quote.formattedAmount(withSymbol: false);
      expect(formatted, isNot(contains('ETH')));
      expect(formatted, contains('1'));
    });

    test('handles null quote', () {
      const Quote? quote = null;
      final formatted = quote.formattedAmount();
      // When quote is null, it uses 0 decimals and formats to 6 decimal places
      expect(formatted, '0.000000');
    });
  });

  group('QuoteStepExtension', () {
    test('identifies deposit step correctly', () {
      final step = QuoteStep.deposit(
        requestId: 'test-id',
        deposit: QuoteDeposit(
          amount: '1000000000000000000',
          currency: 'native',
          receiver: '0x123',
        ),
      );

      expect(step.isDeposit, true);
      expect(step.isTransaction, false);
    });

    test('identifies transaction step correctly', () {
      final step = QuoteStep.transaction(
        requestId: 'test-id',
        transaction: {'type': 'transfer'},
      );

      expect(step.isDeposit, false);
      expect(step.isTransaction, true);
    });
  });
}
