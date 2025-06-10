import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:eth_sig_util/eth_sig_util.dart' as eth_sig_util;
import 'package:eth_sig_util/util/utils.dart' as eth_sig_util_util;
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/main.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/pages/chain_abstraction_execute_page.dart';
import 'package:reown_walletkit_wallet/utils/eth_utils.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

enum SupportedEVMMethods {
  ethSign,
  ethSignTransaction,
  ethSignTypedData,
  ethSignTypedDataV4,
  switchChain,
  addChain,
  personalSign,
  ethSendTransaction;

  String get name {
    switch (this) {
      case ethSign:
        return 'eth_sign';
      case ethSignTransaction:
        return 'eth_signTransaction';
      case ethSignTypedData:
        return 'eth_signTypedData';
      case ethSignTypedDataV4:
        return 'eth_signTypedData_v4';
      case switchChain:
        return 'wallet_switchEthereumChain';
      case addChain:
        return 'wallet_addEthereumChain';
      case personalSign:
        return 'personal_sign';
      case ethSendTransaction:
        return 'eth_sendTransaction';
    }
  }
}

class EVMService {
  final ChainMetadata chainSupported;
  late final IWalletKitService _walletKitService;
  late final Web3Client ethClient;
  late final ReownWalletKit _walletKit;

  Map<String, dynamic Function(String, dynamic)> get sessionRequestHandlers => {
        SupportedEVMMethods.ethSign.name: ethSignHandler,
        SupportedEVMMethods.ethSignTransaction.name: ethSignTransactionHandler,
        SupportedEVMMethods.ethSignTypedData.name: ethSignTypedDataHandler,
        SupportedEVMMethods.ethSignTypedDataV4.name: ethSignTypedDataV4Handler,
        SupportedEVMMethods.switchChain.name: switchChainHandler,
        SupportedEVMMethods.addChain.name: addChainHandler,
      };

  Map<String, dynamic Function(String, dynamic)> get methodRequestHandlers => {
        SupportedEVMMethods.personalSign.name: personalSignHandler,
        SupportedEVMMethods.ethSendTransaction.name: ethSendTransactionHandler,
      };

  EVMService({required this.chainSupported}) {
    ethClient = Web3Client(chainSupported.rpc.first, http.Client());
    _walletKitService = GetIt.I<IWalletKitService>();
    _walletKit = _walletKitService.walletKit;

    for (final event in EventsConstants.allEvents) {
      _walletKit.registerEventEmitter(
        chainId: chainSupported.chainId,
        event: event,
      );
    }

    for (var handler in methodRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
    for (var handler in sessionRequestHandlers.entries) {
      _walletKit.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _walletKit.onSessionRequest.subscribe(_onSessionRequest);
  }

  EthPrivateKey get _credentials {
    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final pk = '0x${keys[0].privateKey}';
    return EthPrivateKey.fromHex(pk);
  }

  // Handler methods

  Future<void> personalSignHandler(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] personalSign request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    final address = EthUtils.getAddressFromSessionRequest(pRequest);
    final data = EthUtils.getDataFromSessionRequest(pRequest);
    final message = EthUtils.getUtf8Message(data.toString());
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      message,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        final signature = _credentials.signPersonalMessageToUint8List(
          utf8.encode(message),
        );
        final signedTx = eth_sig_util_util.bytesToHex(
          signature,
          include0x: true,
        );

        _isValidPersonalSignature(signedTx, message);

        response = response.copyWith(result: signedTx);
      } catch (e) {
        debugPrint('[SampleWallet] personalSign error $e');
        // TODO document errors
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

  Future<void> ethSignHandler(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] ethSign request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    final address = EthUtils.getAddressFromSessionRequest(pRequest);
    final data = EthUtils.getDataFromSessionRequest(pRequest);
    final message = EthUtils.getUtf8Message(data.toString());
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      message,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        final signature = _credentials.signToUint8List(
          utf8.encode(message),
        );
        final signedTx = eth_sig_util_util.bytesToHex(
          signature,
          include0x: true,
        );

        _isValidPersonalSignature(signedTx, message);

        response = response.copyWith(result: signedTx);
      } catch (e) {
        debugPrint('[SampleWallet] ethSign error $e');
        final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
        response = response.copyWith(
          error: JsonRpcError(
            code: error.code,
            message: error.message,
          ),
        );
      }
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

  Future<void> ethSignTypedDataHandler(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] ethSignTypedData request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    final address = EthUtils.getAddressFromSessionRequest(pRequest);
    final data = EthUtils.getDataFromSessionRequest(pRequest);
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      data,
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

        final signature = eth_sig_util.EthSigUtil.signTypedData(
          privateKey: keys[0].privateKey,
          jsonData: data,
          version: eth_sig_util.TypedDataVersion.V4,
        );

        response = response.copyWith(result: signature);
      } catch (e) {
        debugPrint('[SampleWallet] ethSignTypedData error $e');
        final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
        response = response.copyWith(
          error: JsonRpcError(
            code: error.code,
            message: error.message,
          ),
        );
      }
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

