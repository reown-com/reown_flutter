import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';

enum SupportedSUIethods {
  suiSignPersonalMessage,
  suiSignTransaction,
  suiSignAndExecuteTransaction;

  String get name {
    switch (this) {
      case suiSignPersonalMessage:
        return 'sui_signPersonalMessage';
      case suiSignTransaction:
        return 'sui_signTransaction';
      case suiSignAndExecuteTransaction:
        return 'sui_signAndExecuteTransaction';
    }
  }
}

class SUIService {
  final ChainMetadata chainSupported;
  late final ReownWalletKit _walletKit;

  Map<String, dynamic Function(String, dynamic)> get suiRequestHandlers => {
        SupportedSUIethods.suiSignPersonalMessage.name: suiSignPersonalMessage,
        SupportedSUIethods.suiSignTransaction.name: suiSignTransaction,
        SupportedSUIethods.suiSignAndExecuteTransaction.name:
            suiSignAndExecuteTransaction,
      };

  SUIService({
    required this.chainSupported,
    required IWalletKitService walletKitService,
  }) {
    _walletKit = walletKitService.walletKit;

    for (var handler in suiRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _walletKit.onSessionRequest.subscribe(_onSessionRequest);
  }

  Future<void> suiSignPersonalMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] suiSignPersonalMessage: $parameters');
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
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final suiPrivateKey = keys[0].privateKey;

        final signature = await _walletKit.suiClient.personalSign(
          keyPair: suiPrivateKey,
          message: message,
        );

        // TODO Check response format
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
      debugPrint('[SampleWallet] suiSignPersonalMessage error $e');
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

