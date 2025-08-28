import 'package:reown_core/i_core_impl.dart';
import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_core/pairing/utils/json_rpc_utils.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class BlockchainService {
  static final String _baseUrl = 'https://rpc.walletconnect.org/v1/json-rpc';
  IReownCore? core;
  BlockchainService({required this.core});

  static Future<JsonRpcResponse> reownPosBuildTransaction({
    required String token,
    required String recipient,
    required String amount,
    required String sender,
    required String projectId,
  }) async {
    final jsonRpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'reown_pos_buildTransaction',
      params: {
        'asset': token,
        'amount': amount,
        'recipient': recipient,
        'sender': sender,
      },
    );

    final url = Uri.parse('$_baseUrl?projectId=$projectId');
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

  static Future<JsonRpcResponse> reownPosCheckTransaction({
    required String id,
    required String txId,
    required String projectId,
  }) async {
    final jsonRpcRequest = JsonRpcRequest(
      id: JsonRpcUtils.payloadId(),
      method: 'reown_pos_checkTransaction',
      params: {'id': id, 'txid': txId},
    );

    final url = Uri.parse('$_baseUrl?projectId=$projectId');
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
