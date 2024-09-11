import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

class CosmosService {
  final _walletKit = GetIt.I<IWalletKitService>().walletKit;

  final ChainMetadata chainSupported;

  Map<String, dynamic Function(String, dynamic)> get cosmosRequestHandlers => {
        'cosmos_signDirect': cosmosSignDirect,
        'cosmos_signAmino': cosmosSignAmino,
      };

  CosmosService({required this.chainSupported}) {
    for (var handler in cosmosRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<void> cosmosSignDirect(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] cosmosSignDirect request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    final error = Errors.getSdkError(Errors.UNSUPPORTED_METHODS);
    final response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
      error: JsonRpcError(
        code: error.code,
        message: error.message,
      ),
    );

    _handleResponseForTopic(topic, response);
  }

  Future<void> cosmosSignAmino(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] cosmosSignAmino request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    final error = Errors.getSdkError(Errors.UNSUPPORTED_METHODS);
    final response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
      error: JsonRpcError(
        code: error.code,
        message: error.message,
      ),
    );

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
      );
    } on ReownSignError catch (error) {
      MethodsUtils.handleRedirect(
        topic,
        session!.peer.metadata.redirect,
        error.message,
      );
    }
  }
}
