import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

enum SupportedStacksMethods {
  stxSignMessage,
  stxTransferStx;

  String get name {
    switch (this) {
      case stxSignMessage:
        return 'stx_signMessage';
      case stxTransferStx:
        return 'stx_transferStx';
    }
  }
}

class StacksService {
  final ChainMetadata chainSupported;
  late final ReownWalletKit _walletKit;

  Map<String, dynamic Function(String, dynamic)> get stacksRequestHandlers => {
        SupportedStacksMethods.stxSignMessage.name: stxSignMessage,
        SupportedStacksMethods.stxTransferStx.name: stxTransferStx,
      };

  StacksService({required this.chainSupported}) {
    _walletKit = GetIt.I<IWalletKitService>().walletKit;

    for (var handler in stacksRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _walletKit.onSessionRequest.subscribe(_onSessionRequest);
  }

  Future<void> stxSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] stxSignMessage: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();
      final address = params['address'].toString();

      // final feeRate = await _walletKit.stacksClient.transferFees(
      //   network: chainSupported.chainId,
      // );
      // debugPrint('[SampleWallet] transferFees $feeRate');

      // final account = await _walletKit.stacksClient.getAccount(
      //   principal: address,
      //   network: chainSupported.chainId,
      // );
      // debugPrint('[SampleWallet] getAccount ${jsonEncode(account.toJson())}');

      // final nonce = await _walletKit.stacksClient.getNonce(
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
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        if (address != keys[0].address) {
          throw Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
        }

        final privateKey = keys[0].privateKey;
        final signature = await _walletKit.stacksClient.signMessage(
          wallet: privateKey,
          message: message,
        );

        response = response.copyWith(
          result: {
            'signature': signature,
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
      debugPrint('[SampleWallet] stxSignMessage error $e');
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

  Future<void> stxTransferStx(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] stxTransferStx: ${jsonEncode(parameters)}');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

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

        final result = await _walletKit.stacksClient.transferStx(
          wallet: privateKey,
          network: chainSupported.chainId,
          request: TransferStxRequest(
            sender: sender,
            recipient: recipient,
            amount: amount,
            // memo: 'Reown WalletKit for Flutter', // Optional
          ),
        );

        response = response.copyWith(
          result: {
            'txid': result.txid,
            'transaction': result.transaction,
          },
        );
      } else {
        // User rejected manually
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(
            code: error.code,
            message: error.message,
          ),
        );
      }
    } on JsonRpcError catch (e) {
      debugPrint('[SampleWallet] stxTransferStx error $e');
      response = response.copyWith(
        error: e,
      );
    } catch (e) {
      debugPrint('[SampleWallet] stxTransferStx error $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: '${error.message} $e',
        ),
      );
    }

    _handleResponseForTopic(topic, response);
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
}
