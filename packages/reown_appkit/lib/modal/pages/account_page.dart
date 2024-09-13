import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/edit_email_page.dart';
import 'package:reown_appkit/modal/pages/upgrade_wallet_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service_singleton.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
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
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
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
          child: Column(
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
          ),
        ),
        Visibility(
          visible: isEmailLogin,
          child: Column(
            children: [
              const SizedBox.square(dimension: kPadding8),
              AccountListItem(
                iconPath: 'lib/modal/assets/icons/mail.svg',
                iconColor: themeColors.foreground100,
                title: _service.session?.email ?? '',
                titleStyle: themeData.textStyles.paragraph500.copyWith(
                  color: themeColors.foreground100,
                ),
                onTap: () {
                  widgetStack.instance.push(EditEmailPage());
                },
              ),
            ],
          ),
        ),
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

class _SelectNetworkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final chainId = service.selectedChain?.chainId ?? '';
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(chainId);
    final tokenImage = explorerService.instance.getAssetImageUrl(imageId);
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
      onTap: () {
        widgetStack.instance.push(
          ReownAppKitModalSelectNetworkPage(),
          event: ClickNetworksEvent(),
        );
      },
    );
  }
}
