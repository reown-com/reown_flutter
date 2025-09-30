// ignore_for_file: unused_element

import 'package:reown_appkit/base/services/i_exchange_service.dart';
import 'package:reown_appkit/base/services/models/query_models.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_core/i_core_impl.dart';
import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_core/pairing/utils/json_rpc_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeService implements IExchangeService {
  static final String _baseUrl = 'https://rpc.walletconnect.org/v1/json-rpc';

  late final IReownCore core;

  ExchangeService({required this.core});

  @override
  Future<JsonRpcResponse> getExchanges({
    required GetExchangesParams params,
  }) async {
    final rpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'reown_getExchanges',
      params: params.toParams(),
    );
    core.logger.d(
      '[$runtimeType] getExchanges ${jsonEncode(rpcRequest.toJson())}',
    );

    // await Future.delayed(Duration(seconds: 1));
    // return JsonRpcResponse.fromJson(_getExchangesMockResponse);

    try {
      return await _request(rpcRequest);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<JsonRpcResponse> getExchangeUrl({
    required GetExchangeUrlParams params,
  }) async {
    final rpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'reown_getExchangePayUrl',
      params: params.toParams(),
    );
    core.logger.d(
      '[$runtimeType] getExchangePayUrl ${jsonEncode(rpcRequest.toJson())}',
    );

    // await Future.delayed(Duration(seconds: 1));
    // return JsonRpcResponse.fromJson(_getExchangeUrlMockResponse);

    try {
      return await _request(rpcRequest);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<JsonRpcResponse> getExchangeDepositStatus({
    required GetExchangeDepositStatusParams params,
  }) async {
    final rpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'reown_getExchangeBuyStatus',
      params: params.toJson(),
    );
    core.logger.d(
      '[$runtimeType] getExchangeDepositStatus ${jsonEncode(rpcRequest.toJson())}',
    );

    // await Future.delayed(Duration(seconds: 1));
    // return JsonRpcResponse.fromJson(_getExchangeBuyStatusMockResponse);

    try {
      return await _request(rpcRequest);
    } catch (e) {
      rethrow;
    }
  }

  Future<JsonRpcResponse> _request(JsonRpcRequest rpcRequest) async {
    final qParams = QueryParams(
      projectId: core.projectId,
      source: 'fund-wallet',
      st: CoreConstants.X_SDK_TYPE,
      sv: CoreConstants.X_SDK_VERSION,
    ).toJson();
    final jsonRequest = rpcRequest.toJson();
    final url = Uri.parse(_baseUrl).replace(queryParameters: qParams);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonRequest),
    );
    core.logger.d('[$runtimeType] response ${response.body}');

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    final jsonResponse = JsonRpcResponse.fromJson(responseData);

    if (jsonResponse.error != null) {
      throw jsonResponse.error!;
    }

    return jsonResponse;
  }
}

// TODO move to tests
const _getExchangesMockResponse = {
  'id': 1,
  'jsonrpc': '2.0',
  'result': {
    'exchanges': [
      {
        'id': 'binance',
        'imageUrl': 'https://pay-assets.reown.com/binance_128_128.webp',
        'name': 'Binance',
      },
      {
        'id': 'coinbase',
        'imageUrl': 'https://pay-assets.reown.com/coinbase_128_128.webp',
        'name': 'Coinbase',
      },
      {
        'id': 'reown_test',
        'imageUrl': 'https://pay-assets.reown.com/reown_test_128_128.webp',
        'name': 'Reown Test Exchange',
      },
    ],
    'total': 3,
  },
};

const _getExchangeUrlMockResponse = {
  'id': 1,
  'jsonrpc': '2.0',
  'result': {
    'sessionId': '57a5ac338fc4470abb069c34a2228711',
    'url':
        'https://appkit-pay-test-exchange.reown.com/?asset=eip155:84532/slip44:60&amount=0.00001&recipient=0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340&sessionId=6f938cd753aa4f9b9cc413f1e407adf6&projectId=702e2d45d9debca66795614cddb5c1ca',
  },
};

const _getExchangeBuyStatusMockResponse = {
  'id': 1,
  'jsonrpc': '2.0',
  'result': {
    'status': 'UNKNOWN',
    'txHash':
        null, // 'UNKNOWN' | 'IN_PROGRESS' | 'FAILED' | 'SUCCESS' (with txHash)
  },
};
