import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';

class BlockchainApiUtils {
  static const _balancePath = 'https://rpc.walletconnect.org/v1/account';

  /// Fetches balances for [address] via the Reown blockchain API. Works across
  /// namespaces — `eip155:1`, `solana:5eykt4Us…`, etc. The path takes a single
  /// address per call.
  ///
  /// When [chainId] is omitted, the API returns balances across all supported
  /// EVM chains for that address in a single call.
  static Future<List<Map<String, dynamic>>> getBalance({
    required String address,
    String? chainId,
  }) async {
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    final uri = Uri.parse('$_balancePath/$address/balance');
    final queryParams = {
      'projectId': walletKit.core.projectId,
      'currency': 'usd',
      if (chainId != null) 'chainId': chainId,
    };
    final package = await PackageInfo.fromPlatform();
    final response = await http.get(
      uri.replace(queryParameters: queryParams),
      headers: {
        'Content-Type': 'application/json',
        'x-sdk-type': 'flutter-sample-wallet',
        'x-sdk-version': package.version,
        'origin': package.packageName,
      },
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      try {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final balances = (jsonData['balances'] as List).map((e) {
          return e as Map<String, dynamic>;
        }).toList();
        return balances
          ..sort((a, b) {
            final bValue = (b['value'] as num?)?.toDouble() ?? 0.0;
            final aValue = (a['value'] as num?)?.toDouble() ?? 0.0;
            return bValue.compareTo(aValue);
          });
      } catch (e) {
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
      rethrow;
    }
  }
}
