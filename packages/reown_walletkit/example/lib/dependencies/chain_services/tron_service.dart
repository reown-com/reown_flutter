import 'dart:convert';
import 'package:blockchain_utils/blockchain_utils.dart' as b_utils;
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:on_chain/on_chain.dart' as on_chain;
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

import 'package:http/http.dart' as http;

class TronService {
  final _walletKit = GetIt.I<IWalletKitService>().walletKit;
  final ChainMetadata chainSupported;

  Map<String, dynamic Function(String, dynamic)> get tronRequestHandlers => {
        'tron_signMessage': tronSignMessage,
        'tron_signTransaction': tronSignTransaction,
      };

  TronService({required this.chainSupported}) {
    for (var handler in tronRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    // _walletKit.onSessionRequest.subscribe(_onSessionRequest);
  }

  Future<void> tronSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tronSignMessage: $parameters');
    final pendingRequests = await _walletKit.getPendingSessionRequests(
      topic: topic,
    );
    final pRequest = pendingRequests.values.last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final params = parameters as Map<String, dynamic>;
      final address = params['address'].toString();
      final message = params['message'].toString();

      if (await MethodsUtils.requestApproval(
        message,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address,
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
      )) {
        // Convert signature to hex string (r, s, v) → 65 bytes
        final signatureHex = await signMessage(message);

        response = response.copyWith(
          result: {
            'signature': signatureHex,
          },
        );
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(
            code: error.code,
            message: error.message,
          ),
        );
      }
    } catch (e) {
      debugPrint('[SampleWallet] tronSignMessage error $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: error.message,
        ),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<String> signMessage(String message) async {
    // code
    try {
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );

      final privateKeyHex = keys[0].privateKey;
      final signer = on_chain.TronPrivateKey(privateKeyHex);

      final msgBytes = Uint8List.fromList(message.codeUnits);
      return signer.signPersonalMessage(msgBytes);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> tronSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tronSignTransaction: ${jsonEncode(parameters)}');
    final pendingRequests = await _walletKit.getPendingSessionRequests(
      topic: topic,
    );
    final pRequest = pendingRequests.values.last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final params = parameters as Map<String, dynamic>;
    final address = params['address'] as String;
    final transactionJson =
        (parameters['transaction'] as Map<String, dynamic>?)?['transaction'] ??
            parameters['transaction'];

    const encoder = JsonEncoder.withIndent('  ');
    final message = encoder.convert(transactionJson);
    if (await MethodsUtils.requestApproval(
      message,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final privateKeyHex = keys[0].privateKey;
        final privateKey = on_chain.TronPrivateKey(privateKeyHex);

        final tronTx = on_chain.Transaction.fromJson(transactionJson);
        final txBytes = tronTx.rawData.toBuffer();

        final signature = privateKey.sign(txBytes);
        final hexSignature = b_utils.BytesUtils.toHexString(
          signature,
          prefix: '0x',
        );

        transactionJson['signature'] = [hexSignature];

        // Return signed tx
        response = response.copyWith(
          result: transactionJson,
        );
      } catch (e) {
        debugPrint('[SampleWallet] tronSignTransaction error $e');
        final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
        response = response.copyWith(
          error: JsonRpcError(
            code: error.code,
            message: error.message,
          ),
        );
      }
    } else {
      final error = Errors.getSdkError(Errors.USER_REJECTED);
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: error.message,
        ),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<Map<String, dynamic>> getAccount({required String address}) async {
    final apiEndpoint = chainSupported.isTestnet
        ? 'https://nile.trongrid.io'
        : 'https://api.trongrid.io';

    final url = '$apiEndpoint/wallet/getaccount';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'address': address,
        'visible': true,
      }),
      headers: {'accept': 'application/json'},
    );
    try {
      debugPrint('[$runtimeType] getAccount ${response.body}');
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Map<String, int>>> getTokens({required String address}) async {
    final apiEndpoint = chainSupported.isTestnet
        ? 'https://nile.trongrid.io'
        : 'https://api.trongrid.io';

    final url = '$apiEndpoint/v1/accounts/$address';
    final response = await http.get(Uri.parse(url));
    try {
      final parsedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final data = parsedResponse['data'] as List;
      if (data.isEmpty) {
        return [];
      }
      final firstData = data.first as Map<String, dynamic>;
      debugPrint('[$runtimeType] getTokens $firstData');
      return (firstData['trc20'] as List<dynamic>).map((e) {
        final token = Map<String, String>.from(e);
        return {token.keys.first: int.parse(token.values.first)};
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<double> getBalance({required String address}) async {
    final apiEndpoint = chainSupported.isTestnet
        ? 'https://nile.trongrid.io'
        : 'https://api.trongrid.io';

    final blockResponse = await http.get(
      Uri.parse('$apiEndpoint/walletsolidity/getnowblock'),
    );
    final blockID = jsonDecode(blockResponse.body)['blockID'] as String;
    final blockNumber = jsonDecode(blockResponse.body)['block_header']
        ['raw_data']['number'] as num;
    //

    final url = '$apiEndpoint/wallet/getaccountbalance';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'account_identifier': {'address': address},
        'block_identifier': {'hash': blockID, 'number': blockNumber},
        'visible': true
      }),
      headers: {'accept': 'application/json'},
    );

    try {
      final parsedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final intBalance = (parsedResponse['balance'] as int);
      debugPrint('[$runtimeType] getBalance $intBalance');
      // return (intBalance / 1000000.0);
      return parsedBalance(intBalance);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  double parsedBalance(int rawBalance) {
    return (rawBalance / 1000000.0);
  }

  void _handleResponseForTopic(String topic, JsonRpcResponse response) async {
    final activeSessions = await _walletKit.getActiveSessionByTopic(
      sessionTopic: topic,
    );
    final session = activeSessions.values.last;

    try {
      await _walletKit.respondSessionRequest(
        topic: topic,
        response: response,
      );
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
      final handler = tronRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }
}
