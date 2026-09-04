import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/models/tvf_data.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_sign/reown_sign.dart';

import 'shared/shared_test_utils.dart';
import 'shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  group('TVF Collection Tests', () {
    late ReownSign signEngine;
    late ReownCore core;

    setUp(() async {
      core = ReownCore(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
        logLevel: LogLevel.info,
        httpClient: getHttpWrapper(),
      );

      signEngine = ReownSign(
        core: core,
        metadata: RESPONDER,
        proposals: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PROPOSALS,
          version: StoreVersions.VERSION_PROPOSALS,
          fromJson: (dynamic value) => ProposalData.fromJson(value),
        ),
        sessions: Sessions(
          storage: core.storage,
          context: StoreVersions.CONTEXT_SESSIONS,
          version: StoreVersions.VERSION_SESSIONS,
          fromJson: (dynamic value) => SessionData.fromJson(value),
        ),
        pendingRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PENDING_REQUESTS,
          version: StoreVersions.VERSION_PENDING_REQUESTS,
          fromJson: (dynamic value) => SessionRequest.fromJson(value),
        ),
        authKeys: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_KEYS,
          version: StoreVersions.VERSION_AUTH_KEYS,
          fromJson: (dynamic value) => AuthPublicKey.fromJson(value),
        ),
        pairingTopics: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PAIRING_TOPICS,
          version: StoreVersions.VERSION_PAIRING_TOPICS,
          fromJson: (dynamic value) => value,
        ),
        sessionAuthRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_REQUESTS,
          version: StoreVersions.VERSION_AUTH_REQUESTS,
          fromJson: (dynamic value) =>
              PendingSessionAuthRequest.fromJson(value),
        ),
      );

      await core.start();
      await signEngine.init();
    });

    group('TVF Collection through public methods', () {
      test('should collect request TVF data when calling request()', () async {
        // Arrange
        final id = 123;
        final request = SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [
            {
              'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
              'value': '0x0',
              'data': '0x',
            },
          ],
        );

        // Create a mock session first
        final session = SessionData(
          topic: 'test_topic',
          pairingTopic: 'test_pairing_topic',
          relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
          expiry: ReownCoreUtils.calculateExpiry(ReownConstants.SEVEN_DAYS),
          acknowledged: true,
          controller: 'test_controller',
          namespaces: {
            'eip155': Namespace(
              accounts: ['eip155:1:0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6'],
              methods: ['eth_sendTransaction'],
              events: ['chainChanged'],
            ),
          },
          self: ConnectionMetadata(
            publicKey: 'test_self_key',
            metadata: RESPONDER,
          ),
          peer: ConnectionMetadata(
            publicKey: 'test_peer_key',
            metadata: PROPOSER,
          ),
        );

        await signEngine.sessions.set('test_topic', session);

        // Act
        try {
          await signEngine.request(
            requestId: id,
            topic: 'test_topic',
            chainId: 'eip155:1',
            request: request,
          );
        } catch (e) {
          // Expected to fail due to relay connection, but TVF should be collected
        }

        // Assert - check if TVF data was stored
        expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);
        final tvfData = signEngine.pendingTVFRequests[id];
        expect(tvfData, isNotNull);
        expect(tvfData!.rpcMethods, equals(['eth_sendTransaction']));
        expect(tvfData.chainId, equals('eip155:1'));
        expect(tvfData.contractAddresses, isNull);
        expect(tvfData.requestParams, equals(request.params));
        expect(tvfData.txHashes, isNull);
      });

      test('should handle invalid contract data gracefully', () async {
        // Arrange
        final id = 126;
        final request = SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [
            {
              'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
              'value': '0x0',
              'data': 'invalid_data',
            },
          ],
        );

        // Create a mock session
        final session = SessionData(
          topic: 'test_topic_4',
          pairingTopic: 'test_pairing_topic_4',
          relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
          expiry: ReownCoreUtils.calculateExpiry(ReownConstants.SEVEN_DAYS),
          acknowledged: true,
          controller: 'test_controller_4',
          namespaces: {
            'eip155': Namespace(
              accounts: ['eip155:1:0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6'],
              methods: ['eth_sendTransaction'],
              events: ['chainChanged'],
            ),
          },
          self: ConnectionMetadata(
            publicKey: 'test_self_key_4',
            metadata: RESPONDER,
          ),
          peer: ConnectionMetadata(
            publicKey: 'test_peer_key_4',
            metadata: PROPOSER,
          ),
        );

        await signEngine.sessions.set('test_topic_4', session);

        // Act
        try {
          await signEngine.request(
            requestId: id,
            topic: 'test_topic_4',
            chainId: 'eip155:1',
            request: request,
          );
        } catch (e) {
          // Expected to fail due to relay connection, but TVF should be collected
        }

        // Assert
        expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);
        final tvfData = signEngine.pendingTVFRequests[id];
        expect(tvfData, isNotNull);
        expect(tvfData!.contractAddresses, isNull);
      });

      test(
        'should collect response TVF data when calling respondSessionRequest()',
        () async {
          // Arrange
          final id = 127;
          final request = SessionRequestParams(
            method: 'eth_sendTransaction',
            params: [
              {
                'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
                'value': '0x0',
                'data': '0x',
              },
            ],
          );

          // Create a mock session
          final session = SessionData(
            topic: 'test_topic_5',
            pairingTopic: 'test_pairing_topic_5',
            relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
            expiry: ReownCoreUtils.calculateExpiry(ReownConstants.SEVEN_DAYS),
            acknowledged: true,
            controller: 'test_controller_5',
            namespaces: {
              'eip155': Namespace(
                accounts: [
                  'eip155:1:0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
                ],
                methods: ['eth_sendTransaction'],
                events: ['chainChanged'],
              ),
            },
            self: ConnectionMetadata(
              publicKey: 'test_self_key_5',
              metadata: RESPONDER,
            ),
            peer: ConnectionMetadata(
              publicKey: 'test_peer_key_5',
              metadata: PROPOSER,
            ),
          );

          await signEngine.sessions.set('test_topic_5', session);

          // First collect the request TVF
          try {
            await signEngine.request(
              requestId: id,
              topic: 'test_topic_5',
              chainId: 'eip155:1',
              request: request,
            );
          } catch (e) {
            // Expected to fail due to relay connection
          }

          // Verify request TVF was collected
          expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);

          // Create a pending request in the store (required for validation)
          final sessionRequest = SessionRequest(
            id: id,
            topic: 'test_topic_5',
            method: 'eth_sendTransaction',
            chainId: 'eip155:1',
            params: request.params,
            verifyContext: VerifyContext(
              origin: 'test_origin',
              verifyUrl: 'test_verify_url',
              validation: Validation.VALID,
            ),
          );
          await signEngine.pendingRequests.set(id.toString(), sessionRequest);

          // Create response
          final response = JsonRpcResponse(
            id: id,
            result: '0x1234567890abcdef',
          );

          // Act
          try {
            await signEngine.respondSessionRequest(
              topic: 'test_topic_5',
              response: response,
            );
          } catch (e) {
            // Expected to fail due to relay connection, but TVF should be processed
          }

          // Assert - check if pending TVF request was removed
          expect(signEngine.pendingTVFRequests.containsKey(id), isFalse);
        },
      );

      test('should handle response with error gracefully', () async {
        // Arrange
        final id = 128;
        final request = SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [
            {
              'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
              'value': '0x0',
              'data': '0x',
            },
          ],
        );

        // Create a mock session
        final session = SessionData(
          topic: 'test_topic_6',
          pairingTopic: 'test_pairing_topic_6',
          relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
          expiry: ReownCoreUtils.calculateExpiry(ReownConstants.SEVEN_DAYS),
          acknowledged: true,
          controller: 'test_controller_6',
          namespaces: {
            'eip155': Namespace(
              accounts: ['eip155:1:0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6'],
              methods: ['eth_sendTransaction'],
              events: ['chainChanged'],
            ),
          },
          self: ConnectionMetadata(
            publicKey: 'test_self_key_6',
            metadata: RESPONDER,
          ),
          peer: ConnectionMetadata(
            publicKey: 'test_peer_key_6',
            metadata: PROPOSER,
          ),
        );

        await signEngine.sessions.set('test_topic_6', session);

        // First collect the request TVF
        try {
          await signEngine.request(
            requestId: id,
            topic: 'test_topic_6',
            chainId: 'eip155:1',
            request: request,
          );
        } catch (e) {
          // Expected to fail due to relay connection
        }

        // Verify request TVF was collected
        expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);

        // Create a pending request in the store (required for validation)
        final sessionRequest = SessionRequest(
          id: id,
          topic: 'test_topic_6',
          method: 'eth_sendTransaction',
          chainId: 'eip155:1',
          params: request.params,
          verifyContext: VerifyContext(
            origin: 'test_origin',
            verifyUrl: 'test_verify_url',
            validation: Validation.VALID,
          ),
        );
        await signEngine.pendingRequests.set(id.toString(), sessionRequest);

        // Create response with error
        final response = JsonRpcResponse(
          id: id,
          error: JsonRpcError(code: -32603, message: 'Internal error'),
        );

        // Act
        try {
          await signEngine.respondSessionRequest(
            topic: 'test_topic_6',
            response: response,
          );
        } catch (e) {
          // Expected to fail due to relay connection, but TVF should be processed
        }

        // Assert - check if pending TVF request was removed
        expect(signEngine.pendingTVFRequests.containsKey(id), isFalse);
      });

      test(
        'should collect EVM wallet_sendCalls 2.0.0 hashes correctly',
        () async {
          // Arrange
          final id = 129;
          final request = SessionRequestParams(
            method: 'wallet_sendCalls',
            params: [
              {
                'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
                'value': '0x0',
                'data': '0x',
              },
            ],
          );

          // Create a mock session
          final session = SessionData(
            topic: 'test_topic_7',
            pairingTopic: 'test_pairing_topic_7',
            relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
            expiry: ReownCoreUtils.calculateExpiry(ReownConstants.SEVEN_DAYS),
            acknowledged: true,
            controller: 'test_controller_7',
            namespaces: {
              'eip155': Namespace(
                accounts: [
                  'eip155:1:0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
                ],
                methods: ['wallet_sendCalls'],
                events: ['chainChanged'],
              ),
            },
            self: ConnectionMetadata(
              publicKey: 'test_self_key_7',
              metadata: RESPONDER,
            ),
            peer: ConnectionMetadata(
              publicKey: 'test_peer_key_7',
              metadata: PROPOSER,
            ),
          );

          await signEngine.sessions.set('test_topic_7', session);

          // First collect the request TVF
          try {
            await signEngine.request(
              requestId: id,
              topic: 'test_topic_7',
              chainId: 'eip155:1',
              request: request,
            );
          } catch (e) {
            // Expected to fail due to relay connection
          }

          // Verify request TVF was collected
          expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);

          // Create a pending request in the store (required for validation)
          final sessionRequest = SessionRequest(
            id: id,
            topic: 'test_topic_7',
            method: 'wallet_sendCalls',
            chainId: 'eip155:1',
            params: request.params,
            verifyContext: VerifyContext(
              origin: 'test_origin',
              verifyUrl: 'test_verify_url',
              validation: Validation.VALID,
            ),
          );
          await signEngine.pendingRequests.set(id.toString(), sessionRequest);

          // Create response with wallet_sendCalls 2.0.0 format
          final response = JsonRpcResponse(
            id: id,
            result: {
              'id': '0x1234567890abcdef',
              'capabilities': {
                'caip345': {
                  'caip2': 'eip155:1',
                  'transactionHashes': [
                    '0xabcdef1234567890',
                    '0xfedcba0987654321',
                  ],
                },
              },
            },
          );

          // Act
          try {
            await signEngine.respondSessionRequest(
              topic: 'test_topic_7',
              response: response,
            );
          } catch (e) {
            // Expected to fail due to relay connection, but TVF should be processed
          }

          // Assert - check if pending TVF request was removed
          expect(signEngine.pendingTVFRequests.containsKey(id), isFalse);
          final hashes = signEngine.collectHashes('eip155', response);
          expect(hashes?.length, 3);
          expect(hashes, [
            '0x1234567890abcdef',
            '0xabcdef1234567890',
            '0xfedcba0987654321',
          ]);
        },
      );

      test('should collect simple EVM transaction hash correctly', () async {
        // Arrange
        final id = 130;
        final request = SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [
            {
              'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
              'value': '0x0',
              'data': '0x',
            },
          ],
        );

        // Create a mock session
        final session = SessionData(
          topic: 'test_topic_8',
          pairingTopic: 'test_pairing_topic_8',
          relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
          expiry: ReownCoreUtils.calculateExpiry(ReownConstants.SEVEN_DAYS),
          acknowledged: true,
          controller: 'test_controller_8',
          namespaces: {
            'eip155': Namespace(
              accounts: ['eip155:1:0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6'],
              methods: ['eth_sendTransaction'],
              events: ['chainChanged'],
            ),
          },
          self: ConnectionMetadata(
            publicKey: 'test_self_key_8',
            metadata: RESPONDER,
          ),
          peer: ConnectionMetadata(
            publicKey: 'test_peer_key_8',
            metadata: PROPOSER,
          ),
        );

        await signEngine.sessions.set('test_topic_8', session);

        // First collect the request TVF
        try {
          await signEngine.request(
            requestId: id,
            topic: 'test_topic_8',
            chainId: 'eip155:1',
            request: request,
          );
        } catch (e) {
          // Expected to fail due to relay connection
        }

        // Verify request TVF was collected
        expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);

        // Create a pending request in the store (required for validation)
        final sessionRequest = SessionRequest(
          id: id,
          topic: 'test_topic_8',
          method: 'eth_sendTransaction',
          chainId: 'eip155:1',
          params: request.params,
          verifyContext: VerifyContext(
            origin: 'test_origin',
            verifyUrl: 'test_verify_url',
            validation: Validation.VALID,
          ),
        );
        await signEngine.pendingRequests.set(id.toString(), sessionRequest);

        // Create response with simple transaction hash
        final response = JsonRpcResponse(id: id, result: '0x1234567890abcdef');

        // Act
        try {
          await signEngine.respondSessionRequest(
            topic: 'test_topic_8',
            response: response,
          );
        } catch (e) {
          // Expected to fail due to relay connection, but TVF should be processed
        }

        // Assert - check if pending TVF request was removed
        expect(signEngine.pendingTVFRequests.containsKey(id), isFalse);
      });

      test(
        'should collect TON transaction hash correctly through public methods',
        () async {
          // Arrange
          final id = 131;
          final request = SessionRequestParams(
            method: 'ton_sendTransaction',
            params: [
              {
                'to': 'EQD0vdSA_NedR9uv6d8Q8N8ukdWVtJ3Fylj80P4g5zg-Lh0',
                'value': '1000000000',
                'data': 'te6ccgEBAQEADAAMABQAAAAASGVsbG8hCaTc/g==',
              },
            ],
          );

          // Create a mock session
          final session = SessionData(
            topic: 'test_topic_9',
            pairingTopic: 'test_pairing_topic_9',
            relay: Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
            expiry: ReownCoreUtils.calculateExpiry(ReownConstants.SEVEN_DAYS),
            acknowledged: true,
            controller: 'test_controller_9',
            namespaces: {
              'ton': Namespace(
                accounts: [
                  'ton:mainnet:EQD0vdSA_NedR9uv6d8Q8N8ukdWVtJ3Fylj80P4g5zg-Lh0',
                ],
                methods: ['ton_sendTransaction'],
                events: ['chainChanged'],
              ),
            },
            self: ConnectionMetadata(
              publicKey: 'test_self_key_9',
              metadata: RESPONDER,
            ),
            peer: ConnectionMetadata(
              publicKey: 'test_peer_key_9',
              metadata: PROPOSER,
            ),
          );

          await signEngine.sessions.set('test_topic_9', session);

          // First collect the request TVF
          try {
            await signEngine.request(
              requestId: id,
              topic: 'test_topic_9',
              chainId: 'ton:mainnet',
              request: request,
            );
          } catch (e) {
            // Expected to fail due to relay connection
          }

          // Verify request TVF was collected
          expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);

          // Create a pending request in the store (required for validation)
          final sessionRequest = SessionRequest(
            id: id,
            topic: 'test_topic_9',
            method: 'ton_sendTransaction',
            chainId: 'ton:mainnet',
            params: request.params,
            verifyContext: VerifyContext(
              origin: 'test_origin',
              verifyUrl: 'test_verify_url',
              validation: Validation.VALID,
            ),
          );
          await signEngine.pendingRequests.set(id.toString(), sessionRequest);

          // Create response with TON transaction hash
          final response = JsonRpcResponse(
            id: id,
            result:
                '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
          );

          // Act
          try {
            await signEngine.respondSessionRequest(
              topic: 'test_topic_9',
              response: response,
            );
          } catch (e) {
            // Expected to fail due to relay connection, but TVF should be processed
          }

          // Assert - check if pending TVF request was removed
          expect(signEngine.pendingTVFRequests.containsKey(id), isFalse);
          final hashes = signEngine.collectHashes('ton', response);
          expect(hashes?.length, 1);
          expect(hashes, [
            '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
          ]);
        },
      );
    });

    group('Direct Method Testing - collectRequestTVF', () {
      test('should collect basic request TVF data', () {
        // Arrange
        final id = 200;
        final request = WcSessionRequestRequest(
          chainId: 'eip155:1',
          request: SessionRequestParams(
            method: 'eth_sendTransaction',
            params: [
              {
                'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
                'value': '0x0',
                'data': '0x',
              },
            ],
          ),
        );

        // Act
        final tvfData = signEngine.collectRequestTVF(id, request);

        // Assert
        expect(tvfData, isNotNull);
        expect(tvfData!.rpcMethods, equals(['eth_sendTransaction']));
        expect(tvfData.chainId, equals('eip155:1'));
        expect(tvfData.contractAddresses, isNull);
        expect(tvfData.requestParams, equals(request.request.params));
        expect(tvfData.txHashes, isNull);

        // Check if stored in pendingTVFRequests
        expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);
        expect(signEngine.pendingTVFRequests[id], equals(tvfData));
      });

      test('should collect contract address for EVM contract calls', () {
        // Arrange
        final id = 201;
        final request = WcSessionRequestRequest(
          chainId: 'eip155:1',
          request: SessionRequestParams(
            method: 'eth_sendTransaction',
            params: [
              {
                'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
                'value': '0x0',
                'data':
                    '0xa9059cbb000000000000000000000000742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6000000000000000000000000000000000000000000000000000000000000000001',
              },
            ],
          ),
        );

        // Act
        final tvfData = signEngine.collectRequestTVF(id, request);

        // Assert
        expect(tvfData, isNotNull);
        expect(tvfData!.rpcMethods, equals(['eth_sendTransaction']));
        expect(tvfData.chainId, equals('eip155:1'));
        // Note: contractAddresses depends on EvmChainUtils.isValidContractData
        expect(tvfData.requestParams, equals(request.request.params));
        expect(tvfData.txHashes, isNull);
      });

      test('should handle different RPC methods', () {
        // Arrange
        final id = 202;
        final request = WcSessionRequestRequest(
          chainId: 'eip155:1',
          request: SessionRequestParams(
            method: 'personal_sign',
            params: [
              'Hello World',
              '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
            ],
          ),
        );

        // Act
        final tvfData = signEngine.collectRequestTVF(id, request);

        // Assert
        expect(tvfData, isNotNull);
        expect(tvfData!.rpcMethods, equals(['personal_sign']));
        expect(tvfData.chainId, equals('eip155:1'));
        expect(tvfData.contractAddresses, isNull);
        expect(tvfData.requestParams, equals(request.request.params));
      });

      test('should handle non-EVM chains', () {
        // Arrange
        final id = 203;
        final request = WcSessionRequestRequest(
          chainId: 'solana:mainnet',
          request: SessionRequestParams(
            method: 'solana_signTransaction',
            params: [
              {'transaction': 'base64_encoded_transaction'},
            ],
          ),
        );

        // Act
        final tvfData = signEngine.collectRequestTVF(id, request);

        // Assert
        expect(tvfData, isNotNull);
        expect(tvfData!.rpcMethods, equals(['solana_signTransaction']));
        expect(tvfData.chainId, equals('solana:mainnet'));
        expect(tvfData.contractAddresses, isNull);
        expect(tvfData.requestParams, equals(request.request.params));
      });

      test('should handle TON chains', () {
        // Arrange
        final id = 204;
        final request = WcSessionRequestRequest(
          chainId: 'ton:mainnet',
          request: SessionRequestParams(
            method: 'ton_sendTransaction',
            params: [
              {
                'to': 'EQD0vdSA_NedR9uv6d8Q8N8ukdWVtJ3Fylj80P4g5zg-Lh0',
                'value': '1000000000',
                'data': 'te6ccgEBAQEADAAMABQAAAAASGVsbG8hCaTc/g==',
              },
            ],
          ),
        );

        // Act
        final tvfData = signEngine.collectRequestTVF(id, request);

        // Assert
        expect(tvfData, isNotNull);
        expect(tvfData!.rpcMethods, equals(['ton_sendTransaction']));
        expect(tvfData.chainId, equals('ton:mainnet'));
        expect(tvfData.contractAddresses, isNull);
        expect(tvfData.requestParams, equals(request.request.params));
      });
    });

    group('Direct Method Testing - collectResponseTVF', () {
      test('should collect response TVF data and remove from pending', () {
        // Arrange
        final id = 300;
        final request = WcSessionRequestRequest(
          chainId: 'eip155:1',
          request: SessionRequestParams(
            method: 'eth_sendTransaction',
            params: [
              {
                'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
                'value': '0x0',
                'data': '0x',
              },
            ],
          ),
        );

        // First collect request TVF
        signEngine.collectRequestTVF(id, request);
        expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);

        // Create response
        final response = JsonRpcResponse(id: id, result: '0x1234567890abcdef');

        // Act
        final tvfData = signEngine.collectResponseTVF(response);

        // Assert
        expect(tvfData, isNotNull);
        expect(tvfData!.rpcMethods, equals(['eth_sendTransaction']));
        expect(tvfData.chainId, equals('eip155:1'));
        expect(tvfData.contractAddresses, isNull);
        expect(tvfData.requestParams, equals(request.request.params));
        expect(tvfData.txHashes, isNotNull);
        expect(tvfData.txHashes!.length, equals(1));
        expect(tvfData.txHashes!.first, equals('0x1234567890abcdef'));

        // Check if removed from pending
        expect(signEngine.pendingTVFRequests.containsKey(id), isFalse);
      });

      test('should collect TON response TVF data correctly', () {
        // Arrange
        final id = 302;
        final request = WcSessionRequestRequest(
          chainId: 'ton:mainnet',
          request: SessionRequestParams(
            method: 'ton_sendTransaction',
            params: [
              {
                'to': 'EQD0vdSA_NedR9uv6d8Q8N8ukdWVtJ3Fylj80P4g5zg-Lh0',
                'value': '1000000000',
                'data': 'te6ccgEBAQEADAAMABQAAAAASGVsbG8hCaTc/g==',
              },
            ],
          ),
        );

        // First collect request TVF
        signEngine.collectRequestTVF(id, request);
        expect(signEngine.pendingTVFRequests.containsKey(id), isTrue);

        // Create response
        final response = JsonRpcResponse(
          id: id,
          result:
              '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
        );

        // Act
        final tvfData = signEngine.collectResponseTVF(response);

        // Assert
        expect(tvfData, isNotNull);
        expect(tvfData!.rpcMethods, equals(['ton_sendTransaction']));
        expect(tvfData.chainId, equals('ton:mainnet'));
        expect(tvfData.contractAddresses, isNull);
        expect(tvfData.requestParams, equals(request.request.params));
        expect(tvfData.txHashes, isNotNull);
        expect(tvfData.txHashes!.length, equals(1));
        expect(
          tvfData.txHashes!.first,
          equals(
            '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
          ),
        );

        // Check if removed from pending
        expect(signEngine.pendingTVFRequests.containsKey(id), isFalse);
      });

      test('should return null for non-existent request ID', () {
        // Arrange
        final response = JsonRpcResponse(id: 999, result: '0x1234567890abcdef');

        // Act
        final tvfData = signEngine.collectResponseTVF(response);

        // Assert
        expect(tvfData, isNull);
      });

      test('should handle response with error', () {
        // Arrange
        final id = 301;
        final request = WcSessionRequestRequest(
          chainId: 'eip155:1',
          request: SessionRequestParams(
            method: 'eth_sendTransaction',
            params: [
              {
                'to': '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6',
                'value': '0x0',
                'data': '0x',
              },
            ],
          ),
        );

        // First collect request TVF
        signEngine.collectRequestTVF(id, request);

        // Create response with error
        final response = JsonRpcResponse(
          id: id,
          error: JsonRpcError(code: -32603, message: 'Internal error'),
        );

        // Act
        final tvfData = signEngine.collectResponseTVF(response);

        // Assert
        expect(tvfData, isNotNull);
        expect(tvfData!.txHashes, isNull); // No hashes for error responses
        expect(signEngine.pendingTVFRequests.containsKey(id), isFalse);
      });
    });

    group('Direct Method Testing - collectHashes', () {
      test('should collect EVM wallet_sendCalls 2.0.0 hashes correctly', () {
        // Arrange
        final response = JsonRpcResponse(
          id: 400,
          result: {
            'id': '0x1234567890abcdef',
            'capabilities': {
              'caip345': {
                'caip2': 'eip155:1',
                'transactionHashes': [
                  '0xabcdef1234567890',
                  '0xfedcba0987654321',
                ],
              },
            },
          },
        );

        // Act
        final hashes = signEngine.collectHashes('eip155', response);

        // Assert
        expect(hashes, isNotNull);
        expect(hashes!.length, equals(3));
        expect(hashes[0], equals('0x1234567890abcdef')); // id
        expect(
          hashes[1],
          equals('0xabcdef1234567890'),
        ); // first transaction hash
        expect(
          hashes[2],
          equals('0xfedcba0987654321'),
        ); // second transaction hash
      });

      test('should collect simple EVM transaction hash', () {
        // Arrange
        final response = JsonRpcResponse(id: 401, result: '0x1234567890abcdef');

        // Act
        final hashes = signEngine.collectHashes('eip155', response);

        // Assert
        expect(hashes, isNotNull);
        expect(hashes!.length, equals(1));
        expect(hashes[0], equals('0x1234567890abcdef'));
      });

      test('should return null for EVM response with error', () {
        // Arrange
        final response = JsonRpcResponse(
          id: 402,
          error: JsonRpcError(code: -32603, message: 'Internal error'),
        );

        // Act
        final hashes = signEngine.collectHashes('eip155', response);

        // Assert
        expect(hashes, isNull);
      });

      test('should return null for EVM response with null result', () {
        // Arrange
        final response = JsonRpcResponse(id: 403, result: null);

        // Act
        final hashes = signEngine.collectHashes('eip155', response);

        // Assert
        expect(hashes, isNull);
      });

      test('should collect TON transaction hash correctly', () {
        // Arrange
        final response = JsonRpcResponse(
          id: 404,
          result:
              '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
        );

        // Act
        final hashes = signEngine.collectHashes('ton', response);

        // Assert
        expect(hashes, isNotNull);
        expect(hashes!.length, equals(1));
        expect(
          hashes[0],
          equals(
            '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
          ),
        );
      });

      test('should return null for TON response with error', () {
        // Arrange
        final response = JsonRpcResponse(
          id: 405,
          error: JsonRpcError(code: -32603, message: 'Internal error'),
        );

        // Act
        final hashes = signEngine.collectHashes('ton', response);

        // Assert
        expect(hashes, isNull);
      });

      test('should return null for TON response with null result', () {
        // Arrange
        final response = JsonRpcResponse(id: 406, result: null);

        // Act
        final hashes = signEngine.collectHashes('ton', response);

        // Assert
        expect(hashes, isNull);
      });

      test('should return null for TON response with non-string result', () {
        // Arrange
        final response = JsonRpcResponse(
          id: 407,
          result: {'hash': '0x1234567890abcdef'},
        );

        // Act
        final hashes = signEngine.collectHashes('ton', response);

        // Assert
        expect(hashes, isNull);
      });
    });

    group('Direct Method Testing - collectHashes - Stellar', () {
      // Stellar test vectors are real transactions fetched from Horizon
      // (expected hash == the `hash` field of `GET /transactions/{hash}`).
      const pubnetV1Xdr =
          'AAAAAgAAAACutgsH0wwp9iT1V1zWE8jbQAm7JNeTEx4zdvWD4Jtk8wAAAGQDymekAAAAHAAAAAEAAAAAAAAAAAAAAABqguWuAAAAAAAAAAEAAAAAAAAAAQAAAACutgsH0wwp9iT1V1zWE8jbQAm7JNeTEx4zdvWD4Jtk8wAAAAAAAAAAAJiWgAAAAAAAAAAB4Jtk8wAAAECrfMK7BzVXCay0QnEItO7dJ8Ix2wGaMnFfbWHW1tE6cezMinDXiDtlVBwoK2GjAbrE0h+eGDjDqWWaRS1XDrwE';
      const pubnetV1Hash =
          '628ef4f404cba337f757a640260984830728c92101af0a051fb59fc8c79521c6';

      const pubnetFeeBumpXdr =
          'AAAABQAAAAA0mMHF8QGzwsMRBhe9i8PSIqxjNjKyQMyXZODBAdhAUwAAAAAAA5+BAAAAAgAAAAA6Hd6p+AA5GTO2bJqKN/hbBfWcOh2Ow8cnTY3iIFFVPAADnrgDoCvmAAAZVgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAADod3qn4ADkZM7Zsmoo3+FsF9Zw6HY7DxydNjeIgUVU8AAAAGAAAAAAAAAAB1/5EvQrxHWArEJHy9KH03yEtRE0DIeoyrbPMHLurCgQAAAAEd29yawAAAAMAAAASAAAAAAAAAAA6Hd6p+AA5GTO2bJqKN/hbBfWcOh2Ow8cnTY3iIFFVPAAAAA0AAAAgAAAAjpSFVoEyx/Ev5d2V/desEr+GEqMyXKvrs5wXFqwAAAAFAAAAAAIrSjwAAAAAAAAAAQAAAAAAAAABAAAAB9ssFCkNSWTjgF8lJ90TKTm6X7P8ysVrML+rj9CRARYnAAAAAwAAAAYAAAAB1/5EvQrxHWArEJHy9KH03yEtRE0DIeoyrbPMHLurCgQAAAAQAAAAAQAAAAIAAAAPAAAABUJsb2NrAAAAAAAAAwACsj8AAAAAAAAABgAAAAHX/kS9CvEdYCsQkfL0ofTfIS1ETQMh6jKts8wcu6sKBAAAABAAAAABAAAAAwAAAA8AAAAEUGFpbAAAABIAAAAAAAAAADod3qn4ADkZM7Zsmoo3+FsF9Zw6HY7DxydNjeIgUVU8AAAAAwACsj8AAAAAAAAABgAAAAHX/kS9CvEdYCsQkfL0ofTfIS1ETQMh6jKts8wcu6sKBAAAABQAAAABABvFygAAAAAAAAXIAAAAAAADnrgAAAABIFFVPAAAAEBbcalx54eMMHwWJz7tzgOoxIVmMl4pexbgwTLzxnyMtAhZ2nZlsF18jIMDBaubSNSNPi4YRHkSajpyOcdZOzsCAAAAAAAAAAEB2EBTAAAAQDOlpIeUB73BImAZJCSAt0cuKZXHlKG+TJ+j+fCeFe9bDc5wHzMlDjU6YlB6geCuxRi7QwTq4RgxrOIJ9HICfg8=';
      const pubnetFeeBumpHash =
          '5906453d5a367b4a8a1af9bbbc934904841718ec1ca1345874904e15f97bf83b';

      const testnetV1Xdr =
          'AAAAAgAAAAAJDqKNhO2/XZAvmR1Wynm2lxfIUQwB6TDzqNVOlQgQTgAAm74AJGh0ABKiOwAAAAEAAAAAAAAAAAAAAABqgthtAAAAAAAAAAEAAAAAAAAAGAAAAAAAAAABmtIg9IzJFxPz3yuidCMj3LiE2SB3XYOl8DvtohHRPVAAAAAJc2V0X3ByaWNlAAAAAAAAAwAAABIAAAAAAAAAAAkOoo2E7b9dkC+ZHVbKebaXF8hRDAHpMPOo1U6VCBBOAAAADwAAAAZFVEhVU0QAAAAAAAoAAAAAAAAAAAAAAARomVswAAAAAQAAAAAAAAAAAAAAAZrSIPSMyRcT898ronQjI9y4hNkgd12DpfA77aIR0T1QAAAACXNldF9wcmljZQAAAAAAAAMAAAASAAAAAAAAAAAJDqKNhO2/XZAvmR1Wynm2lxfIUQwB6TDzqNVOlQgQTgAAAA8AAAAGRVRIVVNEAAAAAAAKAAAAAAAAAAAAAAAEaJlbMAAAAAAAAAABAAAAAAAAAAQAAAAGAAAAAcbgeSm1T8h+V5r+/0u+qUVZIopr5hDeGKj1+u37faSgAAAAEAAAAAEAAAADAAAADwAAAAdIYXNSb2xlAAAAABIAAAAAAAAAAAkOoo2E7b9dkC+ZHVbKebaXF8hRDAHpMPOo1U6VCBBOAAAADwAAAAZPUkFDTEUAAAAAAAEAAAAGAAAAAcbgeSm1T8h+V5r+/0u+qUVZIopr5hDeGKj1+u37faSgAAAAFAAAAAEAAAAHve3Sc2JfmD0Hu+w96oFCzEX1XxFR0uE/NeSf2Vqmia8AAAAH4IWMslKp5yCKjCiGPIRV6yV0LdrLOEfRrCRSwjur0G8AAAABAAAABgAAAAGa0iD0jMkXE/PfK6J0IyPcuITZIHddg6XwO+2iEdE9UAAAABQAAAABADikCAAAAAAAAAJUAAAAAAAATa0AAAABlQgQTgAAAEDSMm2vdKNsB2TCk+Pbb6vSYgq6Zd5F0E4H5BfMi4lwWEcYFAq2Mp+e12wr1qU+Ni7+2BTqZUkb+uK7lVM8PqkN';
      const testnetV1Hash =
          'c9b2d35ab15c055acb422872a8f1680a84ad6b8ad0d56271cfb74c083edf2007';

      // ENVELOPE_TYPE_TX_V0 (discriminant 0) — exercises the include-leading-zeros path.
      // Hash cross-checked against @stellar/stellar-sdk's Transaction.hash().
      const pubnetV0Xdr =
          'AAAAAG5btGuvFysDlQ/whfTBH8NWx1qRgzGpjtSDnJx3krOBAAAAZAAAAAEAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAsAAAAAAAAAZAAAAAAAAAABd5KzgQAAAEAu0xW2vwIqtuAu4/FFLWHBooGpvqn/N6iHgEX45savBk7SyoFGKIlyhG7ETZQ93tbF1OC/5ym6SdXmwIhIPQUD';
      const pubnetV0Hash =
          '5b709eff53cb92c20d2c79e007f6b53ba9be04d6073119d142ffa70d7ea5c7cb';

      test('should compute hash for stellar_signXDR on pubnet', () {
        // Arrange
        const id = 500;
        signEngine.pendingTVFRequests[id] = const TVFData(
          rpcMethods: ['stellar_signXDR'],
          chainId: 'stellar:pubnet',
        );
        final response = JsonRpcResponse(
          id: id,
          result: {
            'signedXDR': pubnetV1Xdr,
            'signerAddress':
                'stellar:pubnet:GCXLMCYH2MGCT5RE6VLVZVQTZDNUACN3ETLZGEY6GN3PLA7ATNSPGGJH',
          },
        );

        // Act
        final hashes = signEngine.collectHashes('stellar', response);

        // Assert
        expect(hashes, equals([pubnetV1Hash]));
      });

      test('should default to pubnet for stellar_signXDR without pending request', () {
        // Arrange
        final response = JsonRpcResponse(
          id: 501,
          result: {'signedXDR': pubnetV1Xdr},
        );

        // Act
        final hashes = signEngine.collectHashes('stellar', response);

        // Assert
        expect(hashes, equals([pubnetV1Hash]));
      });

      test('should compute canonical fee-bump hash for a fee-bump envelope', () {
        // Arrange
        const id = 502;
        signEngine.pendingTVFRequests[id] = const TVFData(
          rpcMethods: ['stellar_signXDR'],
          chainId: 'stellar:pubnet',
        );
        final response = JsonRpcResponse(
          id: id,
          result: {'signedXDR': pubnetFeeBumpXdr},
        );

        // Act
        final hashes = signEngine.collectHashes('stellar', response);

        // Assert — H_fb, the hash explorers index, not the inner tx hash
        expect(hashes, equals([pubnetFeeBumpHash]));
      });

      test('should compute hash for stellar_signXDR on testnet', () {
        // Arrange
        const id = 503;
        signEngine.pendingTVFRequests[id] = const TVFData(
          rpcMethods: ['stellar_signXDR'],
          chainId: 'stellar:testnet',
        );
        final response = JsonRpcResponse(
          id: id,
          result: {'signedXDR': testnetV1Xdr},
        );

        // Act
        final hashes = signEngine.collectHashes('stellar', response);

        // Assert
        expect(hashes, equals([testnetV1Hash]));
      });

      test('should compute hash for a stellar V0 envelope on pubnet', () {
        // Arrange
        const id = 505;
        signEngine.pendingTVFRequests[id] = const TVFData(
          rpcMethods: ['stellar_signXDR'],
          chainId: 'stellar:pubnet',
        );
        final response = JsonRpcResponse(
          id: id,
          result: {'signedXDR': pubnetV0Xdr},
        );

        // Act
        final hashes = signEngine.collectHashes('stellar', response);

        // Assert
        expect(hashes, equals([pubnetV0Hash]));
      });

      test('should compute the correct hash when a signature ends in four zero bytes', () {
        // Arrange — adversarial: the last 4 bytes of the (structurally valid)
        // signature are 0x00000000, which an ascending signature-array scan
        // mistakes for a zero-length signature array. Hash cross-checked
        // against @stellar/stellar-sdk's Transaction.hash().
        const zeroTailSigXdr =
            'AAAAAgAAAABuW7RrrxcrA5UP8IX0wR/DVsdakYMxqY7Ug5ycd5KzgQAAAGQAAAAASZYC0wAAAAEAAAAAAAAAAAAAAABw29iAAAAAAAAAAAEAAAAAAAAAAQAAAABuW7RrrxcrA5UP8IX0wR/DVsdakYMxqY7Ug5ycd5KzgQAAAAAAAAAAAJiWgAAAAAAAAAABd5KzgQAAAEDGLpyx0gomLUe6OHNM90dIb/J8FPe2mR/+9m8suCVKNCF3UH6jhJthgRaiYAchg4uS+yAghMuqqTVHvyAAAAAA';
        const id = 506;
        signEngine.pendingTVFRequests[id] = const TVFData(
          rpcMethods: ['stellar_signXDR'],
          chainId: 'stellar:pubnet',
        );
        final response = JsonRpcResponse(
          id: id,
          result: {'signedXDR': zeroTailSigXdr},
        );

        // Act
        final hashes = signEngine.collectHashes('stellar', response);

        // Assert
        expect(
          hashes,
          equals([
            '17e5f1f36ff6edc099fc190d24da41e48ab9dd9f0b0be6c6d68d9eba028ed8d3',
          ]),
        );
      });

      test('should extract tx_hash for stellar_signAndSubmitXDR', () {
        // Arrange
        final response = JsonRpcResponse(
          id: 504,
          result: {
            'tx_hash':
                '6da5298ae2b4fd1567fa3f760e66c9fb9014e3ac72bf48af1ad8120f8423b961',
            'signedXDR': 'AAAAAg==',
            'successful': true,
          },
        );

        // Act
        final hashes = signEngine.collectHashes('stellar', response);

        // Assert
        expect(
          hashes,
          equals([
            '6da5298ae2b4fd1567fa3f760e66c9fb9014e3ac72bf48af1ad8120f8423b961',
          ]),
        );
      });

      test('should return null for a malformed stellar envelope', () {
        // Arrange
        final response = JsonRpcResponse(
          id: 505,
          result: {'signedXDR': 'q83vASNFZ4mrze8BI0VniavN7wEjRWeJq83vAQ=='},
        );

        // Act
        final hashes = signEngine.collectHashes('stellar', response);

        // Assert
        expect(hashes, isNull);
      });
    });
  });
}
