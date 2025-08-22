import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/farcaster_qrcode_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/avatars/loading_border.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SocialLoginPage extends StatefulWidget {
  const SocialLoginPage({required this.socialOption, this.farcasterCompleter})
      : super(key: KeyConstants.socialLoginPage);
  final AppKitSocialOption socialOption;
  final Future<bool>? farcasterCompleter;

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> {
  IMagicService get _magicService => GetIt.I<IMagicService>();
  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

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
    setState(() => errorEvent = event);
  }

  Future<void> _initSocialLogin(AppKitSocialOption option) async {
    try {
      setState(() => errorEvent = null);
      _analyticsService.sendEvent(
        SocialLoginStarted(provider: widget.socialOption.name.toLowerCase()),
      );
      if (option == AppKitSocialOption.Farcaster) {
        final farcasterUri = await _magicService.getFarcasterUri(
          chainId: _service?.selectedChain?.chainId,
        );
        if (farcasterUri != null) {
          await _continueInFarcaster(farcasterUri);
        }
      } else {
        _service?.selectWallet(_webWallet);
        await _service?.connectSelectedWallet(socialOption: option);
      }
    } catch (e) {
      debugPrint('[$runtimeType] _initSocialLogin error $e');
    }
  }

  Future<void> _continueInFarcaster(String farcasterUri) async {
    _widgetStack.push(
      replace: true,
      FarcasterQRCodePage(
        farcasterUri: farcasterUri,
        farcasterCompleter: _magicService.awaitFarcasterResponse(),
      ),
    );
  }

  Future<void> _completeFarcasterLogin(bool success) async {
    if (success == false) {
      errorEvent = ModalError('User canceled');
      setState(() => _retrievingData = false);
      _analyticsService.sendEvent(
        SocialLoginCanceled(provider: widget.socialOption.name.toLowerCase()),
      );
    } else {
      setState(() => _retrievingData = true);
      final caip2Chain = _service?.selectedChain?.chainId;
      await _magicService.getUser(chainId: caip2Chain, isUpdate: false);
    }
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
      noBack: true,
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
                            child: (widget.socialOption ==
                                    AppKitSocialOption.Email)
                                ? RoundedIcon(
                                    padding: 20.0,
                                    assetPath:
                                        'lib/modal/assets/icons/mail.svg',
                                    assetColor: themeColors.foreground100,
                                    circleColor: Colors.transparent,
                                    borderColor: Colors.transparent,
                                  )
                                : SvgPicture.asset(
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(1.0),
                                clipBehavior: Clip.antiAlias,
                                child: RoundedIcon(
                                  assetPath: 'lib/modal/assets/icons/close.svg',
                                  assetColor: themeColors.error100,
                                  circleColor: themeColors.error100.withValues(
                                    alpha: 0.2,
                                  ),
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

final _webWallet = ReownAppKitModalWalletInfo(
  listing: _webWalletListing,
  installed: true,
  recent: false,
);

final _webWalletListing = AppKitModalWalletListing.fromJson(
  {
    'id': '0000000000000001',
    'name': 'Reown Web Wallet',
    'homepage': 'https://reown.com',
    'image_id': 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
    'order': 10,
    'mobile_link': null,
    'desktop_link': null,
    'link_mode': null,
    'webapp_link': kDebugMode
        ? UrlConstants.webWalletUrlInternal
        : UrlConstants.webWalletUrl,
    'app_store': null,
    'play_store': null,
    'rdns': null,
    'chrome_store': null,
    'description': 'Reown Web Wallet',
    'badge_type': 'certified'
  },
);
