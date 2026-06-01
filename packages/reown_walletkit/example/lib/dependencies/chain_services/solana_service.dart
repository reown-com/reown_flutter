import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_yttrium_utils/reown_yttrium_utils.dart';

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

      final address = await _getAddress();

      final requester = _walletKit.sessions.get(pRequest.topic)?.peer;
      if (await MethodsUtils.requestApproval(
        message,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address,
        transportType: pRequest.transportType.name,
        requester: requester,
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
    final keyPair = await _yttriumKeyPair();
    final messageBytes = Uint8List.fromList(base58.decode(message).toList());
    return await ReownYttriumUtils.solanaClient.signMessage(
      keyPair: keyPair,
      message: messageBytes,
    );
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

      final address = await _getAddress();

      final requester = _walletKit.sessions.get(pRequest.topic)?.peer;
      if (await MethodsUtils.requestApproval(
        beautifiedTrx,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address,
        transportType: pRequest.transportType.name,
        requester: requester,
      )) {
        // Build a base64-encoded VersionedTransaction for yttrium. Branch 1
        // (modern WC RPC) gets it directly. Branch 2 (legacy feePayer+
        // instructions form) compiles a Message via the solana package, then
        // wraps it in a SignedTx so yttrium can populate the signature.
        final String base64Tx;
        if (params.containsKey('transaction')) {
          base64Tx = params['transaction'] as String;
        } else {
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
          // Empty/placeholder signature so the wire format is well-formed;
          // yttrium will overwrite it at the correct signer slot.
          final placeholder = solana_encoder.Signature(
            List.filled(64, 0),
            publicKey: solana.Ed25519HDPublicKey.fromBase58(feePayer),
          );
          final unsignedTx = solana_encoder.SignedTx(
            signatures: [placeholder],
            compiledMessage: compiledMessage,
          );
          base64Tx = base64.encode(unsignedTx.toByteArray().toList());
        }

        final signed = await ReownYttriumUtils.solanaClient.signTransaction(
          keyPair: await _yttriumKeyPair(),
          transaction: base64Tx,
        );

        response = response.copyWith(
          result: {'signature': signed.signature},
        );
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

      final address = await _getAddress();

      final requester = _walletKit.sessions.get(pRequest.topic)?.peer;
      if (await MethodsUtils.requestApproval(
        beautifiedTrx,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address,
        transportType: pRequest.transportType.name,
        requester: requester,
      )) {
        if (params.containsKey('transactions')) {
          final transactions = (params['transactions'] as List).cast<String>();
          final signed = await ReownYttriumUtils.solanaClient
              .signAllTransactions(
                keyPair: await _yttriumKeyPair(),
                transactions: transactions,
              );
          response = response.copyWith(
            result: {
              'transactions': signed.map((s) => s.transaction).toList(),
            },
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

  /// Signs a Pay-flow `solana_signTransaction` action and returns the
  /// base64-encoded signed transaction blob (what the Pay backend wants in
  /// `confirmPayment.signatures` so it can broadcast).
  Future<String> signPayTransaction(String base64Transaction) async {
    final signed = await ReownYttriumUtils.solanaClient.signTransaction(
      keyPair: await _yttriumKeyPair(),
      transaction: base64Transaction,
    );
    return signed.transaction;
  }

  Future<String> _yttriumKeyPair() async {
    final keys = GetIt.I<IKeyService>().getKeysForChain(chainSupported.chainId);
    final stored = keys[0].privateKey;
    final keyPairBytes = Uint8List.fromList(hex.decode(stored));
    return base58.encode(keyPairBytes);
  }

  Future<String> _getAddress() async {
    final keys = GetIt.I<IKeyService>().getKeysForChain(chainSupported.chainId);
    return keys[0].address;
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
