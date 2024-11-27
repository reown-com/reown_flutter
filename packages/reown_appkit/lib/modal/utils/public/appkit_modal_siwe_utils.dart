import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SIWEUtils {
  /// Given SIWECreateMessageArgs will format message according to EIP-4361 https://docs.login.xyz/general-information/siwe-overview/eip-4361
  static String formatMessage(SIWECreateMessageArgs params) {
    return GetIt.I<ISiweService>().formatMessage(params);
  }

  static String getAddressFromMessage(String message) {
    return AuthSignature.getAddressFromMessage(message);
  }

  static String getChainIdFromMessage(String message) {
    return AuthSignature.getChainIdFromMessage(message);
  }

  // verifies CACAO signature
  // Used by the wallet after formatting the message
  static Future<bool> verifySignature(
    String address,
    String message,
    CacaoSignature cacaoSignature,
    String chainId,
    String projectId,
  ) async {
    return AuthSignature.verifySignature(
      address,
      message,
      cacaoSignature,
      chainId,
      projectId,
    );
  }

  static String generateNonce() {
    return AuthUtils.generateNonce();
  }
}
