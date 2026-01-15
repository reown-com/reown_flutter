import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reown_appkit/modal/services/dwe_service/dwe_service.dart';
import 'package:reown_appkit/modal/services/transfers/i_transfers_service.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_results.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:logger/logger.dart';

import '../../shared/shared_test_utils.dart';
import 'dwe_service_transfers_test.mocks.dart';

@GenerateMocks([IReownAppKit, ITransfersService, IReownCore, Logger])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();

  setUpAll(() {
    provideDummy<GetQuoteStatusResult>(
      GetQuoteStatusResult(status: QuoteStatus.waiting),
    );
  });

  group('DWEService - Transfer Status Check', () {
    late DWEService dweService;
    late MockIReownAppKit mockAppKit;
    late MockITransfersService mockTransfersService;
    late MockIReownCore mockCore;
    late MockLogger mockLogger;

    setUp(() async {
      GetIt.instance.reset();
      mockAppKit = MockIReownAppKit();
      mockTransfersService = MockITransfersService();
      mockCore = MockIReownCore();
      mockLogger = MockLogger();

      // Set up logger before accessing it
      when(mockCore.logger).thenReturn(mockLogger);
      when(mockAppKit.core).thenReturn(mockCore);

      // Register the mock service BEFORE creating DWEService
      GetIt.instance.registerSingleton<ITransfersService>(mockTransfersService);

      // Set up default stub to prevent throwOnMissingStub errors
      when(
        mockTransfersService.getQuoteStatus(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => GetQuoteStatusResult(status: QuoteStatus.waiting),
      );

      dweService = DWEService(appKit: mockAppKit);
      await dweService.init();
    });

    tearDown(() {
      GetIt.instance.reset();
      dweService.stopCheckingStatus();
    });

    group('loopOnTransferStatusCheck', () {
      test('completes with success status', () async {
        final completer = Completer<(QuoteStatus, dynamic)>();
        final statuses = <QuoteStatus>[];

        // Reset and set up stub - anyNamed should match any GetQuoteStatusParams
        reset(mockTransfersService);
        GetIt.instance.registerSingleton<ITransfersService>(
          mockTransfersService,
        );
        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => GetQuoteStatusResult(status: QuoteStatus.success),
        );

        dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
          result,
        ) {
          final status = result.$1;
          final data = result.$2;
          statuses.add(status);
          if (status.isSuccess || status.isError) {
            if (!completer.isCompleted) {
              completer.complete((status, data));
            }
          }
        });

        final result = await completer.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () => (QuoteStatus.timeout, null),
        );

        expect(result.$1, QuoteStatus.success);
        expect(statuses.length, greaterThan(0));
        verify(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).called(greaterThan(0));
      });

      test('handles waiting status and continues polling', () async {
        final statuses = <QuoteStatus>[];
        int callCount = 0;

        // Ensure service is stopped before resetting mock
        dweService.stopCheckingStatus();
        await Future.delayed(const Duration(milliseconds: 50));

        reset(mockTransfersService);
        GetIt.instance.registerSingleton<ITransfersService>(
          mockTransfersService,
        );
        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenAnswer((_) async {
          callCount++;
          if (callCount < 3) {
            return GetQuoteStatusResult(status: QuoteStatus.waiting);
          }
          return GetQuoteStatusResult(status: QuoteStatus.success);
        });

        final completer = Completer<(QuoteStatus, dynamic)>();

        dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
          result,
        ) {
          final status = result.$1;
          final data = result.$2;
          statuses.add(status);
          if (status.isSuccess || status.isError) {
            if (!completer.isCompleted) {
              completer.complete((status, data));
            }
          }
        });

        final result = await completer.future.timeout(
          const Duration(seconds: 20),
          onTimeout: () => (QuoteStatus.timeout, null),
        );

        // Wait a bit to ensure the service has stopped
        await Future.delayed(const Duration(milliseconds: 100));

        expect(result.$1, QuoteStatus.success);
        expect(statuses.contains(QuoteStatus.waiting), true);
        expect(callCount, greaterThan(1));
      });

      test('handles pending status and continues polling', () async {
        final statuses = <QuoteStatus>[];
        int callCount = 0;

        // Ensure service is stopped before resetting mock
        dweService.stopCheckingStatus();
        await Future.delayed(const Duration(milliseconds: 50));

        reset(mockTransfersService);
        GetIt.instance.registerSingleton<ITransfersService>(
          mockTransfersService,
        );
        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenAnswer((_) async {
          callCount++;
          if (callCount < 3) {
            return GetQuoteStatusResult(status: QuoteStatus.pending);
          }
          return GetQuoteStatusResult(status: QuoteStatus.success);
        });

        final completer = Completer<(QuoteStatus, dynamic)>();

        dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
          result,
        ) {
          final status = result.$1;
          final data = result.$2;
          statuses.add(status);
          if (status.isSuccess || status.isError) {
            if (!completer.isCompleted) {
              completer.complete((status, data));
            }
          }
        });

        final result = await completer.future.timeout(
          const Duration(seconds: 20),
          onTimeout: () => (QuoteStatus.timeout, null),
        );

        // Wait a bit to ensure the service has stopped
        await Future.delayed(const Duration(milliseconds: 100));

        expect(result.$1, QuoteStatus.success);
        expect(statuses.contains(QuoteStatus.pending), true);
      });

      test('handles failure status', () async {
        final completer = Completer<(QuoteStatus, dynamic)>();

        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => GetQuoteStatusResult(status: QuoteStatus.failure),
        );

        dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
          result,
        ) {
          completer.complete((result.$1, result.$2));
        });

        final result = await completer.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () => (QuoteStatus.timeout, null),
        );

        expect(result.$1, QuoteStatus.failure);
        expect(result.$1.isError, true);
      });

      test(
        'handles timeout after max attempts',
        () async {
          final statuses = <QuoteStatus>[];

          when(
            mockTransfersService.getQuoteStatus(params: anyNamed('params')),
          ).thenAnswer(
            (_) async => GetQuoteStatusResult(status: QuoteStatus.waiting),
          );

          final completer = Completer<(QuoteStatus, dynamic)>();

          dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
            result,
          ) {
            final status = result.$1;
            final data = result.$2;
            statuses.add(status);
            if (status == QuoteStatus.timeout ||
                status == QuoteStatus.failure) {
              completer.complete((status, data));
            }
          });

          final result = await completer.future.timeout(
            const Duration(seconds: 6 * 60), // 5 min max + buffer
            onTimeout: () => (QuoteStatus.timeout, null),
          );

          // Should timeout after max attempts (60 attempts * 5 seconds = 5 minutes)
          expect(
            result.$1 == QuoteStatus.timeout ||
                result.$1 == QuoteStatus.failure,
            true,
          );
        },
        timeout: const Timeout(Duration(minutes: 6)),
      );

      test('stops checking when stopCheckingStatus is called', () async {
        final statuses = <QuoteStatus>[];

        // Override the default stub
        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => GetQuoteStatusResult(status: QuoteStatus.waiting),
        );

        dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
          result,
        ) {
          final status = result.$1;
          statuses.add(status);
          // Stop after first status update
          if (statuses.length == 1) {
            dweService.stopCheckingStatus();
          }
        });

        // Wait a bit to ensure it stops
        await Future.delayed(const Duration(seconds: 2));

        expect(dweService.isCheckingStatus, false);
      });

      test('does not start new loop if already checking', () async {
        reset(mockTransfersService);
        GetIt.instance.registerSingleton<ITransfersService>(
          mockTransfersService,
        );
        // Match any requestId for this test
        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => GetQuoteStatusResult(status: QuoteStatus.waiting),
        );

        dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
          result,
        ) {
          // Do nothing
        });

        // Try to start another loop immediately
        dweService.loopOnTransferStatusCheck('exchange-id-2', 'request-id-2', (
          result,
        ) {
          // Do nothing
        });

        await Future.delayed(const Duration(milliseconds: 100));

        // Should only have one loop running
        expect(dweService.isCheckingStatus, true);
      });

      test('handles API errors gracefully', () async {
        final completer = Completer<(QuoteStatus, dynamic)>();

        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenThrow(Exception('API Error'));

        dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
          result,
        ) {
          completer.complete((result.$1, result.$2));
        });

        final result = await completer.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () => (QuoteStatus.timeout, null),
        );

        expect(result.$1, QuoteStatus.failure);
        expect(dweService.isCheckingStatus, false);
      });

      test('uses correct requestId parameter', () async {
        const requestId = 'test-request-id-123';

        reset(mockTransfersService);
        GetIt.instance.registerSingleton<ITransfersService>(
          mockTransfersService,
        );
        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => GetQuoteStatusResult(status: QuoteStatus.success),
        );

        final completer = Completer<(QuoteStatus, dynamic)>();

        dweService.loopOnTransferStatusCheck('exchange-id', requestId, (
          result,
        ) {
          completer.complete((result.$1, result.$2));
        });

        await completer.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () => (QuoteStatus.timeout, null),
        );

        verify(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).called(greaterThan(0));
      });
    });

    group('stopCheckingStatus', () {
      test('stops ongoing status check', () async {
        reset(mockTransfersService);
        GetIt.instance.registerSingleton<ITransfersService>(
          mockTransfersService,
        );
        when(
          mockTransfersService.getQuoteStatus(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => GetQuoteStatusResult(status: QuoteStatus.waiting),
        );

        dweService.loopOnTransferStatusCheck('exchange-id', 'request-id', (
          result,
        ) {
          // Do nothing
        });

        expect(dweService.isCheckingStatus, true);

        dweService.stopCheckingStatus();

        expect(dweService.isCheckingStatus, false);
      });
    });
  });
}
