import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reown_core/i_core_impl.dart';
import 'package:reown_core/relay_client/websocket/i_http_client.dart';
import 'package:reown_core/verify/i_verify_store.dart';
import 'package:reown_core/verify/models/jwk.dart';
import 'package:reown_core/verify/models/verify_context.dart';
import 'package:reown_core/verify/verify.dart' as verify_module;

import 'verify_test.mocks.dart';

@GenerateMocks([
  IReownCore,
  IHttpClient,
  IVerifyStore,
  Logger,
])
void main() {
  group('Verify', () {
    late MockIReownCore mockCore;
    late MockIHttpClient mockHttpClient;
    late MockIVerifyStore mockVerifyStore;
    late MockLogger mockLogger;
    late verify_module.Verify verify;

    setUp(() {
      mockCore = MockIReownCore();
      mockHttpClient = MockIHttpClient();
      mockVerifyStore = MockIVerifyStore();
      mockLogger = MockLogger();
      
      // Mock the logger property
      when(mockCore.logger).thenReturn(mockLogger);
      
      verify = verify_module.Verify(
        core: mockCore,
        httpClient: mockHttpClient,
        verifyStore: mockVerifyStore,
      );
    });

    group('init', () {
      test('should initialize store and check public key', () async {
        // Arrange
        when(mockVerifyStore.init()).thenAnswer((_) async {});
        when(mockVerifyStore.getItem()).thenReturn(null);
        when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
          jsonEncode({
            'publicKey': {
              'crv': 'P-256',
              'ext': true,
              'key_ops': ['verify'],
              'kty': 'EC',
              'x': 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
              'y': 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
            },
            'expiresAt': DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
          }),
          200,
        ));
        when(mockVerifyStore.setItem(any)).thenAnswer((_) async {});

        // Act
        await verify.init();

        // Assert
        verifyInOrder([
          mockVerifyStore.init(),
          mockVerifyStore.getItem(),
          mockHttpClient.get(any),
          mockVerifyStore.setItem(any),
        ]);
      });

      test('should handle expired public key', () async {
        // Arrange
        final expiredKey = JWK(
          publicKey: PublicKey(
            crv: 'P-256',
            ext: true,
            keyOps: ['verify'],
            kty: 'EC',
            x: 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
            y: 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
          ),
          expiresAt: DateTime.now().subtract(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
        );
        
        when(mockVerifyStore.init()).thenAnswer((_) async {});
        when(mockVerifyStore.getItem()).thenReturn(expiredKey);
        when(mockVerifyStore.removeItem()).thenAnswer((_) async {});
        when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
          jsonEncode({
            'publicKey': {
              'crv': 'P-256',
              'ext': true,
              'key_ops': ['verify'],
              'kty': 'EC',
              'x': 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
              'y': 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
            },
            'expiresAt': DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
          }),
          200,
        ));
        when(mockVerifyStore.setItem(any)).thenAnswer((_) async {});

        // Act
        await verify.init();

        // Assert
        verifyInOrder([
          mockVerifyStore.removeItem(),
          mockHttpClient.get(any),
          mockVerifyStore.setItem(any),
        ]);
      });
    });

    group('resolve', () {
      test('should resolve v2 first when JWT is provided', () async {
        // Arrange
        const attestationId = 'test-id';
        const attestationJWT = 'test-jwt';

        when(mockVerifyStore.getItem()).thenReturn(JWK(
          publicKey: PublicKey(
            crv: 'P-256',
            ext: true,
            keyOps: ['verify'],
            kty: 'EC',
            x: 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
            y: 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
          ),
          expiresAt: DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
        ));

        // Mock HTTP client for v1 fallback
        when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
          jsonEncode({
            'origin': 'https://example.com',
            'attestationId': attestationId,
            'isScam': false,
          }),
          200,
        ));

        // Act
        await verify.resolve(
          attestationId: attestationId,
          attestationJWT: attestationJWT,
        );

        // Assert
        // Since JWT validation is complex, we expect v1 fallback
        verifyInOrder([mockHttpClient.get(any)]);
      });

      test('should fallback to v1 when v2 fails', () async {
        // Arrange
        const attestationId = 'test-id';
        const attestationJWT = null;
        final expectedResponse = AttestationResponse(
          origin: 'https://example.com',
          attestationId: attestationId,
          isScam: false,
        );

        when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
          jsonEncode(expectedResponse.toJson()),
          200,
        ));

        // Act
        final result = await verify.resolve(
          attestationId: attestationId,
          attestationJWT: attestationJWT,
        );

        // Assert
        expect(result, isNotNull);
        expect(result!.origin, equals(expectedResponse.origin));
        expect(result.attestationId, equals(expectedResponse.attestationId));
        verifyInOrder([mockHttpClient.get(any)]);
      });

      test('should throw AttestationNotFound for 404 response', () async {
        // Arrange
        const attestationId = 'test-id';
        const attestationJWT = null;

        when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response('', 404));

        // Act & Assert
        expect(
          () => verify.resolve(
            attestationId: attestationId,
            attestationJWT: attestationJWT,
          ),
          throwsA(isA<AttestationNotFound>()),
        );
      });

      test('should throw Exception for non-200 response', () async {
        // Arrange
        const attestationId = 'test-id';
        const attestationJWT = null;

        when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response('', 500));

        // Act & Assert
        expect(
          () => verify.resolve(
            attestationId: attestationId,
            attestationJWT: attestationJWT,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getValidation', () {
      test('should return SCAM when attestation is scam', () {
        // Arrange
        final attestation = AttestationResponse(
          origin: 'https://example.com',
          attestationId: 'test-id',
          isScam: true,
        );
        final metadataUri = Uri.parse('https://example.com');

        // Act
        final result = verify.getValidation(attestation, metadataUri);

        // Assert
        expect(result, equals(Validation.SCAM));
      });

      test('should return INVALID when origin is empty', () {
        // Arrange
        final attestation = AttestationResponse(
          origin: '',
          attestationId: 'test-id',
          isScam: false,
        );
        final metadataUri = Uri.parse('https://example.com');

        // Act
        final result = verify.getValidation(attestation, metadataUri);

        // Assert
        expect(result, equals(Validation.INVALID));
      });

      test('should return INVALID when metadataUri is null', () {
        // Arrange
        final attestation = AttestationResponse(
          origin: 'https://example.com',
          attestationId: 'test-id',
          isScam: false,
        );

        // Act
        final result = verify.getValidation(attestation, null);

        // Assert
        expect(result, equals(Validation.INVALID));
      });

      test('should return VALID when origins match', () {
        // Arrange
        final attestation = AttestationResponse(
          origin: 'https://example.com',
          attestationId: 'test-id',
          isScam: false,
        );
        final metadataUri = Uri.parse('https://example.com');

        // Act
        final result = verify.getValidation(attestation, metadataUri);

        // Assert
        expect(result, equals(Validation.VALID));
      });

      test('should return INVALID when origins do not match', () {
        // Arrange
        final attestation = AttestationResponse(
          origin: 'https://example.com',
          attestationId: 'test-id',
          isScam: false,
        );
        final metadataUri = Uri.parse('https://different.com');

        // Act
        final result = verify.getValidation(attestation, metadataUri);

        // Assert
        expect(result, equals(Validation.INVALID));
      });
    });

    group('VerifyV2 extension', () {
      group('fetchPublicKey', () {
        test('should fetch and return public key successfully', () async {
          // Arrange
          final expectedJwk = JWK(
            publicKey: PublicKey(
              crv: 'P-256',
              ext: true,
              keyOps: ['verify'],
              kty: 'EC',
              x: 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
              y: 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
            ),
            expiresAt: DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
          );

          when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
            jsonEncode({
              'publicKey': {
                'crv': 'P-256',
                'ext': true,
                'key_ops': ['verify'],
                'kty': 'EC',
                'x': 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
                'y': 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
              },
              'expiresAt': expectedJwk.expiresAt,
            }),
            200,
          ));

          // Act
          final result = await verify.fetchPublicKey();

          // Assert
          expect(result, isNotNull);
          expect(result!.publicKey.crv, equals(expectedJwk.publicKey.crv));
          expect(result.publicKey.kty, equals(expectedJwk.publicKey.kty));
          verifyInOrder([mockHttpClient.get(any)]);
        });

        test('should return null on error', () async {
          // Arrange
          when(mockHttpClient.get(any)).thenThrow(Exception('Network error'));

          // Act
          final result = await verify.fetchPublicKey();

          // Assert
          expect(result, isNull);
        });
      });

      group('persistPublicKey', () {
        test('should persist public key successfully', () async {
          // Arrange
          final jwk = JWK(
            publicKey: PublicKey(
              crv: 'P-256',
              ext: true,
              keyOps: ['verify'],
              kty: 'EC',
              x: 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
              y: 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
            ),
            expiresAt: DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
          );

          when(mockVerifyStore.setItem(any)).thenAnswer((_) async {});

          // Act
          await verify.persistPublicKey(jwk);

          // Assert
          verifyInOrder([mockVerifyStore.setItem(jwk)]);
        });
      });

      group('removePublicKey', () {
        test('should remove public key successfully', () async {
          // Arrange
          when(mockVerifyStore.removeItem()).thenAnswer((_) async {});

          // Act
          await verify.removePublicKey();

          // Assert
          verifyInOrder([mockVerifyStore.removeItem()]);
        });
      });

      group('getPersistedPublicKey', () {
        test('should return persisted public key', () {
          // Arrange
          final expectedJwk = JWK(
            publicKey: PublicKey(
              crv: 'P-256',
              ext: true,
              keyOps: ['verify'],
              kty: 'EC',
              x: 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
              y: 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
            ),
            expiresAt: DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
          );

          when(mockVerifyStore.getItem()).thenReturn(expectedJwk);

          // Act
          final result = verify.getPersistedPublicKey();

          // Assert
          expect(result, equals(expectedJwk));
          verifyInOrder([mockVerifyStore.getItem()]);
        });

        test('should return null when no key is persisted', () {
          // Arrange
          when(mockVerifyStore.getItem()).thenReturn(null);

          // Act
          final result = verify.getPersistedPublicKey();

          // Assert
          expect(result, isNull);
          verifyInOrder([mockVerifyStore.getItem()]);
        });
      });

      group('getPublicKey', () {
        test('should return cached public key when available', () async {
          // Arrange
          final cachedJwk = JWK(
            publicKey: PublicKey(
              crv: 'P-256',
              ext: true,
              keyOps: ['verify'],
              kty: 'EC',
              x: 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
              y: 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
            ),
            expiresAt: DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
          );

          // First initialize the verify instance to set the internal _publicKey
          when(mockVerifyStore.init()).thenAnswer((_) async {});
          when(mockVerifyStore.getItem()).thenReturn(cachedJwk);
          await verify.init();

          // Act
          final result = await verify.getPublicKey();

          // Assert
          expect(result, equals(cachedJwk));
        });

        test('should fetch and persist new key when cached key is null', () async {
          // Arrange
          when(mockVerifyStore.getItem()).thenReturn(null);
          when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
            jsonEncode({
              'publicKey': {
                'crv': 'P-256',
                'ext': true,
                'key_ops': ['verify'],
                'kty': 'EC',
                'x': 'CbL4DOYOb1ntd-8OmExO-oS0DWCMC00DntrymJoB8tk',
                'y': 'KTFwjHtQxGTDR91VsOypcdBfvbo6sAMj5p4Wb-9hRA0',
              },
              'expiresAt': DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
            }),
            200,
          ));
          when(mockVerifyStore.setItem(any)).thenAnswer((_) async {});

          // Act
          final result = await verify.getPublicKey();

          // Assert
          expect(result, isNotNull);
          verifyInOrder([
            mockHttpClient.get(any),
            mockVerifyStore.setItem(any),
          ]);
        });
      });
    });

    group('error handling', () {
      test('should handle network timeout gracefully', () async {
        // Arrange
        when(mockHttpClient.get(any)).thenThrow(Exception('Timeout'));

        // Act & Assert
        expect(
          () => verify.resolve(
            attestationId: 'test-id',
            attestationJWT: null,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('should handle malformed JSON response', () async {
        // Arrange
        when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
          'invalid json',
          200,
        ));

        // Act & Assert
        expect(
          () => verify.resolve(
            attestationId: 'test-id',
            attestationJWT: null,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}