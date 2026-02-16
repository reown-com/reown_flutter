import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:polkadart/apis/apis.dart' as dot_apis;
import 'package:polkadart/polkadart.dart' as polkadart;
import 'package:polkadart/scale_codec.dart' as scale_codec;
import 'package:polkadart/substrate/era.dart' as era;
import 'package:polkadart_keyring/polkadart_keyring.dart';

import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/chain_key.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';

import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

class PolkadotService {
  late final ReownWalletKit _walletKit;

  final ChainMetadata chainSupported;
  late final Keyring _keyring;
  late final polkadart.Provider _provider;

  Map<String, dynamic Function(String, dynamic)> get polkadotRequestHandlers =>
      {
        'polkadot_signMessage': polkadotSignMessage,
        'polkadot_signTransaction': polkadotSignTransaction,
      };

  PolkadotService({required this.chainSupported}) {
    _walletKit = GetIt.I<IWalletKitService>().walletKit;
    _keyring = Keyring();
    _provider = polkadart.Provider.fromUri(_formatRpcUrl(chainSupported));

    for (var handler in polkadotRequestHandlers.entries) {
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

  Future<void> polkadotSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] polkadotSignMessage: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();
      debugPrint('[SampleWallet] polkadotSignMessage message: $message');

      // code
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );
      final dotkeyPair = await _keyring.fromMnemonic(
        keys[0].privateKey,
        keyPairType: KeyPairType.sr25519,
      );
      // adjust the default ss58Format for Polkadot https://github.com/paritytech/ss58-registry/blob/main/ss58-registry.json
      // if westend (testnet) we don't need ss58 format
      if (!chainSupported.isTestnet) {
        dotkeyPair.ss58Format = 0;
      }

