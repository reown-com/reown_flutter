import 'package:reown_sign/utils/namespace_utils.dart';

class CaipValidator {
  /// Validates a CAIP-2 chain ID (e.g. `eip155:1`)
  static bool isValidCaip2(String input) {
    return NamespaceUtils.isValidChainId(input);
  }

  /// Validates a CAIP-10 Account ID (e.g. `eip155:1:0xabc...`)
  static bool isValidCaip10(String input) {
    final parts = input.split(':');
    if (parts.length != 3) return false;

    final chainId = '${parts[0]}:${parts[1]}';
    final address = parts[2];

    if (!isValidCaip2(chainId)) return false;

    // TODO: Improve for non-EVM chains
    return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(address);
  }
}