  Future<void> ethSignTypedDataV4Handler(
    String topic,
    dynamic parameters,
  ) async {
    debugPrint('[SampleWallet] ethSignTypedDataV4 request: $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    final address = EthUtils.getAddressFromSessionRequest(pRequest);
    final data = EthUtils.getDataFromSessionRequest(pRequest);
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      data,
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

        final signature = eth_sig_util.EthSigUtil.signTypedData(
          privateKey: keys[0].privateKey,
          jsonData: data,
          version: eth_sig_util.TypedDataVersion.V4,
        );

        response = response.copyWith(result: signature);
      } catch (e) {
        debugPrint('[SampleWallet] ethSignTypedDataV4 error $e');
        final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
        response = response.copyWith(
          error: JsonRpcError(
            code: error.code,
            message: error.message,
          ),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5002, message: 'User rejected method'),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> ethSignTransactionHandler(
    String topic,
    dynamic parameters,
  ) async {
    debugPrint('[SampleWallet] ethSignTransaction request: $parameters');
    final SessionRequest pRequest = _walletKit.pendingRequests.getAll().last;

    final data = EthUtils.getTransactionFromSessionRequest(pRequest);
    if (data == null) return;
    final address = EthUtils.getAddressFromSessionRequest(pRequest);

    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final transaction = await approveTransaction(
      data,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    );
    if (transaction is Transaction) {
      try {
        final chainId = chainSupported.chainId.split(':').last;

        final signature = await ethClient.signTransaction(
          _credentials,
          transaction,
          chainId: int.parse(chainId),
        );
        // Sign the transaction
        final signedTx = eth_sig_util_util.bytesToHex(
          signature,
          include0x: true,
        );

        response = response.copyWith(result: signedTx);
      } on RPCError catch (e) {
        debugPrint('[SampleWallet] ethSignTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(
            code: e.errorCode,
            message: e.message,
          ),
        );
      } catch (e) {
        debugPrint('[SampleWallet] ethSignTransaction error $e');
        final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
        response = response.copyWith(
          error: JsonRpcError(
            code: error.code,
            message: error.message,
          ),
        );
      }
    } else {
      response = response.copyWith(error: transaction as JsonRpcError);
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> ethSendTransactionHandler(
    String topic,
    dynamic parameters,
  ) async {
    debugPrint('[SampleWallet] ethSendTransaction request: $parameters');
    final SessionRequest pRequest = _walletKit.pendingRequests.getAll().last;

    final txParams = EthUtils.getTransactionFromSessionRequest(pRequest);
    if (txParams == null) {
      return;
    }

    // ************
    // Intercept to check if Chain Abstraction is required
    // Otherwise continue with regular send transaction flow
    // ************
    if (txParams.containsKey('input') || txParams.containsKey('data')) {
      final caResponse = await handleChainAbstractionIfNeeded(
        pRequest.id,
        pRequest.chainId,
        txParams,
      );
      // caResponse could be JsonRpcResponse, TransactionCompat, BridgingError
      // if chainAbstractionResponse?.result is not null it means it had been handled by Chain Abstraction
      // We return that response and stop the flow
      if (caResponse is JsonRpcResponse) {
        return _handleResponseForTopic(
          topic,
          caResponse,
        );
      } else {
        if (caResponse is BridgingError) {
          final error = caResponse.name;
          return _handleResponseForTopic(
            topic,
            JsonRpcResponse(
              id: pRequest.id,
              jsonrpc: '2.0',
              error: JsonRpcError(code: -1, message: error),
            ),
          );
        }
      }
    }

    // otherwise we continue with regular flow for eth_sendTransaction
    await approveAndSendTransaction(
      pRequest.id,
      txParams,
      pRequest.chainId,
      pRequest.transportType.name,
      pRequest.verifyContext,
      topic,
    );
  }

  Future<void> approveAndSendTransaction(
    int requestId,
    Map<String, dynamic> txParams,
    String chainId,
    String transportType,
    VerifyContext? verifyContext,
    String topic,
  ) async {
    var response = JsonRpcResponse(id: requestId, jsonrpc: '2.0');
    final transaction = await approveTransaction(
      txParams,
      method: 'eth_sendTransaction',
      chainId: chainId,
      transportType: transportType,
      verifyContext: verifyContext,
    );
    if (transaction is Transaction) {
      try {
        final chainId = chainSupported.chainId.split(':').last;
        final signedTx = await sendTransaction(transaction, int.parse(chainId));
        response = response.copyWith(result: signedTx);
      } on RPCError catch (e) {
        debugPrint('[SampleWallet] ethSendTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(
            code: e.errorCode,
            message: e.message,
          ),
        );
      } catch (e) {
        debugPrint('[SampleWallet] ethSendTransaction error $e');
        final error = Errors.getSdkError(Errors.MALFORMED_REQUEST_PARAMS);
        response = response.copyWith(
          error: JsonRpcError(
            code: error.code,
            message: error.message,
          ),
        );
      }
    } else {
      response = response.copyWith(error: transaction as JsonRpcError);
    }

    _handleResponseForTopic(topic, response);
  }

  Future<dynamic> handleChainAbstractionIfNeeded(
    int requestId,
    String chainId,
    Map<String, dynamic> txParams,
  ) async {
    final txData = txParams['input'] ?? txParams['data'];
    final prepareResponse = await _chainAbstractionPrepareHandler(
      chainId,
      txParams['from'],
      txParams['to'],
      txData,
    );
    if (prepareResponse is UiFieldsCompat) {
      final context = navigatorKey.currentState!.context;
      final executeResponse = await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => ChainAbstractionDetailsAndExecute(
            uiFieldsCompat: prepareResponse,
          ),
        ),
      );
      var rpcResponse = JsonRpcResponse(id: requestId, jsonrpc: '2.0');
      if (executeResponse is ReownSignError) {
        // Error from execution fron-end
        rpcResponse = rpcResponse.copyWith(
          error: JsonRpcError(
            code: executeResponse.code,
            message: executeResponse.message,
          ),
        );
      } else if (executeResponse is ErrorCompat) {
        // Error from execution back-end
        rpcResponse = rpcResponse.copyWith(
          error: JsonRpcError(
            code: -1,
            message: executeResponse.message,
          ),
        );
      } else if (executeResponse is ExecuteDetailsCompat) {
        // Success response
        rpcResponse = rpcResponse.copyWith(
          result: executeResponse.initialTxnReceipt,
        );
      }
      return rpcResponse; // JsonRpcResponse
    } else if (prepareResponse is PrepareResponseNotRequiredCompat) {
      // chain abstraction notRequired, continue with initialTransaction
      return prepareResponse.initialTransaction; // TransactionCompat
    } else if (prepareResponse is PrepareResponseError) {
      // chain abstraction error
      return prepareResponse.error; // BridgingError
    }
  }

