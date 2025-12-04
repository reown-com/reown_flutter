import 'package:reown_appkit/reown_appkit.dart';
import 'chain_handler.dart';

/// Handler for Stacks chain
class StacksHandler implements ChainHandler {
  static const _mystPerStx = 1000000.0;

  @override
  String get balanceMethod => 'stacks_accounts';

  @override
  List<dynamic> buildBalanceParams(String address) {
    return [address];
  }

  @override
  double parseBalance(String balanceResult, T Function<T>(String) parseRpc) {
    final result = parseRpc<Map<String, dynamic>>(balanceResult);
    final value = result['balance'] as String;
    return hexToInt(value).toDouble() / _mystPerStx;
  }
}
