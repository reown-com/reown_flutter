import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:solana/solana.dart' as solana;
import 'package:solana/encoder.dart' as solana_encoder;

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

class SolanaService {
  Map<String, dynamic Function(String, dynamic)> get solanaRequestHandlers => {
        'solana_signMessage': solanaSignMessage,
        'solana_signTransaction': solanaSignTransaction,
        'solana_signAllTransactions': solanaSignAllTransaction,
      };

  late final ReownWalletKit _walletKit;
  final ChainMetadata chainSupported;

  SolanaService({required this.chainSupported}) {
    _walletKit = GetIt.I<IWalletKitService>().walletKit;
    for (var handler in solanaRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<void> solanaSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] solanaSignMessage request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString(); // base58 encoded message

      final keyPair = await _getKeyPair();

      // it's being sent encoded from dapp
      // final base58Decoded = base58.decode(message);
      // final decodedMessage = utf8.decode(base58Decoded);
      if (await MethodsUtils.requestApproval(
        message,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: keyPair.address,
        transportType: pRequest.transportType.name,
      )) {
        final signature = await signMessage(message);

        response = response.copyWith(result: {'signature': signature});
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
      //
    } catch (e) {
      debugPrint('[SampleWallet] solanaSignMessage error $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<String> signMessage(String message) async {
    final keyPair = await _getKeyPair();
    final base58Decoded = base58.decode(message);
    final signature = await keyPair.sign(base58Decoded.toList());
    return signature.toBase58();
  }

  Future<void> solanaSignTransaction(String topic, dynamic parameters) async {
    debugPrint(
      '[SampleWallet] solanaSignTransaction: ${jsonEncode(parameters)}',
    );
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final beautifiedTrx = const JsonEncoder.withIndent('  ').convert(params);

      final keyPair = await _getKeyPair();

      if (await MethodsUtils.requestApproval(
        // Show Approval Modal
        beautifiedTrx,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: keyPair.address,
        transportType: pRequest.transportType.name,
      )) {
        // Sign the transaction.
        // if params contains `transaction` key we should parse that one and disregard the rest
        if (params.containsKey('transaction')) {
          final transaction = params['transaction'] as String;
          final transactionBytes = base64.decode(transaction);
          final signedTx = solana_encoder.SignedTx.fromBytes(transactionBytes);

          // Sign the transaction.
          final signature = await keyPair.sign(
            signedTx.compiledMessage.toByteArray(),
          );

          response = response.copyWith(
            result: {'signature': signature.toBase58()},
          );
        } else {
          // else we parse the other key/values, see https://docs.walletconnect.com/advanced/multichain/rpc-reference/solana-rpc#solana_signtransaction
          final feePayer = params['feePayer'].toString();
          final recentBlockHash = params['recentBlockhash'].toString();
          final instructionsList = params['instructions'] as List<dynamic>;

          final instructions = instructionsList.map((json) {
            return (json as Map<String, dynamic>).toInstruction();
          }).toList();

          final message = solana.Message(instructions: instructions);
          final compiledMessage = message.compile(
            recentBlockhash: recentBlockHash,
            feePayer: solana.Ed25519HDPublicKey.fromBase58(feePayer),
          );

          // Sign the transaction.
          final signature = await keyPair.sign(compiledMessage.toByteArray());

          response = response.copyWith(
            result: {'signature': signature.toBase58()},
          );
        }
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } catch (e, s) {
      debugPrint('[SampleWallet] solanaSignTransaction error $e, $s');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> solanaSignAllTransaction(
    String topic,
    dynamic parameters,
  ) async {
    debugPrint(
      '[SampleWallet] solanaSignAllTransaction: ${jsonEncode(parameters)}',
    );
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final beautifiedTrx = const JsonEncoder.withIndent('  ').convert(params);

      final keyPair = await _getKeyPair();

      if (await MethodsUtils.requestApproval(
        // Show Approval Modal
        beautifiedTrx,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: keyPair.address,
        transportType: pRequest.transportType.name,
      )) {
        if (params.containsKey('transactions')) {
          final transactions = params['transactions'] as List;

          List<String> signedTransactions = [];
          for (var transaction in transactions) {
            final transactionBytes = base64.decode(transaction);
            final unsignedTx = solana_encoder.SignedTx.fromBytes(
              transactionBytes,
            );
            final signature = await keyPair.sign(
              unsignedTx.compiledMessage.toByteArray(),
            );
            final signedTx = unsignedTx.copyWith(signatures: [signature]);
            final reEncodedTx = signedTx.encode();
            signedTransactions.add(reEncodedTx);
          }

          response = response.copyWith(
            result: {'transactions': signedTransactions},
          );
        }
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } catch (e, s) {
      debugPrint('[SampleWallet] solanaSignAllTransactions error $e, $s');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<solana.Ed25519HDKeyPair> _getKeyPair() async {
    final keys = GetIt.I<IKeyService>().getKeysForChain(chainSupported.chainId);
    final secKeyBytes = keys[0].privateKey.parse32Bytes();
    return await solana.Ed25519HDKeyPair.fromPrivateKeyBytes(
      privateKey: secKeyBytes,
    );
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

  Future<dynamic> getBalance({required String address}) async {
    final uri = Uri.parse('https://rpc.walletconnect.org/v1');
    final queryParams = {
      'projectId': _walletKit.core.projectId,
      'chainId': chainSupported.chainId,
    };
    final response = await http.post(
      uri.replace(queryParameters: queryParams),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 1,
        'jsonrpc': '2.0',
        'method': 'getBalance',
        'params': [address],
      }),
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        final result = _parseRpcResultAs<Map<String, dynamic>>(response.body);
        final value = result['value'] as int;
        return value / 1000000000.0;
      } catch (e) {
        throw Exception('Failed to load balance. $e');
      }
    }
    try {
      final errorData = jsonDecode(response.body) as Map<String, dynamic>;
      final reasons = errorData['reasons'] as List<dynamic>;
      final reason = reasons.isNotEmpty
          ? reasons.first['description'] ?? ''
          : response.body;
      throw Exception(reason);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetches SPL token accounts for the given address and returns token metadata
  /// Includes native SOL balance at the beginning of the list
  Future<List<Map<String, dynamic>>> getTokens({
    required String address,
  }) async {
    try {
      final tokens = <Map<String, dynamic>>[];

      // Fetch native SOL balance first
      try {
        final solBalance = await getBalance(address: address) as double;
        if (solBalance > 0) {
          final solPrice = await _getSolPrice();
          tokens.add({
            'name': 'Solana',
            'symbol': 'SOL',
            'chainId': chainSupported.chainId,
            'value': solBalance * solPrice,
            'quantity': {
              'decimals': 9,
              'numeric': '$solBalance',
            },
            'iconUrl':
                'https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png',
          });
        }
      } catch (e) {
        debugPrint('[SolanaService] Failed to fetch SOL balance: $e');
      }

      // Fetch all SPL token accounts for the address
      final tokenAccounts = await _getTokenAccountsByOwner(address);
      if (tokenAccounts.isEmpty) {
        return tokens;
      }

      // Extract mint addresses
      final mintAddresses = tokenAccounts
          .map((account) => account['mint'] as String)
          .toSet()
          .toList();

      // Fetch token metadata from Jupiter API (mainnet only)
      // Jupiter API doesn't support devnet, so we skip metadata fetch for testnet
      final tokenMetadata = chainSupported.isTestnet
          ? <String, Map<String, dynamic>>{}
          : await _getTokenMetadata(mintAddresses);

      // Combine token accounts with metadata
      for (final account in tokenAccounts) {
        final mint = account['mint'] as String;
        final rawAmount = account['amount'] as String;
        final metadata = tokenMetadata[mint];

        // For testnet or tokens without Jupiter metadata, use on-chain decimals
        final decimals =
            metadata?['decimals'] as int? ?? account['decimals'] as int? ?? 0;
        final amount = BigInt.parse(rawAmount);
        final quantity = amount / BigInt.from(10).pow(decimals);
        final price = metadata?['usdPrice'] as double? ?? 0.0;

        tokens.add({
          'name': metadata?['name'] ?? 'SPL Token',
          'symbol': metadata?['symbol'] ?? mint.substring(0, 4),
          'chainId': chainSupported.chainId,
          'value': (quantity * price).toDouble(),
          'quantity': {
            'decimals': decimals,
            'numeric': '$quantity',
          },
          'iconUrl': metadata?['icon'],
          'mint': mint,
        });
      }

      debugPrint('[SolanaService] getTokens found ${tokens.length} tokens');
      return tokens;
    } catch (e) {
      debugPrint('[SolanaService] getTokens error: $e');
      rethrow;
    }
  }

  /// Fetches SOL price in USD from CoinGecko API
  Future<double> _getSolPrice() async {
    if (chainSupported.isTestnet) {
      return 0.0;
    }

    try {
      // Use CoinGecko simple price API (no auth required)
      final url =
          'https://api.coingecko.com/api/v3/simple/price?ids=solana&vs_currencies=usd';

      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final solanaData = data['solana'] as Map<String, dynamic>?;
        final price = solanaData?['usd'] as num?;
        return price?.toDouble() ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      debugPrint('[SolanaService] _getSolPrice error: $e');
      return 0.0;
    }
  }

  /// Fetches SPL token accounts owned by the address
  Future<List<Map<String, dynamic>>> _getTokenAccountsByOwner(
    String address,
  ) async {
    final uri = Uri.parse('https://rpc.walletconnect.org/v1');
    final queryParams = {
      'projectId': _walletKit.core.projectId,
      'chainId': chainSupported.chainId,
    };
    final response = await http.post(
      uri.replace(queryParameters: queryParams),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 1,
        'jsonrpc': '2.0',
        'method': 'getTokenAccountsByOwner',
        'params': [
          address,
          {'programId': 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA'},
          {'encoding': 'jsonParsed'},
        ],
      }),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        final result = _parseRpcResultAs<Map<String, dynamic>>(response.body);
        final value = result['value'] as List<dynamic>? ?? [];

        final tokenAccounts = <Map<String, dynamic>>[];
        for (final item in value) {
          final account = item['account'] as Map<String, dynamic>;
          final data = account['data'] as Map<String, dynamic>;
          final parsed = data['parsed'] as Map<String, dynamic>;
          final info = parsed['info'] as Map<String, dynamic>;

          final tokenAmount = info['tokenAmount'] as Map<String, dynamic>;
          final amount = tokenAmount['amount'] as String;

          // Skip zero balance tokens
          if (amount == '0') continue;

          tokenAccounts.add({
            'mint': info['mint'] as String,
            'amount': amount,
            'decimals': tokenAmount['decimals'] as int,
          });
        }

        debugPrint(
          '[SolanaService] _getTokenAccountsByOwner found ${tokenAccounts.length} accounts',
        );
        return tokenAccounts;
      } catch (e) {
        debugPrint('[SolanaService] _getTokenAccountsByOwner error: $e');
        return [];
      }
    }
    return [];
  }

  /// Fetches token metadata from Jupiter API for given mint addresses
  Future<Map<String, Map<String, dynamic>>> _getTokenMetadata(
    List<String> mintAddresses,
  ) async {
    if (mintAddresses.isEmpty) return {};

    try {
      // Jupiter API allows searching multiple mints with comma separation
      final query = mintAddresses.join(',');
      final url = 'https://lite-api.jup.ag/tokens/v2/search?query=$query';

      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        debugPrint('[SolanaService] Jupiter API error: ${response.statusCode}');
        return {};
      }

      final data = jsonDecode(response.body) as List<dynamic>;
      final metadata = <String, Map<String, dynamic>>{};

      for (final token in data) {
        final tokenMap = token as Map<String, dynamic>;
        final mint = tokenMap['id'] as String?;
        if (mint != null) {
          metadata[mint] = {
            'name': tokenMap['name'] as String?,
            'symbol': tokenMap['symbol'] as String?,
            'decimals': tokenMap['decimals'] as int?,
            'icon': tokenMap['icon'] as String?,
            'usdPrice': (tokenMap['usdPrice'] as num?)?.toDouble(),
          };
        }
      }

      debugPrint(
        '[SolanaService] _getTokenMetadata fetched ${metadata.length} tokens',
      );
      return metadata;
    } catch (e) {
      debugPrint('[SolanaService] _getTokenMetadata error: $e');
      return {};
    }
  }

  T _parseRpcResultAs<T>(String body) {
    try {
      final result = Map<String, dynamic>.from({...jsonDecode(body), 'id': 1});
      final jsonResponse = JsonRpcResponse.fromJson(result);
      if (jsonResponse.result != null) {
        return jsonResponse.result;
      } else {
        throw jsonResponse.error ?? 'Error parsing result';
      }
    } catch (e) {
      rethrow;
    }
  }
}

extension on String {
  // SigningKey used by solana package requires a 32 bytes key
  Uint8List parse32Bytes() {
    // Try comma-separated integers first (legacy format)
    if (contains(',')) {
      try {
        final List<int> secBytes = split(',').map((e) => int.parse(e)).toList();
        return Uint8List.fromList(secBytes.sublist(0, 32));
      } catch (_) {}
    }

    // Try hex decoding (stored format from _solanaChainKey is hex-encoded)
    // Check if it looks like hex: even length, only hex characters
    if (length % 2 == 0 && RegExp(r'^[0-9a-fA-F]+$').hasMatch(this)) {
      try {
        final secKeyBytes = hex.decode(this);
        // Extract first 32 bytes (private key)
        // Stored format from _solanaChainKey is privateBytes(32) + publicBytes(32) = 64 bytes = 128 hex chars
        // But also handle case where only private key is stored = 32 bytes = 64 hex chars
        return Uint8List.fromList(secKeyBytes.sublist(0, 32));
      } catch (_) {}
    }

    // Fallback to base58 decoding
    try {
      final secKeyBytes = base58.decode(this);
      return Uint8List.fromList(secKeyBytes.sublist(0, 32));
    } catch (e) {
      throw const FormatException(
        'Unable to parse private key. Expected comma-separated integers, hex string, or base58 string.',
      );
    }
  }
}

extension on Map<String, dynamic> {
  solana_encoder.Instruction toInstruction() {
    final programId = this['programId'] as String;
    final programKey = solana.Ed25519HDPublicKey(
      base58.decode(programId).toList(),
    );

    final data = (this['data'] as List).map((e) => e as int).toList();
    final data58 = base58.encode(Uint8List.fromList(data));
    final dataBytes = solana_encoder.ByteArray.fromBase58(data58);

    final keys = this['keys'] as List;
    return solana_encoder.Instruction(
      programId: programKey,
      data: dataBytes,
      accounts: keys.map((k) {
        final kParams = (k as Map<String, dynamic>);
        return solana_encoder.AccountMeta(
          pubKey: solana.Ed25519HDPublicKey.fromBase58(kParams['pubkey']),
          isWriteable: kParams['isWritable'] as bool,
          isSigner: kParams['isSigner'] as bool,
        );
      }).toList(),
    );
  }
}
