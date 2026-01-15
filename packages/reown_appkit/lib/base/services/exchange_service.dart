// ignore_for_file: unused_element

import 'package:reown_appkit/base/services/models/query_models.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/reown_appkit.dart';
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
      sv: ReownCoreUtils.coreSdkVersion(packageVersion),
    ).toJson();
    final bodyRequest = jsonEncode(rpcRequest.toJson());
    core.logger.d('[$runtimeType] ${rpcRequest.method} request: $bodyRequest');
    final url = Uri.parse(_baseUrl).replace(queryParameters: qParams);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: bodyRequest,
    );
    core.logger.d(
      '[$runtimeType] ${rpcRequest.method} response: ${response.body}',
    );

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    final jsonResponse = JsonRpcResponse.fromJson(responseData);

    if (jsonResponse.error != null) {
      core.logger.e(
        '[$runtimeType] ${rpcRequest.method} error: ${jsonResponse.error?.toJson()}',
      );
      throw jsonResponse.error!;
    }

    return jsonResponse;
  }
}
