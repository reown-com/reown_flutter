import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/widgets/pay_success_view.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A wallet-connect deeplink carries the WC pairing URI in its `uri` query
/// param (e.g. `https://wallet.example/wc?uri=wc:...`). Universal links and
/// custom-scheme deeplinks both match, so `preferUniversalLinks` wallets keep
/// working.
bool isWalletDeeplink(String url) {
  try {
    return Uri.parse(url).queryParameters['uri']?.startsWith('wc:') ?? false;
  } catch (_) {
    return false;
  }
}

/// Appends the two WebView parameters required by the Pay checkout to the
/// gateway URL. Never construct the base URL manually — always start from the
/// `gatewayUrl` returned by the Merchant API.
String buildPayUrl(String gatewayUrl, String appDeepLink) {
  final uri = Uri.parse(gatewayUrl);
  return uri.replace(
    queryParameters: {
      ...uri.queryParameters,
      // The wallet returns here after signing.
      'returnUrl': appDeepLink,
      // Open wallets via universal links instead of custom schemes.
      'preferUniversalLinks': '1',
    },
  ).toString();
}

/// Loads the WalletConnect Pay checkout portal inside a WebView.
///
/// Mirrors the React Native sample's `PayWebView` screen:
/// - intercepts wallet deeplinks (`?uri=wc:...`) and hands them to the OS,
/// - listens for `PAY_SUCCESS` / `PAY_FAILURE` bridge messages,
/// - shows a success screen or backs out with a toast on failure.
///
/// The [url] must already be built with [buildPayUrl] (i.e. carry `returnUrl`
/// and `preferUniversalLinks`).
class PayWebViewPage extends StatefulWidget {
  const PayWebViewPage({super.key, required this.url});

  final String url;

  @override
  State<PayWebViewPage> createState() => _PayWebViewPageState();
}

class _PayWebViewPageState extends State<PayWebViewPage> {
  late final WebViewController _controller;

  // Once the Pay page reports success we swap the WebView for the success
  // result screen, mirroring the wallet sample's Pay flow.
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _onNavigationRequest,
          onWebResourceError: _onWebResourceError,
        ),
      )
      // The hosted checkout calls `window.ReactNativeWebView.postMessage(...)`,
      // so the channel name must stay `ReactNativeWebView` even on Flutter.
      ..addJavaScriptChannel(
        'ReactNativeWebView',
        onMessageReceived: _onBridgeMessage,
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<NavigationDecision> _onNavigationRequest(
    NavigationRequest request,
  ) async {
    if (isWalletDeeplink(request.url)) {
      try {
        final launched = await launchUrl(
          Uri.parse(request.url),
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          _showError(
            "Couldn't open wallet",
            'The wallet app may not be installed.',
          );
        }
      } catch (_) {
        _showError(
          "Couldn't open wallet",
          'The wallet app may not be installed.',
        );
      }
      return NavigationDecision.prevent;
    }
    // Allow https (the checkout) and about: (blank/initial). Block any other
    // scheme so the page can't drive the OS into arbitrary native schemes
    // (tel:, sms:, intent:, …).
    final scheme = Uri.tryParse(request.url)?.scheme.toLowerCase();
    if (scheme == 'https' || scheme == 'about') {
      return NavigationDecision.navigate;
    }
    return NavigationDecision.prevent;
  }

  void _onBridgeMessage(JavaScriptMessage message) {
    Map<String, dynamic> json;
    try {
      json = jsonDecode(message.message) as Map<String, dynamic>;
    } catch (_) {
      // Non-JSON message — ignore.
      return;
    }

    final type = json['type'] as String?;
    final success = json['success'] as bool?;
    final isSuccess = type == 'PAY_SUCCESS' || success == true;
    final isFailure = type == 'PAY_FAILURE' || success == false;

    if (isSuccess) {
      if (!mounted) return;
      setState(() => _successMessage = json['message'] as String? ?? '');
    } else if (isFailure) {
      _showError('Payment failed', json['error'] as String?);
      _goBack();
    }
  }

  // A failed main-frame load (network error, DNS failure, unreachable host)
  // otherwise leaves the user stranded on a blank error page. HTTP errors are
  // intentionally not handled: they can fire for sub-resources and would eject
  // a valid session.
  void _onWebResourceError(WebResourceError error) {
    // Only act on a confirmed main-frame failure. `isForMainFrame` is nullable
    // (iOS/WKWebView leaves it null), and treating null/false as "eject" would
    // dismiss a live checkout on a failing sub-resource (analytics, pixels…).
    if (error.isForMainFrame != true) return;
    _showError(
      'Failed to load payment page',
      'Check your connection and try again.',
    );
    _goBack();
  }

  void _goBack() {
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void _showError(String title, String? description) {
    if (!mounted) return;
    toastification.show(
      type: ToastificationType.error,
      title: Text(title),
      description: description != null ? Text(description) : null,
      context: context,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_successMessage != null) {
      return PaySuccessView(
        message: _successMessage!.isEmpty ? null : _successMessage,
        onDone: _goBack,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ReownAppKitModalTheme.colorsOf(context).background175,
        foregroundColor: ReownAppKitModalTheme.colorsOf(context).foreground100,
        title: const Text('Pay'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
