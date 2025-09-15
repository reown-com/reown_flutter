import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:reown_pos/reown_pos.dart';
import 'package:reown_pos/services/blockchain_service.dart';
import 'package:reown_pos/services/models/query_models.dart';

import 'blockchain_service_test.mocks.dart';

@GenerateMocks([BlockchainService, ReownCore, ReownSign])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    provideDummy<JsonRpcResponse>(
      JsonRpcResponse.fromJson({'id': 1, 'result': {}}),
    );
  });

  group('ReownPos Tests', () {
    late MockBlockchainService mockBlockchainService;
    late MockReownCore mockCore;
    late MockReownSign mockSign;

    setUp(() {
      mockBlockchainService = MockBlockchainService();
      mockCore = MockReownCore();
      mockSign = MockReownSign();
    });

    test('setTokens() configures tokens correctly', () {
      final testReownPos = TestReownPos(
        projectId: '123456789',
        deviceId: '987654321',
        metadata: Metadata(
          merchantName: 'Test',
          description: 'Test',
          url: 'url',
          logoIcon: 'logoIcon',
        ),
        blockchainService: mockBlockchainService,
        core: mockCore,
        sign: mockSign,
      );

      final tokens = [
        PosToken(
          network: PosNetwork(name: 'Ethereum', chainId: 'eip155:1'),
          symbol: 'USDC',
          standard: 'erc20',
          address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
        ),
        PosToken(
          network: PosNetwork(
            name: 'Solana',
            chainId: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
          ),
          symbol: 'USDC',
          standard: 'token',
          address: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
        ),
      ];

      testReownPos.setTokens(tokens: tokens);

      expect(testReownPos.configuredTokens, equals(tokens));
      expect(testReownPos.configuredTokens.length, equals(2));
    });

    test('setTokens() throws error when empty tokens provided', () {
      final testReownPos = TestReownPos(
        projectId: '123456789',
        deviceId: '987654321',
        metadata: Metadata(
          merchantName: 'Test',
          description: 'Test',
          url: 'url',
          logoIcon: 'logoIcon',
        ),
        blockchainService: mockBlockchainService,
        core: mockCore,
        sign: mockSign,
      );

      expect(
        () => testReownPos.setTokens(tokens: []),
        throwsA(isA<ReownSignError>()),
      );
    });

    test('posSupportedNetworks method works correctly', () async {
      final response = JsonRpcResponse.fromJson({
        'id': 1,
        'result': {
          "namespaces": [
            {
              "assetNamespaces": ["token", "slip44"],
              "capabilities": null,
              "events": [],
              "methods": ["solana_signAndSendTransaction"],
              "name": "solana",
            },
            {
              "assetNamespaces": ["trc20", "slip44"],
              "capabilities": null,
              "events": [],
              "methods": ["tron_signTransaction"],
              "name": "tron",
            },
          ],
        },
      });

      when(
        mockBlockchainService.posSupportedNetworks(
          queryParams: anyNamed('queryParams'),
        ),
      ).thenAnswer((_) async => response);

      final testReownPos = TestReownPos(
        projectId: '123456789',
        deviceId: '987654321',
        metadata: Metadata(
          merchantName: 'Test',
          description: 'Test',
          url: 'url',
          logoIcon: 'logoIcon',
        ),
        blockchainService: mockBlockchainService,
        core: mockCore,
        sign: mockSign,
      );

      final queryParams = QueryParams(
        projectId: '123456789',
        deviceId: '987654321',
        st: 'test_st',
        sv: 'test_sv',
      );

      final result = await testReownPos.posSupportedNetworks(
        queryParams: queryParams,
      );

      verify(
        mockBlockchainService.posSupportedNetworks(
          queryParams: anyNamed('queryParams'),
        ),
      ).called(1);

      expect(result, equals(response));
      expect(result.result['namespaces'], isA<List>());
      expect(result.result['namespaces'].length, equals(2));
    });
  });
}

// Test implementation that allows injecting the mock services
class TestReownPos extends ReownPos {
  final BlockchainService blockchainService;
  final ReownCore core;
  final ReownSign sign;

  TestReownPos({
    required super.projectId,
    required super.deviceId,
    required super.metadata,
    required this.blockchainService,
    required this.core,
    required this.sign,
    super.logLevel,
  });

  @override
  Future<JsonRpcResponse> posSupportedNetworks({
    required QueryParams queryParams,
  }) async {
    return blockchainService.posSupportedNetworks(queryParams: queryParams);
  }

  @override
  IReownSign? get reOwnSign => sign;
}
