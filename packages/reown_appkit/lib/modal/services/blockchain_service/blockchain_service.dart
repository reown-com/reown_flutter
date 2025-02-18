import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reown_appkit/modal/services/blockchain_service/models/gas_price.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/wallet_activity.dart';
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

  ActivityData? _activityData;
  @override
  ActivityData? get activityData => _activityData;

  List<TokenBalance>? _tokensList;
  @override
  List<TokenBalance>? get tokensList => _tokensList;

  TokenBalance? _selectedToken;
  @override
  TokenBalance? get selectedSendToken => _selectedToken;

  @override
  void selectSendToken(TokenBalance? token) => _selectedToken = token;

  @override
  Future<void> init() async {
    _clientId = await _core.crypto.getClientId();
  }

  @override
  Future<BlockchainIdentity> getIdentity({required String address}) async {
    final uri = Uri.parse('$_baseUrl/identity/$address');
    final queryParams = {..._requiredParams};
    final url = uri.replace(queryParameters: queryParams);
    final response = await http.get(url, headers: _requiredHeaders);
    _core.logger.i('[$runtimeType] getIdentity $url => ${response.body}');
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return BlockchainIdentity.fromJson(jsonDecode(response.body));
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e('[$runtimeType] getIdentity, decode result error => $e');
      rethrow;
    }
  }

  @override
  Future<ActivityData> getHistory({
    required String address,
    String? caip2Chain,
    String? cursor,
  }) async {
    final uri = Uri.parse('$_baseUrl/account/$address/history');
    final queryParams = {
      ..._requiredParams,
      if (caip2Chain != null) 'chainId': caip2Chain,
      if (cursor != null) 'cursor': cursor,
    };
    final url = uri.replace(queryParameters: queryParams);
    final response = await http.get(url, headers: _requiredHeaders);
    _core.logger.i('[$runtimeType] getHistory $url => ${response.body}');
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        _activityData = ActivityData.fromRawJson(response.body);
        return _activityData!;
      } catch (e) {
        _core.logger.e('[$runtimeType] getHistory, parse result error => $e');
        throw Exception('Failed to load wallet activity. $e');
      }
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e('[$runtimeType] getHistory, decode result error => $e');
      rethrow;
    }
  }

  @override
  Future<List<TokenBalance>> getBalance({
    required String address,
    String? caip2Chain,
  }) async {
    final uri = Uri.parse('$_baseUrl/account/$address/balance');
    final queryParams = {
      ..._requiredParams,
      'currency': 'usd',
      if (caip2Chain != null) 'chainId': caip2Chain,
      // 'forceUpdate': ,
    };
    final url = uri.replace(queryParameters: queryParams);
    final response = await http.get(url, headers: _requiredHeaders);
    _core.logger.i('[$runtimeType] getBalance $url => ${response.body}');
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      final balances = result['balances'] as List;
      _tokensList = balances.map((e) => TokenBalance.fromJson(e)).toList();
      return _tokensList!;
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e('[$runtimeType] getBalance, decode result error => $e');
      rethrow;
    }
  }

  @override
  Future<double> getTokenBalance({
    required String address,
    required String namespace,
    required String chainId,
  }) async {
    final uri = Uri.parse(_baseUrl);
    final queryParams = {..._requiredParams, 'chainId': '$namespace:$chainId'};
    final url = uri.replace(queryParameters: queryParams);
    final body = jsonEncode({
      'id': 1,
      'jsonrpc': '2.0',
      'method': _balanceMetod(namespace),
      'params': [
        address,
        if (namespace == NetworkUtils.eip155) 'latest',
      ],
    });
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: body,
    );
    _core.logger.i(
      '[$runtimeType] getTokenBalance $url, $body => ${response.body}',
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        return _parseBalanceResult(namespace, response.body);
      } catch (e) {
        _core.logger.e('[$runtimeType] getTokenBalance, parse error => $e');
        throw Exception('Failed to load balance. $e');
      }
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e('[$runtimeType] getTokenBalance, decode error => $e');
      rethrow;
    }
  }

  @override
  Future<GasPrice> gasPrice({required String caip2Chain}) async {
    final uri = Uri.parse('$_baseUrl/convert/gas-price');
    final queryParams = {..._requiredParams, 'chainId': caip2Chain};
    final url = uri.replace(queryParameters: queryParams);
    final response = await http.get(url, headers: _requiredHeaders);
    _core.logger.i('[$runtimeType] gasPrice $url => ${response.body}');
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      return GasPrice.fromJson(result);
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e('[$runtimeType] gasPrice, decode result error => $e');
      rethrow;
    }
  }

  @override
  Future<BigInt> estimateGas({
    required Map<String, dynamic> transaction,
    required String caip2Chain,
  }) async {
    final uri = Uri.parse(_baseUrl);
    final queryParams = {..._requiredParams, 'chainId': caip2Chain};
    final url = uri.replace(queryParameters: queryParams);
    final body = jsonEncode({
      'jsonrpc': '2.0',
      'method': 'eth_estimateGas',
      'params': [transaction],
      'id': 1,
    });
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: body,
    );
    _core.logger.i(
      '[$runtimeType] estimateGas $url, $body => ${response.body}',
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        return _parseEstimateGasResult(response.body);
      } on JsonRpcError catch (e) {
        _core.logger.e('[$runtimeType] estimateGas, parse error => $e');
        if ((e.message ?? '')
            .toLowerCase()
            .contains('insufficient funds for gas')) {
          throw 'Insufficient funds for gas';
        }
        throw 'Failed to estimate gas';
      } catch (e) {
        _core.logger.e('[$runtimeType] estimateGas, parse error => $e');
        throw 'Failed to estimate gas.';
      }
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e('[$runtimeType] getBalance, decode error => $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> checkAllowance({
    required String senderAddress,
    required String receiverAddress,
    required String contractAddress,
    required String caip2Chain,
  }) async {
    // Keccak-256 of "allowance(address,address)"
    final functionSelector = 'dd62ed3e';
    final ownerPadded = senderAddress.replaceFirst('0x', '').padLeft(64, '0');
    final spenderPadded =
        receiverAddress.replaceFirst('0x', '').padLeft(64, '0');
    final data = '0x$functionSelector$ownerPadded$spenderPadded';
    //
    final uri = Uri.parse(_baseUrl);
    final queryParams = {..._requiredParams, 'chainId': caip2Chain};
    final url = uri.replace(queryParameters: queryParams);
    final body = jsonEncode({
      'jsonrpc': '2.0',
      'id': 1,
      'method': 'eth_call',
      'params': [
        {'to': contractAddress, 'data': data},
        'latest'
      ]
    });
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: body,
    );
    _core.logger.i(
      '[$runtimeType] checkAllowance $url, $body => ${response.body}',
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        final namespace = NamespaceUtils.getNamespaceFromChain(caip2Chain);
        return _parseBalanceResult(namespace, response.body);
      } on JsonRpcError catch (e) {
        _core.logger.e('[$runtimeType] checkAllowance, parse error => $e');
        throw 'Failed checking allowance';
      } catch (e) {
        _core.logger.e('[$runtimeType] checkAllowance, parse error => $e');
        throw 'Failed checking allowance';
      }
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e('[$runtimeType] checkAllowance, decode error => $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _activityData = null;
    _selectedToken = null;
    _tokensList?.clear();
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
      final value = amount.getValueInUnit(EtherUnit.ether);
      if (value < 0.00001) {
        return 0.0;
      }
      return value;
    }
    return 0.0;
  }

  BigInt _parseEstimateGasResult(String gasResult) {
    try {
      final result = _parseRpcResultAs<String>(gasResult);
      return hexToInt(result);
    } catch (e) {
      rethrow;
    }
  }

  String _parseResponseError(String responseBody) {
    final errorData = jsonDecode(responseBody) as Map<String, dynamic>;
    final reasons = errorData['reasons'] as List<dynamic>;
    return reasons.isNotEmpty
        ? reasons.first['description'] ?? ''
        : responseBody;
  }
}
