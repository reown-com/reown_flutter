import 'dart:convert';
import 'package:convert/convert.dart';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

import 'package:reown_walletkit_wallet/dependencies/bip32/utils/ecurve.dart'
    as bip32;

class TronService {
  late final ReownWalletKit _walletKit;

  final ChainMetadata chainSupported;

  Map<String, dynamic Function(String, dynamic)> get tronRequestHandlers => {
        'tron_signMessage': tronSignMessage,
        'tron_signTransaction': tronSignTransaction,
      };

  TronService({required this.chainSupported}) {
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

  Future<void> tronSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tronSignMessage: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
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
    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final privateKey = keys[0].privateKey; // 0x.....

    // Step 1: Convert private key (remove '0x' if present)
    final privateKeyBytes = Uint8List.fromList(hex.decode(
        privateKey.startsWith('0x') ? privateKey.substring(2) : privateKey));

    // Step 2: Hash message with SHA256
    final msgBytes = Uint8List.fromList(message.codeUnits);
    final hashed = SHA256Digest().process(msgBytes);

    // Step 3: Sign using your custom secp256k1 sign() function
    // this returns 64 bytes (r||s)
    final signatureBytes = bip32.sign(hashed, privateKeyBytes);

    // Optional: Add v = 0 manually if needed
    final fullSignature = Uint8List.fromList([...signatureBytes, 0]);

    // Step 4: Return 0x-prefixed hex string
    return '0x${hex.encode(fullSignature)}';
  }

  Future<void> tronSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tronSignTransaction: ${jsonEncode(parameters)}');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final params = parameters as Map<String, dynamic>;
    final address = params['address'] as String;
    final payload = parameters['transaction'] as Map<String, dynamic>;
    final transaction = payload['transaction'] as Map<String, dynamic>;

    const encoder = JsonEncoder.withIndent('  ');
    final message = encoder.convert(transaction);
    if (await MethodsUtils.requestApproval(
      message,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        final rawData = transaction['raw_data'];
        final rawJson = json.encode(rawData); // must be canonical

        // Step 1: SHA256 hash of raw_data
        final hash = SHA256Digest().process(utf8.encode(rawJson));

        // Step 2: Load private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final tronPrivateKey = keys[0].privateKey.startsWith('0x')
            ? keys[0].privateKey.substring(2)
            : keys[0].privateKey; // 0x.....
        final privateKeyBytes = Uint8List.fromList(hex.decode(tronPrivateKey));

        // Step 3: Sign
        final sigBytes = bip32.sign(hash, privateKeyBytes);
        final signatureHex = hex.encode(sigBytes); // no 0x prefix

        // Step 4: Append signature
        transaction['signature'] = ['0x$signatureHex'];

        // Return signed tx
        response = response.copyWith(
          result: transaction,
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
      final handler = tronRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }
}