  Future<void> suiSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] suiSignTransaction: ${jsonEncode(parameters)}');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final params = parameters as Map<String, dynamic>;
    final address = params['address'] as String;
    final transaction = params['transaction'] as String;
    // {
    //   "transaction": "ewogICJ2ZXJzaW9uIjogMiwKICAic2VuZGVyIjogIjB4ZDVmNjQ3ZWRiNzdkNGZkYTMxZDAzMDQ1MDY0NDdmYjNjOTJlNTVhYWY3N2JjNWVkNGI3N2MzMzJkZDQ2MDVmYSIsCiAgImV4cGlyYXRpb24iOiBudWxsLAogICJnYXNEYXRhIjogewogICAgImJ1ZGdldCI6IG51bGwsCiAgICAicHJpY2UiOiBudWxsLAogICAgIm93bmVyIjogbnVsbCwKICAgICJwYXltZW50IjogbnVsbAogIH0sCiAgImlucHV0cyI6IFsKICAgIHsKICAgICAgIlB1cmUiOiB7CiAgICAgICAgImJ5dGVzIjogIlpBQUFBQUFBQUFBPSIKICAgICAgfQogICAgfSwKICAgIHsKICAgICAgIlB1cmUiOiB7CiAgICAgICAgImJ5dGVzIjogIjFmWkg3YmQ5VDlveDBEQkZCa1IvczhrdVZhcjNlOFh0UzNmRE10MUdCZm89IgogICAgICB9CiAgICB9CiAgXSwKICAiY29tbWFuZHMiOiBbCiAgICB7CiAgICAgICJTcGxpdENvaW5zIjogewogICAgICAgICJjb2luIjogewogICAgICAgICAgIkdhc0NvaW4iOiB0cnVlCiAgICAgICAgfSwKICAgICAgICAiYW1vdW50cyI6IFsKICAgICAgICAgIHsKICAgICAgICAgICAgIklucHV0IjogMAogICAgICAgICAgfQogICAgICAgIF0KICAgICAgfQogICAgfSwKICAgIHsKICAgICAgIlRyYW5zZmVyT2JqZWN0cyI6IHsKICAgICAgICAib2JqZWN0cyI6IFsKICAgICAgICAgIHsKICAgICAgICAgICAgIk5lc3RlZFJlc3VsdCI6IFsKICAgICAgICAgICAgICAwLAogICAgICAgICAgICAgIDAKICAgICAgICAgICAgXQogICAgICAgICAgfQogICAgICAgIF0sCiAgICAgICAgImFkZHJlc3MiOiB7CiAgICAgICAgICAiSW5wdXQiOiAxCiAgICAgICAgfQogICAgICB9CiAgICB9CiAgXQp9",
    //   "address": "0xd5f647edb77d4fda31d0304506447fb3c92e55aaf77bc5ed4b77c332dd4605fa"
    // }

    if (await MethodsUtils.requestApproval(
      transaction,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final suiPrivateKey = keys[0].privateKey;

        final result = await _walletKit.suiClient.signTransaction(
          keyPair: suiPrivateKey,
          chainId: chainSupported.chainId,
          txData: transaction,
        );

        response = response.copyWith(
          result: {
            'signature': result.$1,
            'transactionBytes': result.$2,
          },
        );
      } on PlatformException catch (e) {
        debugPrint('[SampleWallet] suiSignTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(
            code: -1,
            message: '${e.code}: ${e.message}',
          ),
        );
      } catch (e) {
        debugPrint('[SampleWallet] suiSignTransaction error $e');
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

  Future<void> suiSignAndExecuteTransaction(
    String topic,
    dynamic parameters,
  ) async {
    debugPrint(
        '[SampleWallet] suiSignAndExecuteTransaction: ${jsonEncode(parameters)}');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final params = parameters as Map<String, dynamic>;
    final address = params['address'] as String;
    final transaction = params['transaction'] as String;
    // {
    //   "transaction": "ewogICJ2ZXJzaW9uIjogMiwKICAic2VuZGVyIjogIjB4ZDVmNjQ3ZWRiNzdkNGZkYTMxZDAzMDQ1MDY0NDdmYjNjOTJlNTVhYWY3N2JjNWVkNGI3N2MzMzJkZDQ2MDVmYSIsCiAgImV4cGlyYXRpb24iOiBudWxsLAogICJnYXNEYXRhIjogewogICAgImJ1ZGdldCI6IG51bGwsCiAgICAicHJpY2UiOiBudWxsLAogICAgIm93bmVyIjogbnVsbCwKICAgICJwYXltZW50IjogbnVsbAogIH0sCiAgImlucHV0cyI6IFsKICAgIHsKICAgICAgIlB1cmUiOiB7CiAgICAgICAgImJ5dGVzIjogIlpBQUFBQUFBQUFBPSIKICAgICAgfQogICAgfSwKICAgIHsKICAgICAgIlB1cmUiOiB7CiAgICAgICAgImJ5dGVzIjogIjFmWkg3YmQ5VDlveDBEQkZCa1IvczhrdVZhcjNlOFh0UzNmRE10MUdCZm89IgogICAgICB9CiAgICB9CiAgXSwKICAiY29tbWFuZHMiOiBbCiAgICB7CiAgICAgICJTcGxpdENvaW5zIjogewogICAgICAgICJjb2luIjogewogICAgICAgICAgIkdhc0NvaW4iOiB0cnVlCiAgICAgICAgfSwKICAgICAgICAiYW1vdW50cyI6IFsKICAgICAgICAgIHsKICAgICAgICAgICAgIklucHV0IjogMAogICAgICAgICAgfQogICAgICAgIF0KICAgICAgfQogICAgfSwKICAgIHsKICAgICAgIlRyYW5zZmVyT2JqZWN0cyI6IHsKICAgICAgICAib2JqZWN0cyI6IFsKICAgICAgICAgIHsKICAgICAgICAgICAgIk5lc3RlZFJlc3VsdCI6IFsKICAgICAgICAgICAgICAwLAogICAgICAgICAgICAgIDAKICAgICAgICAgICAgXQogICAgICAgICAgfQogICAgICAgIF0sCiAgICAgICAgImFkZHJlc3MiOiB7CiAgICAgICAgICAiSW5wdXQiOiAxCiAgICAgICAgfQogICAgICB9CiAgICB9CiAgXQp9",
    //   "address": "0xd5f647edb77d4fda31d0304506447fb3c92e55aaf77bc5ed4b77c332dd4605fa"
    // }

    if (await MethodsUtils.requestApproval(
      transaction,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final suiPrivateKey = keys[0].privateKey;

        final digest = await _walletKit.suiClient.signAndExecuteTransaction(
          keyPair: suiPrivateKey,
          chainId: chainSupported.chainId,
          txData: transaction,
        );

        response = response.copyWith(
          result: {
            'digest': digest,
          },
        );
      } on PlatformException catch (e) {
        debugPrint('[SampleWallet] suiSignAndExecuteTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(
            code: -1,
            message: '${e.code}: ${e.message}',
          ),
        );
      } catch (e) {
        debugPrint('[SampleWallet] suiSignAndExecuteTransaction error $e');
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
      final handler = suiRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }
}
