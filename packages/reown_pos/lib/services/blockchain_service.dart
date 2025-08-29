import 'package:reown_core/pairing/utils/json_rpc_utils.dart';
import 'package:reown_pos/reown_pos.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reown_pos/services/i_blockchain_service.dart';
import 'package:reown_pos/services/models/query_models.dart';

mixin BlockchainService implements IBlockchainService {
  static final String _baseUrl = 'https://rpc.walletconnect.org/v1/json-rpc';

  @override
  Future<JsonRpcResponse> reownPosBuildTransaction({
    required BuildTransactionParams params,
    required QueryParams queryParams,
  }) async {
    final jsonRpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'reown_pos_buildTransaction',
      params: params.toJson(),
    );

    final qParams = queryParams.toJson();
    final url = Uri.parse(_baseUrl).replace(queryParameters: qParams);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonRpcRequest.toJson()),
    );

    final responseData = json.decode(response.body);
    final jsonResponse = JsonRpcResponse.fromJson(responseData);

    if (jsonResponse.error != null) {
      throw jsonResponse.error!;
    }

    return jsonResponse;
  }

  @override
  Future<JsonRpcResponse> reownPosCheckTransaction({
    required CheckTransactionParams params,
    required QueryParams queryParams,
  }) async {
    final jsonRpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'reown_pos_checkTransaction',
      params: params.toJson(),
    );

    final qParams = queryParams.toJson();
    final url = Uri.parse(_baseUrl).replace(queryParameters: qParams);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonRpcRequest.toJson()),
    );

    final responseData = json.decode(response.body);
    final jsonResponse = JsonRpcResponse.fromJson(responseData);

    if (jsonResponse.error != null) {
      throw jsonResponse.error!;
    }

    return jsonResponse;
  }
}
