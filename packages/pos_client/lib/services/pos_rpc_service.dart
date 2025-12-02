import 'package:reown_core/pairing/utils/json_rpc_utils.dart';
import 'package:pos_client/pos_client.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pos_client/services/i_pos_rpc_service.dart';
import 'package:pos_client/services/models/query_models.dart';

mixin PosRpcService implements IPosRpcService {
  static final String _baseUrl = 'https://rpc.walletconnect.org/v1/json-rpc';

  @override
  Future<JsonRpcResponse> posBuildTransaction({
    required BuildTransactionParams params,
    required QueryParams queryParams,
  }) async {
    final jsonRpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'wc_pos_buildTransactions',
      params: params.toJson(),
    );

    final qParams = queryParams.toJson();
    final jsonRequest = jsonRpcRequest.toJson();
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

  @override
  Future<JsonRpcResponse> posCheckTransaction({
    required CheckTransactionParams params,
    required QueryParams queryParams,
  }) async {
    final jsonRpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'wc_pos_checkTransaction',
      params: params.toJson(),
    );

    final qParams = queryParams.toJson();
    final jsonRequest = jsonRpcRequest.toJson();
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

  @override
  Future<JsonRpcResponse> posSupportedNetworks({
    required QueryParams queryParams,
  }) async {
    final jsonRpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'wc_pos_supportedNetworks',
      params: {},
    );

    final qParams = queryParams.toJson();
    final jsonRequest = jsonRpcRequest.toJson();
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
