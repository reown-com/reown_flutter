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

  /// Validates a CAIP-19 Asset ID (e.g. `eip155:1/erc20:0xabc...`)
  static bool isValidCaip19(String input) {
    final parts = input.split('/');
    if (parts.length != 2) return false;

    final chainId = parts[0];
    final assetParts = parts[1].split(':');
    if (assetParts.length != 2) return false;

    final assetNamespace = assetParts[0];
    final assetReference = assetParts[1];

    if (!isValidCaip2(chainId)) return false;
    if (assetNamespace.isEmpty || assetReference.isEmpty) return false;

    return true;
  }

  /// Optional: parses a CAIP-10 string into structured parts
  static ({String chainId, String address})? parseCaip10(String input) {
    final parts = input.split(':');
    if (parts.length != 3) return null;

    final chainId = '${parts[0]}:${parts[1]}';
    final address = parts[2];

    return (chainId: chainId, address: address);
  }

  /// Optional: parses a CAIP-19 string into structured parts
  static ({String chainId, String assetNamespace, String assetReference})?
  parseCaip19(String input) {
    final parts = input.split('/');
    if (parts.length != 2) return null;

    final chainId = parts[0];
    final assetParts = parts[1].split(':');
    if (assetParts.length != 2) return null;

    return (
      chainId: chainId,
      assetNamespace: assetParts[0],
      assetReference: assetParts[1],
    );
  }
}
