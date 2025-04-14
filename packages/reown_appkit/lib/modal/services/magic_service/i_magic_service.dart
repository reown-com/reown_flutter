import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class IMagicService {
  Map<String, List<String>> get supportedMethods;

  WebViewWidget get webview;
  ValueNotifier<bool> get isReady;
  ValueNotifier<bool> get isConnected;
  ValueNotifier<bool> get isTimeout;
  ValueNotifier<bool> get isFarcasterEnabled;

  Future<void> init({String? chainId});

  Future<String?> getFarcasterUri({String? chainId});
  Future<bool> awaitFarcasterResponse();

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
}
