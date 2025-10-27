import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/activity_page.dart';
import 'package:reown_appkit/modal/pages/upgrade_wallet_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_orb.dart';
import 'package:reown_appkit/modal/widgets/buttons/address_copy_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/text/appkit_balance.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AccountPage extends StatefulWidget {
  const AccountPage() : super(key: KeyConstants.eoAccountPage);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with WidgetsBindingObserver {
  IReownAppKitModal? _appKitModal;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appKitModal = ModalProvider.of(context).instance;
      _appKitModal?.addListener(_rebuild);
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
    _appKitModal?.removeListener(_rebuild);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_appKitModal == null) {
      return ContentLoading(viewHeight: 400.0);
    }
    if (_appKitModal?.session == null) {
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
        child: _DefaultAccountView(appKitModal: _appKitModal!),
      ),
    );
  }
}

class _DefaultAccountView extends StatelessWidget {
  const _DefaultAccountView({required IReownAppKitModal appKitModal})
    : _appKitMoldal = appKitModal;
  final IReownAppKitModal _appKitMoldal;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final isMagicService = _appKitMoldal.session!.sessionService.isMagic;
    final smartAccounts =
        _appKitMoldal.session!.sessionSmartAccounts.isNotEmpty;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            const Orb(size: 72.0),
            const SizedBox.square(dimension: kPadding12),
            const AddressCopyButton(),
            BalanceText(
              textStyle: themeData.textStyles.paragraph500.copyWith(
                color: themeColors.foreground200,
              ),
            ),
            Visibility(
              visible: _appKitMoldal.selectedChain?.explorerUrl != null,
              child: Padding(
                padding: const EdgeInsets.only(top: kPadding12),
                child: SimpleIconButton(
                  onTap: () => _appKitMoldal.launchBlockExplorer(),
                  leftIcon: 'lib/modal/assets/icons/compass.svg',
                  rightIcon: 'lib/modal/assets/icons/arrow_top_right.svg',
                  title: 'Block Explorer',
                  backgroundColor: themeColors.grayGlass002,
                  foregroundColor: themeColors.foreground150,
                  overlayColor: WidgetStateProperty.all<Color>(
                    themeColors.grayGlass002,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox.square(dimension: kPadding12),
        Visibility(
          visible: isMagicService || smartAccounts,
          child: _UpgradeWalletButton(),
        ),
        Visibility(
          visible: isMagicService || smartAccounts,
          child: _EmailAndSocialLoginButton(),
        ),
        // Visibility(
        //   visible: !isMagicService && !smartAccounts,
        //   child: _ConnectedWalletButton(),
        // ),
        _SelectNetworkButton(),
        _FundWalletButton(),
        Visibility(
          visible: !isMagicService && !smartAccounts,
          child: _ActivityButton(),
        ),
        Visibility(visible: smartAccounts, child: _SwitchSmartAccountButton()),
        _DisconnectButton(),
      ],
    );
  }
}

class _UpgradeWalletButton extends StatelessWidget {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

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
          onTap: () => _widgetStack.push(UpgradeWalletPage()),
        ),
      ],
    );
  }
}

class _EmailAndSocialLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final modalInstance = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final provider = AppKitSocialOption.values.firstWhereOrNull((e) {
      final socialProvider = modalInstance.session!.socialProvider ?? '';
      return e.name.toLowerCase() == socialProvider.toString().toLowerCase();
    });
    final title = modalInstance.session!.sessionUsername;
    if (provider == null) {
      return SizedBox.shrink();
    }
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          iconWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: provider == AppKitSocialOption.Email
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
          title: title ?? '',
          titleStyle: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground100,
          ),
          onTap: provider == AppKitSocialOption.Email
              ? () {
                  final walletInfo = GetIt.I<IExplorerService>()
                      .getConnectedWallet();
                  final url = walletInfo!.listing.webappLink;
                  final topic = modalInstance.session!.topic;
                  ReownCoreUtils.openURL('${url}emailUpdate/$topic');
                }
              : null,
          trailing: provider == AppKitSocialOption.Email
              ? null
              : const SizedBox.shrink(),
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
          onTap: walletInfo != null
              ? () {
                  final redirect =
                      service.session!.peer!.metadata.redirect!.native!;
                  ReownCoreUtils.openURL(redirect);
                }
              : null,
        ),
      ],
    );
  }
}

