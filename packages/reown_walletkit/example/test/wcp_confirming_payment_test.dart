import 'package:flutter_test/flutter_test.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_confirming_payment.dart';

void main() {
  test(
    'collectWCPActionSignatures includes transaction hash in action order',
    () async {
      final actions = [
        const Action(
          walletRpc: WalletRpcAction(
            chainId: 'eip155:8453',
            method: 'eth_sendTransaction',
            params: '[]',
          ),
        ),
        const Action(
          walletRpc: WalletRpcAction(
            chainId: 'eip155:8453',
            method: 'eth_signTypedData_v4',
            params: '[]',
          ),
        ),
      ];
      final startedMethods = <String>[];

      final signatures = await collectWCPActionSignatures(
        actions: actions,
        onActionStarted: (action) {
          startedMethods.add(action.walletRpc.method);
        },
        executeAction: (action) async {
          switch (action.walletRpc.method) {
            case 'eth_sendTransaction':
              return '0xapprovaltxhash';
            case 'eth_signTypedData_v4':
              return '0xtypeddatasignature';
            default:
              throw UnimplementedError(action.walletRpc.method);
          }
        },
      );

      expect(startedMethods, ['eth_sendTransaction', 'eth_signTypedData_v4']);
      expect(signatures, ['0xapprovaltxhash', '0xtypeddatasignature']);
    },
  );
}
