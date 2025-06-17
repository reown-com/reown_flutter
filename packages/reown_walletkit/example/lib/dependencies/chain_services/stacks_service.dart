import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

enum SupportedStacksMethods {
  stacksSignMessage,
  stacksStxTransfer;

  String get name {
    switch (this) {
      case stacksSignMessage:
        return 'stacks_signMessage';
      case stacksStxTransfer:
        return 'stacks_stxTransfer';
    }
  }
}

class StacksService {
  final ChainMetadata chainSupported;
  late final ReownWalletKit _walletKit;

  Map<String, dynamic Function(String, dynamic)> get stacksRequestHandlers => {
        SupportedStacksMethods.stacksSignMessage.name: stacksSignMessage,
        SupportedStacksMethods.stacksStxTransfer.name: stacksStxTransfer,
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

  Future<void> stacksSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] stacksSignMessage: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();
      final pubkey = params['pubkey'].toString();

      if (await MethodsUtils.requestApproval(
        message,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: pubkey,
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
      )) {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final privateKey = keys[0].privateKey;
        // final publicKey = keys[0].publicKey;

        final signature = await _walletKit.stacksClient.signMessage(
          wallet: privateKey,
          message: message,
        );

        // TODO Check response format
        response = response.copyWith(
          result: {
            'signature': signature,
            'publicKey': pubkey,
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
      debugPrint('[SampleWallet] stacksSignMessage error $e');
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

  Future<void> stacksStxTransfer(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] stacksStxTransfer: ${jsonEncode(parameters)}');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final params = parameters as Map<String, dynamic>;
    final pubkey = params['pubkey'] as String;
    final recipient = params['recipient'] as String;
    final amount = params['amount'] as BigInt;

    if (await MethodsUtils.requestApproval(
      jsonEncode(params),
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: pubkey,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final privateKey = keys[0].privateKey;

        final result = await _walletKit.stacksClient.transferStx(
          wallet: privateKey,
          network: chainSupported.chainId,
          request: TransferStxRequest(
            amount: amount,
            recipient: recipient,
            // memo: 'Memo example',
          ),
        );

        response = response.copyWith(
          result: result.toJson(),
        );
      } on PlatformException catch (e) {
        debugPrint('[SampleWallet] stacksStxTransfer error $e');
        response = response.copyWith(
          error: JsonRpcError(
            code: -1,
            message: '${e.code}: ${e.message}',
          ),
        );
      } catch (e) {
        debugPrint('[SampleWallet] stacksStxTransfer error $e');
        // print(e);
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
