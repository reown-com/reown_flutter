import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:http/http.dart' as http;

class DWEService implements IDWEService {
  late final IReownCore _core;
  late final String _baseUrl;
  String? _bundleId;

  DWEService({required IReownCore core})
    : _core = core,
      _baseUrl = '${UrlConstants.blockChainService}/v1';

  Map<String, String> get _requiredHeaders => {
    'x-sdk-type': CoreConstants.X_SDK_TYPE,
    'x-sdk-version': ReownCoreUtils.coreSdkVersion(packageVersion),
    'origin': _bundleId ?? 'flutter-appkit',
  };

  final List<ExchangeAsset> _supportedAssets = [];
  @override
  List<ExchangeAsset> get supportedAssets => _supportedAssets;

  @override
  final selectedAsset = ValueNotifier<ExchangeAsset?>(null);

  @override
  final selectedAmount = ValueNotifier<double>(0.0);

  @override
  Future<void> init() async {
    _bundleId = await ReownCoreUtils.getPackageName();
  }

  @override
  void clearState() {
    selectedAmount.value = 0.0;
    selectedAsset.value = null;
    _supportedAssets.clear();
  }

  @override
  void setSupportedAssets(List<ExchangeAsset> assets) {
    _supportedAssets
      ..clear()
      ..addAll(assets);
  }

  @override
  Future<TokenBalance?> getFungiblePrice({required ExchangeAsset asset}) async {
    try {
      _fetchedTokens.removeWhere((token) => _tokenPriceIsOld(token.$2));
      final cachedToken = _getCachedToken(asset);
      // always fetch price for native tokens
      if (cachedToken == null || asset.isNative()) {
        final tokens = await _getFungiblePrices(addresses: [asset.toCaip10()]);
        if (tokens.isNotEmpty) {
          final tokenBalance = tokens.first.copyWith(chainId: asset.network);
          if (!asset.isNative()) {
            _setCachedToken(tokenBalance);
          }
          _core.logger.d('[$runtimeType] token fetched: $tokenBalance');
          return tokenBalance;
        }
        return null;
      }
      return cachedToken;
    } catch (e) {
      rethrow;
    }
  }

  // TokenBalance, timestamp
  final List<(TokenBalance, int)> _fetchedTokens = [];

  Future<List<TokenBalance>> _getFungiblePrices({
    required List<String> addresses,
  }) async {
    final url = Uri.parse('$_baseUrl/fungible/price');
    final body = jsonEncode({
      'addresses': addresses,
      'currency': 'usd',
      'projectId': _core.projectId,
    });
    final response = await http.post(
      url,
      headers: _requiredHeaders,
      body: body,
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final jsonResponse = jsonDecode(response.body);
      final fungibles = jsonResponse['fungibles'] as List;
      return fungibles.map((f) => TokenBalance.fromJson(f)).toList();
    }
    try {
      final reason = _parseResponseError(response.body);
      throw Exception(reason);
    } catch (e) {
      _core.logger.e('[$runtimeType] getFungiblePrices error: $e');
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

  void _setCachedToken(TokenBalance asset) {
    final cachedAsset = _fetchedTokens.firstWhereOrNull((t) {
      return asset.address == t.$1.address && !_tokenPriceIsOld(t.$2);
    })?.$1;
    if (cachedAsset == null) {
      _fetchedTokens.add((asset, DateTime.now().millisecondsSinceEpoch));
    }
  }

  TokenBalance? _getCachedToken(ExchangeAsset asset) {
    return _fetchedTokens.firstWhereOrNull((t) {
      final address1 = t.$1.address;
      final address2 = asset.toCaip10();
      return address1 == address2 && !_tokenPriceIsOld(t.$2);
    })?.$1;
  }

  bool _tokenPriceIsOld(int timestampSeconds) {
    final now = DateTime.now();
    final timestamp = DateTime.fromMillisecondsSinceEpoch(
      timestampSeconds * 1000,
    );
    final difference = now.difference(timestamp);
    return difference.inMinutes > 5;
  }
}
