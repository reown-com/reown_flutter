import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final walletAddressProvider = StateNotifierProvider<WalletAddressNotifier, String?>(
  (ref) => WalletAddressNotifier(),
);

class WalletAddressNotifier extends StateNotifier<String?> {
  WalletAddressNotifier() : super(null) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('wallet_address');
  }

  Future<void> save(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wallet_address', address);
    state = address;
  }
}
