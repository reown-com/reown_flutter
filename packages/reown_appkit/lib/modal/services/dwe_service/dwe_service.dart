import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/modal/services/transfers/i_transfers_service.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_params.dart';
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
  final depositAsset = ValueNotifier<ExchangeAsset?>(null);

  @override
  final depositAmountInUSD = ValueNotifier<double>(0.0);

  @override
  final depositAmountInAsset = ValueNotifier<double>(0.0);

  final List<ExchangeAsset> _supportedAssets = [...allExchangeAssets];
  @override
  List<ExchangeAsset> get supportedAssets => _supportedAssets;

  ExchangeAsset? _preselectedAsset;
  @override
  ExchangeAsset? get preselectedAsset => _preselectedAsset;

  bool _showNetworkIcon = true;
  @override
  bool get showNetworkIcon => _showNetworkIcon;

  bool _depositAssetButton = true;
  @override
  bool get depositAssetButton => _depositAssetButton;

  bool _filterByNetwork = true;
  @override
  bool get filterByNetwork => _filterByNetwork;

  Map<String, String> _configuredRecipients = {};
  @override
  Map<String, String> get configuredRecipients => _configuredRecipients;

  @override
  Future<void> init() async {
    _bundleId = await ReownCoreUtils.getPackageName();
  }

  @override
  void configDeposit({
    List<ExchangeAsset>? supportedAssets,
    ExchangeAsset? preselectedAsset,
    bool? showNetworkIcon,
    bool? filterByNetwork,
    bool? depositAssetButton,
    Map<String, String> configuredRecipients = const {},
  }) {
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

    _supportedAssets
      ..clear()
      ..addAll(supportedAssets ?? allExchangeAssets);

    _preselectedAsset = preselectedAsset ?? _preselectedAsset;
    _showNetworkIcon = showNetworkIcon ?? _showNetworkIcon;
    _filterByNetwork = filterByNetwork ?? _filterByNetwork;
    _depositAssetButton = depositAssetButton ?? _depositAssetButton;
    if (_preselectedAsset == null) {
      _depositAssetButton = true;
    }
    _configuredRecipients = configuredRecipients;
  }

  @override
  List<ExchangeAsset> getAvailableAssets({String? chainId}) {
    _appKit.core.logger.d('[$runtimeType] available assets, chainId: $chainId');
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
  void loopOnDepositStatusCheck(
    String exchangeId,
    String sessionId,
    Function((QuoteStatus status, dynamic data)) completer,
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
        final quoteStatus = QuoteStatus.fromStatus(response.status);
        switch (quoteStatus) {
          case QuoteStatus.waiting:
          case QuoteStatus.pending:
            currentAttempt++;
            if (currentAttempt < maxAttempts && !_shouldStopLooping) {
              // Keep trying
              completer.call((quoteStatus, null));
              await Future.delayed(Duration(seconds: 3));
            } else {
              // Max attempts reached or stopped by user, complete with appropriate status
              stopCheckingStatus();
              final statusResult = _shouldStopLooping
                  ? QuoteStatus.failure
                  : QuoteStatus.timeout;
              completer.call((statusResult, null));
              break;
            }
          // case QuoteStatus.timeout:
          // case QuoteStatus.success:
          // case QuoteStatus.failure:
          // case QuoteStatus.refund:
          // case QuoteStatus.submitted:
          default:
            // Either success, submitted, failure, refund, timeout
            completer.call((quoteStatus, null));
            stopCheckingStatus();
            break;
        }
      } catch (e) {
        stopCheckingStatus();
        completer.call((QuoteStatus.failure, null));
        break;
      }
    }
  }

  ITransfersService get _transferService => GetIt.I<ITransfersService>();

  @override
  void loopOnTransferStatusCheck(
    String exchangeId,
    String requestId,
    Function((QuoteStatus status, dynamic data)) completer,
  ) async {
    // return loopOnStatusUnhappyPathMock2(exchangeId, requestId, completer);

    if (_isLooping) return;
    _isLooping = true;
    _shouldStopLooping = false;
    int currentAttempt = 0;
    int waitingInterval = 5;
    int maxAttempts = 60; // 5 min max

    while (currentAttempt < maxAttempts && !_shouldStopLooping) {
      try {
        final params = GetQuoteStatusParams(requestId: requestId);
        final response = await _transferService.getQuoteStatus(params: params);
        final QuoteStatus quoteStatus = response.status;
        switch (quoteStatus) {
          case QuoteStatus.waiting:
          case QuoteStatus.pending:
            currentAttempt++;
            if (currentAttempt < maxAttempts && !_shouldStopLooping) {
              // Keep trying
              completer.call((quoteStatus, null));
              await Future.delayed(Duration(seconds: waitingInterval));
            } else {
              // Max attempts reached or stopped by user, complete with appropriate status
              stopCheckingStatus();
              final statusResult = _shouldStopLooping
                  ? QuoteStatus.failure
                  : QuoteStatus.timeout;
              completer.call((statusResult, null));
              break;
            }
          // case QuoteStatus.timeout:
          // case QuoteStatus.success:
          // case QuoteStatus.failure:
          // case QuoteStatus.refund:
          // case QuoteStatus.submitted:
          default:
            // Either success, submitted, failure, refund, timeout
            completer.call((quoteStatus, null));
            stopCheckingStatus();
            break;
        }
      } catch (e) {
        stopCheckingStatus();
        completer.call((QuoteStatus.failure, null));
        break;
      }
    }
  }

  @visibleForTesting
  void loopOnStatusHappyPathMock(
    String exchangeId,
    String requestId,
    Function((QuoteStatus status, dynamic data)) completer,
  ) async {
    if (_isLooping) return;
    _isLooping = true;
    _shouldStopLooping = false;
    int maxAttempts = 30;
    int currentAttempt = 0;

    while (currentAttempt < maxAttempts && !_shouldStopLooping) {
      try {
        final quoteStatus = currentAttempt < 2
            ? QuoteStatus.waiting
            : (currentAttempt < 4 ? QuoteStatus.pending : QuoteStatus.success);
        switch (quoteStatus) {
          case QuoteStatus.waiting:
          case QuoteStatus.pending:
            currentAttempt++;
            if (currentAttempt < maxAttempts && !_shouldStopLooping) {
              // Keep trying
              completer.call((quoteStatus, null));
              await Future.delayed(Duration(seconds: 3));
            } else {
              // Max attempts reached or stopped by user, complete with appropriate status
              stopCheckingStatus();
              final statusResult = _shouldStopLooping
                  ? QuoteStatus.failure
                  : QuoteStatus.timeout;
              completer.call((statusResult, null));
              break;
            }
          default:
            // Either success, submitted, failure, refund, timeout
            completer.call((quoteStatus, null));
            stopCheckingStatus();
            break;
        }
      } catch (e) {
        stopCheckingStatus();
        completer.call((QuoteStatus.failure, null));
        break;
      }
    }
  }

  @visibleForTesting
  void loopOnStatusUnhappyPathMock1(
    String exchangeId,
    String requestId,
    Function((QuoteStatus status, dynamic data)) completer,
  ) async {
    if (_isLooping) return;
    _isLooping = true;
    _shouldStopLooping = false;
    int maxAttempts = 30;
    int currentAttempt = 0;

    while (currentAttempt < maxAttempts && !_shouldStopLooping) {
      try {
        final quoteStatus = currentAttempt < 2
            ? QuoteStatus.waiting
            : (currentAttempt < 4 ? QuoteStatus.pending : QuoteStatus.failure);
        switch (quoteStatus) {
          case QuoteStatus.waiting:
          case QuoteStatus.pending:
            currentAttempt++;
            if (currentAttempt < maxAttempts && !_shouldStopLooping) {
              // Keep trying
              completer.call((quoteStatus, null));
              await Future.delayed(Duration(seconds: 3));
            } else {
              // Max attempts reached or stopped by user, complete with appropriate status
              stopCheckingStatus();
              final statusResult = _shouldStopLooping
                  ? QuoteStatus.failure
                  : QuoteStatus.timeout;
              completer.call((statusResult, null));
              break;
            }
          default:
            // Either success, submitted, failure, refund, timeout
            completer.call((quoteStatus, null));
            stopCheckingStatus();
            break;
        }
      } catch (e) {
        stopCheckingStatus();
        completer.call((QuoteStatus.failure, null));
        break;
      }
    }
  }

  @visibleForTesting
  void loopOnStatusUnhappyPathMock2(
    String exchangeId,
    String requestId,
    Function((QuoteStatus status, dynamic data)) completer,
  ) async {
    if (_isLooping) return;
    _isLooping = true;
    _shouldStopLooping = false;
    int maxAttempts = 30;
    int currentAttempt = 0;

    while (currentAttempt < maxAttempts && !_shouldStopLooping) {
      try {
        final quoteStatus = currentAttempt < 2
            ? QuoteStatus.waiting
            : QuoteStatus.failure;
        switch (quoteStatus) {
          case QuoteStatus.waiting:
          case QuoteStatus.pending:
            currentAttempt++;
            if (currentAttempt < maxAttempts && !_shouldStopLooping) {
              // Keep trying
              completer.call((quoteStatus, null));
              await Future.delayed(Duration(seconds: 3));
            } else {
              // Max attempts reached or stopped by user, complete with appropriate status
              stopCheckingStatus();
              final statusResult = _shouldStopLooping
                  ? QuoteStatus.failure
                  : QuoteStatus.timeout;
              completer.call((statusResult, null));
              break;
            }
          default:
            // Either success, submitted, failure, refund, timeout
            completer.call((quoteStatus, null));
            stopCheckingStatus();
            break;
        }
      } catch (e) {
        stopCheckingStatus();
        completer.call((QuoteStatus.failure, null));
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
  Future<TokenBalance?> getFungiblePrice({
    required ExchangeAsset asset,
    bool forceFetch = false,
  }) async {
    try {
      _fetchedTokens.removeWhere((token) => _tokenPriceIsOld(token.$2));
      final cachedAsset = _getCachedAssetIfAny(asset);
      if (cachedAsset == null || forceFetch) {
        final response = await _getFungiblePrice(addresses: [asset.toCaip10()]);
        if (response.isNotEmpty) {
          final relayPrice = await _relayTokenPrice(asset: asset);
          final tokenBalance = response.first.copyWith(
            chainId: asset.network,
            price: relayPrice,
          );
          if (!forceFetch) {
            _setCachedToken(tokenBalance);
          }
          _appKit.core.logger.d(
            '[$runtimeType] fetched ${asset.metadata.symbol} for ${asset.metadata.name} ${asset.network}',
          );
          return tokenBalance;
        }
        return null;
      }
      _appKit.core.logger.d(
        '[$runtimeType] cached ${asset.metadata.symbol} for ${asset.metadata.name} ${asset.network}',
      );
      return cachedAsset;
    } catch (e) {
      rethrow;
    }
  }

  final _relayAddressMap = {
    '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee':
        '0x0000000000000000000000000000000000000000', // ETH
    'So11111111111111111111111111111111111111111':
        '11111111111111111111111111111111', // SOL
  };

  final _relayChainMap = {
    '5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp': '792703809', // Solana
    '000000000019d6689c085ae165831e93': '8253038', // Bitcoin
  };

  Future<double?> _relayTokenPrice({required ExchangeAsset asset}) async {
    try {
      final address = asset.toCaip10().split(':').last;
      final chainId = asset.network.split(':').last;
      final params = {
        'address': _relayAddressMap[address] ?? address,
        'chainId': _relayChainMap[chainId] ?? chainId,
      };
      final url = Uri.parse(
        'https://api.relay.link/currencies/token/price',
      ).replace(queryParameters: params);

      _appKit.core.logger.d('[$runtimeType] relay price: $address $chainId');
      _appKit.core.logger.d('[$runtimeType] relay price params: $params');

      final response = await http
          .get(url, headers: _requiredHeaders)
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final price = jsonResponse['price'];
        if (price != null) {
          return (price is num) ? price.toDouble() : null;
        }
        return null;
      }

      _appKit.core.logger.e('[$runtimeType] relay price api error: $response');
      return null;
    } catch (e) {
      _appKit.core.logger.e('[$runtimeType] relay price error: $e');
      rethrow;
    }
  }

  @override
  void clearState() {
    depositAmountInUSD.value = 0.0;
    depositAmountInAsset.value = 0.0;
    depositAsset.value = null;
    // _preselectedAsset = null;
    // _showNetworkIcon = true;
    // _depositAssetButton = true;
    // _configuredRecipients = {};
    // _supportedAssets
    //   ..clear()
    //   ..addAll(allExchangeAssets);
    // _filterByNetwork = true;
  }

  // TokenBalance, timestamp
  final List<(TokenBalance, int)> _fetchedTokens = [];

  Future<List<TokenBalance>> _getFungiblePrice({
    required List<String> addresses,
  }) async {
    final url = Uri.parse('$_baseUrl/fungible/price');
    final body = jsonEncode({
      'addresses': addresses,
      'currency': 'usd',
      'projectId': _appKit.core.projectId,
    });
    final response = await http
        .post(url, headers: _requiredHeaders, body: body)
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final jsonResponse = jsonDecode(response.body);
      final fungibles = jsonResponse['fungibles'] as List;
      return fungibles.map((f) => TokenBalance.fromJson(f)).toList();
    }
    try {
      final reason = _parseResponseError(response.body);
      if (reason.toLowerCase().contains('asset is not supported')) {
        return [];
      }
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

  TokenBalance? _getCachedAssetIfAny(ExchangeAsset asset) {
    return _fetchedTokens.firstWhereOrNull((t) {
      final address1 = t.$1.address;
      final address2 = asset.toCaip10();
      return address1 == address2 && !_tokenPriceIsOld(t.$2);
    })?.$1;
  }

  bool _tokenPriceIsOld(int timestampMilliseconds) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(
      timestampMilliseconds,
    );
    final difference = DateTime.now().difference(timestamp);
    return difference.inMinutes >= 5;
  }
}
