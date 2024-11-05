import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/pages/about_wallets.dart';
import 'package:reown_appkit/modal/pages/connect_wallet_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/buttons/email_login_input_field.dart';
import 'package:reown_appkit/modal/widgets/buttons/social_login_buttons_view.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/all_wallets_item.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/wallet_item_chip.dart';
import 'package:reown_appkit/modal/widgets/lists/wallets_list.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar_action_button.dart';
import 'package:reown_appkit/modal/widgets/value_listenable_builders/explorer_service_items_listener.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ReownAppKitModalMainWalletsPage extends StatefulWidget {
  const ReownAppKitModalMainWalletsPage()
      : super(key: KeyConstants.walletListShortPageKey);

  @override
  State<ReownAppKitModalMainWalletsPage> createState() =>
      _AppKitModalMainWalletsPageState();
}

class _AppKitModalMainWalletsPageState
    extends State<ReownAppKitModalMainWalletsPage> {
  IMagicService get _magicService => GetIt.I<IMagicService>();
  IExplorerService get _explorerService => GetIt.I<IExplorerService>();

  @override
  void initState() {
    super.initState();
    _magicService.isEmailEnabled.addListener(_enabledListener);
    _magicService.isSocialEnabled.addListener(_enabledListener);
  }

  void _enabledListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _magicService.isSocialEnabled.removeListener(_enabledListener);
    _magicService.isEmailEnabled.removeListener(_enabledListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modalInstance = ModalProvider.of(context).instance;
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final service = ModalProvider.of(context).instance;
    final isPortrait = ResponsiveData.isPortrait(context);
    double maxHeight = isPortrait
        ? (kListItemHeight * 6)
        : ResponsiveData.maxHeightOf(context);

    final isSignIn = _magicService.isEmailEnabled.value ||
        _magicService.isSocialEnabled.value;
    return ModalNavbar(
      title: isSignIn ? 'Sign in' : 'Connect wallet',
      leftAction: NavbarActionButton(
        asset: 'lib/modal/assets/icons/help.svg',
        action: () {
          widgetStack.instance.push(
            const AboutWallets(),
            event: ClickWalletHelpEvent(),
          );
        },
      ),
      safeAreaLeft: true,
      safeAreaRight: true,
      body: ExplorerServiceItemsListener(
        builder: (context, initialised, items, _) {
          if (!initialised) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: const WalletsList(
                isLoading: true,
                itemList: [],
              ),
            );
          }
          final emailEnabled = _magicService.isEmailEnabled.value;
          final socials = _magicService.socials;
          if (!modalInstance.featuresConfig.showMainWallets &&
              (emailEnabled || socials.isNotEmpty)) {
            items.clear();
          }
          final itemsCount = min(kShortWalletListCount, items.length);
          if (itemsCount < kShortWalletListCount) {
            maxHeight = kListItemHeight * (itemsCount + 1.5);
          }
          if (emailEnabled) {
            maxHeight += kListItemHeight;
          } else {
            maxHeight -= 10.0;
          }
          final socialEnabled = _magicService.isSocialEnabled.value;
          if (socialEnabled) {
            final length = socials.length;
            if (length <= 4) {
              maxHeight += (kListItemHeight * 2);
            } else {
              maxHeight += (kListItemHeight * 3);
            }
          } else {
            maxHeight += 30.0;
          }
          final itemsToShow = items.getRange(0, itemsCount);
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: WalletsList(
              onTapWallet: (data) {
                service.selectWallet(data);
                widgetStack.instance.push(const ConnectWalletPage());
              },
              firstItem: Column(
                children: [
                  EmailLoginInputField(),
                  Visibility(
                    visible: emailEnabled || socialEnabled,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: Column(
                        children: [
                          SocialLoginButtonsView(),
                          _LoginDivider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              itemList: itemsToShow.toList(),
              bottomItems: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: (!modalInstance.featuresConfig.showMainWallets &&
                          (emailEnabled || socials.isNotEmpty))
                      ? AllWalletsItem(
                          title: 'Continue with a wallet',
                          titleAlign: TextAlign.center,
                          leading: RoundedIcon(
                            padding: 10.0,
                            assetPath:
                                'lib/modal/assets/icons/regular/wallet.svg',
                            assetColor: themeColors.foreground100,
                            circleColor: Colors.transparent,
                            borderColor: Colors.transparent,
                          ),
                          onTap: () {
                            widgetStack.instance.push(
                              const ReownAppKitModalAllWalletsPage(),
                              event: ClickAllWalletsEvent(),
                            );
                          },
                        )
                      : AllWalletsItem(
                          trailing: (items.length <= kShortWalletListCount)
                              ? null
                              : ValueListenableBuilder<int>(
                                  valueListenable:
                                      _explorerService.totalListings,
                                  builder: (context, value, _) {
                                    return WalletItemChip(
                                      value: value.lazyCount,
                                    );
                                  },
                                ),
                          onTap: () {
                            if (items.length <= kShortWalletListCount) {
                              widgetStack.instance.push(
                                const ReownAppKitModalQRCodePage(),
                                event: SelectWalletEvent(
                                  name: 'WalletConnect',
                                  platform: AnalyticsPlatform.qrcode,
                                ),
                              );
                            } else {
                              widgetStack.instance.push(
                                const ReownAppKitModalAllWalletsPage(),
                                event: ClickAllWalletsEvent(),
                              );
                            }
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LoginDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    return Row(
      children: [
        Expanded(
          child: Divider(color: themeColors.grayGlass005, height: 0.0),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: kPadding12,
            right: kPadding12,
          ),
          child: Text(
            'Or',
            style: themeData.textStyles.small400.copyWith(
              color: themeColors.foreground200,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: themeColors.grayGlass005, height: 0.0),
        ),
      ],
    );
  }
}

extension on int {
  String get lazyCount {
    if (this <= 10) return toString();
    return '${toString().substring(0, toString().length - 1)}0+';
  }
}
