import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/ton/ton_client.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

import 'package:reown_yttrium/models/ton.dart';

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
      return TonKeyPair(sk: DartDefines.tonSK, pk: DartDefines.tonPK);
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
    //  [{type: text, text: Hello from WalletConnect TON, from: EQB_Kdx9GXsDatq7-wTciIY4xOe5vITtH1RWMN4aiv2rGL8X}]
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final params = parameters as List;
      final paramsMap = params.first as Map<String, dynamic>;
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
        final keyPair = GetIt.I<IKeyService>()
            .getKeysForChain(chainSupported.chainId)
            .first;

        final signature = await _tonClient.signData(
          text: text,
          keyPair: TonKeyPair(
            sk: keyPair.privateKey,
            pk: keyPair.publicKey,
          ),
        );

        response = response.copyWith(
          result: signature,
        );
        //
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
      debugPrint('[SampleWallet] tonSignData error: $e');
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

  Future<void> tonSendMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tonSendMessage: ${jsonEncode(parameters)}');
    // [{"valid_until":1760369763,"from":"EQB_Kdx9GXsDatq7-wTciIY4xOe5vITtH1RWMN4aiv2rGL8X","messages":[{"address":"EQB_Kdx9GXsDatq7-wTciIY4xOe5vITtH1RWMN4aiv2rGL8X","amount":"1000"}]}]
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final params = parameters as List;
      final paramsMap = params.first as Map<String, dynamic>;
      final validUntil = paramsMap['valid_until'] as int;
      final address = paramsMap['from'] as String;
      final messages = (paramsMap['messages'] as List)
          .map((e) => TonMessage.fromJson(e))
          .toList();

      const encoder = JsonEncoder.withIndent('  ');
      if (await MethodsUtils.requestApproval('',
          method: pRequest.method,
          chainId: pRequest.chainId,
          address: address,
          transportType: pRequest.transportType.name,
          verifyContext: pRequest.verifyContext,
          extraModels: messages
              .map((m) => WCConnectionModel(
                    title: 'Message',
                    elements: [encoder.convert(m.toJson())],
                  ))
              .toList())) {
        final keyPair = GetIt.I<IKeyService>()
            .getKeysForChain(chainSupported.chainId)
            .first;

        final signature = await _tonClient.sendMessage(
          networkId: chainSupported.chainId,
          from: address,
          validUntil: validUntil,
          messages: messages,
          keyPair: TonKeyPair(
            sk: keyPair.privateKey,
            pk: keyPair.publicKey,
          ),
        );

        response = response.copyWith(
          result: signature,
        );
        //
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
      debugPrint('[SampleWallet] tonSendMessage error: $e');
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
}
