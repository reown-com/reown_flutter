import 'chain_handler.dart';

/// Handler for Sui chain
class SuiHandler implements ChainHandler {
  static const _mystPerSui = 1000000000.0;

  @override
  String get balanceMethod => 'suix_getBalance';

  @override
  List<dynamic> buildBalanceParams(String address) {
    return [address, '0x2::sui::SUI'];
    // 0x2::sui::SUI is the Move type identifier for the native SUI coin.
    // Format Breakdown
    // 0x2 — Package ID (SUI framework/core system package)
    // sui — Module name
    // SUI — Struct/type name for the native coin
    // Usage
    // This is the default coin type for native SUI. In suix_getBalance, you can:
    // Omit it (defaults to 0x2::sui::SUI)
    // Specify it explicitly
    // Use a different coin type for other tokens
    // Examples
    // Native SUI (default):
    // {  "method": "suix_getBalance",  "params": ["0x51ceab2edc89f74730e683ebee65578cb3bc9237ba6fca019438a9737cf156ae", "0x2::sui::SUI"]}
    // Or omit the coin type (defaults to SUI):
    // {  "method": "suix_getBalance",  "params": ["0x51ceab2edc89f74730e683ebee65578cb3bc9237ba6fca019438a9737cf156ae"]}
    // Other tokens would have different types, e.g.:
    // 0x...::usdc::USDC (USDC on SUI)
    // 0x...::weth::WETH (Wrapped ETH on SUI)
    // The 0x2 package is the SUI system package that contains core types like the native coin.
  }

  @override
  double parseBalance(String balanceResult, T Function<T>(String) parseRpc) {
    final result = parseRpc<Map<String, dynamic>>(balanceResult);
    final value = result['totalBalance'] as String;
    return double.parse(value) / _mystPerSui;
  }
}
