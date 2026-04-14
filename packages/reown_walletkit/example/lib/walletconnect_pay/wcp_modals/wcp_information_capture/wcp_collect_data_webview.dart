import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/main.dart' show navigatorKey;
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/theme_provider.dart';
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

const _preloadViewportAndBridgeJs = '''
  (function() {
    function applyViewportStyles() {
      var head = document.head || document.getElementsByTagName('head')[0];
      if (!head) {
        return;
      }

      var meta = document.querySelector('meta[name="viewport"]');
      if (!meta) {
        meta = document.createElement('meta');
        meta.name = 'viewport';
        head.appendChild(meta);
      }

      meta.content =
        'width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover';

      var style = document.getElementById('flutter-webview-fit-style');
      if (!style) {
        style = document.createElement('style');
        style.id = 'flutter-webview-fit-style';
        style.textContent =
          'html, body { margin: 0 !important; padding: 0 !important; width: 100% !important; max-width: 100% !important; overflow: hidden !important; overscroll-behavior: none !important; }';
        head.appendChild(style);
      }
    }

    function installFlutterBridge() {
      if (!window.FlutterCollectDataBridge) {
        return;
      }

      window.ReactNativeWebView = window.ReactNativeWebView || {};
      window.ReactNativeWebView.postMessage = function(message) {
        window.FlutterCollectDataBridge.postMessage(String(message));
      };
    }

    applyViewportStyles();
    installFlutterBridge();

    document.addEventListener('DOMContentLoaded', function() {
      applyViewportStyles();
      installFlutterBridge();
    }, { once: true });
  })();
''';

/// Opens the WCPay collect-data form in an embedded WebView and returns:
/// - [WCBottomSheetResult.next] name on success
/// - [PaymentStatus.expired], [PaymentStatus.failed], or
///   [PaymentStatus.cancelled] on form errors
/// - [WCBottomSheetResult.close] name if the user dismisses the WebView
class WCPCollectDataWebView {
  WCPCollectDataWebView._();

  static const _collectDataBridge = 'FlutterCollectDataBridge';
  static const _prefillFieldValues = {
    'fullName': 'Test User',
    'dob': '1990-01-15',
    'pobAddress': 'New York, NY',
    'pobCountry': 'US',
    'porAddress': 'New York, NY',
    'porCountry': 'US',
  };

  static Future<Object?> show(String collectDataUrl, {String? schema}) async {
    final context = navigatorKey.currentContext;
    if (context == null) {
      return WCBottomSheetResult.close.name;
    }

    final prefill = DartDefines.enableTestMode
        ? _buildPrefillParam(schema)
        : null;
    final result =
        await Navigator.of(context, rootNavigator: true).push<Object>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _WCPCollectDataWebViewPage(
          initialUrl: _buildCollectDataUrl(collectDataUrl),
          prefill: prefill,
        ),
      ),
    );

    return result ?? WCBottomSheetResult.close.name;
  }

  static String _buildCollectDataUrl(String collectDataUrl) {
    var url = collectDataUrl;

    final themeProvider =
        GetIt.I.isRegistered<ThemeProvider>() ? GetIt.I<ThemeProvider>() : null;
    final isDark = themeProvider?.isDark ??
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    final theme = isDark ? 'dark' : 'light';
    url = _appendOrReplaceQueryParam(url, 'theme', theme);

    return url;
  }

  static String? _buildPrefillParam(String? schema) {
    if (schema == null) return null;

    try {
      final schemaJson = jsonDecode(schema);
      if (schemaJson is! Map<String, dynamic>) {
        return null;
      }

      final requiredFields = <String>{};
      _appendRequiredFields(requiredFields, schemaJson['required']);

      final anyOf = schemaJson['anyOf'];
      if (anyOf is List) {
        for (final group in anyOf) {
          if (group is Map<String, dynamic>) {
            _appendRequiredFields(requiredFields, group['required']);
          }
        }
      }

      final prefillData = <String, String>{};
      for (final fieldId in requiredFields) {
        final value = _prefillFieldValues[fieldId];
        if (value != null) {
          prefillData[fieldId] = value;
        }
      }

      if (prefillData.isEmpty) {
        return null;
      }

      return base64Url.encode(utf8.encode(jsonEncode(prefillData)));
    } catch (_) {
      return null;
    }
  }

  static void _appendRequiredFields(Set<String> target, Object? required) {
    if (required is! List) return;
    for (final field in required) {
      if (field is String && field.isNotEmpty) {
        target.add(field);
      }
    }
  }

  static String _appendOrReplaceQueryParam(
    String url,
    String key,
    String value,
  ) {
    final uri = Uri.parse(url);
    final query = Map<String, String>.from(uri.queryParameters);
    query[key] = value;
    return uri.replace(queryParameters: query).toString();
  }

  static Object mapWebViewMessage(String data) {
    try {
      final message = jsonDecode(data);
      if (message is Map<String, dynamic>) {
        final type = '${message['type'] ?? ''}';
        final success = message['success'];
        final error = '${message['error'] ?? ''}';

        if ((type == 'IC_COMPLETE' || type == 'IC_SUCCESS') &&
            success != false) {
          return WCBottomSheetResult.next.name;
        }

        if (type == 'IC_ERROR' || success == false) {
          return _mapErrorToResult(error);
        }
      }
    } catch (_) {
      // Fall through to string-based handling below.
    }

    if (data.contains('IC_SUCCESS') || data.contains('IC_COMPLETE')) {
      return WCBottomSheetResult.next.name;
    }

    return _mapErrorToResult(data);
  }

  static Object _mapErrorToResult(String error) {
    final normalized = error.toLowerCase();
    if (normalized.contains('cancel') ||
        normalized.contains('closed') ||
        normalized.contains('dismiss') ||
        normalized.contains('reject')) {
      return PaymentStatus.cancelled;
    }
    if (normalized.contains('expired') ||
        normalized.contains('invalid_state')) {
      return PaymentStatus.expired;
    }
    return PaymentStatus.failed;
  }

  static String get collectDataBridge => _collectDataBridge;
}

