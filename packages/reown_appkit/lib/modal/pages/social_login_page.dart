import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';

import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/farcaster_qrcode_page.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service_singleton.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/avatars/loading_border.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar_action_button.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class SocialLoginPage extends StatefulWidget {
  const SocialLoginPage({
    required this.socialOption,
    this.farcasterCompleter,
  }) : super(key: KeyConstants.socialLoginPage);
  final AppKitSocialOption socialOption;
  final Future<bool>? farcasterCompleter;

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> {
  IReownAppKitModal? _service;
  ModalError? errorEvent;
  bool _retrievingData = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _service = ModalProvider.of(context).instance;
      _service?.onModalError.subscribe(_errorListener);
      if (widget.farcasterCompleter == null) {
        _initSocialLogin(widget.socialOption);
        setState(() {});
      } else {
        widget.farcasterCompleter!.then((success) async {
          await _completeFarcasterLogin(success);
        });
      }
    });
  }

  @override
  void dispose() {
    _service?.onModalError.unsubscribe(_errorListener);
    super.dispose();
  }

  void _errorListener(ModalError? event) {
    toastService.instance.show(ToastMessage(
      type: ToastType.error,
      text: event?.message ?? 'Something went wrong.',
    ));
    setState(() => errorEvent = event);
  }

  Future<void> _initSocialLogin(AppKitSocialOption option) async {
    try {
      setState(() => errorEvent = null);
      if (option == AppKitSocialOption.Farcaster) {
        final farcasterUri = await magicService.instance.getFarcasterUri(
          chainId: _service?.selectedChain?.chainId,
        );

        if (farcasterUri != null) {
          await _continueInFarcaster(farcasterUri);
        }
      } else {
        final redirectUri = await magicService.instance.getSocialRedirectUri(
          provider: option,
          chainId: _service?.selectedChain?.chainId,
        );

        if (redirectUri != null) {
          await _continueInWebview(redirectUri);
        }
      }
    } catch (e) {
      debugPrint('[$runtimeType] _initSocialLogin error $e');
    }
  }

  Future<void> _continueInWebview(String redirectUri) async {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final bottomSheet = PlatformUtils.isBottomSheet();
    final isTabletSize = PlatformUtils.isTablet(context);
    final maxRadius = min(radiuses.radiusM, 36.0);
    final innerContainerBorderRadius = bottomSheet && !isTabletSize
        ? BorderRadius.only(
            topLeft: Radius.circular(maxRadius),
            topRight: Radius.circular(maxRadius),
          )
        : BorderRadius.all(Radius.circular(maxRadius));
    final result = await showModalBottomSheet(
      backgroundColor: Colors.black.withOpacity(0.5),
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      useRootNavigator: false,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: themeColors.background125,
          borderRadius: innerContainerBorderRadius,
        ),
        child: _WebViewLoginWidget(
          url: redirectUri,
          onCancel: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
    );

    if (result == false) {
      _cancelSocialLogin();
    } else {
      await _completeSocialLogin(result);
    }
  }

  Future<void> _completeSocialLogin(String url) async {
    try {
      setState(() => _retrievingData = true);
      final success = await magicService.instance.connectSocial(
        uri: '?${Uri.parse(url).query}',
      );
      if (success == true) {
        await magicService.instance.getUser();
      } else {
        _cancelSocialLogin();
      }
    } catch (e) {
      debugPrint('[$runtimeType] _completeSocialLogin error $e');
      _cancelSocialLogin();
      setState(() => _retrievingData = false);
    }
  }

  Future<void> _continueInFarcaster(String farcasterUri) async {
    widgetStack.instance.push(
      replace: true,
      FarcasterQRCodePage(
        farcasterUri: farcasterUri,
        farcasterCompleter: magicService.instance.connectFarcaster(),
      ),
    );
  }

  Future<void> _completeFarcasterLogin(bool success) async {
    if (success == false) {
      _cancelSocialLogin();
    } else {
      setState(() => _retrievingData = true);
      await magicService.instance.getUser();
    }
  }

  void _cancelSocialLogin() {
    debugPrint('[$runtimeType] _cancelSocialLogin');
    errorEvent = ModalError('User canceled');
    setState(() => _retrievingData = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      return ContentLoading();
    }
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final isPortrait = ResponsiveData.isPortrait(context);
    final maxWidth = isPortrait
        ? ResponsiveData.maxWidthOf(context)
        : ResponsiveData.maxHeightOf(context) -
            kNavbarHeight -
            (kPadding16 * 2);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return ModalNavbar(
      title: widget.socialOption.name,
      onBack: () {
        _cancelSocialLogin();
        widgetStack.instance.pop();
      },
      body: SingleChildScrollView(
        scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: kPadding16),
        child: Flex(
          direction: isPortrait ? Axis.vertical : Axis.horizontal,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox.square(dimension: 20.0),
                  errorEvent == null
                      ? LoadingBorder(
                          animate: errorEvent == null,
                          borderRadius: kSelectedWalletIconHeight,
                          child: ClipRRect(
                            borderRadius: radiuses.isSquare()
                                ? BorderRadius.zero
                                : BorderRadius.circular(maxWidth),
                            child: SvgPicture.asset(
                              AssetUtils.getThemedAsset(
                                context,
                                '${widget.socialOption.name.toLowerCase()}_logo.svg',
                              ),
                              package: 'reown_appkit',
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            SizedBox.square(
                              dimension: kSelectedWalletIconHeight,
                              child: ClipRRect(
                                borderRadius: radiuses.isSquare()
                                    ? BorderRadius.zero
                                    : BorderRadius.circular(maxWidth),
                                child: SvgPicture.asset(
                                  AssetUtils.getThemedAsset(
                                    context,
                                    '${widget.socialOption.name.toLowerCase()}_logo.svg',
                                  ),
                                  package: 'reown_appkit',
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themeColors.background125,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                padding: const EdgeInsets.all(1.0),
                                clipBehavior: Clip.antiAlias,
                                child: RoundedIcon(
                                  assetPath: 'lib/modal/assets/icons/close.svg',
                                  assetColor: themeColors.error100,
                                  circleColor:
                                      themeColors.error100.withOpacity(0.2),
                                  borderColor: themeColors.background125,
                                  padding: 4.0,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox.square(dimension: 20.0),
                  Text(
                    'Log in with ${widget.socialOption.name}',
                    textAlign: TextAlign.center,
                    style: themeData.textStyles.paragraph500.copyWith(
                      color: themeColors.foreground100,
                    ),
                  ),
                  const SizedBox.square(dimension: 8.0),
                  errorEvent == null
                      ? Text(
                          _retrievingData
                              ? 'Retrieving user data'
                              : 'Connect in the provider window',
                          textAlign: TextAlign.center,
                          style: themeData.textStyles.small500.copyWith(
                            color: themeColors.foreground200,
                          ),
                        )
                      : SimpleIconButton(
                          onTap: () {
                            _initSocialLogin(widget.socialOption);
                          },
                          leftIcon: 'lib/modal/assets/icons/refresh_back.svg',
                          title: 'Try again',
                          backgroundColor: Colors.transparent,
                          foregroundColor: themeColors.accent100,
                        ),
                  const SizedBox.square(dimension: kPadding16),
                ],
              ),
            ),
            if (!isPortrait) const SizedBox.square(dimension: kPadding16),
          ],
        ),
      ),
    );
  }
}

class _WebViewLoginWidget extends StatefulWidget {
  const _WebViewLoginWidget({
    required this.url,
    required this.onCancel,
  });
  final String url;
  final VoidCallback onCancel;

  @override
  State<_WebViewLoginWidget> createState() => __WebViewLoginWidgetState();
}

class __WebViewLoginWidgetState extends State<_WebViewLoginWidget> {
  final _webViewController = WebViewController();
  final _cookieManager = WebViewCookieManager();
  final _authority = Uri.parse(UrlConstants.secureDashboard).authority;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _clearCookies() async {
    if (kDebugMode) return;
    try {
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        final webKitManager =
            _cookieManager.platform as WebKitWebViewCookieManager;
        webKitManager.clearCookies();
      } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
        final androidManager =
            _cookieManager.platform as AndroidWebViewCookieManager;
        androidManager.clearCookies();
        androidManager.setAcceptThirdPartyCookies(
          _webViewController.platform as AndroidWebViewController,
          kDebugMode,
        );
      }
    } catch (e) {
      debugPrint('[$runtimeType] _clearCookies error $e');
    }
  }

  void _setDebugMode() {
    if (kDebugMode) {
      if (Platform.isIOS) {
        final wkCtrl = _webViewController.platform as WebKitWebViewController;
        wkCtrl.setInspectable(true);
      }
      if (Platform.isAndroid) {
        if (_webViewController.platform is AndroidWebViewController) {
          final aCtrl = _webViewController.platform as AndroidWebViewController;
          aCtrl.setMediaPlaybackRequiresUserGesture(false);
          AndroidWebViewController.enableDebugging(true);

          final cookieManager =
              _cookieManager.platform as AndroidWebViewCookieManager;
          cookieManager.setAcceptThirdPartyCookies(
            _webViewController.platform as AndroidWebViewController,
            true,
          );
        }
      }
    }
  }

  Future<void> _init() async {
    _setDebugMode();
    await _clearCookies();
    await _webViewController.clearCache();
    await _webViewController.clearLocalStorage();
    await _webViewController.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          final uri = Uri.parse(request.url);
          final params = uri.queryParameters;
          if (uri.authority == _authority && params.containsKey('state')) {
            debugPrint('onNavigationRequest ${request.url}');
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.of(context).pop(request.url);
            });
          }
          return NavigationDecision.navigate;
        },
      ),
    );
    await _webViewController.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return ModalNavbar(
      title: '',
      onBack: () => widget.onCancel(),
      noClose: true,
      rightAction: NavbarActionButton(
        asset: 'lib/modal/assets/icons/close.svg',
        action: () => widget.onCancel(),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}

extension _AppKitSocialOptionExtension on AppKitSocialOption {
  bool get supportsWebView {
    switch (this) {
      case AppKitSocialOption.X:
        return true;
      case AppKitSocialOption.Apple:
        return true;
      case AppKitSocialOption.Discord:
        return true;
      case AppKitSocialOption.Github:
        return true;
      case AppKitSocialOption.Facebook:
        return true;
      case AppKitSocialOption.Farcaster:
        return true;
      // case AppKitSocialOption.Twitch:
      //   return true;
      // case AppKitSocialOption.Telegram:
      //   return true;
      // case AppKitSocialOption.Google:
      //   return false;
    }
  }
}
