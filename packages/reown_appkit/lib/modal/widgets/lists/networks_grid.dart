import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/models/public/appkit_network_info.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/lists/grid_items/wallet_grid_item.dart';

class NetworksGrid extends StatelessWidget {
  const NetworksGrid({
    super.key,
    required this.itemList,
    this.onTapNetwork,
  });
  final List<GridItem<ReownAppKitModalNetworkInfo>> itemList;
  final Function(ReownAppKitModalNetworkInfo)? onTapNetwork;

  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final itemSize = ResponsiveData.gridItemSzieOf(context);
    // final themeData = ReownAppKitModalTheme.getDataOf(context);
    // final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final children = itemList
        .map(
          (info) => WalletGridItem(
            onTap: info.disabled ? null : () => onTapNetwork?.call(info.data),
            isSelected: service.selectedChain?.chainId == info.id,
            imageUrl: info.image,
            title: info.title,
            isNetwork: true,
            // info.data.isTestNetwork
            // bottom: info.data.isTestNetwork
            //     ? Text(
            //         'Test',
            //         style: themeData.textStyles.tiny400.copyWith(
            //           color: themeColors.accent100,
            //           height: 1.0,
            //         ),
            //       )
            //     : null,
          ),
        )
        .toList();
    return GridView.builder(
      padding: EdgeInsets.only(
        bottom: kPadding12 + ResponsiveData.paddingBottomOf(context),
        left: kPadding6,
        right: kPadding6,
        top: ResponsiveData.isPortrait(context) ? kPadding12 : kPadding6,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveData.gridAxisCountOf(context),
        mainAxisSpacing: kPadding12,
        crossAxisSpacing: 0.0,
        mainAxisExtent: itemSize.height,
      ),
      itemBuilder: (_, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: itemSize.width,
              height: itemSize.height,
              child: children[index],
            ),
          ],
        );
      },
      itemCount: children.length,
    );
  }
}
