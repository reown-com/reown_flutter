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

    final namespace = parts[0];
    final reference = parts[1];
    final address = parts[2];

    if (address.isEmpty) return false;

    final chainId = '$namespace:$reference';
    return isValidCaip2(chainId);
  }

  // static bool _isValidEthereumAddress(String address) {
  //   // https://namespaces.chainagnostic.org/eip155/caip10
  //   return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(address);
  // }

  // static bool _isValidSolanaAddress(String address) {
  //   // https://namespaces.chainagnostic.org/solana/caip10
  //   final base58Regex = RegExp(r'^[1-9A-HJ-NP-Za-km-z]{32,44}$');
  //   return base58Regex.hasMatch(address);
  // }

  // static bool _isValidTronAddress(String address) {
  //   final tronRegex = RegExp(r'^T[A-Za-z1-9]{33}$');
  //   return tronRegex.hasMatch(address);
  // }
}
