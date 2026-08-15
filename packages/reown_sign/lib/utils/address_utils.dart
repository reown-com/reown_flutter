import 'package:wallet/wallet.dart' as wallet;

class AddressUtils {
  static List<String> _getDidAddressSegments(String iss) {
    return iss.split(':');
  }

  static String? getDidAddressAddress(String iss) {
    final segments = _getDidAddressSegments(iss);
    if (segments.isNotEmpty) {
      return segments.last;
    }
    return null;
  }

  static String? getDidAddressChainId(String iss) {
    final segments = _getDidAddressSegments(iss);
    if (segments.isNotEmpty) {
      return segments[3];
    }
    return null;
  }

  static String? getDidAddressNamespace(String iss) {
    final segments = _getDidAddressSegments(iss);
    if (segments.isNotEmpty) {
      if (iss.contains('did:pkh:')) {
        return segments.length > 2 ? segments[2] : null;
      }
      return segments[0];
    }
    return null;
  }

  static final _NAMESPACE_DISPLAY_NAMES = {
    'eip155': 'Ethereum',
    'solana': 'Solana',
    'bip122': 'Bitcoin',
  };

  static String getNamespaceNameFromNamespace(String? namespace) {
    if (namespace == null) return '';
    final displayName = _NAMESPACE_DISPLAY_NAMES[namespace];
    return displayName ?? namespace;
  }
}

final _evmAddress = RegExp(r'^(0x)?[0-9a-fA-F]{40}$');

extension AddressUtilsExtension on String {
  /// Checksums an EVM address per EIP-55. Non-EVM values are returned unchanged
  /// so Solana / Bitcoin accounts are not forced through EthereumAddress.
  String toEIP55() {
    if (!_evmAddress.hasMatch(this)) {
      return this;
    }
    try {
      return wallet.EthereumAddress.fromHex(this).eip55With0x;
    } catch (_) {
      return this;
    }
  }
}
