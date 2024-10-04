import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';

class DeepLinkHandler {
  static const _methodChannel = MethodChannel(
    'com.walletconnect.flutterwallet/methods',
  );
  static const _eventChannel = EventChannel(
    'com.walletconnect.flutterwallet/events',
  );
  static final waiting = ValueNotifier<bool>(false);

  static void initListener() {
    if (kIsWeb) return;
    _eventChannel.receiveBroadcastStream().listen(
          _onLink,
          onError: _onError,
        );
  }

  static void checkInitialLink() async {
    if (kIsWeb) return;
    try {
      final initialLink = await _methodChannel.invokeMethod('initialLink');
      if (initialLink != null) {
        _onLink(initialLink);
      }
    } catch (e) {
      debugPrint('[SampleWallet] [DeepLinkHandler] checkInitialLink $e');
    }
  }

  static IReownWalletKit get _walletKit =>
      GetIt.I<IWalletKitService>().walletKit;
  static Uri get nativeUri =>
      Uri.parse(_walletKit.metadata.redirect?.native ?? '');
  static Uri get universalUri =>
      Uri.parse(_walletKit.metadata.redirect?.universal ?? '');
  static String get host => universalUri.host;

  static void _onLink(Object? event) async {
    try {
      return await _walletKit.dispatchEnvelope('$event');
    } catch (e) {
      final decodedUri = Uri.parse(Uri.decodeFull(event.toString()));
      if (decodedUri.isScheme('wc')) {
        debugPrint('[SampleWallet] is legacy uri $decodedUri');
        waiting.value = true;
        await _walletKit.pair(uri: decodedUri);
      } else {
        final uriParam = ReownCoreUtils.getSearchParamFromURL(
          decodedUri.toString(),
          'uri',
        );
        if (decodedUri.isScheme(nativeUri.scheme) && uriParam.isNotEmpty) {
          debugPrint('[SampleWallet] is custom uri $decodedUri');
          waiting.value = true;
          final pairingUri = decodedUri.query.replaceFirst('uri=', '');
          await _walletKit.pair(uri: Uri.parse(pairingUri));
        }
      }
    }
  }

  static void _onError(Object error) {
    waiting.value = false;
    debugPrint('[SampleWallet] [DeepLinkHandler] _onError $error');
  }
}
