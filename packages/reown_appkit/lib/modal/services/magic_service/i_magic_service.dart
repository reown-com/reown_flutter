import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/services/magic_service/models/email_login_step.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class IMagicService {
  Map<String, List<String>> get supportedMethods;
  List<AppKitSocialOption> get socials;

  WebViewWidget get webview;
  ValueNotifier<bool> get isReady;
  ValueNotifier<bool> get isConnected;
  ValueNotifier<bool> get isTimeout;
  ValueNotifier<bool> get isEmailEnabled;
  ValueNotifier<bool> get isSocialEnabled;
  ValueNotifier<String> get email;
  ValueNotifier<String> get newEmail;
  ValueNotifier<EmailLoginStep> get step;

  Future<void> init({String? chainId});

  void setEmail(String value);
  void setNewEmail(String value);
  void setProvider(AppKitSocialOption? provider);

  Future<String?> getSocialRedirectUri({
    required AppKitSocialOption provider,
    String? schema,
    String? chainId,
  });
  Future<dynamic> connectSocial({required String uri});
  void completeSocialLogin({required String url});
  Future<String?> getFarcasterUri({String? chainId});
  Future<bool> awaitFarcasterResponse();
  Future<void> connectEmail({required String value, String? chainId});
  Future<void> updateEmail({required String value});
  Future<void> updateEmailPrimaryOtp({required String otp});
  Future<void> updateEmailSecondaryOtp({required String otp});
  Future<void> connectOtp({required String otp});
  Future<void> syncTheme(ReownAppKitModalTheme? theme);
  Future<String?> getChainId();
  Future<bool> getUser({required String? chainId, required bool isUpdate});
  Future<bool> switchNetwork({required String chainId});
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
  abstract final Event<CompleteSocialLoginEvent> onCompleteSocialLogin;
}
