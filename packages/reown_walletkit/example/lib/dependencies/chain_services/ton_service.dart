import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

class TonService {
  late final ReownWalletKit _walletKit;

  final ChainMetadata chainSupported;

  Map<String, dynamic Function(String, dynamic)> get tronRequestHandlers => {
        // 'ton_proof': tonProof,
        'ton_signData': tonSignData,
        'ton_sendTransaction': tonSendTransaction,
      };

  TonService({required this.chainSupported}) {
    _walletKit = GetIt.I<IWalletKitService>().walletKit;

    for (var handler in tronRequestHandlers.entries) {
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

  Future<void> tonSignData(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tonSignData: $parameters');
    //
    // _handleResponseForTopic(topic, response);
  }

  Future<void> tonSendTransaction(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tonSendTransaction: ${jsonEncode(parameters)}');
    //
    // _handleResponseForTopic(topic, response);
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
