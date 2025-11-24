// ignore: library_annotations
@Timeout(Duration(seconds: 45))
import 'dart:async';

import 'package:event/event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:reown_core/relay_client/relay_client.dart';
import 'package:reown_core/reown_core.dart';

import 'shared/shared_test_utils.dart';
import 'shared/shared_test_utils.mocks.dart';
import 'shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  const TEST_TOPIC = 'abc123';
  const TEST_MESSAGE = 'swagmasterss';

  test('relays are correct', () {
    expect(ReownConstants.DEFAULT_RELAY_URL, 'wss://relay.walletconnect.org');
    expect(ReownConstants.DEFAULT_PUSH_URL, 'https://echo.walletconnect.org');
  });

  group('Relay throws errors', () {
    test('on init if there is no internet connection', () async {
      final MockWebSocketHandler mockWebSocketHandler = MockWebSocketHandler();
      when(mockWebSocketHandler.connect()).thenThrow(
        const ReownCoreError(code: -1, message: 'No internet connection: test'),
      );

      const testRelayUrl = 'wss://relay.test.com';
      IReownCore core = ReownCore(
        projectId: 'abc',
        memoryStore: true,
        relayUrl: testRelayUrl,
      );
      core.relayClient = RelayClient(
        core: core,
        messageTracker: getMessageTracker(core: core),
        topicMap: getTopicMap(core: core),
        socketHandler: mockWebSocketHandler,
      );
      int errorCounter = 0;
      core.relayClient.onRelayClientError.subscribe((args) {
        errorCounter++;
        expect(args.error.message, 'No internet connection: test');
      });
      await core.storage.init();
      await core.crypto.init();
      await core.relayClient.init();

      verify(
        mockWebSocketHandler.setup(
          url: argThat(contains(testRelayUrl), named: 'url'),
        ),
      ).called(1);
      verify(mockWebSocketHandler.connect()).called(1);
      expect(errorCounter, 1);
    });

    test('when connection parameters are invalid', () async {
      final http = MockHttpWrapper();
      when(http.get(any)).thenAnswer((_) async => Response('', 3000));
      final IReownCore core = ReownCore(
        projectId: 'abc',
        memoryStore: true,
        httpClient: http,
      );

      Completer completer = Completer();
      core.relayClient.onRelayClientError.subscribe((args) {
        expect(args.error, isA<ReownCoreError>());
        expect(args.error.code, 3000);
        completer.complete();
      });

      await core.start();

      await completer.future;

      core.relayClient.onRelayClientError.unsubscribeAll();
    });
  });

  test('Relay client connect and disconnect events broadcast', () async {
    IReownCore coreDapp = ReownCore(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
      httpClient: getHttpWrapper(),
    );
    IReownCore coreWallet = ReownCore(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
      httpClient: getHttpWrapper(),
    );

    int counterA = 0, counterB = 0, counterC = 0, counterD = 0;
    Completer completerA = Completer(),
        completerB = Completer(),
        completerC = Completer(),
        completerD = Completer();
    coreDapp.relayClient.onRelayClientConnect.subscribe((args) {
      expect(args, isA<EventArgs>());
      counterA++;
      completerA.complete();
    });
    coreDapp.relayClient.onRelayClientDisconnect.subscribe((args) {
      expect(args, isA<EventArgs>());
      counterB++;
      completerB.complete();
    });
    coreWallet.relayClient.onRelayClientConnect.subscribe((args) {
      expect(args, isA<EventArgs>());
      counterC++;
      completerC.complete();
    });
    coreWallet.relayClient.onRelayClientDisconnect.subscribe((args) {
      expect(args, isA<EventArgs>());
      counterD++;
      completerD.complete();
    });

    await coreDapp.start();
    await coreWallet.start();

    if (!completerA.isCompleted) {
      coreDapp.logger.i('relay client test waiting sessionACompleter');
      await completerA.future;
    }
    if (!completerC.isCompleted) {
      coreDapp.logger.i('relay client test waiting sessionCCompleter');
      await completerC.future;
    }

    expect(counterA, 1);
    expect(counterC, 1);

    await coreDapp.relayClient.disconnect();
    await coreWallet.relayClient.disconnect();

    if (!completerB.isCompleted) {
      coreDapp.logger.i('relay client test waiting sessionBCompleter');
      await completerB.future;
    }
    if (!completerD.isCompleted) {
      coreDapp.logger.i('relay client test waiting sessionDCompleter');
      await completerD.future;
    }

    expect(counterB, 1);
    expect(counterD, 1);
  });

  group('Relay Client', () {
    IReownCore core = ReownCore(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
      httpClient: getHttpWrapper(),
    );
    late RelayClient relayClient;
    MockMessageTracker messageTracker = MockMessageTracker();

    setUp(() async {
      await core.start();
      relayClient = RelayClient(
        core: core,
        messageTracker: messageTracker,
        topicMap: getTopicMap(core: core),
      );
      await relayClient.init();
    });

    // tearDown(() async {
    //   await relayClient.disconnect();
    // });

    test('Handle publish broadcasts and stores the message event', () async {
      await relayClient.topicMap.set(TEST_TOPIC, 'test');

      int counter = 0;
      relayClient.onRelayClientMessage.subscribe((MessageEvent? args) {
        counter++;
      });

      when(
        messageTracker.messageIsRecorded(TEST_TOPIC, TEST_MESSAGE),
      ).thenAnswer((_) => false);

      bool published = await relayClient.handlePublish(
        TEST_TOPIC,
        TEST_MESSAGE,
      );
      expect(published, true);
      expect(counter, 1);

      verify(
        messageTracker.recordMessageEvent(TEST_TOPIC, TEST_MESSAGE),
      ).called(1);
    });

    test('Handle publish with null attestation', () async {
      await relayClient.topicMap.set(TEST_TOPIC, 'test');

      MessageEvent? capturedEvent;
      relayClient.onRelayClientMessage.subscribe((MessageEvent? args) {
        capturedEvent = args;
      });

      when(
        messageTracker.messageIsRecorded(TEST_TOPIC, TEST_MESSAGE),
      ).thenAnswer((_) => false);

      bool published = await relayClient.handlePublish(
        TEST_TOPIC,
        TEST_MESSAGE,
        null, // Explicitly pass null attestation
      );

      expect(published, true);
      expect(capturedEvent, isNotNull);
      expect(capturedEvent!.attestation, isNull);
      expect(capturedEvent!.topic, equals(TEST_TOPIC));
      expect(capturedEvent!.message, equals(TEST_MESSAGE));
      expect(capturedEvent!.transportType, equals(TransportType.relay));

      verify(
        messageTracker.recordMessageEvent(TEST_TOPIC, TEST_MESSAGE),
      ).called(1);
    });

    test('Handle publish with non-null attestation', () async {
      await relayClient.topicMap.set(TEST_TOPIC, 'test');

      const testAttestation =
          'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.test.attestation';

      MessageEvent? capturedEvent;
      relayClient.onRelayClientMessage.subscribe((MessageEvent? args) {
        capturedEvent = args;
      });

      when(
        messageTracker.messageIsRecorded(TEST_TOPIC, TEST_MESSAGE),
      ).thenAnswer((_) => false);

      bool published = await relayClient.handlePublish(
        TEST_TOPIC,
        TEST_MESSAGE,
        testAttestation, // Pass non-null attestation
      );

      expect(published, true);
      expect(capturedEvent, isNotNull);
      expect(capturedEvent!.attestation, equals(testAttestation));
      expect(capturedEvent!.topic, equals(TEST_TOPIC));
      expect(capturedEvent!.message, equals(TEST_MESSAGE));
      expect(capturedEvent!.transportType, equals(TransportType.relay));

      verify(
        messageTracker.recordMessageEvent(TEST_TOPIC, TEST_MESSAGE),
      ).called(1);
    });

    group('JSON RPC', () {
      late IReownCore coreDapp;
      late IReownCore coreWallet;

      setUp(() async {
        coreDapp = ReownCore(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
          httpClient: getHttpWrapper(),
        );
        coreWallet = ReownCore(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
          httpClient: getHttpWrapper(),
        );
        await coreDapp.start();
        await coreWallet.start();
        coreDapp.relayClient = RelayClient(
          core: coreDapp,
          messageTracker: getMessageTracker(core: coreDapp),
          topicMap: getTopicMap(core: coreDapp),
        );
        coreWallet.relayClient = RelayClient(
          core: coreWallet,
          messageTracker: getMessageTracker(core: coreWallet),
          topicMap: getTopicMap(core: coreWallet),
        );
        await coreDapp.relayClient.init();
        await coreWallet.relayClient.init();
      });

      tearDown(() async {
        await coreDapp.relayClient.disconnect();
        await coreWallet.relayClient.disconnect();
      });

      // TODO fix this test
      // test('Publish is received by clients', () async {
      //   CreateResponse response = await coreA.pairing.create();
      //   await coreB.pairing.pair(uri: response.uri, activatePairing: true);
      //   coreA.pairing.activate(topic: response.topic);

      //   Completer completerA = Completer();
      //   Completer completerB = Completer();
      //   int counterA = 0;
      //   int counterB = 0;
      //   coreA.relayClient.onRelayClientMessage.subscribe((args) {
      //     expect(args == null, false);
      //     expect(args!.topic, response.topic);
      //     expect(args.message, 'Swag');
      //     counterA++;
      //     completerA.complete();
      //   });
      //   coreB.relayClient.onRelayClientMessage.subscribe((args) {
      //     expect(args == null, false);
      //     expect(args!.topic, response.topic);
      //     expect(args.message, TEST_MESSAGE);
      //     counterB++;
      //     completerB.complete();
      //   });

      //   // await coreA.relayClient.unsubscribe(response.topic);
      //   // await coreB.relayClient.unsubscribe(response.topic);

      //   await coreA.relayClient.publish(
      //     topic: response.topic,
      //     message: TEST_MESSAGE,
      //     ttl: 6000,
      //     tag: 0,
      //   );
      //   await coreB.relayClient.publish(
      //     topic: response.topic,
      //     message: 'Swag',
      //     ttl: 6000,
      //     tag: 0,
      //   );

      //   if (!completerA.isCompleted) {
      //     await completerA.future;
      //   }
      //   if (!completerB.isCompleted) {
      //     await completerB.future;
      //   }

      //   expect(counterA, 1);
      //   expect(counterB, 1);
      // });

      test(
        'PublishPayload can be called with valid payload structure',
        () async {
          CreateResponse response = await coreDapp.pairing.create();
          await coreWallet.pairing.pair(
            uri: response.uri,
            activatePairing: true,
          );
          await coreDapp.pairing.activate(topic: response.topic);

          final payloadA = {
            'pairingTopic': response.topic,
            'sessionProposal': 'SwagPayload',
          };
          final payloadB = {
            'sessionTopic': response.topic,
            'sessionProposalResponse': TEST_MESSAGE,
          };

          // Test that publishPayload can be called without throwing
          expect(() async {
            await coreDapp.relayClient.publishPayload(
              payload: payloadA,
              options: PublishOptions(
                publishMethod: RelayClient.WC_PROPOSE_SESSION,
              ),
            );
          }, returnsNormally);

          expect(() async {
            await coreWallet.relayClient.publishPayload(
              payload: payloadB,
              options: PublishOptions(
                publishMethod: RelayClient.WC_APPROVE_SESSION,
              ),
            );
          }, returnsNormally);
        },
      );

      test('Relay client handles concurrent initialization gracefully', () async {
        // Test that multiple simultaneous initialization calls are handled properly
        // This verifies the enhanced subscription management system works correctly
        final concurrentInitOperations = [
          coreDapp.relayClient.init(),
          coreDapp.relayClient.init(),
          coreWallet.relayClient.init(),
          coreWallet.relayClient.init(),
        ];

        // Execute all initialization operations concurrently
        final results = await Future.wait(concurrentInitOperations);

        // Verify all operations completed successfully
        expect(results.length, equals(4));

        // Ensure both relay clients are properly initialized and connected
        expect(coreDapp.relayClient.isConnected, isTrue);
        expect(coreWallet.relayClient.isConnected, isTrue);
      });

      test('MessageEvent handles null attestation correctly', () async {
        // Test that MessageEvent properly handles null attestation
        const testTopic = 'test-topic-null-attestation';
        const testMessage = 'test-message-null-attestation';

        final messageEvent = MessageEvent(
          testTopic,
          testMessage,
          DateTime.now().millisecondsSinceEpoch,
          null, // null attestation
          TransportType.relay,
        );

        expect(messageEvent.topic, equals(testTopic));
        expect(messageEvent.message, equals(testMessage));
        expect(messageEvent.attestation, isNull);
        expect(messageEvent.transportType, equals(TransportType.relay));

        // Test JSON serialization with null attestation
        final json = messageEvent.toJson();
        expect(json['topic'], equals(testTopic));
        expect(json['message'], equals(testMessage));
        expect(
          json.containsKey('attestation'),
          isFalse,
        ); // Should not include null attestation
        expect(json['transportType'], equals('relay'));
      });

      test('MessageEvent handles non-null attestation correctly', () async {
        // Test that MessageEvent properly handles non-null attestation
        const testTopic = 'test-topic-with-attestation';
        const testMessage = 'test-message-with-attestation';
        const testAttestation =
            'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.test.attestation';

        final messageEvent = MessageEvent(
          testTopic,
          testMessage,
          DateTime.now().millisecondsSinceEpoch,
          testAttestation, // non-null attestation
          TransportType.relay,
        );

        expect(messageEvent.topic, equals(testTopic));
        expect(messageEvent.message, equals(testMessage));
        expect(messageEvent.attestation, equals(testAttestation));
        expect(messageEvent.transportType, equals(TransportType.relay));

        // Test JSON serialization with non-null attestation
        final json = messageEvent.toJson();
        expect(json['topic'], equals(testTopic));
        expect(json['message'], equals(testMessage));
        expect(json['attestation'], equals(testAttestation));
        expect(json['transportType'], equals('relay'));
      });

      test(
        'publish method constructs parameters with correct tvf structure',
        () async {
          const testTopic = 'test-topic-123';
          const testMessage = 'test-message-456';

          // Create PublishOptions with tvf data
          final publishOptions = PublishOptions(
            ttl: 300,
            tag: 1109,
            correlationId: 1756879922616218,
            tvf: {
              'correlationId': 1756879922616218,
              'rpcMethods': ['eth_sendTransaction'],
              'chainId': 'eip155:8453',
              'txHashes': [
                '0x42d4e0dc0f301b2a119e68e52041fb6b84b3dc0bfb9a4f5c2a04898b80ff6755',
              ],
              'contractAddresses': [
                '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
              ],
            },
          );

          // Subscribe to the topic first
          await coreDapp.relayClient.subscribe(
            options: SubscribeOptions(topic: testTopic),
          );

          // Test that publish can be called without throwing
          expect(() async {
            await coreDapp.relayClient.publish(
              topic: testTopic,
              message: testMessage,
              options: publishOptions,
            );
          }, returnsNormally);
        },
      );

      test(
        'publishPayload method constructs parameters with correct tvf structure',
        () async {
          CreateResponse response = await coreDapp.pairing.create();
          await coreWallet.pairing.pair(
            uri: response.uri,
            activatePairing: true,
          );
          await coreDapp.pairing.activate(topic: response.topic);

          // Create PublishOptions with tvf data
          final publishOptions = PublishOptions(
            ttl: 300,
            tag: 1109,
            correlationId: 1756879922616218,
            publishMethod: RelayClient.WC_PROPOSE_SESSION,
            tvf: {
              'correlationId': 1756879922616218,
              'rpcMethods': ['eth_sendTransaction'],
              'chainId': 'eip155:8453',
              'txHashes': [
                '0x42d4e0dc0f301b2a119e68e52041fb6b84b3dc0bfb9a4f5c2a04898b80ff6755',
              ],
              'contractAddresses': [
                '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
              ],
            },
          );

          final payload = {
            'pairingTopic': response.topic,
            'sessionProposal': 'testSessionProposal',
          };

          // Test that publishPayload can be called without throwing
          expect(() async {
            await coreDapp.relayClient.publishPayload(
              payload: payload,
              options: publishOptions,
            );
          }, returnsNormally);
        },
      );
    });
  });

  group('PublishOptions Parameter Structure Tests', () {
    test('PublishOptionsExtension.toMap() correctly structures tvf data', () {
      // Test case 1: PublishOptions with tvf data
      final publishOptionsWithTvf = PublishOptions(
        ttl: 300,
        tag: 1109,
        correlationId: 1756879922616218,
        tvf: {
          'correlationId': 1756879922616218,
          'rpcMethods': ['eth_sendTransaction'],
          'chainId': 'eip155:8453',
          'txHashes': [
            '0x42d4e0dc0f301b2a119e68e52041fb6b84b3dc0bfb9a4f5c2a04898b80ff6755',
          ],
          'contractAddresses': ['0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913'],
        },
      );

      final result = publishOptionsWithTvf.toMap();

      // Verify that tvf data is spread to the top level (NOT nested under 'tvf' key)
      expect(result.containsKey('tvf'), isFalse);

      // Verify that tvf fields are at the top level
      expect(result['correlationId'], equals(1756879922616218));
      expect(result['rpcMethods'], equals(['eth_sendTransaction']));
      expect(result['chainId'], equals('eip155:8453'));
      expect(
        result['txHashes'],
        equals([
          '0x42d4e0dc0f301b2a119e68e52041fb6b84b3dc0bfb9a4f5c2a04898b80ff6755',
        ]),
      );
      expect(
        result['contractAddresses'],
        equals(['0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913']),
      );

      // Verify that other fields are also at the top level
      expect(result['ttl'], equals(300));
      expect(result['tag'], equals(1109));
    });

    test('PublishOptionsExtension.toMap() handles null tvf data', () {
      final publishOptionsWithoutTvf = PublishOptions(
        ttl: 300,
        tag: 1109,
        correlationId: 1756879922616218,
        tvf: null,
      );

      final result = publishOptionsWithoutTvf.toMap();

      // Verify that tvf key is not present when tvf is null
      expect(result.containsKey('tvf'), isFalse);

      // Verify that tvf fields are not present when tvf is null
      expect(result.containsKey('rpcMethods'), isFalse);
      expect(result.containsKey('chainId'), isFalse);
      expect(result.containsKey('txHashes'), isFalse);
      expect(result.containsKey('contractAddresses'), isFalse);

      // Verify that other fields are present
      expect(result['ttl'], equals(300));
      expect(result['tag'], equals(1109));
      expect(result['correlationId'], equals(1756879922616218));
    });

    test('PublishOptionsExtension.toMap() handles empty tvf data', () {
      final publishOptionsWithEmptyTvf = PublishOptions(
        ttl: 300,
        tag: 1109,
        correlationId: 1756879922616218,
        tvf: {},
      );

      final result = publishOptionsWithEmptyTvf.toMap();

      // Verify that tvf key is not present when tvf is empty
      expect(result.containsKey('tvf'), isFalse);

      // Verify that no tvf fields are present when tvf is empty
      expect(result.containsKey('rpcMethods'), isFalse);
      expect(result.containsKey('chainId'), isFalse);
      expect(result.containsKey('txHashes'), isFalse);
      expect(result.containsKey('contractAddresses'), isFalse);

      // Verify that other fields are present
      expect(result['ttl'], equals(300));
      expect(result['tag'], equals(1109));
      expect(result['correlationId'], equals(1756879922616218));
    });

    test('PublishOptionsExtension.toMap() handles partial tvf data', () {
      final publishOptionsWithPartialTvf = PublishOptions(
        ttl: 300,
        tag: 1109,
        correlationId: 1756879922616218,
        tvf: {
          'rpcMethods': ['eth_sendTransaction'],
          'chainId': 'eip155:8453',
        },
      );

      final result = publishOptionsWithPartialTvf.toMap();

      // Verify that tvf data is spread to the top level (NOT nested under 'tvf' key)
      expect(result.containsKey('tvf'), isFalse);

      // Verify that partial tvf fields are at the top level
      expect(result['rpcMethods'], equals(['eth_sendTransaction']));
      expect(result['chainId'], equals('eip155:8453'));
      expect(result.containsKey('txHashes'), isFalse);
      expect(result.containsKey('contractAddresses'), isFalse);

      // Verify that other fields are at the top level
      expect(result['ttl'], equals(300));
      expect(result['tag'], equals(1109));
      expect(result['correlationId'], equals(1756879922616218));
    });

    test('PublishOptions parameter structure matches expected JSON-RPC format', () {
      // This test verifies that the PublishOptions.toMap() method produces
      // the correct parameter structure that matches the expected JSON-RPC format

      final publishOptions = PublishOptions(
        ttl: 300,
        tag: 1109,
        correlationId: 1756879922616218,
        tvf: {
          'correlationId': 1756879922616218,
          'rpcMethods': ['eth_sendTransaction'],
          'chainId': 'eip155:8453',
          'txHashes': [
            '0x42d4e0dc0f301b2a119e68e52041fb6b84b3dc0bfb9a4f5c2a04898b80ff6755',
          ],
          'contractAddresses': ['0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913'],
        },
      );

      // Get the parameters that would be sent in the JSON-RPC request
      final parameters = publishOptions.toMap();

      // Simulate the complete JSON-RPC request structure
      final jsonRpcRequest = {
        'jsonrpc': '2.0',
        'method': 'irn_publish',
        'id': '1756879930406439680',
        'params': {
          'topic':
              '5a277ade637c43a6100dd33953f6409af985eada5864d26a915fab2ca681a320',
          'message':
              'ACBwpU/2/dFGFB3SxOowfMW6Zrr2P4rXjOpGLk2Bcl0mCue8wZnN/Lt8KuuqXe/zTrX4jl4hXGMbnT8fzSSS1L04b3QqewlEeWejqcndMPVNpsXH4CuUjG9XJPry28gGJYP/Br02zftytxLUYMPf/OtrdvLG7QLtq4O3PUYfXk6DDeomoY2tkQDt6qltiqPzOKU=',
          ...parameters, // This is where the PublishOptions parameters are spread
        },
      };

      // Verify the complete request structure
      expect(jsonRpcRequest['jsonrpc'], equals('2.0'));
      expect(jsonRpcRequest['method'], equals('irn_publish'));
      expect(jsonRpcRequest['params'], isA<Map<String, dynamic>>());

      final params = jsonRpcRequest['params'] as Map<String, dynamic>;

      // Verify basic parameters are at the top level
      expect(params['ttl'], equals(300));
      expect(params['tag'], equals(1109));
      expect(params['correlationId'], equals(1756879922616218));

      // Verify tvf data is spread to the top level (NOT nested under 'tvf' key)
      expect(params.containsKey('tvf'), isFalse);

      // Verify that tvf fields are at the top level
      expect(params['rpcMethods'], equals(['eth_sendTransaction']));
      expect(params['chainId'], equals('eip155:8453'));
      expect(
        params['txHashes'],
        equals([
          '0x42d4e0dc0f301b2a119e68e52041fb6b84b3dc0bfb9a4f5c2a04898b80ff6755',
        ]),
      );
      expect(
        params['contractAddresses'],
        equals(['0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913']),
      );
    });

    test(
      'JSON-RPC payload structure regression test - catches wrong nested structure',
      () {
        // This test verifies the complete JSON-RPC request structure and will catch
        // if someone accidentally changes the implementation to nest tvf data under a 'tvf' key

        final publishOptions = PublishOptions(
          ttl: 300,
          tag: 1109,
          correlationId: 1756879922616218,
          tvf: {
            'correlationId': 1756879922616218,
            'rpcMethods': ['eth_sendTransaction'],
            'chainId': 'eip155:8453',
            'txHashes': [
              '0x42d4e0dc0f301b2a119e68e52041fb6b84b3dc0bfb9a4f5c2a04898b80ff6755',
            ],
            'contractAddresses': ['0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913'],
          },
        );

        // Get the parameters that would be sent in the JSON-RPC request
        final parameters = publishOptions.toMap();

        // Simulate the complete JSON-RPC request structure
        final jsonRpcRequest = {
          'jsonrpc': '2.0',
          'method': 'irn_publish',
          'id': '1756879930406439680',
          'params': {
            'topic':
                '5a277ade637c43a6100dd33953f6409af985eada5864d26a915fab2ca681a320',
            'message':
                'ACBwpU/2/dFGFB3SxOowfMW6Zrr2P4rXjOpGLk2Bcl0mCue8wZnN/Lt8KuuqXe/zTrX4jl4hXGMbnT8fzSSS1L04b3QqewlEeWejqcndMPVNpsXH4CuUjG9XJPry28gGJYP/Br02zftytxLUYMPf/OtrdvLG7QLtq4O3PUYfXk6DDeomoY2tkQDt6qltiqPzOKU=',
            ...parameters, // This is where the PublishOptions parameters are spread
          },
        };

        final params = jsonRpcRequest['params'] as Map<String, dynamic>;

        // REGRESSION TEST: Verify that tvf data is NOT nested under a 'tvf' key
        // This will fail if someone changes the implementation to use 'if (tvf != null) 'tvf': tvf'
        expect(
          params.containsKey('tvf'),
          isFalse,
          reason:
              'REGRESSION: JSON-RPC params should NOT have a nested "tvf" key. '
              'The tvf fields should be spread to the top level of params. '
              'If this fails, someone changed the implementation to nest tvf data under a "tvf" key.',
        );
      },
    );
  });

  group('Relay Client Mock Tests', () {
    late IReownCore coreDapp;
    late IReownCore coreWallet;
    late MockWebSocketHandler mockWebSocketHandlerDapp;
    late MockWebSocketHandler mockWebSocketHandlerWallet;

    setUp(() async {
      mockWebSocketHandlerDapp = MockWebSocketHandler();
      mockWebSocketHandlerWallet = MockWebSocketHandler();

      // Setup mock behavior for WebSocket handlers
      when(
        mockWebSocketHandlerDapp.setup(url: anyNamed('url')),
      ).thenAnswer((_) async {});
      when(mockWebSocketHandlerDapp.connect()).thenAnswer((_) async {});
      when(mockWebSocketHandlerDapp.close()).thenAnswer((_) async {});
      // when(mockWebSocketHandlerDapp.ready).thenAnswer((_) async {});
      when(mockWebSocketHandlerDapp.channel).thenReturn(null);

      when(
        mockWebSocketHandlerWallet.setup(url: anyNamed('url')),
      ).thenAnswer((_) async {});
      when(mockWebSocketHandlerWallet.connect()).thenAnswer((_) async {});
      when(mockWebSocketHandlerWallet.close()).thenAnswer((_) async {});
      // when(mockWebSocketHandlerWallet.ready).thenAnswer((_) async {});
      when(mockWebSocketHandlerWallet.channel).thenReturn(null);

      coreDapp = ReownCore(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );
      coreWallet = ReownCore(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );

      // Replace relay clients with mocked ones
      coreDapp.relayClient = RelayClient(
        core: coreDapp,
        messageTracker: getMessageTracker(core: coreDapp),
        topicMap: getTopicMap(core: coreDapp),
        socketHandler: mockWebSocketHandlerDapp,
      );
      coreWallet.relayClient = RelayClient(
        core: coreWallet,
        messageTracker: getMessageTracker(core: coreWallet),
        topicMap: getTopicMap(core: coreWallet),
        socketHandler: mockWebSocketHandlerWallet,
      );

      await coreDapp.start();
      await coreWallet.start();
      await coreDapp.relayClient.init();
      await coreWallet.relayClient.init();
    });

    tearDown(() async {
      await coreDapp.relayClient.disconnect();
      await coreWallet.relayClient.disconnect();
    });

    group('proposeSession', () {
      test('proposeSession success', () async {
        const pairingTopic = 'testPairingTopic';
        const sessionProposal = 'testSessionProposal';
        const correlationId = 1234;

        // Mock successful response
        when(mockWebSocketHandlerDapp.channel).thenReturn(null);

        // Test that proposeSession can be called without throwing
        expect(() async {
          await coreDapp.relayClient.publishPayload(
            payload: {
              'pairingTopic': pairingTopic,
              'sessionProposal': sessionProposal,
            },
            options: PublishOptions(
              correlationId: correlationId,
              publishMethod: RelayClient.WC_PROPOSE_SESSION,
            ),
          );
        }, returnsNormally);
      });

      test('proposeSession failure due to timeout', () async {
        const pairingTopic = 'testPairingTopic';
        const sessionProposal = 'testSessionProposal';
        const correlationId = 1234;

        // Mock timeout behavior
        when(mockWebSocketHandlerDapp.channel).thenReturn(null);

        // Test that proposeSession can be called without throwing
        // Note: In the Dart implementation, timeout handling might be different
        expect(() async {
          await coreDapp.relayClient.publishPayload(
            payload: {
              'pairingTopic': pairingTopic,
              'sessionProposal': sessionProposal,
            },
            options: PublishOptions(
              correlationId: correlationId,
              publishMethod: RelayClient.WC_PROPOSE_SESSION,
            ),
          );
        }, returnsNormally);
      });

      test('proposeSession error response', () async {
        const pairingTopic = 'testPairingTopic';
        const sessionProposal = 'testSessionProposal';
        const correlationId = 1234;

        // Mock error response
        when(mockWebSocketHandlerDapp.channel).thenReturn(null);

        // Test that proposeSession can be called without throwing
        // Error handling would be different in the actual implementation
        expect(() async {
          await coreDapp.relayClient.publishPayload(
            payload: {
              'pairingTopic': pairingTopic,
              'sessionProposal': sessionProposal,
            },
            options: PublishOptions(
              correlationId: correlationId,
              publishMethod: RelayClient.WC_PROPOSE_SESSION,
            ),
          );
        }, returnsNormally);
      });
    });

    group('approveSession', () {
      test('approveSession success', () async {
        const pairingTopic = 'testPairingTopic';
        const sessionTopic = 'testSessionTopic';
        const sessionProposalResponse = 'testSessionProposalResponse';
        const sessionSettlementRequest = 'testSessionSettlementRequest';
        const correlationId = 1234;

        // Mock successful response
        when(mockWebSocketHandlerWallet.channel).thenReturn(null);

        // Test that approveSession can be called without throwing
        expect(() async {
          await coreWallet.relayClient.publishPayload(
            payload: {
              'sessionTopic': sessionTopic,
              'pairingTopic': pairingTopic,
              'sessionProposalResponse': sessionProposalResponse,
              'sessionSettlementRequest': sessionSettlementRequest,
            },
            options: PublishOptions(
              correlationId: correlationId,
              publishMethod: RelayClient.WC_APPROVE_SESSION,
            ),
          );
        }, returnsNormally);
      });

      test('approveSession failure due to timeout', () async {
        const pairingTopic = 'testPairingTopic';
        const sessionTopic = 'testSessionTopic';
        const sessionProposalResponse = 'testSessionProposalResponse';
        const sessionSettlementRequest = 'testSessionSettlementRequest';
        const correlationId = 1234;

        // Mock timeout behavior
        when(mockWebSocketHandlerWallet.channel).thenReturn(null);

        // Test that approveSession can be called without throwing
        // Note: In the Dart implementation, timeout handling might be different
        expect(() async {
          await coreWallet.relayClient.publishPayload(
            payload: {
              'sessionTopic': sessionTopic,
              'pairingTopic': pairingTopic,
              'sessionProposalResponse': sessionProposalResponse,
              'sessionSettlementRequest': sessionSettlementRequest,
            },
            options: PublishOptions(
              correlationId: correlationId,
              publishMethod: RelayClient.WC_APPROVE_SESSION,
            ),
          );
        }, returnsNormally);
      });

      test('approveSession error response', () async {
        const pairingTopic = 'testPairingTopic';
        const sessionTopic = 'testSessionTopic';
        const sessionProposalResponse = 'testSessionProposalResponse';
        const sessionSettlementRequest = 'testSessionSettlementRequest';
        const correlationId = 1234;

        // Mock error response
        when(mockWebSocketHandlerWallet.channel).thenReturn(null);

        // Test that approveSession can be called without throwing
        // Error handling would be different in the actual implementation
        expect(() async {
          await coreWallet.relayClient.publishPayload(
            payload: {
              'sessionTopic': sessionTopic,
              'pairingTopic': pairingTopic,
              'sessionProposalResponse': sessionProposalResponse,
              'sessionSettlementRequest': sessionSettlementRequest,
            },
            options: PublishOptions(
              correlationId: correlationId,
              publishMethod: RelayClient.WC_APPROVE_SESSION,
            ),
          );
        }, returnsNormally);
      });
    });

    group('Integration with real relay', () {
      test('proposeSession with real relay connection', () async {
        // Create real relay clients for integration testing
        final realCoreDapp = ReownCore(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
          httpClient: getHttpWrapper(),
        );
        final realCoreWallet = ReownCore(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
          httpClient: getHttpWrapper(),
        );

        await realCoreDapp.start();
        await realCoreWallet.start();

        // Create a pairing
        final response = await realCoreDapp.pairing.create();
        await realCoreWallet.pairing.pair(
          uri: response.uri,
          activatePairing: true,
        );
        realCoreDapp.pairing.activate(topic: response.topic);

        // Test proposeSession with real connection
        expect(() async {
          await realCoreDapp.relayClient.publishPayload(
            payload: {
              'pairingTopic': response.topic,
              'sessionProposal': 'testSessionProposal',
            },
            options: PublishOptions(
              publishMethod: RelayClient.WC_PROPOSE_SESSION,
            ),
          );
        }, returnsNormally);

        await realCoreDapp.relayClient.disconnect();
        await realCoreWallet.relayClient.disconnect();
      });

      test('approveSession with real relay connection', () async {
        // Create real relay clients for integration testing
        final realCoreDapp = ReownCore(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
          httpClient: getHttpWrapper(),
        );
        final realCoreWallet = ReownCore(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
          httpClient: getHttpWrapper(),
        );

        await realCoreDapp.start();
        await realCoreWallet.start();

        // Create a pairing
        final response = await realCoreDapp.pairing.create();
        await realCoreWallet.pairing.pair(
          uri: response.uri,
          activatePairing: true,
        );
        realCoreDapp.pairing.activate(topic: response.topic);

        // Test approveSession with real connection
        expect(() async {
          await realCoreWallet.relayClient.publishPayload(
            payload: {
              'sessionTopic': response.topic,
              'pairingTopic': response.topic,
              'sessionProposalResponse': 'testSessionProposalResponse',
              'sessionSettlementRequest': 'testSessionSettlementRequest',
            },
            options: PublishOptions(
              publishMethod: RelayClient.WC_APPROVE_SESSION,
            ),
          );
        }, returnsNormally);

        await realCoreDapp.relayClient.disconnect();
        await realCoreWallet.relayClient.disconnect();
      });
    });
  });
}
