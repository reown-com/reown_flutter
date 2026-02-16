import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/stacks/stacks_client.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';
import 'package:reown_yttrium_utils/reown_yttrium_utils.dart';

class StacksService {
  late final ReownWalletKit _walletKit;
  late final StacksClient _stacksClient;
  final ChainMetadata chainSupported;

  Map<String, dynamic Function(String, dynamic)> get stacksRequestHandlers => {
        'stx_signMessage': stxSignMessage,
        'stx_transferStx': stxTransferStx,
      };

  StacksService({required this.chainSupported}) {
    _walletKit = GetIt.I<IWalletKitService>().walletKit;
    _stacksClient = StacksClient(
      projectId: _walletKit.core.projectId,
      networkId: chainSupported.chainId,
    );

    for (var handler in stacksRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _walletKit.onSessionRequest.subscribe(_onSessionRequest);
  }

  Future<void> init() async {
    try {
      await _stacksClient.init();
      debugPrint('[$runtimeType] _stacksClient initialized');
    } catch (e) {
      debugPrint('❌ [$runtimeType] _stacksClient init error, $e');
    }
  }

  Future<String> getAddress({
    required String wallet,
    required StacksVersion version,
    required String networkId,
  }) async {
    return await _stacksClient.getAddress(
      wallet: wallet,
      version: version,
      networkId: networkId,
    );
  }

  Future<void> stxSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] stxSignMessage: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();
      final address = params['address'].toString();

      // final feeRate = await _walletKit._stacksClient.transferFees(
      //   network: chainSupported.chainId,
      // );
      // debugPrint('[SampleWallet] transferFees $feeRate');

      // final account = await _walletKit._stacksClient.getAccount(
      //   principal: address,
      //   network: chainSupported.chainId,
      // );
      // debugPrint('[SampleWallet] getAccount ${jsonEncode(account.toJson())}');

      // final nonce = await _walletKit._stacksClient.getNonce(
      //   principal: address,
      //   network: chainSupported.chainId,
      // );
      // debugPrint('[SampleWallet] getNonce $nonce');

