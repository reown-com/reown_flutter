import 'chain_handler.dart';

/// Handler for TON chain
class TonHandler implements ChainHandler {
  static const _nanotonsPerTon = 1000000000.0;

  @override
  String get balanceMethod => 'getAddressBalance';

  @override
  Map<String, String> buildBalanceParams(String address) {
    return {'address': address};
  }

  @override
  double parseBalance(String balanceResult, T Function<T>(String) parseRpc) {
    final resultString = parseRpc<String>(balanceResult);
    final nanotons = int.parse(resultString);
    return nanotons / _nanotonsPerTon;
  }
}
