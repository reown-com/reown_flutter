import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shimmer/shimmer.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/lists/grid_items/wallet_grid_item.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';

class WalletsGrid extends StatelessWidget {
  const WalletsGrid({
    super.key,
    required this.itemList,
    this.onTapWallet,
    this.showLoading = false,
    this.loadingCount = 8,
    this.scrollController,
    this.paddingTop = 0.0,
  });
  final List<GridItem<ReownAppKitModalWalletInfo>> itemList;
  final Function(ReownAppKitModalWalletInfo walletInfo)? onTapWallet;
  final bool showLoading;
  final int loadingCount;
  final ScrollController? scrollController;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final List<Widget> children = itemList
        .map(
          (info) => SizedBox(
            child: WalletGridItem(
              onTap: () => onTapWallet?.call(info.data),
              imageUrl: info.image,
              title: info.title,
              showCheckmark: info.data.installed,
            ),
          ),
        )
        .toList();

    if (showLoading) {
      final offset = itemList.length % loadingCount;
      final count = offset == 0 ? 0 : loadingCount - offset;
      for (var i = 0; i < (loadingCount + count); i++) {
        children.add(
          SizedBox(
            child: Shimmer.fromColors(
              baseColor: themeColors.grayGlass100,
              highlightColor: themeColors.grayGlass025,
              child: const WalletGridItem(title: ''),
            ),
          ),
        );
      }
    }

    final itemSize = ResponsiveData.gridItemSzieOf(context);
    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        bottom: kPadding12 + ResponsiveData.paddingBottomOf(context),
        left: kPadding6,
        right: kPadding6,
        top: paddingTop,
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
