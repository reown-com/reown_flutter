import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';

class DeepLinkHandler {
  static const _methodChannel = MethodChannel(
    'com.web3modal.flutterExample/methods',
  );
  static const _eventChannel = EventChannel(
    'com.web3modal.flutterExample/events',
  );
  static final waiting = ValueNotifier<bool>(false);
  static late IReownAppKitModal _appKitModal;

  static void initListener() {
    if (kIsWeb) return;
    try {
      _eventChannel.receiveBroadcastStream().listen(
            _onLink,
            onError: _onError,
          );
    } catch (e) {
      debugPrint('[SampleModal] initListener $e');
    }
  }

  static void init(IReownAppKitModal appKitModal) {
    if (kIsWeb) return;
    _appKitModal = appKitModal;
  }

  static void checkInitialLink() async {
    if (kIsWeb) return;
    try {
      _methodChannel.invokeMethod('initialLink');
    } catch (e) {
      debugPrint('[SampleModal] checkInitialLink $e');
    }
  }

  static Uri get nativeUri =>
      Uri.parse(_appKitModal.appKit!.metadata.redirect?.native ?? '');
  static Uri get universalUri =>
      Uri.parse(_appKitModal.appKit!.metadata.redirect?.universal ?? '');
  static String get host => universalUri.host;

  static void _onLink(dynamic link) async {
    debugPrint('[SampleModal] _onLink $link');
    if (link == null) return;
    final handled = await _appKitModal.dispatchEnvelope(link);
    if (!handled) {
      debugPrint('[SampleModal] _onLink not handled by AppKit');
    }
  }

  static void _onError(dynamic error) {
    debugPrint('[SampleModal] _onError $error');
    waiting.value = false;
  }
}
