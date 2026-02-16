import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';
import 'package:reown_walletkit_wallet/widgets/kadena_request_widget/kadena_request_widget.dart';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

class KadenaService {
  final _bottomSheetService = GetIt.I<IBottomSheetService>();
  late final ReownWalletKit _walletKit;

  final ChainMetadata chainSupported;
  late final SigningApi kadenaClient;

  /// Tracks whether the Chainweb API is available
  /// This prevents repeated failed requests when the API is down
  static bool _apiAvailable = true;
  static DateTime? _lastApiCheck;

  Map<String, dynamic Function(String, dynamic)> get kadenaRequestHandlers => {
        'kadena_getAccounts_v1': kadenaGetAccountsV1,
        'kadena_sign_v1': kadenaSignV1,
        'kadena_quicksign_v1': kadenaQuicksignV1,
      };

  KadenaService({required this.chainSupported}) {
    _walletKit = GetIt.I<IWalletKitService>().walletKit;
    kadenaClient = SigningApi();

    _walletKit.registerEventEmitter(
      chainId: chainSupported.chainId,
      event: 'kadena_transaction_updated',
    );

    for (var handler in kadenaRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _walletKit.onSessionRequest.subscribe(_onSessionRequest);
  }

  Uri _formatRpcUrl(ChainMetadata chainSupported) {
    if (chainSupported.rpc.isEmpty) {
      return Uri.parse('');
    }

    String rpcUrl = chainSupported.rpc.first;
    if (Uri.parse(rpcUrl).host == 'rpc.walletconnect.org') {
      rpcUrl += '?chainId=${chainSupported.chainId}';
      rpcUrl += '&projectId=${_walletKit.core.projectId}';
    }
    debugPrint('[SampleWallet] rpcUrl: $rpcUrl');
    return Uri.parse(rpcUrl);
  }

  Future<void> kadenaGetAccountsV1(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] kadenaGetAccountsV1 request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final accountRequest = AccountRequest.fromJson(parameters);
      final getAccountsRequest = GetAccountsRequest(accounts: [accountRequest]);
      // Get the keys for the kadena chain
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );

      final kadenaAccounts = <KadenaAccount>[];

      // Loop through the contracts of the request if it exists and add all accounts
      for (var account in getAccountsRequest.accounts) {
        for (var contract in (account.contracts ?? [])) {
          kadenaAccounts.add(
            KadenaAccount(
              name: 'k:${keys[0].publicKey}',
              contract: contract,
              chains: ['1'],
            ),
          );
        }
      }

