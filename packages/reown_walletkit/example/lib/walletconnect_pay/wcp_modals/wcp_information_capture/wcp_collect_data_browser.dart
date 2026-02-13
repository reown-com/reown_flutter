import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';

/// Opens the WCPay data-collection form in an in-app browser
/// (SFSafariViewController on iOS, Chrome Custom Tabs on Android)
/// and waits for a callback redirect to signal completion.
///
/// Uses platform-specific callback strategies:
/// - Android: custom scheme (`wcflutterwallet://`) — Chrome Custom Tabs
///   handles custom scheme redirects natively.
/// - iOS: universal link (`https://...`) — SFSafariVC can't handle custom
///   schemes, but universal links work.
class WCPCollectDataBrowser {
  WCPCollectDataBrowser._();

  static const _callbackScheme = 'wcflutterwallet';

  /// Opens [collectDataUrl] in an in-app browser and returns:
  /// - [WCBottomSheetResult.next] name on success
  /// - [WCBottomSheetResult.close] name if user dismisses the browser
  /// - An error string on failure
  static Future<Object?> show(String collectDataUrl) async {
    final callbackUrl = _getCallbackUrl();
    final separator = collectDataUrl.contains('?') ? '&' : '?';
    final encodedCallback = Uri.encodeComponent(callbackUrl);
    final url =
        '$collectDataUrl${separator}callbackUrl=$encodedCallback';

    final completer = Completer<Uri>();

    // Register interceptor to capture the callback deep link.
    // Android: wcflutterwallet://collect-data?status=success
    // iOS: https://appkit-lab.reown.com/flutter_walletkit_internal?status=success
    DeepLinkHandler.oneShotInterceptor = (uri) {
      if (uri.host == 'collect-data' ||
          uri.queryParameters.containsKey('status')) {
        completer.complete(uri);
        return true;
      }
      return false;
    };

    // Listen for app resume — if the user dismisses the browser without
    // submitting the form, no deep link callback fires and the completer
    // would hang forever. When the app resumes and the completer is still
    // pending, treat it as a user cancellation.
    late final AppLifecycleListener lifecycleListener;
    lifecycleListener = AppLifecycleListener(
      onStateChange: (state) {
        if (state == AppLifecycleState.resumed && !completer.isCompleted) {
          // Small delay to allow a deep link to arrive first (the resume
          // event can fire slightly before the deep link is dispatched).
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!completer.isCompleted) {
              completer.completeError('Browser dismissed');
            }
          });
        }
      },
    );

    try {
      final launched = await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.inAppBrowserView,
      );
      if (!launched) {
        lifecycleListener.dispose();
        DeepLinkHandler.oneShotInterceptor = null;
        return 'Failed to open browser';
      }

      final uri = await completer.future;
      lifecycleListener.dispose();
      await closeInAppWebView();

      final status = uri.queryParameters['status'];
      if (status == 'success') {
        return WCBottomSheetResult.next.name;
      }

      return uri.queryParameters['error'] ?? 'Data collection failed';
    } catch (e) {
      lifecycleListener.dispose();
      DeepLinkHandler.oneShotInterceptor = null;
      debugPrint('[WCPCollectDataBrowser] error: $e');
      return WCBottomSheetResult.close.name;
    }
  }

  /// Android: custom scheme (Chrome Custom Tabs handles it natively).
  /// iOS: universal link (SFSafariVC can't handle custom schemes).
  /// Falls back to custom scheme if no universal link is configured.
  static String _getCallbackUrl() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '$_callbackScheme://collect-data';
    }
    // iOS: prefer universal link
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    return walletKit.metadata.redirect?.universal ??
        '$_callbackScheme://collect-data';
  }
}
