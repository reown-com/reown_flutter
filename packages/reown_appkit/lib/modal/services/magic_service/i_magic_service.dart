import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/reown_appkit.dart';

abstract class IMagicService {
  ConnectionMetadata get metadata;

  Future<void> init();

  void setEmail(String value);
  void setNewEmail(String value);

  // ****** W3mFrameProvider public methods ******* //
  Future<void> connectEmail({required String value});
  Future<void> updateEmail({required String value});
  Future<void> updateEmailPrimaryOtp({required String otp});
  Future<void> updateEmailSecondaryOtp({required String otp});
  Future<void> connectOtp({required String otp});
  Future<void> getChainId();
  Future<void> syncTheme(ReownAppKitModalTheme? theme);
  Future<void> getUser({String? chainId});
  Future<void> switchNetwork({required String chainId});
  Future<dynamic> request({
    String? chainId,
    required SessionRequestParams request,
  });
  Future<bool> disconnect();

  abstract final Event<MagicSessionEvent> onMagicLoginRequest;
  abstract final Event<MagicLoginEvent> onMagicLoginSuccess;
  abstract final Event<MagicConnectEvent> onMagicConnect;
  abstract final Event<MagicSessionEvent> onMagicUpdate;
  abstract final Event<MagicErrorEvent> onMagicError;
  abstract final Event<MagicRequestEvent> onMagicRpcRequest;
}
