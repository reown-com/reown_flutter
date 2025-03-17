import 'dart:convert';
import 'dart:typed_data';
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
        'solana_signAndSendTransaction': solanaSignAndSendTransaction,
      };

  final _walletKit = GetIt.I<IWalletKitService>().walletKit;
  final ChainMetadata chainSupported;
  late final solana.Wallet _solanaWallet;

  SolanaService({required this.chainSupported}) {
    for (var handler in solanaRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<void> init() async {
    _solanaWallet = await _getSolanaWallet();
  }

  Future<void> solanaSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] solanaSignMessage request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();

      // it's being sent encoded from dapp
      final base58Decoded = base58.decode(message);
      final decodedMessage = utf8.decode(base58Decoded);
      if (await MethodsUtils.requestApproval(
        decodedMessage,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: _solanaWallet.address,
        transportType: pRequest.transportType.name,
      )) {
        final signature = await _solanaWallet.sign(base58Decoded.toList());

        response = response.copyWith(
          result: {
            'signature': signature.toBase58(),
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
      //
    } catch (e) {
      debugPrint('[SampleWallet] polkadotSignMessage error $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: error.message,
        ),
      );
    }

    await _walletKit.respondSessionRequest(
      topic: topic,
      response: response,
    );

    _handleResponseForTopic(topic, response);
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

      if (await MethodsUtils.requestApproval(
        // Show Approval Modal
        beautifiedTrx,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: _solanaWallet.address,
        transportType: pRequest.transportType.name,
      )) {
        // Sign the transaction.
        // if params contains `transaction` key we should parse that one and disregard the rest
        if (params.containsKey('transaction')) {
          final transaction = params['transaction'] as String;
          final transactionBytes = base64.decode(transaction);
          final signedTx = solana_encoder.SignedTx.fromBytes(
            transactionBytes,
          );

          // Sign the transaction.
          final signature = await _solanaWallet.sign(
            signedTx.compiledMessage.toByteArray(),
          );

          response = response.copyWith(
            result: {
              'signature': signature.toBase58(),
            },
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
          final signature = await _solanaWallet.sign(
            compiledMessage.toByteArray(),
          );

          response = response.copyWith(
            result: {
              'signature': signature.toBase58(),
            },
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
    } catch (e, s) {
      debugPrint('[SampleWallet] solanaSignTransaction error $e, $s');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: error.message,
        ),
      );
    }

    await _walletKit.respondSessionRequest(
      topic: topic,
      response: response,
    );

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

      if (await MethodsUtils.requestApproval(
        // Show Approval Modal
        beautifiedTrx,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: _solanaWallet.address,
        transportType: pRequest.transportType.name,
      )) {
        if (params.containsKey('transactions')) {
          final transactions = params['transactions'] as List;

          List<String> signedTransactions = [];
          for (var transaction in transactions) {
            final signedAndEncodedTx = await _signAndReencodeTransaction(
              transaction,
            );
            signedTransactions.add(signedAndEncodedTx);
          }

          response = response.copyWith(
            result: {
              'transactions': signedTransactions,
            },
          );
        } else {
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
    } catch (e, s) {
      debugPrint('[SampleWallet] solanaSignAllTransactions error $e, $s');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: error.message,
        ),
      );
    }

    await _walletKit.respondSessionRequest(
      topic: topic,
      response: response,
    );

    _handleResponseForTopic(topic, response);
  }

  Future<void> solanaSignAndSendTransaction(
    String topic,
    dynamic parameters,
  ) async {
    debugPrint(
      '[SampleWallet] solanaSignAndSendTransaction: ${jsonEncode(parameters)}',
    );
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final beautifiedTrx = const JsonEncoder.withIndent('  ').convert(params);

      if (await MethodsUtils.requestApproval(
        // Show Approval Modal
        beautifiedTrx,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: _solanaWallet.address,
        transportType: pRequest.transportType.name,
      )) {
        // Sign the transaction.
        // if params contains `transaction` key we should parse that one and disregard the rest
        if (params.containsKey('transaction')) {
          try {
            final transaction = params['transaction'] as String;
            final signedAndEncodedTx = await _signAndReencodeTransaction(
              transaction,
            );

            final rpcUrl = chainSupported.rpc.first;
            final transactionId =
                await solana.RpcClient(rpcUrl).sendTransaction(
              signedAndEncodedTx,
            );

            response = response.copyWith(
              result: {
                'signature': transactionId,
              },
            );
          } on solana.JsonRpcException catch (e) {
            response = response.copyWith(
              error: JsonRpcError(
                code: e.code,
                message: e.message,
              ),
            );
          }
        } else {
          // else we parse the other key/values, see https://docs.walletconnect.com/advanced/multichain/rpc-reference/solana-rpc#solana_signtransaction
          final instructionsList = params['instructions'] as List<dynamic>;
          final instructions = instructionsList.map((json) {
            return (json as Map<String, dynamic>).toInstruction();
          }).toList();

          final message = solana.Message(instructions: instructions);

          final rpcUrl = chainSupported.rpc.first;
          final trxId = await solana.RpcClient(rpcUrl).signAndSendTransaction(
            message,
            [_solanaWallet],
          );

          response = response.copyWith(
            result: {
              'signature': trxId,
            },
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
    } catch (e, s) {
      debugPrint('[SampleWallet] solanaSignTransaction error $e, $s');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: error.message,
        ),
      );
    }

    await _walletKit.respondSessionRequest(
      topic: topic,
      response: response,
    );

    _handleResponseForTopic(topic, response);
  }

  Future<String> _signAndReencodeTransaction(String encodedTx) async {
    final transactionBytes = base64.decode(encodedTx);
    final unsignedTx = solana_encoder.SignedTx.fromBytes(
      transactionBytes,
    );
    final signature = await _solanaWallet.sign(
      unsignedTx.compiledMessage.toByteArray(),
    );
    final signedTx = unsignedTx.copyWith(signatures: [
      signature,
    ]);
    return signedTx.encode();
  }

  Future<solana.Wallet> _getSolanaWallet() async {
    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final secKeyBytes = keys[0].privateKey.parse32Bytes();
    return await solana.Wallet.fromPrivateKeyBytes(
      privateKey: secKeyBytes,
    );
  }

  void _handleResponseForTopic(String topic, JsonRpcResponse response) async {
    final session = _walletKit.sessions.get(topic);

    try {
      await _walletKit.respondSessionRequest(
        topic: topic,
        response: response,
      );
      MethodsUtils.handleRedirect(
        topic,
        session!.peer.metadata.redirect,
        response.error?.message,
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
      'chainId': chainSupported.chainId
    };
    final response = await http.post(
      uri.replace(queryParameters: queryParams),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 1,
        'jsonrpc': '2.0',
        'method': 'getBalance',
        'params': [address]
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

extension on String {
  // SigningKey used by solana package requires a 32 bytes key
  Uint8List parse32Bytes() {
    try {
      final List<int> secBytes = split(',').map((e) => int.parse(e)).toList();
      return Uint8List.fromList(secBytes.sublist(0, 32));
    } catch (e) {
      final secKeyBytes = base58.decode(this);
      return Uint8List.fromList(secKeyBytes.sublist(0, 32));
    }
  }
}

extension on Map<String, dynamic> {
  solana_encoder.Instruction toInstruction() {
    final programId = this['programId'] as String;
    final programKey =
        solana.Ed25519HDPublicKey(base58.decode(programId).toList());

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
