import 'package:reown_appkit/reown_appkit.dart';

class ThirdPartyWalletException implements Exception {
  final String message;
  final dynamic error;
  final dynamic stackTrace;

  ThirdPartyWalletException(
    this.message, [
    this.error,
    this.stackTrace,
  ]) : super();
}

class ThirdPartyWalletNotInstalled extends ThirdPartyWalletException {
  ThirdPartyWalletNotInstalled({required String walletName})
      : super('$walletName is not installed');
}

class ThirdPartyWalletNotEnabled extends ThirdPartyWalletException {
  ThirdPartyWalletNotEnabled({required String walletName})
      : super('$walletName is disabled');
}

class ThirdPartyWalletUnsupportedChains extends ThirdPartyWalletException {
  ThirdPartyWalletUnsupportedChains({required String walletName})
      : super('The current configured chains are not supported by $walletName');
}

abstract class IThirdPartyWalletService {
  Future<void> init();
  Future<void> connect({String? chainId});
  Future<bool> isConnected();
  bool get isInstalled;

  Future<dynamic> request({
    required String chainId,
    required SessionRequestParams request,
  });

  Future<void> disconnect();

  Future<String> get dappPublicKey;
  Future<String> get walletPublicKey;
  List<String> get walletSupportedMethods;
  ConnectionMetadata get walletMetadata;
}
