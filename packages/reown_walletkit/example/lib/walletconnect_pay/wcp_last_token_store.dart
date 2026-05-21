import 'package:shared_preferences/shared_preferences.dart';

/// Remembers the [PayAmount.unit] (e.g. `eip155:8453/erc20:0x…`) the user last
/// successfully paid with, so the next WCPay session against any merchant can
/// pre-select the same token when it's among the available options.
///
/// Mirrors RN `PAY_LAST_TOKEN_UNIT` (PR #480) and Kotlin
/// `PaymentSelectionResolver` (PR #385).
class WCPLastTokenStore {
  WCPLastTokenStore._();
  static final instance = WCPLastTokenStore._();

  static const _key = 'PAY_LAST_TOKEN_UNIT';

  Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    return (value == null || value.isEmpty) ? null : value;
  }

  Future<void> write(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, unit);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
