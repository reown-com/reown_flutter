import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/blockchain_identity.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';

class BlockChainService implements IBlockChainService {
  late final IReownCore _core;
  late final String _baseUrl;
  String? _clientId;

  BlockChainService({required IReownCore core})
      : _core = core,
        _baseUrl = '${UrlConstants.blockChainService}/v1';

  Map<String, String?> get _requiredParams => {
        'projectId': _core.projectId,
        'clientId': _clientId,
      };

  Map<String, String> get _requiredHeaders => {
        'x-sdk-type': CoreConstants.X_SDK_TYPE,
        'x-sdk-version': 'flutter-${CoreConstants.X_SDK_VERSION}',
      };

  @override
  Future<void> init() async {
    _clientId = await _core.crypto.getClientId();
  }

  @override
  Future<BlockchainIdentity> getIdentity(String address) async {
    try {
      final uri = Uri.parse('$_baseUrl/identity/$address');
      final queryParams = {..._requiredParams};
      // if (queryParams['clientId'] == null) {
      //   queryParams['clientId'] = await _core.crypto.getClientId();
      // }
      final response = await http.get(
        uri.replace(queryParameters: queryParams),
        headers: _requiredHeaders,
      );
      if (response.statusCode == 200) {
        return BlockchainIdentity.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load avatar');
      }
    } catch (e) {
      _core.logger.e('[$runtimeType] getIdentity: $e');
      rethrow;
    }
  }

  int _retries = 1;
  @override
  Future<dynamic> rpcRequest({
    // required String? topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    final bool isChainId = NamespaceUtils.isValidChainId(chainId);
    if (!isChainId) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: '[$runtimeType] chain should be CAIP-2 valid',
      );
    }
    final uri = Uri.parse(_baseUrl);
    final queryParams = {..._requiredParams, 'chainId': chainId};
    final response = await http.post(
      uri.replace(queryParameters: queryParams),
      headers: {
        ..._requiredHeaders,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': 1,
        'jsonrpc': '2.0',
        'method': request.method,
        'params': request.params,
      }),
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      _retries = 1;
      try {
        final result = _parseRpcResultAs<String>(response.body);
        final amount = EtherAmount.fromBigInt(EtherUnit.wei, hexToInt(result));
        return amount.getValueInUnit(EtherUnit.ether);
      } catch (e) {
        rethrow;
      }
    } else {
      if (response.body.isEmpty && _retries > 0) {
        _core.logger.i('[$runtimeType] Empty body');
        _retries -= 1;
        await rpcRequest(chainId: chainId, request: request);
      } else {
        _core.logger.i(
          '[$runtimeType] Failed to get request ${request.toJson()}. '
          'Response: ${response.body}, Status code: ${response.statusCode}',
        );
      }
    }
  }

  T _parseRpcResultAs<T>(String body) {
    try {
      final result = Map<String, dynamic>.from({
        ...jsonDecode(body),
        'id': 1,
      });
      final jsonResponse = JsonRpcResponse.fromJson(result);
      if (jsonResponse.result != null) {
        return jsonResponse.result;
      }
      throw jsonResponse.error ??
          // TODO ReownAppKitModal change this error
          ReownSignError(
            code: 0,
            message: 'Error parsing result',
          );
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<double?> getBalance(
  //   String address,
  //   String currency, {
  //   String? chain,
  //   String? forceUpdate,
  // }) async {
  //   final uri = Uri.parse('$_baseUrl/account/$address/balance');
  //   final queryParams = {
  //     ..._requiredParams,
  //     'currency': currency,
  //     if (chain != null) 'chainId': chain,
  //     if (forceUpdate != null) 'forceUpdate': forceUpdate,
  //   };
  //   final response = await http.get(
  //     uri.replace(queryParameters: queryParams),
  //     headers: {
  //       ..._requiredHeaders,
  //       // 'chain': chainId,
  //       // 'forceUpdate': string
  //       // 'Content-Type': 'application/json',
  //     },
  //     // body: jsonEncode({
  //     //   'jsonrpc': '2.0',
  //     //   'method': 'eth_getBalance',
  //     //   'params': [address, 'latest'],
  //     //   'chainId': 1
  //     // }),
  //   );
  //   _core.logger.i('[$runtimeType] getBalance $address: ${response.body}');
  //   if (response.statusCode == 200) {
  //   } else {
  //     throw Exception('Failed to load balance');
  //   }
  // }

  // @override
  // Future<String> fetchEnsName(String rpcUrl, String address) async {
  //   return '';
  // }

  // @override
  // Future<String> fetchEnsAvatar(String rpcUrl, String address) async {
  //   return '';
  // }
}
