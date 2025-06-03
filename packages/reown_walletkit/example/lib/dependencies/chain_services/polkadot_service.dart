import 'dart:convert';
import 'package:convert/convert.dart';

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

  PolkadotService({
    required this.chainSupported,
    required IWalletKitService walletKitService,
  }) {
    _walletKit = walletKitService.walletKit;
    _keyring = Keyring();
    _provider = polkadart.Provider.fromUri(Uri.parse(chainSupported.rpc.first));

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
        final encodedMessage = utf8.encode(message);
        final signature = dotkeyPair.sign(encodedMessage);

        final isVerified = dotkeyPair.verify(encodedMessage, signature);
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
    } catch (e, s) {
      debugPrint('[SampleWallet] polkadotSignMessage error $e');
      debugPrint(s.toString());
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
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

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

        final payloadToSign = trxPayload.toSigningPayload(
          registry,
        );
        final payloadBytes = payloadToSign.encode(registry);
        final signature = dotkeyPair.sign(payloadBytes);

        final isVerified = dotkeyPair.verify(payloadBytes, signature);
        debugPrint('[$runtimeType] isVerified $isVerified');

        final hexSignature = hex.encode(signature);
        response = response.copyWith(
          result: {
            'id': response.id,
            'signature': '0x$hexSignature',
          },
        );
      } catch (e, s) {
        debugPrint('[SampleWallet] polkadotSignTransaction error $e');
        debugPrint(s.toString());
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
