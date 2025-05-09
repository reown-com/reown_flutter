import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/pages/about_networks.dart';
import 'package:reown_appkit/modal/pages/connet_network_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/lists/networks_grid.dart';
import 'package:reown_appkit/modal/widgets/value_listenable_builders/network_service_items_listener.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ReownAppKitModalSelectNetworkPage extends StatelessWidget {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

  const ReownAppKitModalSelectNetworkPage({
    this.onTapNetwork,
  }) : super(key: KeyConstants.selectNetworkPage);

  final Function(ReownAppKitModalNetworkInfo)? onTapNetwork;

  void _onSelectNetwork(
    BuildContext context,
    ReownAppKitModalNetworkInfo chainInfo,
  ) async {
    final appKitModal = ModalProvider.of(context).instance;
    if (appKitModal.isConnected) {
      final tokenName = chainInfo.currency;
      final formattedBalance = CoreUtils.formatChainBalance(null);
      appKitModal.balanceNotifier.value = '$formattedBalance $tokenName';

      final chainId = chainInfo.chainId;
      final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
      final approvedChains = appKitModal.session!.getApprovedChains(
        namespace: namespace,
      );
      final isMagic = appKitModal.session!.sessionService.isMagic;
      final isChainApproved = (approvedChains ?? []).contains(chainId);
      if (chainInfo.chainId == appKitModal.selectedChain?.chainId) {
        if (_widgetStack.canPop()) {
          _widgetStack.pop();
        } else {
          appKitModal.closeModal();
        }
      } else if (isChainApproved || isMagic) {
        if (isMagic) {
          _widgetStack.push(ConnectNetworkPage(
            chainInfo: chainInfo,
            isMagic: true,
          ));
        } else {
          await appKitModal.selectChain(chainInfo, switchChain: true);
          if (_widgetStack.canPop()) {
            _widgetStack.pop();
          } else {
            appKitModal.closeModal();
          }
        }
      } else {
        _widgetStack.push(ConnectNetworkPage(chainInfo: chainInfo));
      }
    } else {
      onTapNetwork?.call(chainInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final service = ModalProvider.of(context).instance;
    final isSwitch = service.selectedChain != null;
    final isPortrait = ResponsiveData.isPortrait(context);

    return ModalNavbar(
      title: isSwitch ? UIConstants.changeNetwork : UIConstants.selectNetwork,
      safeAreaLeft: true,
      safeAreaRight: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: isPortrait ? FlexFit.loose : FlexFit.tight,
            child: NetworkServiceItemsListener(
              builder: (context, initialised, items) {
                if (!initialised) return const ContentLoading();
                //
                final rows = min((items.length ~/ 4) + 1, 3);
                final height =
                    (ResponsiveData.gridItemSzieOf(context).height * rows);
                final maxHeight = height + (kPadding12 * (rows + 1));
                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: NetworksGrid(
                    onTapNetwork: (chainInfo) => _onSelectNetwork(
                      context,
                      chainInfo,
                    ),
                    itemList: items,
                  ),
                );
              },
            ),
          ),
          Divider(color: themeColors.grayGlass005, height: 0.0),
          const SizedBox.square(dimension: 8.0),
          Text(
            'Your connected wallet may not support some of the networks available for this dApp',
            textAlign: TextAlign.center,
            style: themeData.textStyles.small500.copyWith(
              color: themeColors.foreground300,
            ),
          ),
          SimpleIconButton(
            onTap: () {
              _widgetStack.push(
                const AboutNetworks(),
                event: ClickNetworkHelpEvent(),
              );
            },
            size: BaseButtonSize.small,
            leftIcon: 'lib/modal/assets/icons/help.svg',
            title: 'What is a network?',
            fontSize: 15.0,
            backgroundColor: Colors.transparent,
            foregroundColor: themeColors.accent100,
            overlayColor: WidgetStateProperty.all<Color>(
              themeColors.background200,
            ),
            withBorder: false,
          ),
        ],
      ),
    );
  }
}
