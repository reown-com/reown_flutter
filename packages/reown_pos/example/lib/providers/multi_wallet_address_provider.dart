import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_pos/models/pos_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiWalletAddresses {
  final String? evmWalletAddress;
  final String? solanaWalletAddress;
  final String? tronWalletAddress;

  const MultiWalletAddresses({
    this.evmWalletAddress,
    this.solanaWalletAddress,
    this.tronWalletAddress,
  });

  MultiWalletAddresses copyWith({
    String? evmWalletAddress,
    String? solanaWalletAddress,
    String? tronWalletAddress,
  }) {
    return MultiWalletAddresses(
      evmWalletAddress: evmWalletAddress ?? this.evmWalletAddress,
      solanaWalletAddress: solanaWalletAddress ?? this.solanaWalletAddress,
      tronWalletAddress: tronWalletAddress ?? this.tronWalletAddress,
    );
  }

  String? getRecipientForChain(PosNetwork network) {
    switch (network.chainId.split(':').first.toLowerCase()) {
      case 'solana':
        return solanaWalletAddress;
      case 'tron':
        return tronWalletAddress;
      default:
        return evmWalletAddress; // Default to EVM for unknown networks
    }
  }

  bool get hasAnyAddress =>
      evmWalletAddress != null ||
      solanaWalletAddress != null ||
      tronWalletAddress != null;
}

final multiWalletAddressProvider =
    StateNotifierProvider<MultiWalletAddressNotifier, MultiWalletAddresses>(
      (ref) => MultiWalletAddressNotifier(),
    );

class MultiWalletAddressNotifier extends StateNotifier<MultiWalletAddresses> {
  MultiWalletAddressNotifier() : super(const MultiWalletAddresses()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = MultiWalletAddresses(
      evmWalletAddress: prefs.getString('evm_wallet_address'),
      solanaWalletAddress: prefs.getString('solana_wallet_address'),
      tronWalletAddress: prefs.getString('tron_wallet_address'),
    );
  }

  Future<void> saveEvmAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('evm_wallet_address', address);
    state = state.copyWith(evmWalletAddress: address);
  }

  Future<void> saveSolanaAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('solana_wallet_address', address);
    state = state.copyWith(solanaWalletAddress: address);
  }

  Future<void> saveTronAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tron_wallet_address', address);
    state = state.copyWith(tronWalletAddress: address);
  }

  Future<void> saveAddressForNetwork(String networkName, String address) async {
    switch (networkName.toLowerCase()) {
      case 'solana':
        await saveSolanaAddress(address);
        break;
      case 'tron':
        await saveTronAddress(address);
        break;
      default:
        await saveEvmAddress(address); // Default to EVM for unknown networks
    }
  }
}
