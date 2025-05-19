import 'dart:convert';
import 'package:convert/convert.dart';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';

import 'package:polkadart/polkadart.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

class PolkadotService {
  late final ReownWalletKit _walletKit;

  final ChainMetadata chainSupported;
  late final Keyring keyring;
  late final Provider provider;

  Map<String, dynamic Function(String, dynamic)> get polkadotRequestHandlers =>
      {
        'polkadot_signMessage': polkadotSignMessage,
        'polkadot_signTransaction': polkadotSignTransaction,
      };

  PolkadotService({
    required this.chainSupported,
    required IWalletKitService walletKitService,
  }) {
    _walletKit = walletKitService.walletKit;
    keyring = Keyring();
    provider = Provider.fromUri(Uri.parse(chainSupported.rpc.first));

    for (var handler in polkadotRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _walletKit.onSessionRequest.subscribe(_onSessionRequest);
  }

  Future<void> polkadotSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] polkadotSignMessage: $parameters');
    const method = 'polkadot_signMessage';
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();
      debugPrint('[SampleWallet] polkadotSignMessage message: $message');

      // code
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );
      final keyPair = await keyring.fromUri(keys[0].privateKey);
      // adjust the default ss58Format for Polkadot
      keyPair.ss58Format = 0;
      // adjust the default ss58Format for Kusama
      // keyPair.ss58Format = 2;

      if (await MethodsUtils.requestApproval(
        message,
        title: method,
        transportType: pRequest.transportType.name,
      )) {
        final encodedMessage = utf8.encode(message);
        final signature = keyPair.sign(encodedMessage);

        final isVerified = keyPair.verify(encodedMessage, signature);
        debugPrint('[$runtimeType] isVerified $isVerified');

        final hexSignature = hex.encode(signature);
        response = response.copyWith(
          result: {
            'signature': '0x$hexSignature',
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
      debugPrint('[SampleWallet] polkadotSignMessage error $e');
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

  Future<void> polkadotSignTransaction(String topic, dynamic parameters) async {
    debugPrint(
        '[SampleWallet] polkadotSignTransaction: ${jsonEncode(parameters)}');
    const method = 'polkadot_signTransaction';
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final trxPayload = parameters['transactionPayload'] as Map<String, dynamic>;

    const encoder = JsonEncoder.withIndent('  ');
    final message = encoder.convert(trxPayload);
    if (await MethodsUtils.requestApproval(
      message,
      title: method,
      transportType: pRequest.transportType.name,
    )) {
      try {
        final keyPair = await keyring.fromUri(keys[0].privateKey);
        // adjust the default ss58Format for Polkadot
        keyPair.ss58Format = 0;
        // adjust the default ss58Format for Kusama
        // keyPair.ss58Format = 2;

        // Get info necessary to build an extrinsic
        final provider = Provider.fromUri(Uri.parse(chainSupported.rpc.first));
        final stateApi = StateApi(provider);
        final customMetadata = await stateApi.getMetadata();
        final registry = customMetadata.chainInfo.scaleCodec.registry;

        final payload = trxPayload.toSigningPayload(registry);
        final payloadBytes = payload.encode(registry);
        final signature = keyPair.sign(payloadBytes);

        final isVerified = keyPair.verify(payloadBytes, signature);
        debugPrint('[$runtimeType] isVerified $isVerified');

        final hexSignature = hex.encode(signature);
        response = response.copyWith(
          result: {
            'signature': '0x$hexSignature',
          },
        );
      } catch (e) {
        debugPrint('[SampleWallet] polkadotSignTransaction error $e');
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
}

extension on Map<String, dynamic> {
  SigningPayload toSigningPayload(Registry registry) {
    final signedExtensions = registry.getSignedExtensionTypes();
    final requestSignedExtensions = this['signedExtensions'] as List;
    final mapEntries = requestSignedExtensions.map((e) {
      return MapEntry<String, dynamic>(e, signedExtensions[e]);
    }).toList();

    final method = this['method'].toString();
    final decoded = hex.decode(method.substring(2));
    final decodedMethod = utf8.decode(decoded);
    return SigningPayload(
      method: utf8.encode(decodedMethod),
      specVersion: int.parse(this['specVersion']),
      transactionVersion: int.parse(this['transactionVersion']),
      genesisHash: this['genesisHash'].toString(),
      blockHash: this['blockHash'].toString(),
      blockNumber: int.parse(this['blockNumber']),
      eraPeriod: int.parse(this['era']),
      nonce: int.parse(this['nonce']),
      tip: int.parse(this['tip']),
      customSignedExtensions: Map.fromEntries(mapEntries),
    );
  }
}