      if (await MethodsUtils.requestApproval(
        message,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: dotkeyPair.address,
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
      )) {
        final hexSignature = await signMessage(message);

        response = response.copyWith(result: {'signature': hexSignature});
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } catch (e, s) {
      debugPrint('[SampleWallet] polkadotSignMessage error $e');
      debugPrint(s.toString());
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<String> signMessage(String message) async {
    // code
    final keys = GetIt.I<IKeyService>().getKeysForChain(chainSupported.chainId);
    final dotkeyPair = await _keyring.fromMnemonic(
      keys[0].privateKey,
      keyPairType: KeyPairType.sr25519,
    );
    // adjust the default ss58Format for Polkadot https://github.com/paritytech/ss58-registry/blob/main/ss58-registry.json
    // if westend (testnet) we don't need ss58 format
    if (!chainSupported.isTestnet) {
      dotkeyPair.ss58Format = 0;
    }

    final encodedMessage = utf8.encode(message);
    final signature = dotkeyPair.sign(encodedMessage);

    final isVerified = dotkeyPair.verify(encodedMessage, signature);
    debugPrint('[$runtimeType] isVerified $isVerified');

    final hexSignature = hex.encode(signature);
    return '0x$hexSignature';
  }

  Future<void> polkadotSignTransaction(String topic, dynamic parameters) async {
    debugPrint(
      '[SampleWallet] polkadotSignTransaction: ${jsonEncode(parameters)}',
    );
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    late final List<ChainKey> keys;
    if (chainSupported.chainId.contains('e143f23803ac50e8f6f8e62695d1ce9e')) {
      keys = GetIt.I<IKeyService>().getKeysForChain(
        'polkadot_test:e143f23803ac50e8f6f8e62695d1ce9e',
      );
    } else {
      keys = GetIt.I<IKeyService>().getKeysForChain(chainSupported.chainId);
    }
    final dotkeyPair = await _keyring.fromMnemonic(
      keys[0].privateKey,
      keyPairType: KeyPairType.sr25519,
    );
    // adjust the default ss58Format for Polkadot https://github.com/paritytech/ss58-registry/blob/main/ss58-registry.json
    // if westend (testnet) we don't need ss58 format
    if (!chainSupported.isTestnet) {
      dotkeyPair.ss58Format = 0;
    }

    final trxPayload = parameters['transactionPayload'] as Map<String, dynamic>;

    const encoder = JsonEncoder.withIndent('  ');
    final message = encoder.convert(trxPayload);
    if (await MethodsUtils.requestApproval(
      message,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: dotkeyPair.address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        // Get info necessary to build an extrinsic
        // final provider = Provider.fromUri(Uri.parse(chainSupported.rpc.first));
        final stateApi = dot_apis.StateApi(_provider);

        final customMetadata = await stateApi.getMetadata();
        final registry = customMetadata.chainInfo.scaleCodec.registry;

        final payloadToSign = trxPayload.toSigningPayload(registry);
        final payloadBytes = payloadToSign.encode(registry);
        final signature = dotkeyPair.sign(payloadBytes);

        final isVerified = dotkeyPair.verify(payloadBytes, signature);
        debugPrint('[$runtimeType] isVerified $isVerified');

        final hexSignature = hex.encode(signature);
        response = response.copyWith(
          result: {'id': response.id, 'signature': '0x$hexSignature'},
        );
      } catch (e, s) {
        debugPrint('[SampleWallet] polkadotSignTransaction error $e');
        debugPrint(s.toString());
        final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } else {
      final error = Errors.getSdkError(Errors.USER_REJECTED);
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
      final handler = polkadotRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }

  /// Returns the Subscan API endpoint for the chain
  String get _subscanApiEndpoint {
    if (chainSupported.isTestnet) {
      return 'https://westend.api.subscan.io';
    }
    return 'https://polkadot.api.subscan.io';
  }

  /// Fetches account tokens with metadata using Subscan API
  /// Note: Subscan API requires an API key for production use
  /// Get your API key at https://support.subscan.io/
  Future<List<Map<String, dynamic>>> getTokens({
    required String address,
    String? apiKey,
  }) async {
    try {
      final url = '$_subscanApiEndpoint/api/scan/account/tokens';
      final headers = {
        'Content-Type': 'application/json',
        if (apiKey != null) 'X-API-Key': apiKey,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({'address': address}),
      );

      if (response.statusCode != 200) {
        debugPrint(
            '[PolkadotService] Subscan API error: ${response.statusCode}');
        // Fallback to native balance only
        return _getNativeBalanceOnly(address);
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['code'] != 0) {
        debugPrint('[PolkadotService] Subscan API error: ${data['message']}');
        return _getNativeBalanceOnly(address);
      }

      final tokenData = data['data'] as Map<String, dynamic>?;
      if (tokenData == null) {
        return _getNativeBalanceOnly(address);
      }

      final tokens = <Map<String, dynamic>>[];

      // Process native token
      final native = tokenData['native'] as List<dynamic>? ?? [];
      for (final token in native) {
        final tokenMap = token as Map<String, dynamic>;
        final decimals = tokenMap['decimals'] as int? ?? 10;
        final balance = tokenMap['balance'] as String? ?? '0';
        final rawAmount = BigInt.parse(balance);
        final quantity = rawAmount / BigInt.from(10).pow(decimals);

        tokens.add({
          'name': tokenMap['symbol'] ?? 'Polkadot',
          'symbol': tokenMap['symbol'] ?? 'DOT',
          'chainId': chainSupported.chainId,
          'value': (tokenMap['price'] as num?)?.toDouble() ?? 0.0,
          'quantity': {
            'decimals': decimals,
            'numeric': '$quantity',
          },
          'iconUrl': tokenMap['token_image'],
        });
      }

      // Process asset tokens
      final assets = tokenData['assets'] as List<dynamic>? ?? [];
      for (final token in assets) {
        final tokenMap = token as Map<String, dynamic>;
        final decimals = tokenMap['decimals'] as int? ?? 10;
        final balance = tokenMap['balance'] as String? ?? '0';
        final rawAmount = BigInt.parse(balance);
        final quantity = rawAmount / BigInt.from(10).pow(decimals);

        tokens.add({
          'name': tokenMap['symbol'] ?? 'Unknown',
          'symbol': tokenMap['symbol'] ?? 'UNKNOWN',
          'chainId': chainSupported.chainId,
          'value': (tokenMap['price'] as num?)?.toDouble() ?? 0.0,
          'quantity': {
            'decimals': decimals,
            'numeric': '$quantity',
          },
          'iconUrl': tokenMap['token_image'],
          'assetId': tokenMap['asset_id'],
        });
      }

      debugPrint('[PolkadotService] getTokens found ${tokens.length} tokens');
      return tokens;
    } catch (e) {
      debugPrint('[PolkadotService] getTokens error: $e');
      return _getNativeBalanceOnly(address);
    }
  }

  /// Fallback when Subscan API is unavailable
  /// Returns empty list - Subscan API key is required for token data
  Future<List<Map<String, dynamic>>> _getNativeBalanceOnly(
    String address,
  ) async {
    // Without Subscan API, we return empty list
    // To get token data, please provide a Subscan API key
    // Get your API key at https://support.subscan.io/
    debugPrint(
      '[PolkadotService] Subscan API required for token data. '
      'Get API key at https://support.subscan.io/',
    );
    return [];
  }
}

extension on Map<String, dynamic> {
  polkadart.SigningPayload toSigningPayload(scale_codec.Registry registry) {
    // final signedExtensions = registry.getSignedExtensionTypes();
    final requestSignedExtensions = this['signedExtensions'] as List;
    final List<MapEntry<String, dynamic>> customSignedExtensions =
        requestSignedExtensions.map((e) {
      return MapEntry<String, dynamic>(e.toString(), <String, dynamic>{});
    }).toList();

    final hexMethod = '${this['method']}'.replaceFirst('0x', '');
    final method = Uint8List.fromList(hex.decode(hexMethod));

    final hexSpecVersion = '${this['specVersion']}'.replaceFirst('0x', '');
    final specVersion = scale_codec.U32Codec.codec.decode(
      scale_codec.Input.fromHex(hexSpecVersion),
    );

    final hexTxVersion = '${this['transactionVersion']}'.replaceFirst('0x', '');
    final transactionVersion = scale_codec.U32Codec.codec.decode(
      scale_codec.Input.fromHex(hexTxVersion),
    );

    final hexBlockNumber = '${this["blockNumber"]}'.replaceFirst('0x', '');
    final blockNumber = int.parse(hexBlockNumber, radix: 16);

    final hexNonce = '${this['nonce']}'.replaceFirst('0x', '');
    final nonce = scale_codec.CompactCodec.codec.decode(
      scale_codec.Input.fromHex(hexNonce),
    );

    final hexTip = '${this['tip']}'.replaceFirst('0x', '');
    final tip = scale_codec.CompactBigIntCodec.codec.decode(
      scale_codec.Input.fromHex(hexTip),
    );

    final eraValue = this['era'].toString();
    final eraPeriod = era.Era.codec.decode(eraValue).$2;

    return polkadart.SigningPayload(
      method: method,
      specVersion: specVersion,
      transactionVersion: transactionVersion,
      genesisHash: this['genesisHash'].toString(),
      blockHash: this['blockHash'].toString(),
      blockNumber: blockNumber,
      eraPeriod: eraPeriod,
      nonce: nonce,
      tip: tip,
      customSignedExtensions: Map<String, dynamic>.fromEntries(
        customSignedExtensions,
      ),
    );
  }
}