      if (await MethodsUtils.requestApproval(
        message,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address,
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
      )) {
        final signature = await signMessage(message);
        response = response.copyWith(result: {'signature': signature});
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } catch (e) {
      debugPrint('[SampleWallet] stxSignMessage error $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<String> signMessage(String message) async {
    final keys = GetIt.I<IKeyService>().getKeysForChain(chainSupported.chainId);

    final privateKey = keys[0].privateKey;
    final signature = await _stacksClient.signMessage(
      wallet: privateKey,
      message: message,
      networkId: chainSupported.chainId,
    );
    return signature;
  }

  Future<void> stxTransferStx(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] stxTransferStx: ${jsonEncode(parameters)}');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final sender = params['sender'] as String;
      final recipient = params['recipient'] as String;
      final amount = BigInt.parse(params['amount'].toString());
      // final amount = BigInt.parse('1000000');

      if (await MethodsUtils.requestApproval(
        jsonEncode(params),
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: sender,
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
      )) {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final privateKey = keys[0].privateKey;

        final result = await _stacksClient.transferStx(
          wallet: privateKey,
          networkId: chainSupported.chainId,
          request: TransferStxRequest(
            sender: sender,
            recipient: recipient,
            amount: amount,
            // memo: 'Reown WalletKit for Flutter', // Optional
          ),
        );

        response = response.copyWith(
          result: {'txid': result.txid, 'transaction': result.transaction},
        );
      } else {
        // User rejected manually
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } on JsonRpcError catch (e) {
      debugPrint('[SampleWallet] stxTransferStx error $e');
      response = response.copyWith(error: e);
    } catch (e) {
      debugPrint('[SampleWallet] stxTransferStx error $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: '${error.message} $e'),
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
      final handler = stacksRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }

  /// Returns the Hiro API endpoint for the chain
  String get _hiroApiEndpoint {
    return chainSupported.isTestnet
        ? 'https://api.testnet.hiro.so'
        : 'https://api.hiro.so';
  }

  /// Fetches all token balances with metadata for an address
  Future<List<Map<String, dynamic>>> getTokens({
    required String address,
  }) async {
    try {
      // Get all balances for the address
      final url = '$_hiroApiEndpoint/extended/v1/address/$address/balances';
      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        debugPrint('[StacksService] Hiro API error: ${response.statusCode}');
        return [];
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final tokens = <Map<String, dynamic>>[];

      // Fetch STX price
      final stxPrice = await _getStxPrice();

      // Process STX balance
      final stx = data['stx'] as Map<String, dynamic>?;
      if (stx != null) {
        final balance = stx['balance'] as String? ?? '0';
        final rawAmount = BigInt.parse(balance);
        final quantity =
            rawAmount / BigInt.from(10).pow(6); // STX has 6 decimals

        tokens.add({
          'name': 'Stacks',
          'symbol': 'STX',
          'chainId': chainSupported.chainId,
          'value': (quantity * stxPrice).toDouble(),
          'quantity': {
            'decimals': 6,
            'numeric': '$quantity',
          },
          'iconUrl':
              'https://assets.coingecko.com/coins/images/2069/small/Stacks_logo_full.png',
        });
      }

      // Process fungible tokens (SIP-010)
      final fungibleTokens = data['fungible_tokens'] as Map<String, dynamic>?;
      if (fungibleTokens != null) {
        for (final entry in fungibleTokens.entries) {
          final tokenId = entry.key;
          final tokenData = entry.value as Map<String, dynamic>;
          final balance = tokenData['balance'] as String? ?? '0';

          // Fetch token metadata
          final metadata = await _getTokenMetadata(tokenId);
          final decimals = metadata['decimals'] as int? ?? 6;
          final rawAmount = BigInt.parse(balance);
          final quantity = rawAmount / BigInt.from(10).pow(decimals);

          // Try to get token price from CoinGecko if it's a known token
          final symbol = metadata['symbol'] ?? _extractTokenSymbol(tokenId);
          final tokenPrice =
              await _getTokenPrice(symbol.toString().toLowerCase());

          tokens.add({
            'name': metadata['name'] ?? _extractTokenName(tokenId),
            'symbol': symbol,
            'chainId': chainSupported.chainId,
            'value': (quantity * tokenPrice).toDouble(),
            'quantity': {
              'decimals': decimals,
              'numeric': '$quantity',
            },
            'iconUrl': metadata['image_uri'] ?? metadata['image_thumbnail_uri'],
            'tokenId': tokenId,
          });
        }
      }

      debugPrint('[StacksService] getTokens found ${tokens.length} tokens');
      return tokens;
    } catch (e) {
      debugPrint('[StacksService] getTokens error: $e');
      rethrow;
    }
  }

  /// Fetches STX price in USD from CoinGecko API
  Future<double> _getStxPrice() async {
    if (chainSupported.isTestnet) {
      return 0.0;
    }

    try {
      final url =
          'https://api.coingecko.com/api/v3/simple/price?ids=blockstack&vs_currencies=usd';

      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final stxData = data['blockstack'] as Map<String, dynamic>?;
        final price = stxData?['usd'] as num?;
        return price?.toDouble() ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      debugPrint('[StacksService] _getStxPrice error: $e');
      return 0.0;
    }
  }

  /// Fetches token price from CoinGecko for known Stacks tokens
  Future<double> _getTokenPrice(String symbol) async {
    if (chainSupported.isTestnet) {
      return 0.0;
    }

    // Map of known Stacks tokens to their CoinGecko IDs
    const tokenIdMap = {
      'alex': 'alex-lab',
      'velar': 'velar',
      'leo': 'leo-token',
      'welsh': 'welsh-corgi-coin',
      'not': 'not-stacks',
      'roo': 'roo-token',
    };

    final coinGeckoId = tokenIdMap[symbol];
    if (coinGeckoId == null) {
      return 0.0;
    }

    try {
      final url =
          'https://api.coingecko.com/api/v3/simple/price?ids=$coinGeckoId&vs_currencies=usd';

      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final tokenData = data[coinGeckoId] as Map<String, dynamic>?;
        final price = tokenData?['usd'] as num?;
        return price?.toDouble() ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      debugPrint('[StacksService] _getTokenPrice error for $symbol: $e');
      return 0.0;
    }
  }

  /// Fetches token metadata from Hiro Token Metadata API
  Future<Map<String, dynamic>> _getTokenMetadata(String tokenId) async {
    try {
      // tokenId format: CONTRACT_ADDRESS::TOKEN_NAME
      final parts = tokenId.split('::');
      if (parts.length < 2) return {};

      final contractId = parts[0];
      final tokenName = parts[1];

      final url = '$_hiroApiEndpoint/metadata/v1/ft/$contractId/$tokenName';
      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        return {};
      }

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('[StacksService] _getTokenMetadata error: $e');
      return {};
    }
  }

  /// Extracts a readable name from the token ID
  String _extractTokenName(String tokenId) {
    final parts = tokenId.split('::');
    if (parts.length >= 2) {
      return parts.last.replaceAll('-', ' ');
    }
    return tokenId;
  }

  /// Extracts a symbol from the token ID
  String _extractTokenSymbol(String tokenId) {
    final name = _extractTokenName(tokenId);
    // Take first letter of each word or first 4 chars
    final words = name.split(' ');
    if (words.length > 1) {
      return words.map((w) => w.isNotEmpty ? w[0] : '').join().toUpperCase();
    }
    return name.substring(0, name.length > 4 ? 4 : name.length).toUpperCase();
  }
}