  Future<dynamic> _chainAbstractionPrepareHandler(
    String chainId,
    String from,
    String to,
    String input,
  ) async {
    dynamic prepareResponse;
    try {
      final response = await _walletKit.prepare(
        chainId: chainId,
        from: from,
        call: CallCompat(to: to, input: input),
      );
      response.when(
        success: (PrepareDetailedResponseSuccessCompat deatailResponse) {
          deatailResponse.when(
            available: (UiFieldsCompat uiFieldsCompat) {
              prepareResponse = uiFieldsCompat;
            },
            notRequired: (PrepareResponseNotRequiredCompat notRequired) {
              // it means that no bridging is required
              // proceeds as normal transaction with initial transaction
              prepareResponse = notRequired;
            },
          );
        },
        error: (PrepareResponseError error) {
          prepareResponse = error;
        },
      );
    } catch (e) {
      // if prepare fails for any reason we should let the flow continue as usual with the regular approval
      debugPrint('[SampleWallet] prepare error $e');
      prepareResponse = null;
    }

    return prepareResponse;
  }

  Future<dynamic> chainAbstractionExecuteHandler(
    UiFieldsCompat uiFields,
  ) async {
    final TxnDetailsCompat initial = uiFields.initial;
    final List<TxnDetailsCompat> route = uiFields.route;

    final String initialSignature = signHash(initial.transactionHashToSign);
    final isValid = isValidSignature(
      initial.transactionHashToSign,
      initialSignature,
    );
    if (isValid) {
      final List<String> routeSignatures = route.map((route) {
        final String rSignature = signHash(route.transactionHashToSign);
        return rSignature;
      }).toList();
      try {
        return await _walletKit.execute(
          uiFields: uiFields,
          initialTxnSig: initialSignature,
          routeTxnSigs: routeSignatures,
        );
      } catch (e) {
        rethrow;
      }
    } else {
      return Errors.getSdkError(
        Errors.SIGNATURE_VERIFICATION_FAILED,
      ).toSignError();
    }
  }

