import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit/reown_appkit.dart';

enum SolanaMethods {
  solanaSignTransaction,
  solanaSignMessage,
}

enum SolanaEvents {
  none,
}

class Solana {
  static final Map<SolanaMethods, String> methods = {
    SolanaMethods.solanaSignTransaction: 'solana_signTransaction',
    SolanaMethods.solanaSignMessage: 'solana_signMessage'
  };

  static final Map<SolanaEvents, String> events = {};

  static Future<dynamic> callMethod({
    required IReownAppKit appKit,
    required String topic,
    required String method,
    required ReownAppKitModalNetworkInfo chainData,
    required String address,
  }) async {
    switch (method) {
      case 'solana_signMessage':
        return appKit.request(
          topic: topic,
          chainId: chainData.chainId,
          request: (await getParams(method, address))!,
        );
      case 'solana_signTransaction':
        return appKit.request(
          topic: topic,
          chainId: chainData.chainId,
          request: (await getParams(
            method,
            address,
            rpcUrl: chainData.rpcUrl,
          ))!,
        );
      default:
        throw 'Method unimplemented';
    }
  }
}
