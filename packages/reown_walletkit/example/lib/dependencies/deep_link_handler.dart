import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

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

  /// Temporary interceptor for deep links. When set, incoming links are
  /// checked against this callback first. If it returns true the link is
  /// considered handled and normal processing is skipped.
  static bool Function(Uri uri)? oneShotInterceptor;

  static void initListener() {
    if (kIsWeb) return;
    _eventChannel.receiveBroadcastStream().listen(_onLink, onError: _onError);
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

  // Pay links reach the wallet via NFC (the NDEF_DISCOVERED intent-filter on
  // Android / associated NFC delivery on iOS). Universal-link registration for
  // these hosts was removed from AndroidManifest.xml / Runner.entitlements, so
  // on native these URLs now arrive via NFC rather than a tapped App Link.
  static const _payHosts = [
    'pay.walletconnect.com',
    'staging.pay.walletconnect.com',
    'dev.pay.walletconnect.com',
  ];

  static const _customSchemes = [
    'wcflutterwallet',
    'wcflutterwallet-internal',
  ];

  static bool _isPayLink(String link) {
    final uri = Uri.tryParse(link);
    if (uri == null) return false;
    return _payHosts.contains(uri.host);
  }

  /// Returns the payload of a `wcflutterwallet[-internal]://wc?uri=<...>`
  /// link, or null when [link] isn't one. The payload may arrive URL-encoded
  /// or raw, so the whole link is decoded and everything after `uri=` is kept.
  static String? _customSchemeUri(String link) {
    try {
      final decodedUri = Uri.parse(Uri.decodeFull(link));
      if (!_customSchemes.contains(decodedUri.scheme)) return null;
      if (!decodedUri.query.startsWith('uri=')) return null;
      final payload = decodedUri.query.replaceFirst('uri=', '');
      return payload.isEmpty ? null : payload;
    } catch (_) {
      return null;
    }
  }

  static void _onLink(dynamic link) async {
    debugPrint('[WalletKit] [DeepLinkHandler] _onLink $link');

    // Check one-shot interceptor first (used by in-app browser callback).
    if (oneShotInterceptor != null) {
      final uri = Uri.tryParse('$link');
      if (uri != null && oneShotInterceptor!(uri)) {
        oneShotInterceptor = null;
        return;
      }
    }

    // Route pay.walletconnect.com links through the payment flow, whether
    // they arrive bare (NFC) or wrapped in our custom scheme
    // (`wcflutterwallet://wc?uri=<encoded pay link>`, used by the Maestro
    // pay tests).
    if (_isPayLink('$link')) {
      _handlePayLink('$link');
      return;
    }
    final wrappedUri = _customSchemeUri('$link');
    if (wrappedUri != null && _isPayLink(wrappedUri)) {
      _handlePayLink(wrappedUri);
      return;
    }

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

  static void _handlePayLink(String link) async {
    try {
      final serviceRegistered = GetIt.I.isRegistered<IWalletKitService>();
      if (!serviceRegistered) return;

      waiting.value = true;
      final walletKitService = GetIt.I<IWalletKitService>();
      await walletKitService.pair(link);
    } catch (e) {
      debugPrint('[WalletKit] [DeepLinkHandler] pay link error: $e');
      _errorStream.sink.add(e.toString());
    } finally {
      waiting.value = false;
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
        final pairingUri = _customSchemeUri('$link');
        if (pairingUri != null) {
          debugPrint('[WalletKit] [DeepLinkHandler] is custom uri $decodedUri');
          waiting.value = true;
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
