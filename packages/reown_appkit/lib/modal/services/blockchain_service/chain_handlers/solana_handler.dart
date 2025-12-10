import 'chain_handler.dart';

/// Handler for Solana chain
class SolanaHandler implements ChainHandler {
  static const _lamportsPerSol = 1000000000.0;

  @override
  String get balanceMethod => 'getBalance';

  @override
  List<dynamic> buildBalanceParams(String address) {
    return [address];
  }

  @override
  double parseBalance(String balanceResult, T Function<T>(String) parseRpc) {
    final result = parseRpc<Map<String, dynamic>>(balanceResult);
    final value = result['value'] as int;
    return value / _lamportsPerSol;
  }
}
