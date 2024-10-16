import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/segmented_control.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/avatars/wallet_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/download_wallet_item.dart';
import 'package:reown_appkit/modal/widgets/avatars/loading_border.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ConnectWalletPage extends StatefulWidget {
  const ConnectWalletPage() : super(key: KeyConstants.connectWalletPageKey);

  @override
  State<ConnectWalletPage> createState() => _ConnectWalletPageState();
}

class _ConnectWalletPageState extends State<ConnectWalletPage>
    with WidgetsBindingObserver {
  IExplorerService get _explorerService => GetIt.I<IExplorerService>();
  ISiweService get _siweService => GetIt.I<ISiweService>();

  IReownAppKitModal? _service;
  SegmentOption _selectedSegment = SegmentOption.mobile;
  ModalError? errorEvent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _service = ModalProvider.of(context).instance;
        _service?.onModalError.subscribe(_errorListener);
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        _service?.connectSelectedWallet();
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final isOpen = _service?.isOpen ?? false;
      final isConnected = _service?.isConnected ?? false;
      if (isOpen && isConnected && !_siweService.enabled) {
        Future.delayed(Duration(seconds: 1), () {
          if (!mounted) return;
          _service?.closeModal();
        });
      }
    }
  }

  void _errorListener(ModalError? event) => setState(() => errorEvent = event);

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
    //
    final walletRedirect = _explorerService.getWalletRedirect(
      _service!.selectedWallet,
    );
    final webOnlyWallet = walletRedirect?.webOnly == true;
    final mobileOnlyWallet = walletRedirect?.mobileOnly == true;
    //
    final selectedWallet = _service!.selectedWallet;
    final walletName = selectedWallet?.listing.name ?? 'Wallet';
    final imageId = selectedWallet?.listing.imageId ?? '';
    final imageUrl = _explorerService.getWalletImageUrl(imageId);
    //
    return ModalNavbar(
      title: walletName,
      onBack: () {
        _service?.selectWallet(null);
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
                  const SizedBox.square(dimension: 12.0),
                  Visibility(
                    visible: !webOnlyWallet && !mobileOnlyWallet,
                    child: SegmentedControl(
                      onChange: (option) => setState(() {
                        _selectedSegment = option;
                      }),
                    ),
                  ),
                  const SizedBox.square(dimension: 20.0),
                  LoadingBorder(
                    // animate: walletInstalled && !errorConnection,
                    animate: errorEvent == null,
                    borderRadius: themeData.radiuses.isSquare()
                        ? 0
                        : themeData.radiuses.radiusM + 4.0,
                    child: _WalletAvatar(
                      imageUrl: imageUrl,
                      // errorConnection: errorConnection,
                      errorConnection: errorEvent is ErrorOpeningWallet ||
                          errorEvent is UserRejectedConnection,
                      themeColors: themeColors,
                    ),
                  ),
                  const SizedBox.square(dimension: 20.0),
                  errorEvent is ErrorOpeningWallet ||
                          errorEvent is UserRejectedConnection
                      ? Text(
                          errorEvent is ErrorOpeningWallet
                              ? 'Error opening wallet'
                              : 'Connection declined',
                          textAlign: TextAlign.center,
                          style: themeData.textStyles.paragraph500.copyWith(
                            color: themeColors.error100,
                          ),
                        )
                      : errorEvent is WalletNotInstalled &&
                              _selectedSegment == SegmentOption.mobile
                          ? Text(
                              'App not installed',
                              textAlign: TextAlign.center,
                              style: themeData.textStyles.paragraph500.copyWith(
                                color: themeColors.foreground100,
                              ),
                            )
                          : Text(
                              'Continue in $walletName',
                              textAlign: TextAlign.center,
                              style: themeData.textStyles.paragraph500.copyWith(
                                color: themeColors.foreground100,
                              ),
                            ),
                  const SizedBox.square(dimension: 8.0),
                  errorEvent is ErrorOpeningWallet ||
                          errorEvent is UserRejectedConnection
                      ? Text(
                          errorEvent is ErrorOpeningWallet
                              ? 'Unable to connect with $walletName'
                              : 'Connection can be declined by the user or if a previous request is still active',
                          textAlign: TextAlign.center,
                          style: themeData.textStyles.small500.copyWith(
                            color: themeColors.foreground200,
                          ),
                        )
                      : errorEvent is WalletNotInstalled &&
                              _selectedSegment == SegmentOption.mobile
                          ? SizedBox.shrink()
                          : Text(
                              webOnlyWallet ||
                                      _selectedSegment == SegmentOption.browser
                                  ? 'Open and continue in a new browser tab'
                                  : 'Accept connection request in the wallet',
                              textAlign: TextAlign.center,
                              style: themeData.textStyles.small500.copyWith(
                                color: themeColors.foreground200,
                              ),
                            ),
                  const SizedBox.square(dimension: kPadding16),
                  Visibility(
                    visible: isPortrait &&
                        _selectedSegment != SegmentOption.browser &&
                        errorEvent == null,
                    child: SimpleIconButton(
                      onTap: () => _service!.connectSelectedWallet(),
                      leftIcon: 'lib/modal/assets/icons/refresh_back.svg',
                      title: 'Try again',
                      backgroundColor: Colors.transparent,
                      foregroundColor: themeColors.accent100,
                    ),
                  ),
                  Visibility(
                    visible: isPortrait &&
                        (webOnlyWallet ||
                            _selectedSegment == SegmentOption.browser),
                    child: SimpleIconButton(
                      onTap: () => _service!.connectSelectedWallet(
                        inBrowser: _selectedSegment == SegmentOption.browser,
                      ),
                      rightIcon: 'lib/modal/assets/icons/arrow_top_right.svg',
                      title: 'Open',
                      backgroundColor: Colors.transparent,
                      foregroundColor: themeColors.accent100,
                    ),
                  ),
                ],
              ),
            ),
            if (!isPortrait) const SizedBox.square(dimension: kPadding16),
            Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isPortrait) const SizedBox.square(dimension: kPadding12),
                  Visibility(
                    visible: !isPortrait &&
                        _selectedSegment != SegmentOption.browser &&
                        errorEvent == null,
                    child: SimpleIconButton(
                      onTap: () => _service!.connectSelectedWallet(),
                      leftIcon: 'lib/modal/assets/icons/refresh_back.svg',
                      title: 'Try again',
                      backgroundColor: Colors.transparent,
                      foregroundColor: themeColors.accent100,
                    ),
                  ),
                  Visibility(
                    visible: !isPortrait &&
                        (webOnlyWallet ||
                            _selectedSegment == SegmentOption.browser),
                    child: SimpleIconButton(
                      onTap: () => _service!.connectSelectedWallet(
                        inBrowser: _selectedSegment == SegmentOption.browser,
                      ),
                      leftIcon: 'lib/modal/assets/icons/arrow_top_right.svg',
                      title: 'Open',
                      backgroundColor: Colors.transparent,
                      foregroundColor: themeColors.accent100,
                    ),
                  ),
                  if (!isPortrait) const SizedBox.square(dimension: kPadding8),
                  SimpleIconButton(
                    onTap: () => _copyToClipboard(context),
                    leftIcon: 'lib/modal/assets/icons/copy_14.svg',
                    iconSize: 13.0,
                    title: 'Copy link',
                    fontSize: 14.0,
                    backgroundColor: Colors.transparent,
                    foregroundColor: themeColors.foreground200,
                    overlayColor: MaterialStateProperty.all<Color>(
                      themeColors.background200,
                    ),
                    withBorder: false,
                  ),
                  if (!isPortrait) const SizedBox.square(dimension: kPadding8),
                  if (errorEvent is WalletNotInstalled &&
                      _selectedSegment == SegmentOption.mobile)
                    Column(
                      children: [
                        if (isPortrait)
                          const SizedBox.square(dimension: kPadding16),
                        if (selectedWallet != null)
                          DownloadWalletItem(
                            walletInfo: selectedWallet,
                            webOnly: webOnlyWallet,
                          ),
                        const SizedBox.square(dimension: kPadding16),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    final service = ModalProvider.of(context).instance;
    await Clipboard.setData(ClipboardData(text: service.wcUri!));
    GetIt.I<IToastService>().show(ToastMessage(
      type: ToastType.success,
      text: 'Link copied',
    ));
  }
}

class _WalletAvatar extends StatelessWidget {
  const _WalletAvatar({
    required this.imageUrl,
    required this.errorConnection,
    required this.themeColors,
  });

  final String imageUrl;
  final bool errorConnection;
  final ReownAppKitModalColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListAvatar(imageUrl: imageUrl),
        Positioned(
          bottom: 0,
          right: 0,
          child: Visibility(
            visible: errorConnection,
            child: Container(
              decoration: BoxDecoration(
                color: themeColors.background125,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              padding: const EdgeInsets.all(1.0),
              clipBehavior: Clip.antiAlias,
              child: RoundedIcon(
                assetPath: 'lib/modal/assets/icons/close.svg',
                assetColor: themeColors.error100,
                circleColor: themeColors.error100.withOpacity(0.2),
                borderColor: themeColors.background125,
                padding: 4.0,
                size: 24.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