      response = response.copyWith(
        result: GetAccountsResponse(
          accounts: [
            AccountResponse(
              account: '${chainSupported.chainId}${keys[0].publicKey}',
              publicKey: keys[0].publicKey,
              kadenaAccounts: kadenaAccounts,
            ),
          ],
        ).toJson(),
      );
    } catch (e) {
      debugPrint('[SampleWallet] kadenaGetAccountsV1 error: $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> kadenaSignV1(String topic, dynamic parameters) async {
    debugPrint(
      '[SampleWallet] kadenaSignV1 request: ${jsonEncode(parameters)}',
    );
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final chain = ChainsDataList.kadenaChains.firstWhere(
        (c) => c.chainId == chainSupported.chainId,
      );
      final uri = Uri.parse(_formatRpcUrl(chain).toString());
      final params = parameters as Map<String, dynamic>;
      params.putIfAbsent('networkId', () => uri.host);

      final signRequest = kadenaClient.parseSignRequest(request: params);

      // Get the keys for the kadena chain
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );

      final payload = kadenaClient.constructPactCommandPayload(
        request: signRequest,
        signingPubKey: keys[0].publicKey,
      );

      // Show the sign widget
      final List<bool>? approved = await _bottomSheetService.queueBottomSheet(
        widget: KadenaRequestWidget(payloads: [payload]),
      );

      // If the user approved, sign the request
      if ((approved ?? []).isNotEmpty) {
        final signature = kadenaClient.sign(
          payload: payload,
          keyPair: KadenaSignKeyPair(
            privateKey: keys[0].privateKey,
            publicKey: keys[0].publicKey,
          ),
        );

        response = response.copyWith(result: signature.toJson());
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } catch (e) {
      debugPrint('[SampleWallet] kadenaSignV1 error: $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    await _walletKit.respondSessionRequest(topic: topic, response: response);

    _handleResponseForTopic(topic, response);
  }

  Future<void> kadenaQuicksignV1(String topic, dynamic parameters) async {
    debugPrint(
      '[SampleWallet] kadenaQuicksignV1 request: ${jsonEncode(parameters)}',
    );
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final quicksignRequest = kadenaClient.parseQuicksignRequest(
        request: parameters,
      );

      // Get the keys for the kadena chain
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );

      // Show the sign widget
      final List<bool>? approved = await _bottomSheetService.queueBottomSheet(
        widget: KadenaRequestWidget(
          payloads: [
            ...(quicksignRequest.commandSigDatas
                .map((e) => PactCommandPayload.fromJson(jsonDecode(e.cmd)))
                .toList()),
          ],
        ),
      );

      if ((approved ?? <bool>[]).isNotEmpty) {
        final List<QuicksignResponse> signatures = [];

        // Loop through the requests and sign each one that is true
        for (int i = 0; i < approved!.length; i++) {
          final bool isApproved = approved[i];
          final CommandSigData request = quicksignRequest.commandSigDatas[i];
          late QuicksignResponse signature;
          if (isApproved) {
            signature = kadenaClient.quicksignSingleCommand(
              commandSigData: request,
              keyPairs: [
                KadenaSignKeyPair(
                  privateKey: keys[0].privateKey,
                  publicKey: keys[0].publicKey,
                ),
              ],
            );
          } else {
            signature = QuicksignResponse(
              commandSigData: request,
              outcome: QuicksignOutcome(
                result: QuicksignOutcome.failure,
                msg: 'User rejected sign',
              ),
            );
          }

          signatures.add(signature);
        }

        final result = QuicksignResult(responses: signatures);

        response = response.copyWith(result: result.toJson());
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } catch (e) {
      debugPrint('[SampleWallet] kadenaSignV1 error: $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  void _handleResponseForTopic(String topic, JsonRpcResponse response) async {
    final session = _walletKit.sessions.get(topic);

    try {
      await _walletKit.respondSessionRequest(topic: topic, response: response);
      MethodsUtils.handleRedirect(
        topic,
        session!.peer.metadata.redirect,
        response.error?.message,
        response.result != null,
      );
    } on ReownSignError catch (error) {
      MethodsUtils.handleRedirect(
        topic,
        session!.peer.metadata.redirect,
        error.message,
      );
    }
  }

  void _onSessionRequest(SessionRequestEvent? args) async {
    if (args != null && args.chainId == chainSupported.chainId) {
      debugPrint('[SampleWallet] _onSessionRequest ${args.toString()}');
      final handler = kadenaRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }

  /// Returns the Chainweb API endpoint
  String get _chainwebApiEndpoint {
    return chainSupported.isTestnet
        ? 'https://api.testnet.chainweb.com'
        : 'https://api.chainweb.com';
  }

  String get _networkId {
    return chainSupported.isTestnet ? 'testnet04' : 'mainnet01';
  }

  /// Fetches KDA balance across all 20 chains
  Future<List<Map<String, dynamic>>> getTokens({
    required String address,
  }) async {
    // Skip if API was recently marked as unavailable (check every 5 minutes)
    if (!_apiAvailable) {
      final now = DateTime.now();
      if (_lastApiCheck != null &&
          now.difference(_lastApiCheck!).inMinutes < 5) {
        debugPrint('[KadenaService] Skipping - API unavailable');
        return [];
      }
    }

    try {
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );
      final accountName = 'k:${keys[0].publicKey}';

      // First, check if the API is reachable by testing chain 0
      final testResult = await _getChainBalance(accountName, 0);
      if (testResult.value == -1) {
        // API is unavailable
        _apiAvailable = false;
        _lastApiCheck = DateTime.now();
        debugPrint('[KadenaService] Chainweb API unavailable');
        return [];
      }

      // API is available, mark it and fetch remaining chains
      _apiAvailable = true;

      // Kadena has 20 parallel chains (0-19)
      // Fetch balance from remaining chains (1-19) since we already have chain 0
      double totalBalance = testResult.value > 0 ? testResult.value : 0.0;
      final chainBalances = <int, double>{};
      if (testResult.value > 0) {
        chainBalances[0] = testResult.value;
      }

      // Query balances from remaining chains in parallel
      final futures = <Future<MapEntry<int, double>>>[];
      for (int chainId = 1; chainId < 20; chainId++) {
        futures.add(_getChainBalance(accountName, chainId));
      }

      final results = await Future.wait(futures);
      for (final entry in results) {
        if (entry.value > 0) {
          chainBalances[entry.key] = entry.value;
          totalBalance += entry.value;
        }
      }

      debugPrint(
        '[KadenaService] getTokens total balance: $totalBalance KDA across ${chainBalances.length} chains',
      );

      if (totalBalance == 0) {
        return [];
      }

      // Fetch KDA price
      final kdaPrice = await _getKdaPrice();

      return [
        {
          'name': 'Kadena',
          'symbol': 'KDA',
          'chainId': chainSupported.chainId,
          'value': totalBalance * kdaPrice,
          'quantity': {
            'decimals': 12,
            'numeric': '$totalBalance',
          },
          'iconUrl':
              'https://raw.githubusercontent.com/ApeSwapFinance/apeswap-token-lists/main/assets/KDA.png',
          'chainBalances': chainBalances,
        }
      ];
    } catch (e) {
      debugPrint('[KadenaService] getTokens error: $e');
      return [];
    }
  }

  /// Fetches KDA price in USD from CoinGecko API
  Future<double> _getKdaPrice() async {
    if (chainSupported.isTestnet) {
      return 0.0;
    }

    try {
      final url =
          'https://api.coingecko.com/api/v3/simple/price?ids=kadena&vs_currencies=usd';

      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final kdaData = data['kadena'] as Map<String, dynamic>?;
        final price = kdaData?['usd'] as num?;
        return price?.toDouble() ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      debugPrint('[KadenaService] _getKdaPrice error: $e');
      return 0.0;
    }
  }

  /// Fetches balance for a specific Kadena chain (0-19)
  /// Returns -1 if the API is unavailable (DNS/network error)
  Future<MapEntry<int, double>> _getChainBalance(
    String accountName,
    int chainId,
  ) async {
    try {
      final url =
          '$_chainwebApiEndpoint/chainweb/0.0/$_networkId/chain/$chainId/pact/api/v1/local';

      final pactCode = '(coin.get-balance "$accountName")';
      final cmd = {
        'cmd': jsonEncode({
          'networkId': _networkId,
          'payload': {
            'exec': {
              'data': {},
              'code': pactCode,
            },
          },
          'signers': <Map<String, dynamic>>[],
          'meta': {
            'chainId': '$chainId',
            'sender': '',
            'gasLimit': 1000,
            'gasPrice': 0.0000001,
            'ttl': 600,
            'creationTime': DateTime.now().millisecondsSinceEpoch ~/ 1000,
          },
          'nonce': DateTime.now().toIso8601String(),
        }),
        'hash': '',
        'sigs': <Map<String, dynamic>>[],
      };

      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(cmd),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        final resultData = result['result'] as Map<String, dynamic>?;

        if (resultData?['status'] == 'success') {
          final data = resultData!['data'];
          if (data is num) {
            return MapEntry(chainId, data.toDouble());
          } else if (data is Map && data['decimal'] != null) {
            return MapEntry(chainId, double.parse(data['decimal'].toString()));
          }
        }
      }
    } catch (e) {
      // Check if it's a DNS/network error (SocketException)
      final errorString = e.toString().toLowerCase();
      if (errorString.contains('socketexception') ||
          errorString.contains('failed host lookup') ||
          errorString.contains('connection refused') ||
          errorString.contains('network is unreachable')) {
        // Return -1 to indicate API unavailability
        return MapEntry(chainId, -1);
      }
      // Only log non-network errors (account not found, etc.)
      // Don't log for each chain to reduce noise
    }
    return MapEntry(chainId, 0.0);
  }
}
