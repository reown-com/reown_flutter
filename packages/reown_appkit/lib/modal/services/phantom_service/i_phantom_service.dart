import 'package:reown_appkit/modal/services/phantom_service/models/phantom_events.dart';
import 'package:reown_appkit/reown_appkit.dart';

class PhantomServiceException implements Exception {
  final String message;
  final dynamic error;
  final dynamic stackTrace;
  PhantomServiceException(
    this.message, [
    this.error,
    this.stackTrace,
  ]) : super();
}

class PhantomWalletNotInstalledException extends PhantomServiceException {
  PhantomWalletNotInstalledException() : super('App not installed');
}

class PhantomNotEnabledException extends PhantomServiceException {
  PhantomNotEnabledException() : super('Phantom is disabled');
}

abstract class IPhantomService {
  List<String> get supportedMethods;

  Future<void> init();
  Future<bool> isConnected();
  Future<void> getAccount();
  Future<dynamic> request({
    required String chainId,
    required SessionRequestParams request,
  });
  void completePhantomRequest({required String url});

  Future<void> resetSession();
  Future<bool> isInstalled();

  Future<String> get ownPublicKey;
  Future<String> get peerPublicKey;

  ConnectionMetadata get metadata;

  abstract final Event<PhantomConnectEvent> onPhantomConnect;
  abstract final Event<PhantomErrorEvent> onPhantomError;
  abstract final Event<PhantomSessionEvent> onPhantomSessionUpdate;
  abstract final Event<PhantomResponseEvent> onPhantomResponse;
}
