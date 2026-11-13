import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reown_core/relay_client/relay_client.dart';
import 'package:reown_core/relay_client/websocket/websocket_handler.dart';
import 'package:reown_core/reown_core.dart';

import 'shared/shared_test_utils.dart';
import 'shared/shared_test_utils.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  group('WebSocketHandler', () {
    late ServerSocket server;
    final accepted = <Socket>[];

    tearDown(() async {
      for (final socket in accepted) {
        socket.destroy();
      }
      accepted.clear();
      await server.close();
    });

    test('connect times out when the handshake never completes', () async {
      // Accepts TCP connections but never answers the WebSocket handshake,
      // like a network that silently drops packets.
      server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      server.listen(accepted.add);

      final handler = WebSocketHandler(
        connectTimeout: const Duration(milliseconds: 300),
        closeTimeout: const Duration(milliseconds: 300),
      );
      await handler.setup(url: 'ws://127.0.0.1:${server.port}/?a=b');

      final stopwatch = Stopwatch()..start();
      await expectLater(handler.connect(), throwsA(isA<ReownCoreError>()));
      expect(stopwatch.elapsed, lessThan(const Duration(seconds: 3)));
      expect(handler.channel, isNull);

      // Closing again must not hang either
      await handler.close().timeout(const Duration(seconds: 2));
    });

    test('close completes after a failed connection attempt', () async {
      // Closes every connection immediately: the handshake fails.
      server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      server.listen((socket) => socket.destroy());

      final handler = WebSocketHandler(
        connectTimeout: const Duration(seconds: 5),
        closeTimeout: const Duration(milliseconds: 300),
      );
      await handler.setup(url: 'ws://127.0.0.1:${server.port}/?a=b');

      await expectLater(
        handler.connect().timeout(const Duration(seconds: 3)),
        throwsA(isA<ReownCoreError>()),
      );

      // A new attempt (setup closes the previous socket) must not hang
      await handler
          .setup(url: 'ws://127.0.0.1:${server.port}/?a=b')
          .timeout(const Duration(seconds: 2));
      await handler.close().timeout(const Duration(seconds: 2));
    });
  });

  group('RelayClient reconnection', () {
    late IReownCore core;
    late MockWebSocketHandler socketHandler;

    setUp(() async {
      socketHandler = MockWebSocketHandler();
      when(socketHandler.setup(url: anyNamed('url'))).thenAnswer((_) async {});
      when(socketHandler.close()).thenAnswer((_) async {});
      when(socketHandler.connect()).thenThrow(
        const ReownCoreError(code: -1, message: 'No internet connection'),
      );

      core = ReownCore(projectId: 'abc', memoryStore: true);
      core.relayClient = RelayClient(
        core: core,
        messageTracker: getMessageTracker(core: core),
        topicMap: getTopicMap(core: core),
        socketHandler: socketHandler,
      );
      await core.storage.init();
      await core.crypto.init();
      // The first connection attempt fails
      await core.relayClient.init();
      verify(socketHandler.connect()).called(1);
    });

    test('concurrent connect calls share one connection attempt', () async {
      final pending = Completer<void>();
      when(socketHandler.connect()).thenAnswer((_) => pending.future);

      final first = core.relayClient.connect();
      final second = core.relayClient.connect();
      await pumpEventQueue();

      verify(socketHandler.connect()).called(1);

      pending.completeError(
        const ReownCoreError(code: -1, message: 'No internet connection'),
      );
      await Future.wait([first, second]).timeout(const Duration(seconds: 2));
      expect(core.relayClient.isConnected, isFalse);
    });

    test('requests waiting on a failed connect get a uniform error', () async {
      final pending = Completer<void>();
      when(socketHandler.connect()).thenAnswer((_) => pending.future);

      final errors = <Object>[];
      core.relayClient.onRelayClientError.subscribe((args) {
        errors.add(args.error);
      });

      final connecting = core.relayClient.connect();
      await pumpEventQueue();
      final publishing = core.relayClient.publish(
        topic: 'abc',
        message: 'msg',
        options: const PublishOptions(ttl: 300, tag: 1),
      );
      await pumpEventQueue();

      pending.completeError(TimeoutException('handshake'));
      await Future.wait([
        connecting,
        publishing,
      ]).timeout(const Duration(seconds: 2));

      expect(
        errors,
        contains(
          isA<ReownCoreError>().having(
            (e) => e.message,
            'message',
            'Relay is not connected',
          ),
        ),
      );
    });

    test('heartbeat retries the connection after a failed attempt', () async {
      core.heartbeat.onPulse.broadcast();
      await pumpEventQueue();
      verify(socketHandler.connect()).called(1);

      core.heartbeat.onPulse.broadcast();
      await pumpEventQueue();
      verify(socketHandler.connect()).called(1);
    });

    test('heartbeat does not reconnect after a manual disconnect', () async {
      await core.relayClient.disconnect();

      core.heartbeat.onPulse.broadcast();
      await pumpEventQueue();
      verifyNever(socketHandler.connect());
    });
  });
}
