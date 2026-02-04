import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WCPCollectDataWebView extends StatefulWidget {
  const WCPCollectDataWebView({
    super.key,
    required this.collectDataUrl,
    this.stepper = const (1, 2),
  });

  final String collectDataUrl;
  final (int, int) stepper;

  @override
  State<WCPCollectDataWebView> createState() => _WCPCollectDataWebViewState();
}

class _WCPCollectDataWebViewState extends State<WCPCollectDataWebView> {
  static const _channelName = 'wcpCollectData';
  // The web page checks for handlers in this order:
  // 1. iOS WKWebView (webkit.messageHandlers.payDataCollectionComplete)
  // 2. Android WebView (AndroidWallet.onDataCollectionComplete)
  // 3. React Native WebView (ReactNativeWebView.postMessage)
  // 4. Web fallback (window.parent/opener.postMessage)
  // We provide option 3 since webview_flutter doesn't expose the native handlers.
  static const _bridgeScript = '''
    (function () {
      if (window.__wcpCollectDataBridge) return;
      window.__wcpCollectDataBridge = true;

      window.ReactNativeWebView = {
        postMessage: function(data) {
          try {
            const payload = typeof data === 'string' ? data : JSON.stringify(data);
            window.$_channelName.postMessage(payload);
          } catch (e) {
            window.$_channelName.postMessage(String(data));
          }
        }
      };
    })();
  ''';

  late final WebViewController _controller;
  bool _isLoading = true;
  bool _didComplete = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    final uri = Uri.tryParse(widget.collectDataUrl);
    if (uri == null || !uri.hasScheme) {
      setState(() {
        _loadError = 'Invalid data collection URL.';
      });
      return;
    }
    if (uri.scheme != 'https') {
      setState(() {
        _loadError = 'Data collection requires a secure HTTPS connection.';
      });
      return;
    }

    _controller = WebViewController()
      ..setBackgroundColor(StyleConstants.bgPrimary)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(_channelName, onMessageReceived: _handleMessage)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => _setLoading(true),
          onPageFinished: (_) async {
            _setLoading(false);
            await _injectBridge();
          },
          onWebResourceError: (_) {
            _setLoading(false);
            _setError('Unable to load verification page.');
          },
          onNavigationRequest: (NavigationRequest request) async {
            // Open Terms and Privacy links in external browser
            if (request.url == 'https://walletconnect.com/terms' ||
                request.url == 'https://walletconnect.com/privacy') {
              final url = Uri.tryParse(request.url);
              if (url != null) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
              return NavigationDecision.prevent;
            }
            // Allow all other navigation within the webview
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(uri);
  }

  Future<void> _injectBridge() async {
    if (_loadError != null) return;
    try {
      await _controller.runJavaScript(_bridgeScript);
    } catch (_) {}
  }

  void _setLoading(bool value) {
    if (!mounted) return;
    setState(() {
      _isLoading = value;
    });
  }

  void _setError(String message) {
    if (!mounted) return;
    setState(() {
      _loadError = message;
    });
  }

  void _handleMessage(JavaScriptMessage message) {
    if (_didComplete) return;
    final result = _parseMessage(message.message);
    if (result == null) return;
    _didComplete = true;
    if (!mounted) return;
    Navigator.of(context).pop(result);
  }

  Object? _parseMessage(String message) {
    dynamic payload;
    try {
      payload = jsonDecode(message);
    } catch (_) {
      return null;
    }

    if (payload is! Map<String, dynamic>) return null;

    final type = payload['type']?.toString();
    final success = payload['success'];

    if (type == 'IC_COMPLETE' && success == true) {
      return WCBottomSheetResult.next.name;
    }

    if (type == 'IC_ERROR' || success == false) {
      final error = payload['error']?.toString();
      return error ?? 'Data collection failed';
    }

    return null;
  }

  void _close() {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(WCBottomSheetResult.close.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleConstants.bgPrimary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Header with stepper and close button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: StyleConstants.linear16,
                vertical: StyleConstants.linear8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40.0),
                  if (widget.stepper.$1 > 0 && widget.stepper.$2 > 0)
                    WCPStepsIndicator(
                      currentStep: widget.stepper.$1,
                      totalSteps: widget.stepper.$2,
                    )
                  else
                    const SizedBox(width: 40.0),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    visualDensity: VisualDensity.compact,
                    onPressed: _close,
                    icon: const Icon(Icons.close_sharp),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_loadError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleConstants.linear16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WCModalTitle(text: 'Verification needed'),
            const SizedBox(height: StyleConstants.linear16),
            Text(
              _loadError!,
              style: StyleConstants.wcpTextSecondaryStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: StyleConstants.linear24),
            WCPrimaryButton(onPressed: _close, text: 'Close'),
          ],
        ),
      );
    }

    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: StyleConstants.bgPrimary.withValues(alpha: 0.9),
              child: const Center(
                child: WalletConnectLoading(size: 120.0),
              ),
            ),
          ),
      ],
    );
  }
}
