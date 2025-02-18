import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/widgets/avatars/wallet_avatar.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';

class ReceiveCompatibleNetworks extends StatelessWidget {
  const ReceiveCompatibleNetworks()
      : super(key: KeyConstants.receiveNetworksKey);

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final isPortrait = ResponsiveData.isPortrait(context);
    final maxHeight = isPortrait
        ? (kListItemHeight * 10)
        : ResponsiveData.maxHeightOf(context);
    final networks = _networkIcons(context);
    return ModalNavbar(
      title: 'Compatible networks',
      safeAreaLeft: true,
      safeAreaBottom: true,
      safeAreaRight: true,
      divider: false,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding12,
        ),
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: ListView.separated(
          itemBuilder: (_, index) {
            if (index == 0) {
              return AccountListItem(
                iconWidget: RoundedIcon(
                  borderRadius: radiuses.isSquare() ? 0.0 : 12.0,
                  size: 24.0,
                  padding: 4.0,
                  assetPath: 'lib/modal/assets/icons/info.svg',
                  assetColor: themeColors.foreground250,
                  circleColor: themeColors.grayGlass005,
                  borderColor: themeColors.grayGlass005,
                ),
                flexible: true,
                title: 'You can only receive assets on these networks.',
                titleStyle: themeData.textStyles.small400.copyWith(
                  color: themeColors.foreground200,
                ),
              );
            }
            return networks[index - 1];
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox.square(dimension: kPadding6);
          },
          itemCount: networks.length + 1,
        ),
      ),
    );
  }

  List<Widget> _networkIcons(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    //
    List<Widget> buttons = [];

    final chainId = appKitModal.selectedChain!.chainId;
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
    final available = appKitModal.getAvailableChains()!.where((c) {
      final ns = NamespaceUtils.getNamespaceFromChain(c);
      return namespace == ns;
    }).toList();
    final chainList = available.map((c) {
      final ns = c.split(':').first;
      final cid = c.split(':').last;
      return ReownAppKitModalNetworks.getNetworkById(ns, cid);
    }).toList();

    final orderedList = [
      ...(chainList.where((e) => !e!.isTestNetwork)),
      ...(chainList.where((e) => e!.isTestNetwork)),
    ];

    for (var chainInfo in orderedList) {
      final imageId = ReownAppKitModalNetworks.getNetworkIconId(
        chainInfo!.chainId,
      );
      final imageUrl = GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
      buttons.add(
        AccountListItem(
          iconWidget: ListAvatar(
            borderRadius: radiuses.radiusXS,
            imageUrl: imageUrl,
            isNetwork: true,
          ),
          title: chainInfo.name,
          titleStyle: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground100,
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            Colors.transparent,
          ),
        ),
      );
    }
    return buttons;
  }
}
