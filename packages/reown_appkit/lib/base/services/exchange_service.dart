import 'package:reown_appkit/base/services/i_exchange_service.dart';
import 'package:reown_appkit/base/services/models/query_models.dart';
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
    core.logger.d('[$runtimeType] getExchanges ${rpcRequest.toJson()}');

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
    core.logger.d('[$runtimeType] getExchangeUrl ${rpcRequest.toJson()}');

    try {
      return await _request(rpcRequest);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<JsonRpcResponse> getExchangeByStatus({
    required GetExchangeByStatusParams params,
  }) async {
    final rpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'reown_getExchangeBuyStatus',
      params: params.toJson(),
    );
    core.logger.d('[$runtimeType] getExchangeByStatus ${rpcRequest.toJson()}');

    try {
      return await _request(rpcRequest);
    } catch (e) {
      rethrow;
    }
  }

  Future<JsonRpcResponse> _request(JsonRpcRequest rpcRequest) async {
    final qParams = QueryParams(projectId: core.projectId).toJson();
    final jsonRequest = rpcRequest.toJson();
    final url = Uri.parse(_baseUrl).replace(queryParameters: qParams);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonRequest),
    );

    final responseData = jsonDecode(response.body);

    final jsonResponse = JsonRpcResponse.fromJson(responseData);

    if (jsonResponse.error != null) {
      throw jsonResponse.error!;
    }

    return jsonResponse;
  }
}
