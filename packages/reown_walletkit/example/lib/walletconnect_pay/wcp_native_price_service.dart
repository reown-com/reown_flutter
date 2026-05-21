import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';

/// Fiat price of a chain's native token. `currency` is normalized to upper-case
/// ISO 4217 (e.g. `USD`, `EUR`).
class NativeTokenPrice {
  const NativeTokenPrice({required this.price, required this.currency});
  final double price;
  final String currency;
}

/// Looks up the fiat price of a chain's native token via WalletConnect's
/// blockchain-api fungible price endpoint, so the WCPay review UI can render
/// gas estimates in the same currency as the merchant invoice.
///
/// Mirrors `NativeTokenPriceService` in reown-kotlin sample/wallet (PR #385):
/// in-memory cache with 60s TTL, in-flight request dedup keyed by
/// `(currency, chainId)`, 10s per-request timeout, defaults to USD when the
/// merchant currency isn't supported.
class WCPNativePriceService {
  WCPNativePriceService._();
  static final instance = WCPNativePriceService._();

  static const _endpoint = 'https://rpc.walletconnect.org/v1/fungible/price';
  static const _nativeTokenAddress =
      '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee';
  static const _cacheTtl = Duration(seconds: 60);
  static const _requestTimeout = Duration(seconds: 10);
  static const _defaultFiat = 'USD';
  static const _supportedFiats = <String>{'USD', 'EUR'};

  final Map<String, _CachedPrice> _cache = {};
  final Map<String, Future<NativeTokenPrice?>> _inFlight = {};

  http.Client _client = http.Client();

  @visibleForTesting
  void debugReplaceClient(http.Client client) {
    _client.close();
    _client = client;
    _cache.clear();
    _inFlight.clear();
  }

  /// Returns the supported fiat code for [unit] (an ISO-4217-style PayAmount
  /// unit like `iso4217/EUR`), or `USD` when unsupported / null.
  static String normalizeFiatCurrency(String? unit) {
    if (unit == null) return _defaultFiat;
    final code = unit.contains('/')
        ? unit.split('/').last.toUpperCase()
        : unit.toUpperCase();
    return _supportedFiats.contains(code) ? code : _defaultFiat;
  }

  Future<NativeTokenPrice?> fetchNativeTokenPrice({
    required String chainId,
    String? currency,
  }) {
    final projectId = DartDefines.projectId.trim();
    if (projectId.isEmpty) return Future.value(null);

    final fiat = normalizeFiatCurrency(currency);
    final cacheKey = '$fiat:$chainId';

    final cached = _cache[cacheKey];
    if (cached != null && cached.expiresAt.isAfter(DateTime.now())) {
      return Future.value(
          NativeTokenPrice(price: cached.price, currency: fiat));
    }

    final existing = _inFlight[cacheKey];
    if (existing != null) return existing;

    final future = _fetch(projectId, chainId, fiat, cacheKey);
    _inFlight[cacheKey] = future;
    return future;
  }

  Future<NativeTokenPrice?> _fetch(
    String projectId,
    String chainId,
    String fiat,
    String cacheKey,
  ) async {
    try {
      final address = '$chainId:$_nativeTokenAddress';
      final body = jsonEncode({
        'projectId': projectId,
        'currency': fiat.toLowerCase(),
        'addresses': [address],
      });
      final response = await _client
          .post(
            Uri.parse(_endpoint),
            headers: const {'content-type': 'application/json'},
            body: body,
          )
          .timeout(_requestTimeout);

      if (response.statusCode != 200) {
        debugPrint(
          '[SampleWallet] fungible price HTTP ${response.statusCode} for $chainId',
        );
        return null;
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final fungibles = decoded['fungibles'];
      if (fungibles is! List) return null;

      double? price;
      for (final entry in fungibles) {
        if (entry is! Map) continue;
        final addr = entry['address'];
        if (addr is String && addr.toLowerCase() == address.toLowerCase()) {
          final p = entry['price'];
          if (p is num && p.isFinite && p > 0) {
            price = p.toDouble();
          }
          break;
        }
      }

      if (price == null) return null;
      _cache[cacheKey] = _CachedPrice(
        price: price,
        expiresAt: DateTime.now().add(_cacheTtl),
      );
      return NativeTokenPrice(price: price, currency: fiat);
    } on TimeoutException {
      debugPrint('[SampleWallet] fungible price timed out for $chainId');
      return null;
    } catch (e) {
      debugPrint('[SampleWallet] fungible price failed for $chainId: $e');
      return null;
    } finally {
      _inFlight.remove(cacheKey);
    }
  }
}

class _CachedPrice {
  _CachedPrice({required this.price, required this.expiresAt});
  final double price;
  final DateTime expiresAt;
}
