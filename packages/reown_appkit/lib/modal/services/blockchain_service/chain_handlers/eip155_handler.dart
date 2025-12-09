import 'package:reown_appkit/reown_appkit.dart';
import 'chain_handler.dart';

/// Handler for EIP-155 compatible chains (Ethereum, Polygon, etc.)
class Eip155Handler implements ChainHandler {
  static const _weiPerEther = 1000000000000000000.0;

  @override
  String get balanceMethod => 'eth_getBalance';

  @override
  List<dynamic> buildBalanceParams(String address) {
    return [address, 'latest'];
  }

  @override
  double parseBalance(String balanceResult, T Function<T>(String) parseRpc) {
    final result = parseRpc<String>(balanceResult);
    return hexToInt(result).toDouble() / _weiPerEther;
  }
}
