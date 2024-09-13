import 'dart:math';

import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/pages/about_wallets.dart';
import 'package:reown_appkit/modal/pages/confirm_email_page.dart';
import 'package:reown_appkit/modal/pages/connect_wallet_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service_singleton.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/models/email_login_step.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/input_email.dart';
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
  @override
  void initState() {
    super.initState();
    magicService.instance.isEnabled.addListener(_mailEnabledListener);
  }

  void _mailEnabledListener() {
    setState(() {});
  }

  @override
  void dispose() {
    magicService.instance.isEnabled.removeListener(_mailEnabledListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final isPortrait = ResponsiveData.isPortrait(context);
    double maxHeight = isPortrait
        ? (kListItemHeight * 6)
        : ResponsiveData.maxHeightOf(context);
    return ModalNavbar(
      title: 'Connect wallet',
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
          final itemsCount = min(kShortWalletListCount, items.length);
          if (itemsCount < kShortWalletListCount) {
            maxHeight = kListItemHeight * (itemsCount + 1.5);
          }
          final emailEnabled = magicService.instance.isEnabled.value;
          if (emailEnabled) {
            maxHeight += (kSearchFieldHeight * 2);
          }
          final itemsToShow = items.getRange(0, itemsCount);
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: WalletsList(
              onTapWallet: (data) {
                service.selectWallet(data);
                widgetStack.instance.push(const ConnectWalletPage());
              },
              firstItem: _EmailLoginWidget(),
              itemList: itemsToShow.toList(),
              bottomItems: [
                AllWalletsItem(
                  trailing: (items.length <= kShortWalletListCount)
                      ? null
                      : ValueListenableBuilder<int>(
                          valueListenable:
                              explorerService.instance.totalListings,
                          builder: (context, value, _) {
                            return WalletItemChip(value: value.lazyCount);
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

class _EmailLoginWidget extends StatefulWidget {
  @override
  State<_EmailLoginWidget> createState() => __EmailLoginWidgetState();
}

class __EmailLoginWidgetState extends State<_EmailLoginWidget> {
  bool _submitted = false;
  @override
  void initState() {
    super.initState();
    magicService.instance.step.addListener(_stepListener);
  }

  void _stepListener() {
    debugPrint(magicService.instance.step.value.toString());
    if ((magicService.instance.step.value == EmailLoginStep.verifyDevice ||
            magicService.instance.step.value == EmailLoginStep.verifyOtp ||
            magicService.instance.step.value == EmailLoginStep.verifyOtp2) &&
        _submitted) {
      widgetStack.instance.push(ConfirmEmailPage());
      _submitted = false;
    }
  }

  @override
  void dispose() {
    magicService.instance.step.removeListener(_stepListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: magicService.instance.isEnabled,
      builder: (context, emailEnabled, _) {
        if (!emailEnabled) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            InputEmailWidget(
              onFocus: (value) {
                if (value) {
                  analyticsService.instance.sendEvent(
                    EmailLoginSelected(),
                  );
                }
              },
              onValueChange: (value) {
                magicService.instance.setEmail(value);
              },
              onSubmitted: (value) {
                setState(() => _submitted = true);
                final service = ModalProvider.of(context).instance;
                final chainId = service.selectedChain?.chainId;
                analyticsService.instance.sendEvent(EmailSubmitted());
                magicService.instance.connectEmail(
                  value: value,
                  chainId: chainId,
                );
              },
            ),
            const SizedBox.square(dimension: 4.0),
            _LoginDivider(),
            const SizedBox.square(dimension: kListViewSeparatorHeight),
          ],
        );
      },
    );
  }
}