class _WCPCollectDataWebViewPage extends StatefulWidget {
  const _WCPCollectDataWebViewPage({
    required this.initialUrl,
    this.prefill,
  });

  final String initialUrl;
  final String? prefill;

  @override
  State<_WCPCollectDataWebViewPage> createState() =>
      _WCPCollectDataWebViewPageState();
}

class _WCPCollectDataWebViewPageState
    extends State<_WCPCollectDataWebViewPage> {
  late final WebViewController _controller;
  late final String _baseUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _baseUrl = _getBaseUrl(widget.initialUrl);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        WCPCollectDataWebView.collectDataBridge,
        onMessageReceived: (message) {
          _complete(WCPCollectDataWebView.mapWebViewMessage(message.message));
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (_) async {
            try {
              await _controller.runJavaScript(_preloadViewportAndBridgeJs);
              if (widget.prefill != null) {
                final payload = jsonEncode({
                  'type': 'PREFILL',
                  'data': widget.prefill,
                });
                await _controller.runJavaScript(
                  'window.postMessage(${jsonEncode(payload)}, "*");',
                );
              }
            } catch (e) {
              debugPrint(
                '[WCPCollectDataWebView] bridge injection failed: $e',
              );
            }
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('about:blank')) {
              return NavigationDecision.navigate;
            }

            final requestBaseUrl = _getBaseUrl(request.url);
            if (requestBaseUrl != _baseUrl) {
              unawaited(
                launchUrl(
                  Uri.parse(request.url),
                  mode: LaunchMode.externalApplication,
                ),
              );
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            if (!mounted || !error.isForMainFrame) return;
            _complete(
              WCPCollectDataWebView.mapWebViewMessage(
                error.description.isNotEmpty
                    ? error.description
                    : 'Failed to load the form',
              ),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  String _getBaseUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return '${uri.scheme}://${uri.host}';
    } catch (_) {
      return url;
    }
  }

  void _dismiss() {
    Navigator.of(context).pop(WCBottomSheetResult.close.name);
  }

  void _complete(Object result) {
    if (!mounted) return;
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _dismiss();
        }
      },
      child: Scaffold(
        backgroundColor: colors.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s5,
                  AppSpacing.s5,
                  AppSpacing.s5,
                  AppSpacing.s3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Semantics(
                      container: true,
                      identifier: 'pay-button-back',
                      label: 'pay-button-back',
                      child: WCPSheetIconButton(
                        icon: Icons.arrow_back,
                        showBorder: false,
                        onPressed: _dismiss,
                      ),
                    ),
                    Expanded(
                      child: Semantics(
                        container: true,
                        identifier: 'pay-webview-header',
                        label: 'pay-webview-header',
                        child: Text(
                          'Add your personal details',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: colors.textPrimary),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Semantics(
                      container: true,
                      identifier: 'pay-button-close',
                      label: 'pay-button-close',
                      child: WCPSheetIconButton(
                        icon: Icons.close,
                        onPressed: _dismiss,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    WebViewWidget(controller: _controller),
                    if (_isLoading)
                      ColoredBox(
                        color: colors.background,
                        child: const Center(
                          child: WalletConnectLoading(size: 120),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