class _SelectNetworkButton extends StatelessWidget {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final chainId = service.selectedChain?.chainId ?? '';
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(chainId);
    final tokenImage = GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
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
          onTap: () => _widgetStack.push(
            ReownAppKitModalSelectNetworkPage(),
            event: ClickNetworksEvent(),
          ),
        ),
      ],
    );
  }
}

class _FundWalletButton extends StatelessWidget {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          iconWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(17.0)),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: themeColors.grayGlass002,
                    width: 2.0,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
              ),
              child: CircleAvatar(
                radius: 17.0,
                child: Icon(
                  Icons.attach_money_outlined,
                  color: themeColors.accent100,
                  size: 26.0,
                ),
                backgroundColor: themeColors.accenGlass015,
                foregroundColor: themeColors.accent100,
              ),
            ),
          ),
          title: 'Fund wallet',
          onTap: () => _widgetStack.push(
            ReownAppKitModalDepositScreen(),
            // event: ClickNetworksEvent(),
          ),
        ),
      ],
    );
  }
}

class _ActivityButton extends StatelessWidget {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          iconPath: 'lib/modal/assets/icons/swap_horizontal.svg',
          iconColor: themeColors.accent100,
          iconBGColor: themeColors.accenGlass015,
          iconBorderColor: themeColors.accenGlass005,
          title: 'Activity',
          onTap: () => _widgetStack.push(ActivityPage()),
        ),
      ],
    );
  }
}

class _SwitchSmartAccountButton extends StatefulWidget {
  @override
  State<_SwitchSmartAccountButton> createState() =>
      _SwitchSmartAccountButtonState();
}

class _SwitchSmartAccountButtonState extends State<_SwitchSmartAccountButton> {
  bool _loading = false;

  bool get _isSmartAccountSelected {
    try {
      final modalInstance = ModalProvider.of(context).instance;
      final chainId = modalInstance.selectedChain!.chainId;
      final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
      final address = modalInstance.session!.getAddress(namespace);
      final account = '$chainId:$address';
      final sessionSmartAccounts = modalInstance.session!.sessionSmartAccounts;
      return sessionSmartAccounts.contains(account);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          iconPath: 'lib/modal/assets/icons/swap_horizontal.svg',
          iconColor: themeColors.accent100,
          iconBGColor: themeColors.accenGlass015,
          iconBorderColor: themeColors.accenGlass005,
          title: _isSmartAccountSelected
              ? 'Switch to your EOA'
              : 'Switch to your smart account',
          titleStyle: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground100,
          ),
          trailing: _loading
              ? Row(
                  children: [
                    CircularLoader(size: 18.0, strokeWidth: 2.0),
                    SizedBox.square(dimension: kPadding12),
                  ],
                )
              : const SizedBox.shrink(),
          onTap: () async {
            setState(() => _loading = !_loading);
            await service.switchSmartAccounts();
            setState(() => _loading = !_loading);
            _sendEvent();
          },
        ),
      ],
    );
  }

  void _sendEvent() {
    final modalInstance = ModalProvider.of(context).instance;
    final chainId = modalInstance.selectedChain!.chainId;
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final network = ReownAppKitModalNetworks.getNetworkInfo(namespace, chainId);
    GetIt.I<IAnalyticsService>().sendEvent(
      SetPreferredAccountTypeEvent(
        network: network!.name,
        accountType: _isSmartAccountSelected ? 'Smart Accounts' : 'EOA',
      ),
    );
  }
}

class _DisconnectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Column(
      children: [
        const SizedBox.square(dimension: kPadding8),
        AccountListItem(
          iconPath: 'lib/modal/assets/icons/disconnect.svg',
          iconColor: themeColors.foreground175,
          iconBGColor: themeColors.grayGlass010,
          iconBorderColor: themeColors.grayGlass005,
          trailing: service.status.isLoading
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
          onTap: service.status.isLoading
              ? null
              : () => service.closeModal(disconnectSession: true),
        ),
      ],
    );
  }
}
