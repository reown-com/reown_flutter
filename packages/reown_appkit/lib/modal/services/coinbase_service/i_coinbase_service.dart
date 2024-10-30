import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_events.dart';
import 'package:reown_appkit/reown_appkit.dart';

class CoinbaseServiceException implements Exception {
  final String message;
  final dynamic error;
  final dynamic stackTrace;
  CoinbaseServiceException(
    this.message, [
    this.error,
    this.stackTrace,
  ]) : super();
}

class CoinbaseWalletNotInstalledException extends CoinbaseServiceException {
  CoinbaseWalletNotInstalledException() : super('App not installed');
}

class CoinbaseNotEnabledException extends CoinbaseServiceException {
  CoinbaseNotEnabledException() : super('Coinbase is disabled');
}

abstract class ICoinbaseService {
  List<String> get supportedMethods;

  Future<void> init();
  Future<bool> isConnected();
  Future<void> getAccount();
  Future<dynamic> request({
    required String chainId,
    required SessionRequestParams request,
  });
  Future<void> resetSession();
  Future<bool> isInstalled();

  Future<String> get ownPublicKey;
  Future<String> get peerPublicKey;

  ConnectionMetadata get metadata;

  abstract final Event<CoinbaseConnectEvent> onCoinbaseConnect;
  abstract final Event<CoinbaseErrorEvent> onCoinbaseError;
  abstract final Event<CoinbaseSessionEvent> onCoinbaseSessionUpdate;
  abstract final Event<CoinbaseResponseEvent> onCoinbaseResponse;
}
