import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/ton/ton_client.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

import 'package:reown_yttrium_utils/models/ton.dart';

class TonService {
  late final ReownWalletKit _walletKit;
  late final TonClient _tonClient;
  final ChainMetadata chainSupported;

  Map<String, dynamic Function(String, dynamic)> get tonRequestHandlers => {
        'ton_signData': tonSignData,
        'ton_sendMessage': tonSendMessage,
      };

  TonService({required this.chainSupported}) {
    _walletKit = GetIt.I<IWalletKitService>().walletKit;
    _tonClient = TonClient(
      projectId: _walletKit.core.projectId,
      networkId: chainSupported.chainId,
    );

    for (var handler in tonRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<void> init() async {
    try {
      await _tonClient.init();
      debugPrint('[$runtimeType] _tonClient initialized');
    } catch (e) {
      debugPrint('❌ [$runtimeType] _tonClient init error, $e');
    }
  }

  Future<TonKeyPair> generateKeypair() async {
    if (DartDefines.tonSK.isNotEmpty && DartDefines.tonPK.isNotEmpty) {
      return const TonKeyPair(sk: DartDefines.tonSK, pk: DartDefines.tonPK);
    }
    return await _tonClient.generateKeypair();
  }

  Future<TonKeyPair> generateKeypairFromBip39Mnemonic(String mnemonic) async {
    return await _tonClient.generateKeypairFromBip39Mnemonic(mnemonic);
  }

  Future<TonIdentity> getAddressFromKeypair(TonKeyPair keyPair) async {
    return await _tonClient.getAddressFromKeypair(keyPair);
  }

  Future<void> tonSignData(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tonSignData: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as List;
      final paramsMap = params.first as Map<String, dynamic>;
      final type = paramsMap['type'] as String;
      final text = paramsMap['text'] as String;
      final address = paramsMap['from'] as String;

      if (await MethodsUtils.requestApproval(
        text,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address,
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
      )) {
        if (type == 'text') {
          final signature = await signMessage(text);
          response = response.copyWith(
            result: {
              'signature': signature,
              'address': address,
              'publicKey': getBase64PublicKey(),
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'payload': paramsMap,
            },
          );
        } else {
          final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
          response = response.copyWith(
            error: JsonRpcError(
              code: error.code,
              message: 'Unsupported type $type',
            ),
          );
        }
        //
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } catch (e) {
      debugPrint('[SampleWallet] tonSignData error: $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  String getBase64PublicKey() {
    // We generate PK in hex from Yttrium but React App requires it in base64
    final chainId = chainSupported.chainId;
    final keys = GetIt.I<IKeyService>().getKeysForChain(chainId);
    final hexPK = keys[0].publicKey;
    return base64.encode(hex.decode(hexPK));
  }

  Future<String> signMessage(String message) async {
    final chainId = chainSupported.chainId;
    final keys = GetIt.I<IKeyService>().getKeysForChain(chainId);
    final privateKey = keys[0].privateKey;
    final publicKey = keys[0].publicKey;

    return await _tonClient.signData(
      text: message,
      keyPair: TonKeyPair(sk: privateKey, pk: publicKey),
    );
  }

  Future<void> tonSendMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tonSendMessage: ${jsonEncode(parameters)}');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final paramsMap = parameters as Map<String, dynamic>;
      final validUntil = paramsMap['valid_until'] as int;
      final address = paramsMap['from'] as String;
      final messages = (paramsMap['messages'] as List)
          .map((e) => TonMessage.fromJson(e))
          .toList();

      const encoder = JsonEncoder.withIndent('  ');
      if (await MethodsUtils.requestApproval(
        '',
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address,
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
        extraModels: messages
            .map(
              (m) => WCConnectionModel(
                title: 'Message',
                elements: [encoder.convert(m.toJson())],
              ),
            )
            .toList(),
      )) {
        final keyPair = GetIt.I<IKeyService>()
            .getKeysForChain(chainSupported.chainId)
            .first;

        final signature = await _tonClient.sendMessage(
          networkId: chainSupported.chainId,
          from: address,
          validUntil: validUntil,
          messages: messages,
          keyPair: TonKeyPair(sk: keyPair.privateKey, pk: keyPair.publicKey),
        );

        response = response.copyWith(result: signature);
        //
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } catch (e) {
      debugPrint('[SampleWallet] tonSendMessage error: $e');
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

  /// Returns the TonAPI endpoint for the chain
  String get _tonApiEndpoint {
    return chainSupported.isTestnet
        ? 'https://testnet.tonapi.io'
        : 'https://tonapi.io';
  }

  /// Fetches Jetton (TON token) balances with metadata
  /// Includes native TON balance at the beginning of the list
  Future<List<Map<String, dynamic>>> getTokens({
    required String address,
  }) async {
    try {
      final tokens = <Map<String, dynamic>>[];

      // Fetch native TON balance first
      try {
        final tonBalance = await getBalance(address: address);
        if (tonBalance > 0) {
          final tonPrice = await _getTonPrice();
          tokens.add({
            'name': 'Toncoin',
            'symbol': 'TON',
            'chainId': chainSupported.chainId,
            'value': tonBalance * tonPrice,
            'quantity': {
              'decimals': 9,
              'numeric': '$tonBalance',
            },
            'iconUrl':
                'https://assets.coingecko.com/coins/images/17980/small/ton_symbol.png',
          });
        }
      } catch (e) {
        debugPrint('[TonService] Failed to fetch TON balance: $e');
      }

      // Fetch Jettons
      final url = '$_tonApiEndpoint/v2/accounts/$address/jettons';
      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        debugPrint('[TonService] TonAPI error: ${response.statusCode}');
        return tokens;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final balances = data['balances'] as List<dynamic>? ?? [];

      for (final item in balances) {
        final jetton = item as Map<String, dynamic>;
        final jettonInfo = jetton['jetton'] as Map<String, dynamic>? ?? {};
        final balance = jetton['balance'] as String? ?? '0';

        final decimals = jettonInfo['decimals'] as int? ?? 9;
        final rawAmount = BigInt.parse(balance);
        final quantity = rawAmount / BigInt.from(10).pow(decimals);

        // Get price if available
        final price = jetton['price'] as Map<String, dynamic>?;
        final priceUsd = (price?['prices']?['USD'] as num?)?.toDouble() ?? 0.0;

        tokens.add({
          'name': jettonInfo['name'] ?? 'Unknown Jetton',
          'symbol': jettonInfo['symbol'] ?? 'JETTON',
          'chainId': chainSupported.chainId,
          'value': (quantity * priceUsd).toDouble(),
          'quantity': {
            'decimals': decimals,
            'numeric': '$quantity',
          },
          'iconUrl': jettonInfo['image'],
          'jettonAddress': jettonInfo['address'],
          'verified': jettonInfo['verification'] == 'whitelist',
        });
      }

      debugPrint('[TonService] getTokens found ${tokens.length} tokens');
      return tokens;
    } catch (e) {
      debugPrint('[TonService] getTokens error: $e');
      rethrow;
    }
  }

  /// Fetches TON price in USD from TonAPI
  Future<double> _getTonPrice() async {
    if (chainSupported.isTestnet) {
      return 0.0;
    }

    try {
      // Use TonAPI rates endpoint for TON price
      final url = '$_tonApiEndpoint/v2/rates?tokens=ton&currencies=usd';

      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final rates = data['rates'] as Map<String, dynamic>?;
        final tonRates = rates?['TON'] as Map<String, dynamic>?;
        final prices = tonRates?['prices'] as Map<String, dynamic>?;
        final usdPrice = prices?['USD'] as num?;
        return usdPrice?.toDouble() ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      debugPrint('[TonService] _getTonPrice error: $e');
      return 0.0;
    }
  }

  /// Fetches native TON balance
  Future<double> getBalance({required String address}) async {
    try {
      final url = '$_tonApiEndpoint/v2/accounts/$address';
      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        debugPrint('[TonService] TonAPI error: ${response.statusCode}');
        return 0.0;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final balance = data['balance'] as int? ?? 0;

      // TON has 9 decimals (nanoton)
      return balance / 1000000000.0;
    } catch (e) {
      debugPrint('[TonService] getBalance error: $e');
      return 0.0;
    }
  }
}
