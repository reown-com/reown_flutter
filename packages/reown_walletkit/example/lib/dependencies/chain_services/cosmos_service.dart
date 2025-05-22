import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

class CosmosService {
  late final ReownWalletKit _walletKit;

  final ChainMetadata chainSupported;

  Map<String, dynamic Function(String, dynamic)> get cosmosRequestHandlers => {
        'cosmos_getAccounts': cosmosGetAccounts,
        'cosmos_signDirect': cosmosSignDirect,
        'cosmos_signAmino': cosmosSignAmino,
      };

  CosmosService({
    required this.chainSupported,
    required IWalletKitService walletKitService,
  }) {
    _walletKit = walletKitService.walletKit;
    for (var handler in cosmosRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<void> cosmosGetAccounts(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] cosmosGetAccounts request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final address = keys[0].address;

    if (await MethodsUtils.requestApproval(
      '',
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      final publicKey = keys[0].publicKey;
      response = response.copyWith(
        result: [
          {
            'algo': 'secp256k1',
            'address': address,
            'pubkey': publicKey,
          }
        ],
      );
    } else {
      final error = Errors.getSdkError(Errors.USER_REJECTED).toSignError();
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: error.message,
        ),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> cosmosSignDirect(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] cosmosSignDirect request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final address = keys[0].address;

    final trxPayload = parameters as Map<String, dynamic>;
    const encoder = JsonEncoder.withIndent('  ');
    final message = encoder.convert(trxPayload);
    if (await MethodsUtils.requestApproval(
      message,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      final publicKey = keys[0].publicKey;
      response = response.copyWith(
        result: {
          // TODO result is hardcoded for testing purposes
          // proper signing tools has yet to be implemented
          'signature': {
            'pub_key': {
              'type': 'tendermint/PubKeySecp256k1',
              'value': publicKey
            },
            'signature':
                'S7BJEbiXQ6vxvF9o4Wj7qAcocMQqBsqz+NVH4wilhidFsRpyqpSP5XiXoQZxTDrT9uET/S5SH6+5gUmjYntH/Q=='
          },
          'signed': {
            'chainId': 'cosmoshub-4',
            'accountNumber': '2612147',
            'authInfoBytes':
                'ClAKRgofL2Nvc21vcy5jcnlwdG8uc2VjcDI1NmsxLlB1YktleRIjCiEDNOXj4u60JFq00+VbLBCNBTYy76Pn864AvYNFG/9cQwMSBAoCCH8YAhITCg0KBXVhdG9tEgQ0NTM1EIaJCw==',
            'bodyBytes':
                'CpoICikvaWJjLmFwcGxpY2F0aW9ucy50cmFuc2Zlci52MS5Nc2dUcmFuc2ZlchLsBwoIdHJhbnNmZXISC2NoYW5uZWwtMTQxGg8KBXVhdG9tEgYxODg4MDYiLWNvc21vczFhanBkZndsZmRqY240MG5yZXN5ZHJxazRhOGo2ZG0wemY0MGszcSo/b3NtbzEwYTNrNGh2azM3Y2M0aG54Y3R3NHA5NWZoc2NkMno2aDJybXgwYXVrYzZybTh1OXFxeDlzbWZzaDd1MgcIARDFt5YRQsgGeyJ3YXNtIjp7ImNvbnRyYWN0Ijoib3NtbzEwYTNrNGh2azM3Y2M0aG54Y3R3NHA5NWZoc2NkMno2aDJybXgwYXVrYzZybTh1OXFxeDlzbWZzaDd1IiwibXNnIjp7InN3YXBfYW5kX2FjdGlvbiI6eyJ1c2VyX3N3YXAiOnsic3dhcF9leGFjdF9hc3NldF9pbiI6eyJzd2FwX3ZlbnVlX25hbWUiOiJvc21vc2lzLXBvb2xtYW5hZ2VyIiwib3BlcmF0aW9ucyI6W3sicG9vbCI6IjE0MDAiLCJkZW5vbV9pbiI6ImliYy8yNzM5NEZCMDkyRDJFQ0NENTYxMjNDNzRGMzZFNEMxRjkyNjAwMUNFQURBOUNBOTdFQTYyMkIyNUY0MUU1RUIyIiwiZGVub21fb3V0IjoidW9zbW8ifSx7InBvb2wiOiIxMzQ3IiwiZGVub21faW4iOiJ1b3NtbyIsImRlbm9tX291dCI6ImliYy9ENzlFN0Q4M0FCMzk5QkZGRjkzNDMzRTU0RkFBNDgwQzE5MTI0OEZDNTU2OTI0QTJBODM1MUFFMjYzOEIzODc3In1dfX0sIm1pbl9hc3NldCI6eyJuYXRpdmUiOnsiZGVub20iOiJpYmMvRDc5RTdEODNBQjM5OUJGRkY5MzQzM0U1NEZBQTQ4MEMxOTEyNDhGQzU1NjkyNEEyQTgzNTFBRTI2MzhCMzg3NyIsImFtb3VudCI6IjMzOTQ2NyJ9fSwidGltZW91dF90aW1lc3RhbXAiOjE3NDc3NDY3MzM3OTU4OTgzNjQsInBvc3Rfc3dhcF9hY3Rpb24iOnsiaWJjX3RyYW5zZmVyIjp7ImliY19pbmZvIjp7InNvdXJjZV9jaGFubmVsIjoiY2hhbm5lbC02OTk0IiwicmVjZWl2ZXIiOiJjZWxlc3RpYTFhanBkZndsZmRqY240MG5yZXN5ZHJxazRhOGo2ZG0wemNsN3h0ZCIsIm1lbW8iOiIiLCJyZWNvdmVyX2FkZHJlc3MiOiJvc21vMWFqcGRmd2xmZGpjbjQwbnJlc3lkcnFrNGE4ajZkbTB6cHd1eDhqIn19fSwiYWZmaWxpYXRlcyI6W119fX19'
          }
        },
      );
    } else {
      final error = Errors.getSdkError(Errors.USER_REJECTED).toSignError();
      response = response.copyWith(
        error: JsonRpcError(
          code: error.code,
          message: error.message,
        ),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> cosmosSignAmino(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] cosmosSignAmino request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    final error = Errors.getSdkError(Errors.UNSUPPORTED_METHODS);
    // TODO method not yest implemented due to lack of documentation
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
