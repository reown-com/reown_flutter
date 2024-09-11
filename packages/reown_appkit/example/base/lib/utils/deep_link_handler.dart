import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_appkit/reown_appkit.dart';

class DeepLinkHandler {
  static const _methodChannel = MethodChannel(
    'com.walletconnect.flutterdapp/methods',
  );
  static const _eventChannel = EventChannel(
    'com.walletconnect.flutterdapp/events',
  );
  static final waiting = ValueNotifier<bool>(false);
  static late IReownAppKit _appKit;

  static void initListener() {
    if (kIsWeb) return;
    try {
      _eventChannel.receiveBroadcastStream().listen(
            _onLink,
            onError: _onError,
          );
    } catch (e) {
      debugPrint('[SampleWallet] [DeepLinkHandler] checkInitialLink $e');
    }
  }

  static void init(IReownAppKit appKit) {
    if (kIsWeb) return;
    _appKit = appKit;
  }

  static void checkInitialLink() async {
    if (kIsWeb) return;
    try {
      _methodChannel.invokeMethod('initialLink');
    } catch (e) {
      debugPrint('[SampleWallet] [DeepLinkHandler] checkInitialLink $e');
    }
  }

  static Uri get nativeUri =>
      Uri.parse(_appKit.metadata.redirect?.native ?? '');
  static Uri get universalUri =>
      Uri.parse(_appKit.metadata.redirect?.universal ?? '');
  static String get host => universalUri.host;

  static void _onLink(dynamic link) async {
    if (link == null) return;
    final envelope = ReownCoreUtils.getSearchParamFromURL(link, 'wc_ev');
    if (envelope.isNotEmpty) {
      debugPrint('[SampleDapp] is linkMode $link');
      await _appKit.dispatchEnvelope(link);
    }
  }

  static void _onError(dynamic error) {
    debugPrint('[SampleDapp] _onError $error');
    waiting.value = false;
  }
}
