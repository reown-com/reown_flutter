import 'dart:async';

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

  static final _errorStream = StreamController<String>();
  static Stream<String> get errorStream => _errorStream.stream;

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
      debugPrint('[WalletKit] [DeepLinkHandler] checkInitialLink $e');
    }
  }

  // static IReownWalletKit get _walletKit =>
  //     GetIt.I<IWalletKitService>().walletKit;
  // static Uri get nativeUri =>
  //     Uri.parse(_walletKit.metadata.redirect?.native ?? '');
  // static Uri get universalUri =>
  //     Uri.parse(_walletKit.metadata.redirect?.universal ?? '');
  // static String get host => universalUri.host;

  static void _onLink(dynamic link) async {
    debugPrint('[WalletKit] [DeepLinkHandler] _onLink $link');
    try {
      final serviceRegistered = GetIt.I.isRegistered<IWalletKitService>();
      if (serviceRegistered) {
        final walletKit = GetIt.I<IWalletKitService>().walletKit;
        return await walletKit.dispatchEnvelope('$link');
      }
    } catch (e) {
      _relayConnetionUri(link);
    }
  }

  static void _relayConnetionUri(dynamic link) async {
    try {
      final serviceRegistered = GetIt.I.isRegistered<IWalletKitService>();
      if (!serviceRegistered) return;

      final decodedUri = Uri.parse(Uri.decodeFull('$link'));
      if (decodedUri.isScheme('wc')) {
        debugPrint('[WalletKit] [DeepLinkHandler] is legacy uri $decodedUri');
        waiting.value = true;
        final walletKit = GetIt.I<IWalletKitService>().walletKit;
        await walletKit.pair(uri: decodedUri);
      } else {
        final uriParam = ReownCoreUtils.getSearchParamFromURL(
          decodedUri.toString(),
          'uri',
        );
        if ((decodedUri.isScheme('wcflutterwallet') ||
                decodedUri.isScheme('wcflutterwallet-internal')) &&
            uriParam.isNotEmpty) {
          debugPrint('[WalletKit] [DeepLinkHandler] is custom uri $decodedUri');
          waiting.value = true;
          final pairingUri = decodedUri.query.replaceFirst('uri=', '');
          final walletKit = GetIt.I<IWalletKitService>().walletKit;
          await walletKit.pair(uri: Uri.parse(pairingUri));
        }
      }
    } catch (e) {
      //
      debugPrint('[WalletKit] [DeepLinkHandler] $link error: $e');
      waiting.value = false;
      _errorStream.sink.add(e.toString());
    }
  }

  static void _onError(Object error) {
    waiting.value = false;
    debugPrint('[WalletKit] [DeepLinkHandler] _onError $error');
    _errorStream.sink.add(error.toString());
  }
}