  Future<void> switchChainHandler(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] switchChain request: $topic $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');
    try {
      final params = (parameters as List).first as Map<String, dynamic>;
      final hexChainId = params['chainId'].toString().replaceFirst('0x', '');
      final chainId = int.parse(hexChainId, radix: 16);
      final chainInfo = ChainsDataList.eip155Chains.firstWhere(
        (e) => e.chainId == 'eip155:$chainId',
      );
      // this change will handle the session event emit, see settings_page
      _walletKitService.currentSelectedChain.value = chainInfo;
      response = response.copyWith(result: true);
    } on ReownSignError catch (e) {
      debugPrint('[SampleWallet] switchChain error $e');
      response = response.copyWith(
        error: JsonRpcError(
          code: e.code,
          message: e.message,
        ),
      );
    } catch (e) {
      debugPrint('[SampleWallet] switchChain error $e');
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

  Future<void> addChainHandler(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] addChain request: $topic $parameters');
    final pRequest = _walletKit.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      jsonEncode(parameters),
      method: pRequest.method,
      chainId: pRequest.chainId,
      transportType: pRequest.transportType.name,
      verifyContext: pRequest.verifyContext,
    )) {
      try {
        final params = (parameters as List).first as Map<String, dynamic>;
        final hexChainId = params['chainId'].toString().replaceFirst('0x', '');
        final decimalChainId = int.parse(hexChainId, radix: 16);
        final chainId = 'eip155:$decimalChainId';
        final chainData = ChainMetadata(
          type: ChainType.eip155,
          chainId: chainId,
          name: params['chainName'],
          logo: '/chain-logos/eip155-$decimalChainId.png',
          color: Colors.blue.shade300,
          rpc: (params['rpcUrls'] as List).map((e) => e.toString()).toList(),
        );

        // Register the corresponding singleton for the new chain
        // This will also call registerEventEmitter and registerRequestHandler
        GetIt.I.registerSingleton<EVMService>(
          EVMService(
            chainSupported: chainData,
            // walletKitService: _walletKitService,
          ),
          instanceName: chainData.chainId,
        );

        // register the new account
        final keysService = GetIt.I<IKeyService>();
        final chainKeys = keysService.getKeysForChain('eip155');
        final address = chainKeys.first.address;
        _walletKit.registerAccount(chainId: chainId, accountAddress: address);

        // update session's namespaces
        final currentSession = _walletKit.sessions.get(topic)!;
        final namespaces = _updateNamespaces(
          currentSession.namespaces,
          'eip155',
          [chainId],
        );
        await _walletKit.updateSession(topic: topic, namespaces: namespaces);
        // add the new chain to the list
        ChainsDataList.eip155Chains.add(chainData);
        // this change will handle the session event emit, see settings_page
        _walletKitService.currentSelectedChain.value = chainData;

        response = response.copyWith(result: true);
      } on ReownSignError catch (e) {
        debugPrint('[SampleWallet] addChain error $e');
        response = response.copyWith(
          error: JsonRpcError(
            code: e.code,
            message: e.message,
          ),
        );
      } catch (e) {
        debugPrint('[SampleWallet] addChain error $e');
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

  // Support methods

  Future<String> sendTransaction(dynamic transaction, int chainId) async {
    return await ethClient.sendTransaction(
      _credentials,
      transaction,
      chainId: chainId,
    );
  }

  Future<dynamic> approveTransaction(
    Map<String, dynamic> tJson, {
    String? title,
    String? method,
    String? chainId,
    String? address,
    VerifyContext? verifyContext,
    required String transportType,
  }) async {
    Transaction transaction = tJson.toTransaction();

    final gasPrice = await ethClient.getGasPrice();
    try {
      final gasLimit = await ethClient.estimateGas(
        sender: transaction.from,
        to: transaction.to,
        value: transaction.value,
        data: transaction.data,
        gasPrice: gasPrice,
      );

      transaction = transaction.copyWith(
        gasPrice: gasPrice,
        maxGas: gasLimit.toInt(),
      );
    } on RPCError catch (e) {
      return JsonRpcError(code: e.errorCode, message: e.message);
    }

    final gweiGasPrice = (transaction.gasPrice?.getInWei ?? BigInt.zero) /
        BigInt.from(1000000000);

    const encoder = JsonEncoder.withIndent('  ');
    final trx = encoder.convert(tJson);

    if (await MethodsUtils.requestApproval(
      trx,
      title: title,
      method: method,
      chainId: chainId,
      address: address,
      transportType: transportType,
      verifyContext: verifyContext,
      extraModels: [
        WCConnectionModel(
          title: 'Gas price',
          elements: ['${gweiGasPrice.toStringAsFixed(2)} GWEI'],
        ),
      ],
    )) {
      return transaction;
    }

    return const JsonRpcError(code: 5002, message: 'User rejected method');
  }

  String signHash(String hashToSign, [String? privateKey]) {
    final credentials =
        privateKey != null ? EthPrivateKey.fromHex(privateKey) : _credentials;

    final Uint8List dataToSign = hashToSign.startsWith('0x')
        ? eth_sig_util_util.hexToBytes(hashToSign.substring(2))
        : utf8.encode(hashToSign);

    final String signature = eth_sig_util.EthSigUtil.signMessage(
      message: dataToSign,
      privateKeyInBytes: credentials.privateKey,
    );

    return signature;
  }

  Future<dynamic> getBalance({required String address}) async {
    final uri = Uri.parse('https://rpc.walletconnect.org/v1');
    final queryParams = {
      'projectId': _walletKit.core.projectId,
      'chainId': chainSupported.chainId
    };
    final response = await http.post(
      uri.replace(queryParameters: queryParams),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 1,
        'jsonrpc': '2.0',
        'method': 'eth_getBalance',
        'params': [address, 'latest'],
      }),
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        final result = _parseRpcResultAs<String>(response.body);
        final amount = EtherAmount.fromBigInt(
          EtherUnit.wei,
          hexToInt(result),
        );
        return amount.getValueInUnit(EtherUnit.ether);
      } catch (e) {
        throw Exception('Failed to load balance. $e');
      }
    }
    try {
      final errorData = jsonDecode(response.body) as Map<String, dynamic>;
      final reasons = errorData['reasons'] as List<dynamic>;
      final reason = reasons.isNotEmpty
          ? reasons.first['description'] ?? ''
          : response.body;
      throw Exception(reason);
    } catch (e) {
      rethrow;
    }
  }

  // Validate signatures

  bool isValidSignature(
    String hashToVerify,
    String signature, [
    String? privateKey,
  ]) {
    try {
      final credentials =
          privateKey != null ? EthPrivateKey.fromHex(privateKey) : _credentials;

      final expectedAddress = credentials.address.hex;

      // Prepare the data to verify
      final dataToVerify = hashToVerify.startsWith('0x')
          ? eth_sig_util_util.hexToBytes(hashToVerify)
          : utf8.encode(hashToVerify);

      final recoveredAddress = eth_sig_util.EthSigUtil.recoverSignature(
        signature: signature,
        message: dataToVerify,
      );

      return recoveredAddress.toLowerCase() == expectedAddress.toLowerCase();
    } catch (e) {
      debugPrint('[SampleWallet] $e');
      return false;
    }
  }

  bool _isValidPersonalSignature(
    String signature,
    String message, [
    String? privateKey,
  ]) {
    try {
      final credentials =
          privateKey != null ? EthPrivateKey.fromHex(privateKey) : _credentials;

      final expectedAddress = credentials.address.hex;

      // Prepare the data to verify
      final dataToVerify = message.startsWith('0x')
          ? eth_sig_util_util.hexToBytes(message)
          : utf8.encode(message);

      final recoveredAddress = eth_sig_util.EthSigUtil.recoverPersonalSignature(
        signature: signature,
        message: dataToVerify,
      );
      debugPrint('[SampleWallet] recoveredAddress: $recoveredAddress');

      return recoveredAddress.toLowerCase() == expectedAddress.toLowerCase();
    } catch (e) {
      debugPrint('[SampleWallet] $e');
      return false;
    }
  }

  T _parseRpcResultAs<T>(String body) {
    try {
      final result = Map<String, dynamic>.from({...jsonDecode(body), 'id': 1});
      final jsonResponse = JsonRpcResponse.fromJson(result);
      if (jsonResponse.result != null) {
        return jsonResponse.result;
      } else {
        throw jsonResponse.error ?? 'Error parsing result';
      }
    } catch (e) {
      rethrow;
    }
  }

  void _handleResponseForTopic(String topic, JsonRpcResponse response) async {
    if (topic.isEmpty) {
      return MethodsUtils.handleRedirect(
        topic,
        null,
        response.error?.message,
        response.error == null,
      );
    }
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
        response.error == null,
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
      final handler = sessionRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }

  // TODO add this method inside NamespaceUtils
  static Map<String, Namespace> _updateNamespaces(
    Map<String, Namespace> currentNamespaces,
    String namespace,
    List<String> newChains,
  ) {
    final updatedNamespaces = Map<String, Namespace>.from(currentNamespaces);
    final accounts = currentNamespaces[namespace]!.accounts;
    final address = NamespaceUtils.getAccount(accounts.first);
    final newAccounts = newChains.map((c) => '$c:$address').toList();

    final newNamespaces = currentNamespaces[namespace]!.copyWith(
      chains: NamespaceUtils.getChainsFromAccounts(accounts)..addAll(newChains),
      accounts: List<String>.from(accounts)..addAll(newAccounts),
    );
    updatedNamespaces[namespace] = newNamespaces;
    return updatedNamespaces;
  }
}
