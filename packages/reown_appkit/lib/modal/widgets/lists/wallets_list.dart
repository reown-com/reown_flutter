import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/widgets/visibility_checker.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shimmer/shimmer.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/wallet_item_chip.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/wallet_list_item.dart';

class WalletsList extends StatelessWidget {
  const WalletsList({
    super.key,
    required this.itemList,
    this.firstItem,
    this.bottomItems = const [],
    this.onTapWallet,
    this.isLoading = false,
  });
  final List<GridItem<ReownAppKitModalWalletInfo>> itemList;
  final Widget? firstItem;
  final List<Widget> bottomItems;
  final Function(ReownAppKitModalWalletInfo walletInfo)? onTapWallet;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final loadingList =
        [
          const WalletListItem(title: ''),
          const WalletListItem(title: ''),
          const WalletListItem(title: ''),
          const WalletListItem(title: ''),
          const WalletListItem(title: ''),
        ].map(
          (e) => Shimmer.fromColors(
            baseColor: themeColors.grayGlass100,
            highlightColor: themeColors.grayGlass025,
            child: e,
          ),
        );

    final walletsListItems = isLoading
        ? loadingList.map(
            (listItem) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: listItem,
            ),
          )
        : itemList.map(
            (wallet) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: VisibilityChecker(
                enabled: GetIt.I<IAnalyticsService>().isEnabled,
                onVisible: () {
                  try {
                    debugPrint('onVisible ${wallet.data.listing.name}');
                    GetIt.I<IAnalyticsService>().storeEvent(
                      WalletImpressionEvent(
                        name: wallet.data.listing.name,
                        explorerId: wallet.data.listing.id,
                        view: 'Connect',
                        walletRank: wallet.data.listing.order,
                        certified: wallet.data.listing.badgeType == 'certified',
                        installed: wallet.data.installed,
                      ),
                    );
                  } catch (_) {}
                },
                child: WalletListItem(
                  onTap: () => onTapWallet?.call(wallet.data),
                  showCheckmark: wallet.data.installed,
                  imageUrl: wallet.image,
                  title: wallet.title,
                  certified: wallet.data.listing.badgeType == 'certified',
                  trailing: wallet.data.recent
                      ? const WalletItemChip(value: ' RECENT ')
                      : null,
                ),
              ),
            ),
          );
    final List<Widget> items = List<Widget>.from(walletsListItems);
    if (firstItem != null) {
      items.insert(0, firstItem!);
    }
    if (bottomItems.isNotEmpty) {
      items.addAll(bottomItems);
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding8,
        vertical: kPadding12,
      ),
      itemBuilder: (context, index) {
        return SizedBox(width: 1000.0, child: items[index]);
      },
      separatorBuilder: (_, index) =>
          SizedBox.square(dimension: kListViewSeparatorHeight),
      itemCount: items.length,
    );
  }
}
