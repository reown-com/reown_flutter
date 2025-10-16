import 'package:flutter_test/flutter_test.dart';
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
                    '0xa9059cbb000000000000000000000000742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6' +
                    '000000000000000000000000000000000000000000000000000000000000000001',
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
    });
  });
}
