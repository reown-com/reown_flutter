import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';

import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/avatars/loading_border.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialLoginPage extends StatefulWidget {
  const SocialLoginPage({required this.socialOption})
      : super(key: KeyConstants.socialLoginPage);
  final AppKitSocialOption socialOption;

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage>
    with WidgetsBindingObserver {
  IReownAppKitModal? _service;
  ModalError? errorEvent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _service = ModalProvider.of(context).instance;
      _service?.onModalError.subscribe(_errorListener);
      _initSocialLogin(widget.socialOption);
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // final isOpen = _service?.isOpen ?? false;
      // final isConnected = _service?.isConnected ?? false;
      // if (isOpen && isConnected && !siweService.instance!.enabled) {
      //   Future.delayed(Duration(seconds: 1), () {
      //     if (!mounted) return;
      //     _service?.closeModal();
      //   });
      // }
    }
  }

  void _errorListener(ModalError? event) => setState(() => errorEvent = event);

  void _initSocialLogin(AppKitSocialOption option) async {
    try {
      final appKitModal = ModalProvider.of(context).instance;
      final redirectUri = await magicService.instance.getSocialRedirectUri(
        provider: option.name.toLowerCase(),
        chainId: appKitModal.selectedChain?.chainId,
      );
      debugPrint('[$runtimeType] _initSocialLogin uri $redirectUri');
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          barrierDismissible: true,
          builder: (context) => _WebViewLoginWidget(url: redirectUri!),
        ),
      );
      // await ReownCoreUtils.openURL(uri!);
      // await _launchUrlInBottomSheet(uri!);
      await _completeSocialLogin(result);
    } catch (e) {
      debugPrint('[$runtimeType] _initSocialLogin error $e');
    }
  }

  Future<void> _completeSocialLogin(String url) async {
    try {
      debugPrint('[$runtimeType] _completeSocialLogin $url');
      final uri = Uri.parse(url);
      final result = await magicService.instance.connectSocial(
        uri: '?${uri.query}',
      );
      debugPrint('[$runtimeType] _completeSocialLogin result $result');
      if (result == true) {
        await magicService.instance.getUser();
      }
    } catch (e) {
      debugPrint('[$runtimeType] _completeSocialLogin error $e');
    }
  }

  @override
  void dispose() {
    _service?.onModalError.unsubscribe(_errorListener);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
    return ModalNavbar(
      title: widget.socialOption.name,
      onBack: () {
        // TODO Social Login cancel Social Login flow
        // _service?.selectWallet(null);
        // widgetStack.instance.pop();
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
                  LoadingBorder(
                    animate: errorEvent == null,
                    borderRadius: themeData.radiuses.isSquare()
                        ? 0
                        : themeData.radiuses.radiusM + 4.0,
                    child: SvgPicture.asset(
                      AssetUtils.getThemedAsset(
                        context,
                        '${widget.socialOption.name.toLowerCase()}_logo.svg',
                      ),
                      package: 'reown_appkit',
                    ),
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
                  Text(
                    'Connect in the provider window',
                    textAlign: TextAlign.center,
                    style: themeData.textStyles.small500.copyWith(
                      color: themeColors.foreground200,
                    ),
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
  const _WebViewLoginWidget({required this.url});
  final String url;

  @override
  State<_WebViewLoginWidget> createState() => __WebViewLoginWidgetState();
}

class __WebViewLoginWidgetState extends State<_WebViewLoginWidget> {
  final _webViewController = WebViewController();
  final _authority = Uri.parse(UrlConstants.secureDashboard).authority;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
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
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
