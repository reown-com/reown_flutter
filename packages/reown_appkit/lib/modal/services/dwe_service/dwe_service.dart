import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:http/http.dart' as http;

class DWEService implements IDWEService {
  late final IReownAppKit _appKit;
  late final String _baseUrl;
  String? _bundleId;

  DWEService({required IReownAppKit appKit})
    : _appKit = appKit,
      _baseUrl = '${UrlConstants.blockChainService}/v1';

  Map<String, String> get _requiredHeaders => {
    'x-sdk-type': CoreConstants.X_SDK_TYPE,
    'x-sdk-version': ReownCoreUtils.coreSdkVersion(packageVersion),
    'origin': _bundleId ?? 'flutter-appkit',
  };

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
    // _supportedAssets.clear();
  }

  final List<ExchangeAsset> _supportedAssets = [];
  @override
  List<ExchangeAsset> get supportedAssets => _supportedAssets;

  ExchangeAsset? _preselectedAsset;
  @override
  ExchangeAsset? get preselectedAsset => _preselectedAsset;

  bool _showNetworkIcon = true;
  @override
  bool get showNetworkIcon => _showNetworkIcon;

  // bool _enableNetworkSelection = false;
  // @override
  // bool get enableNetworkSelection => _enableNetworkSelection;

  // String? _preselectedNamespace;
  // @override
  // String? get preselectedNamespace => _preselectedNamespace;

  String? _preselectedRecipient;
  @override
  String? get preselectedRecipient => _preselectedRecipient;

  @override
  void configDeposit({
    List<ExchangeAsset>? supportedAssets,
    ExchangeAsset? preselectedAsset,
    bool? showNetworkIcon,
    String? preselectedRecipient,
    // bool? enableNetworkSelection,
    // String? preselectedNamespace,
  }) {
    // if (preselectedRecipient != null) {
    //   if (preselectedNamespace == null && preselectedAsset == null) {
    //     'Either `preselectedNamespace` or `preselectedAsset` has to be set when `preselectedRecipient` is used';
    //   }
    // }

    if (preselectedAsset != null) {
      final chainId = preselectedAsset.network;
      if (!NamespaceUtils.isValidChainId(chainId)) {
        throw Exception('Invalid chain id on asset');
      }

      final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
      final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
        namespace,
        chainId,
      );
      if (networkInfo == null) {
        final errorMessage =
            '$chainId has not been added to `ReownAppKitModalNetworks`. '
            'Please call `ReownAppKitModalNetworks.addSupportedNetworks()`, '
            'See docs: https://docs.reown.com/appkit/flutter/core/custom-chains#custom-networks-addition-and-selection';
        throw Exception(errorMessage);
      }
    }

    if (supportedAssets != null) {
      _supportedAssets
        ..clear()
        ..addAll(supportedAssets);
    }
    _preselectedAsset = preselectedAsset ?? _preselectedAsset;
    _showNetworkIcon = showNetworkIcon ?? _showNetworkIcon;
    _preselectedRecipient = preselectedRecipient ?? _preselectedRecipient;
    // _enableNetworkSelection = enableNetworkSelection ?? false;
    // _preselectedNamespace = preselectedNamespace;
  }

  @override
  List<ExchangeAsset> getAvailableAssets({String? chainId}) {
    if (_supportedAssets.isEmpty) {
      return _appKit.getPaymentAssetsForNetwork(chainId: chainId);
    }

    if (chainId == null) {
      return _supportedAssets;
    }

    return _supportedAssets.where((e) => e.network == chainId).toList();
  }

  @override
  Future<GetExchangesResult> getExchanges({
    required GetExchangesParams params,
  }) async {
    return await _appKit.getExchanges(params: params);
  }

  @override
  Future<GetExchangeUrlResult> getExchangeUrl({
    required GetExchangeUrlParams params,
  }) async {
    final result = await _appKit.getExchangeUrl(params: params);
    GetIt.I<IAnalyticsService>().sendEvent(
      PayExchangeSelectedEvent(
        exchange: {'id': params.exchangeId},
        configuration: {
          'network': params.asset.network,
          'asset': params.asset.address,
          'recipient': params.recipient,
          'amount': params.amount,
        },
        currentPayment: {'type': 'exchange', 'exchangeId': params.exchangeId},
        source: 'fund-from-exchange',
        headless: false,
      ),
    );
    return result;
  }

  bool _isLooping = false;
  @override
  bool get isCheckingStatus => _isLooping;
  bool _shouldStopLooping = false;

  @override
  void loopOnStatusCheck(
    String exchangeId,
    String sessionId,
    Function(GetExchangeDepositStatusResult?) completer,
  ) async {
    if (_isLooping) return;
    _isLooping = true;
    _shouldStopLooping = false;
    int maxAttempts = 30;
    int currentAttempt = 0;

    while (currentAttempt < maxAttempts && !_shouldStopLooping) {
      try {
        // 4. [DWE Check the status of the deposit/transaction Better to call this in a loop]
        final params = GetExchangeDepositStatusParams(
          exchangeId: exchangeId,
          sessionId: sessionId,
        );
        final response = await _appKit.getExchangeDepositStatus(params: params);
        //
        if (response.status == 'UNKNOWN' || response.status == 'IN_PROGRESS') {
          currentAttempt++;
          if (currentAttempt < maxAttempts && !_shouldStopLooping) {
            // Keep trying
            await Future.delayed(Duration(seconds: 5));
          } else {
            // Max attempts reached or stopped by user, complete with appropriate status
            _isLooping = false;
            completer.call(
              _shouldStopLooping
                  ? GetExchangeDepositStatusResult(status: 'CANCELLED')
                  : GetExchangeDepositStatusResult(status: 'TIMEOUT'),
            );
            break;
          }
        } else {
          // Either SUCCESS or FAILED received
          _isLooping = false;
          completer.call(response);
          break;
        }
      } catch (e) {
        debugPrint(e.toString());
        _isLooping = false;
        completer.call(null);
        break;
      }
    }
  }

  @override
  void stopCheckingStatus() {
    _isLooping = false;
    _shouldStopLooping = true;
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
          _appKit.core.logger.d('[$runtimeType] token fetched: $tokenBalance');
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
      'projectId': _appKit.core.projectId,
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
      _appKit.core.logger.e('[$runtimeType] getFungiblePrices error: $e');
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
