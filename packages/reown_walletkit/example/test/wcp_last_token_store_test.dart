import 'package:flutter_test/flutter_test.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_last_token_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('returns null when nothing has been written', () async {
    expect(await WCPLastTokenStore.instance.read(), isNull);
  });

  test('round-trips a unit', () async {
    await WCPLastTokenStore.instance.write('eip155:8453/erc20:0xUSDC');
    expect(
      await WCPLastTokenStore.instance.read(),
      'eip155:8453/erc20:0xUSDC',
    );
  });

  test('write overwrites the previous value', () async {
    await WCPLastTokenStore.instance.write('A');
    await WCPLastTokenStore.instance.write('B');
    expect(await WCPLastTokenStore.instance.read(), 'B');
  });

  test('clear removes the stored unit', () async {
    await WCPLastTokenStore.instance.write('A');
    await WCPLastTokenStore.instance.clear();
    expect(await WCPLastTokenStore.instance.read(), isNull);
  });

  test('empty string is treated as null', () async {
    SharedPreferences.setMockInitialValues({'PAY_LAST_TOKEN_UNIT': ''});
    expect(await WCPLastTokenStore.instance.read(), isNull);
  });
}
