import 'package:reown_appkit/reown_appkit.dart';
import 'chain_handler.dart';

/// Handler for Tron chain
class TronHandler implements ChainHandler {
  static const _sunPerTrx = 1000000.0;

  @override
  String get balanceMethod => 'eth_getBalance';

  @override
  List<dynamic> buildBalanceParams(String address) {
    return [_tronBase58ToHex(address), 'latest'];
  }

  @override
  double parseBalance(String balanceResult, T Function<T>(String) parseRpc) {
    final result = parseRpc<String>(balanceResult);
    return hexToInt(result).toDouble() / _sunPerTrx;
  }

  /// Converts Tron base58 address to hex
  String _tronBase58ToHex(String base58Address) {
    final decoded = base58.decode(base58Address);
    final addressBytes = decoded.sublist(0, decoded.length - 4);
    return '0x${addressBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';
  }
}
