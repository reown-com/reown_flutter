import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/ton/ton_client.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/ton/ton_validation.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

import 'package:reown_yttrium_utils/models/ton.dart';

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

  /// Returns the wallet's TON keypair from the key service.
  TonKeyPair _getKeyPair() {
    final keys =
        GetIt.I<IKeyService>().getKeysForChain(chainSupported.chainId);
    return TonKeyPair(sk: keys[0].privateKey, pk: keys[0].publicKey);
  }

  /// Returns session properties (publicKey and stateInit) for TON Connect.
  /// Not cached since this is called infrequently (only during session approval)
  /// and caching could return stale data if keys change.
  Future<TonSessionProperties?> getSessionProperties() async {
    try {
      return await _tonClient.getSessionProperties(_getKeyPair());
    } catch (e) {
      debugPrint('[$runtimeType] getSessionProperties error: $e');
      return null;
    }
  }

  Future<void> tonSignData(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tonSignData: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as List;
      final paramsMap = params.first as Map<String, dynamic>;

      // Validate BEFORE showing approval modal
      _validateSignData(paramsMap);

      final type = paramsMap['type'] as String;
      final address = paramsMap['from'] as String?;
      // Extract text for display (only present for 'text' type)
      final text = paramsMap['text'] as String?;
      final displayText = text ?? '(binary/cell data)';

      // Extract domain from session peer metadata
      final session = _walletKit.sessions.get(topic);
      final peerUrl = session?.peer.metadata.url ?? '';
      final domain = Uri.tryParse(peerUrl)?.host ?? 'unknown';

      if (await MethodsUtils.requestApproval(
        displayText,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address ?? '',
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
      )) {
        if (type == 'text' && text != null) {
          final signature = await signMessage(text);
          final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
          final network = chainSupported.chainId.split(':').last;
          response = response.copyWith(
            result: {
              'signature': signature,
              if (address != null) 'address': address,
              'publicKey': getBase64PublicKey(),
              'timestamp': timestamp,
              'domain': domain,
              'payload': {...paramsMap, 'network': network},
            },
          );
        } else {
          final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
          response = response.copyWith(
            error: JsonRpcError(
              code: error.code,
              message: 'Unsupported type $type',
            ),
          );
        }
        //
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } on TonValidationError catch (e) {
      debugPrint('[SampleWallet] tonSignData validation error: $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: e.message),
      );
      _handleResponseForTopic(topic, response);
      return;
    } catch (e) {
      debugPrint('[SampleWallet] tonSignData error: $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  String getBase64PublicKey() {
    // We generate PK in hex from Yttrium but React App requires it in base64
    return base64.encode(hex.decode(_getKeyPair().pk));
  }

  Future<String> signMessage(String message) async {
    return await _tonClient.signData(text: message, keyPair: _getKeyPair());
  }

  Future<void> tonSendMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] tonSendMessage: ${jsonEncode(parameters)}');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final paramsMap = parameters as Map<String, dynamic>;

      // Validate BEFORE showing approval modal
      _validateSendMessage(paramsMap);

      final rawValidUntil = paramsMap['valid_until'] as int;
      // Normalize milliseconds to seconds if needed
      final validUntil = normalizeValidUntil(rawValidUntil);
      final address = paramsMap['from'] as String;
      final messages = (paramsMap['messages'] as List)
          .map((e) => TonMessage.fromJson(e as Map<String, dynamic>))
          .toList();

      const encoder = JsonEncoder.withIndent('  ');
      if (await MethodsUtils.requestApproval(
        '',
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: address,
        transportType: pRequest.transportType.name,
        verifyContext: pRequest.verifyContext,
        extraModels: messages
            .map(
              (m) => WCConnectionModel(
                title: 'Message',
                elements: [encoder.convert(m.toJson())],
              ),
            )
            .toList(),
      )) {
        final signature = await _tonClient.sendMessage(
          networkId: chainSupported.chainId,
          from: address,
          validUntil: validUntil,
          messages: messages,
          keyPair: _getKeyPair(),
        );
        response = response.copyWith(result: signature);
        //
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        response = response.copyWith(
          error: JsonRpcError(code: error.code, message: error.message),
        );
      }
    } on TonValidationError catch (e) {
      debugPrint('[SampleWallet] tonSendMessage validation error: $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: e.message),
      );
      _handleResponseForTopic(topic, response);
      return;
    } catch (e) {
      debugPrint('[SampleWallet] tonSendMessage error: $e');
      final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
      response = response.copyWith(
        error: JsonRpcError(code: error.code, message: error.message),
      );
    }

    _handleResponseForTopic(topic, response);
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

  // ============ Validation Methods ============

  void _validateSendMessage(Map<String, dynamic> params) {
    // Validate from address
    final from = params['from'];
    if (from is! String) {
      throw TonValidationError('From address must be a string');
    }
    final keys =
        GetIt.I<IKeyService>().getKeysForChain(chainSupported.chainId);
    if (from != keys[0].address) {
      throw TonValidationError('From address does not match wallet');
    }

    // Validate valid_until
    final validUntil = params['valid_until'];
    if (validUntil is! int) {
      throw TonValidationError('Valid until must be a number');
    }
    if (normalizeValidUntil(validUntil) <
        DateTime.now().millisecondsSinceEpoch ~/ 1000) {
      throw TonValidationError('Message is expired');
    }

    // Validate messages
    final messages = params['messages'];
    if (messages is! List || messages.isEmpty) {
      throw TonValidationError('Messages must be a non-empty array');
    }
    messages.forEach(_validateMessage);
  }

  void _validateMessage(dynamic msg) {
    if (msg is! Map<String, dynamic>) {
      throw TonValidationError('Message must be an object');
    }
    if (!msg.containsKey('address') || msg['address'] is! String) {
      throw TonValidationError('Address must be a string');
    }
    if (!msg.containsKey('amount')) {
      throw TonValidationError('Amount is absent');
    }
    final amount = msg['amount'];
    if (amount is num) {
      throw TonValidationError(
        'Amount must be a string representing nanoTON, not a number',
      );
    }
    if (amount is! String || BigInt.tryParse(amount) == null) {
      throw TonValidationError('Amount must be a valid numeric string');
    }
  }

  void _validateSignData(Map<String, dynamic> params) {
    final type = params['type'];
    switch (type) {
      case 'text':
        if (params['text'] is! String) {
          throw TonValidationError('Text payload must have a "text" string');
        }
      case 'binary':
        if (params['bytes'] is! String) {
          throw TonValidationError(
            'Binary payload must have a "bytes" base64 string',
          );
        }
      case 'cell':
        if (params['cell'] is! String) {
          throw TonValidationError(
            'Cell payload must have a "cell" base64 string',
          );
        }
        if (params['schema'] is! String) {
          throw TonValidationError(
            'Cell payload must have a "schema" TL-B string',
          );
        }
      default:
        throw TonValidationError(
          'Invalid payload type. Must be "text", "binary", or "cell"',
        );
    }
  }
}
