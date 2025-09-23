import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/solana/solana_web3/src/rpc/models/token_balance.dart';

import 'package:http/http.dart' as http;

class DWEService {
  late final IReownCore _core;
  late final String _baseUrl;
  String? _bundleId;
  String? _clientId;

  DWEService({required IReownCore core})
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
  // @override
  // List<TokenBalance>? get tokensList => _tokensList;

  TokenBalance? _selectedToken;
  // @override
  // TokenBalance? get selectedSendToken => _selectedToken;

  List<ExchangeAsset>? _supportedAssets;
  ValueNotifier<List<ExchangeAsset>> supportedAssets =
      ValueNotifier<List<ExchangeAsset>>([]);

  ExchangeAsset? _selectedAsset;
  ValueNotifier<ExchangeAsset?> selectedAsset = ValueNotifier<ExchangeAsset?>(
    null,
  );

  // @override
  void selectAsset(ExchangeAsset? token) => selectedAsset.value = token;

  Future<void> init() async {
    _bundleId = await ReownCoreUtils.getPackageName();
    _clientId = await _core.crypto.getClientId();
  }

  Future<List<TokenBalance>> getFungiblePrices({
    required List<String> addresses,
  }) async {
    final url = Uri.parse('$_baseUrl/fungible/price');
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: jsonEncode({
        'addresses': addresses,
        'currency': 'usd',
        'projectId': _core.projectId,
      }),
    );

    _core.logger.i('[$runtimeType] getFungiblePrices $url => ${response.body}');
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final jsonResponse = jsonDecode(response.body);
      final fungibles = jsonResponse['fungibles'] as List;
      return fungibles.map((f) => TokenBalance.fromJson(f)).toList();
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e(
        '[$runtimeType] getFungiblePrices, decode result error => $e',
      );
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
