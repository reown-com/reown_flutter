import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reown_appkit/modal/services/blockchain_service/models/gas_price.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/wallet_activity.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/blockchain_identity.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/chain_handlers/chain_handler_factory.dart';
import 'package:reown_core/pairing/utils/json_rpc_utils.dart';

// TODO move to Core SDK
class BlockChainService implements IBlockChainService {
  late final IReownCore _core;
  late final String _baseUrl;
  String? _bundleId;
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
    'x-sdk-version': ReownCoreUtils.coreSdkVersion(packageVersion),
    'origin': _bundleId ?? 'flutter-appkit',
  };

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
    _bundleId = await ReownCoreUtils.getPackageName();
    _clientId = await _core.crypto.getClientId();
  }

  @override
  Future<BlockchainIdentity> getIdentity({required String address}) async {
    final url = _buildUrl('identity/$address');
    final response = await http.get(url, headers: _requiredHeaders);
    _core.logger.i('[$runtimeType] getIdentity $url => ${response.body}');

    return _handleResponse(
      response: response,
      parser: (body) => BlockchainIdentity.fromJson(jsonDecode(body)),
      errorContext: 'getIdentity',
    );
  }

  @override
  Future<ActivityData> getHistory({
    required String address,
    String? caip2Chain,
    String? cursor,
  }) async {
    final queryParams = {
      if (caip2Chain != null) 'chainId': caip2Chain,
      if (cursor != null) 'cursor': cursor,
    };
    final url = _buildUrl('account/$address/history', queryParams);
    final response = await http.get(url, headers: _requiredHeaders);
    _core.logger.i('[$runtimeType] getHistory $url => ${response.body}');

    return _handleResponse(
      response: response,
      parser: (body) => ActivityData.fromRawJson(body),
      errorContext: 'getHistory',
      errorMessage: 'Failed to load wallet activity',
    );
  }

  @override
  Future<List<TokenBalance>> getTokenBalance({
    required String address,
    String? caip2Chain,
  }) async {
    try {
      final queryParams = {
        'currency': 'usd',
        if (caip2Chain != null) 'chainId': caip2Chain,
      };
      final url = _buildUrl('account/$address/balance', queryParams);
      _core.logger.i('[$runtimeType] getTokenBalance, url: $url');
      final response = await http.get(url, headers: _requiredHeaders);
      _core.logger.i('[$runtimeType] getTokenBalance => ${response.body}');

      final balances = _handleResponse<Map<String, dynamic>>(
        response: response,
        parser: (body) => jsonDecode(body) as Map<String, dynamic>,
        errorContext: 'getTokenBalance',
      );

      _tokensList = (balances['balances'] as List)
          .map((e) => TokenBalance.fromJson(e))
          .toList();
      return _tokensList!;
    } catch (e) {
      _tokensList = [];
      rethrow;
    }
  }

  @override
  Future<double> getNativeTokenBalance({
    required String address,
    required String namespace,
    required String chainId,
  }) async {
    final handler = ChainHandlerFactory.getHandlerOrThrow(namespace);
    final params = handler.buildBalanceParams(address);
    final body = _buildJsonRpcRequest(
      method: handler.balanceMethod,
      params: params,
    );

    final url = _buildRpcUrl(chainId);
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: body,
    );
    _core.logger.i(
      '[$runtimeType] getNativeTokenBalance $url, $body => ${response.body}',
    );

    return _handleResponse(
      response: response,
      parser: (body) => handler.parseBalance(body, _parseRpcResultAs),
      errorContext: 'getNativeTokenBalance',
      errorMessage: 'Failed to load balance',
    );
  }

  @override
  Future<GasPrice> gasPrice({required String caip2Chain}) async {
    final url = _buildUrl('convert/gas-price', {'chainId': caip2Chain});
    final response = await http.get(url, headers: _requiredHeaders);
    _core.logger.i('[$runtimeType] gasPrice $url => ${response.body}');

    return _handleResponse(
      response: response,
      parser: (body) =>
          GasPrice.fromJson(jsonDecode(body) as Map<String, dynamic>),
      errorContext: 'gasPrice',
    );
  }

  @override
  Future<BigInt> estimateGas({
    required Map<String, dynamic> transaction,
    required String caip2Chain,
  }) async {
    final body = _buildJsonRpcRequest(
      method: 'eth_estimateGas',
      params: [transaction],
    );
    final url = _buildRpcUrl(caip2Chain);
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: body,
    );
    _core.logger.i(
      '[$runtimeType] estimateGas $url, $body => ${response.body}',
    );

    try {
      return _handleResponse(
        response: response,
        parser: (body) => _parseEstimateGasResult(body),
        errorContext: 'estimateGas',
      );
    } on JsonRpcError catch (e) {
      _core.logger.e('[$runtimeType] estimateGas, parse error => $e');
      if ((e.message ?? '').toLowerCase().contains(
        'insufficient funds for gas',
      )) {
        throw 'Insufficient funds for gas';
      }
      throw 'Failed to estimate gas';
    }
  }

  @override
  Future<dynamic> checkAllowance({
    required String senderAddress,
    required String receiverAddress,
    required String contractAddress,
    required String caip2Chain,
  }) async {
    final data = _buildAllowanceCallData(senderAddress, receiverAddress);
    final body = _buildJsonRpcRequest(
      method: 'eth_call',
      params: [
        {'to': contractAddress, 'data': data},
        'latest',
      ],
    );
    final url = _buildRpcUrl(caip2Chain);
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: body,
    );
    _core.logger.i(
      '[$runtimeType] checkAllowance $url, $body => ${response.body}',
    );

    try {
      final namespace = NamespaceUtils.getNamespaceFromChain(caip2Chain);
      final handler = ChainHandlerFactory.getHandlerOrThrow(namespace);
      return _handleResponse(
        response: response,
        parser: (body) => handler.parseBalance(body, _parseRpcResultAs),
        errorContext: 'checkAllowance',
      );
    } on JsonRpcError catch (e) {
      _core.logger.e('[$runtimeType] checkAllowance, parse error => $e');
      throw 'Failed checking allowance';
    }
  }

  @override
  Future<JsonRpcResponse> rawCall({
    required String chainId,
    required String method,
    required List<dynamic> params,
  }) async {
    final body = jsonEncode({
      'jsonrpc': '2.0',
      'id': JsonRpcUtils.payloadId(),
      'method': method,
      'params': params,
    });
    final url = _buildRpcUrl(chainId);
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: body,
    );
    _core.logger.i('[$runtimeType] rawCall $url, $body => ${response.body}');

    final parsedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return JsonRpcResponse.fromJson(parsedResponse);
  }

  @override
  void dispose() {
    _selectedToken = null;
    _tokensList?.clear();
  }

  // HTTP Request Helpers
  Uri _buildUrl(String path, [Map<String, String>? additionalParams]) {
    final uri = Uri.parse('$_baseUrl/$path');
    final queryParams = {..._requiredParams, ...?additionalParams};
    return uri.replace(queryParameters: queryParams);
  }

  Uri _buildRpcUrl(String chainId) {
    return _buildUrl('', {'chainId': chainId});
  }

  String _buildJsonRpcRequest({
    required String method,
    required dynamic params,
    int? id,
  }) {
    return jsonEncode({
      'jsonrpc': '2.0',
      'method': method,
      'params': params,
      'id': id ?? 1,
    });
  }

  // Response Handling
  T _handleResponse<T>({
    required http.Response response,
    required T Function(String body) parser,
    required String errorContext,
    String? errorMessage,
  }) {
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        return parser(response.body);
      } catch (e) {
        _core.logger.e('[$runtimeType] $errorContext, parse error => $e');
        throw Exception(errorMessage ?? 'Failed to parse response. $e');
      }
    }

    final reason = _parseResponseError(response.body);
    _core.logger.e('[$runtimeType] $errorContext, decode error => $reason');
    throw Exception(reason);
  }

  String _parseResponseError(String responseBody) {
    try {
      final errorData = jsonDecode(responseBody) as Map<String, dynamic>;
      final jsonResponse = JsonRpcResponse.fromJson(errorData);
      if (jsonResponse.error != null) {
        return jsonResponse.error!.message ?? '';
      }

      final reasons = errorData['reasons'] as List<dynamic>?;
      if (reasons != null && reasons.isNotEmpty) {
        return reasons.first['description'] ?? '';
      }
    } catch (_) {}

    return responseBody;
  }

  // RPC Result Parsing
  T _parseRpcResultAs<T>(String body) {
    final result = Map<String, dynamic>.from({...jsonDecode(body), 'id': 1});
    final jsonResponse = JsonRpcResponse.fromJson(result);
    if (jsonResponse.result != null) {
      return jsonResponse.result as T;
    }
    throw jsonResponse.error ??
        ReownSignError(code: 0, message: 'Error parsing result');
  }

  BigInt _parseEstimateGasResult(String gasResult) {
    final result = _parseRpcResultAs<String>(gasResult);
    return hexToInt(result);
  }

  // Allowance Helpers
  String _buildAllowanceCallData(String owner, String spender) {
    final ownerPadded = owner.replaceFirst('0x', '').padLeft(64, '0');
    final spenderPadded = spender.replaceFirst('0x', '').padLeft(64, '0');

    final allowanceFunctionSelector = 'dd62ed3e';
    return '0x$allowanceFunctionSelector$ownerPadded$spenderPadded';
  }
}
