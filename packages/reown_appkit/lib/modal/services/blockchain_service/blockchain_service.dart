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
        'x-sdk-version': CoreConstants.X_SDK_VERSION,
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
      final response = await http.get(
        uri.replace(queryParameters: queryParams),
        headers: _requiredHeaders,
      );
      _core.logger.i('[$runtimeType] getIdentity $address => ${response.body}');
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return BlockchainIdentity.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        final reasons = errorData['reasons'] as List<dynamic>;
        final reason = reasons.isNotEmpty
            ? reasons.first['description'] ?? ''
            : response.body;
        throw Exception(reason);
      } else {
        throw Exception('Failed to load avatar');
      }
    } catch (e) {
      _core.logger.e('[$runtimeType] getIdentity $address error => $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> getBalance({
    required String address,
    required String namespace,
    required String chainId,
  }) async {
    final uri = Uri.parse(_baseUrl);
    final queryParams = {..._requiredParams, 'chainId': '$namespace:$chainId'};
    final response = await http.post(
      uri.replace(queryParameters: queryParams),
      headers: {..._requiredHeaders, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 1,
        'jsonrpc': '2.0',
        'method': _balanceMetod(namespace),
        'params': [
          address,
          if (namespace == NetworkUtils.eip155) 'latest',
        ],
      }),
    );
    _core.logger.i(
      '[$runtimeType] getBalance $namespace, $chainId, $address => ${response.body}',
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        return _parseBalanceResult(namespace, response.body);
      } catch (e) {
        _core.logger.e('[$runtimeType] getBalance, parse result error => $e');
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
      _core.logger.e('[$runtimeType] getBalance, decode result error => $e');
      rethrow;
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

  String _balanceMetod(String namespace) {
    if (namespace == NetworkUtils.eip155) {
      return 'eth_getBalance';
    } else if (namespace == NetworkUtils.solana) {
      return 'getBalance';
    }
    return '';
  }

  double _parseBalanceResult(String namespace, String balanceResult) {
    if (namespace == NetworkUtils.solana) {
      final result = _parseRpcResultAs<Map<String, dynamic>>(balanceResult);
      final value = result['value'] as int;
      return value / 1000000000.0;
    } else if (namespace == NetworkUtils.eip155) {
      final result = _parseRpcResultAs<String>(balanceResult);
      final amount = EtherAmount.fromBigInt(
        EtherUnit.wei,
        hexToInt(result),
      );
      return amount.getValueInUnit(EtherUnit.ether);
    }
    return 0.0;
  }
}
