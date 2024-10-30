import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/edit_email_page.dart';
import 'package:reown_appkit/modal/pages/upgrade_wallet_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_orb.dart';
import 'package:reown_appkit/modal/widgets/buttons/address_copy_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/text/appkit_balance.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AccountPage extends StatefulWidget {
  const AccountPage() : super(key: KeyConstants.accountPage);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with WidgetsBindingObserver {
  IReownAppKitModal? _service;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _service = ModalProvider.of(context).instance;
      _service?.addListener(_rebuild);
      _rebuild();
    });
  }

  void _rebuild() => setState(() {});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _rebuild();
    }
  }

  @override
  void dispose() {
    _service?.removeListener(_rebuild);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      return ContentLoading(viewHeight: 400.0);
    }

    return ModalNavbar(
      title: '',
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: true,
      divider: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding12),
        child: _DefaultAccountView(
          service: _service!,
        ),
      ),
    );
  }
}

class _DefaultAccountView extends StatelessWidget {
  const _DefaultAccountView({required IReownAppKitModal service})
      : _service = service;
  final IReownAppKitModal _service;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final isEmailLogin = _service.session?.sessionService.isMagic ?? false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            const Orb(size: 72.0),
            const SizedBox.square(dimension: kPadding12),
            const AddressCopyButton(),
            const BalanceText(),
            Visibility(
              visible: _service.selectedChain?.explorerUrl != null,
              child: Padding(
                padding: const EdgeInsets.only(top: kPadding12),
                child: SimpleIconButton(
                  onTap: () => _service.launchBlockExplorer(),
                  leftIcon: 'lib/modal/assets/icons/compass.svg',
                  rightIcon: 'lib/modal/assets/icons/arrow_top_right.svg',
                  title: 'Block Explorer',
                  backgroundColor: themeColors.background125,
                  foregroundColor: themeColors.foreground150,
                  overlayColor: MaterialStateProperty.all<Color>(
                    themeColors.background200,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox.square(dimension: kPadding12),
        Visibility(
          visible: isEmailLogin,
          child: _UpgradeWalletButton(),
        ),
        Visibility(
          visible: isEmailLogin,
          child: _EmailAndSocialLoginButton(),
        ),
        // Visibility(
        //   visible: !isEmailLogin,
        //   child: _ConnectedWalletButton(),
        // ),
        const SizedBox.square(dimension: kPadding8),
        _SelectNetworkButton(),
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          iconPath: 'lib/modal/assets/icons/disconnect.svg',
          trailing: _service.status.isLoading
              ? Row(
                  children: [
                    CircularLoader(size: 18.0, strokeWidth: 2.0),
                    SizedBox.square(dimension: kPadding12),
                  ],
                )
              : const SizedBox.shrink(),
          title: 'Disconnect',
          titleStyle: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground200,
          ),
          onTap: _service.status.isLoading
              ? null
              : () => _service.closeModal(disconnectSession: true),
        ),
      ],
    );
  }
}

class _UpgradeWalletButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          padding: const EdgeInsets.symmetric(
            horizontal: kPadding8,
            vertical: kPadding12,
          ),
          iconWidget: Padding(
            padding: const EdgeInsets.all(4.0),
            child: RoundedIcon(
              borderRadius: radiuses.isSquare()
                  ? 0.0
                  : radiuses.isCircular()
                      ? 40.0
                      : 8.0,
              size: 40.0,
              assetPath: 'lib/modal/assets/icons/regular/wallet.svg',
              assetColor: themeColors.accent100,
              circleColor: themeColors.accenGlass010,
              borderColor: themeColors.accenGlass010,
            ),
          ),
          title: 'Upgrade your wallet',
          subtitle: 'Transition to a self-custodial wallet',
          hightlighted: true,
          flexible: true,
          titleStyle: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground100,
          ),
          onTap: () => widgetStack.instance.push(UpgradeWalletPage()),
        ),
      ],
    );
  }
}

class _EmailAndSocialLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final provider = AppKitSocialOption.values.firstWhereOrNull(
      (e) => e.name == service.session!.peer?.metadata.name,
    );
    final title =
        provider != null ? service.session!.userName : service.session!.email;
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          iconWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: provider == null
                ? RoundedIcon(
                    assetPath: 'lib/modal/assets/icons/mail.svg',
                    assetColor: themeColors.foreground100,
                    borderRadius: radiuses.isSquare() ? 0.0 : null,
                  )
                : ClipRRect(
                    borderRadius: radiuses.isSquare()
                        ? BorderRadius.zero
                        : BorderRadius.circular(34),
                    child: SvgPicture.asset(
                      AssetUtils.getThemedAsset(
                        context,
                        '${provider.name.toLowerCase()}_logo.svg',
                      ),
                      package: 'reown_appkit',
                      height: 34,
                      width: 34,
                    ),
                  ),
          ),
          title: title,
          titleStyle: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground100,
          ),
          onTap: provider == null
              ? () => widgetStack.instance.push(EditEmailPage())
              : null,
          trailing: provider != null ? const SizedBox.shrink() : null,
        ),
      ],
    );
  }
}

// ignore: unused_element
class _ConnectedWalletButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    String iconImage = '';
    if ((service.session!.peer?.metadata.icons ?? []).isNotEmpty) {
      iconImage = service.session!.peer?.metadata.icons.first ?? '';
    }
    final walletInfo = GetIt.I<IExplorerService>().getConnectedWallet();
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          iconWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: iconImage.isEmpty
                ? RoundedIcon(
                    assetPath: 'lib/modal/assets/icons/wallet.svg',
                    assetColor: themeColors.inverse100,
                    borderRadius: radiuses.isSquare() ? 0.0 : null,
                  )
                : ClipRRect(
                    borderRadius: radiuses.isSquare()
                        ? BorderRadius.zero
                        : BorderRadius.circular(34),
                    child: CachedNetworkImage(
                      imageUrl: iconImage,
                      height: 34,
                      width: 34,
                      errorWidget: (context, url, error) {
                        return RoundedIcon(
                          assetPath: 'lib/modal/assets/icons/wallet.svg',
                          assetColor: themeColors.inverse100,
                          borderRadius: radiuses.isSquare() ? 0.0 : null,
                        );
                      },
                    ),
                  ),
          ),
          title: service.session!.peer?.metadata.name ?? 'Connected Wallet',
          titleStyle: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground100,
          ),
          onTap:
              walletInfo != null ? () => service.launchConnectedWallet() : null,
        ),
      ],
    );
  }
}

class _SelectNetworkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final chainId = service.selectedChain?.chainId ?? '';
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(chainId);
    final tokenImage = GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return AccountListItem(
      iconWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: imageId.isEmpty
            ? RoundedIcon(
                assetPath: 'lib/modal/assets/icons/network.svg',
                assetColor: themeColors.inverse100,
                borderRadius: radiuses.isSquare() ? 0.0 : null,
              )
            : RoundedIcon(
                borderRadius: radiuses.isSquare() ? 0.0 : null,
                imageUrl: tokenImage,
                assetColor: themeColors.background100,
              ),
      ),
      title: service.selectedChain?.name ?? 'Unsupported network',
      titleStyle: themeData.textStyles.paragraph500.copyWith(
        color: themeColors.foreground100,
      ),
      onTap: () => widgetStack.instance.push(
        ReownAppKitModalSelectNetworkPage(),
        event: ClickNetworksEvent(),
      ),
    );
  }
}
