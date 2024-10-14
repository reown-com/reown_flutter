import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/all_wallets_item.dart';
import 'package:reown_appkit/modal/widgets/lists/wallets_list.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/value_listenable_builders/explorer_service_items_listener.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';

class GetWalletPage extends StatelessWidget {
  const GetWalletPage() : super(key: KeyConstants.getAWalletPageKey);

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final isPortrait = ResponsiveData.isPortrait(context);
    final maxHeight = isPortrait
        ? (kListItemHeight * 7)
        : ResponsiveData.maxHeightOf(context);
    return ModalNavbar(
      title: 'Get a Wallet',
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: ExplorerServiceItemsListener(
          builder: (context, initialised, items, _) {
            if (!initialised) {
              return const ContentLoading();
            }

            final notInstalledItems = items
                .where((GridItem<ReownAppKitModalWalletInfo> w) =>
                    !w.data.installed && !w.data.recent)
                .toList();
            final itemsToShow = notInstalledItems
                .getRange(0, min(5, notInstalledItems.length))
                .toList();

            return WalletsList(
              itemList: itemsToShow,
              onTapWallet: (data) {
                final url = Platform.isIOS
                    ? data.listing.appStore
                    : data.listing.playStore;
                if ((url ?? '').isNotEmpty) {
                  ReownCoreUtils.openURL(url!);
                }
              },
              bottomItems: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: AllWalletsItem(
                    title: 'Explore all',
                    onTap: () => ReownCoreUtils.openURL(
                      UrlConstants.exploreWallets,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset(
                        'lib/modal/assets/icons/arrow_top_right.svg',
                        package: 'reown_appkit',
                        colorFilter: ColorFilter.mode(
                          themeColors.foreground200,
                          BlendMode.srcIn,
                        ),
                        width: 18.0,
                        height: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
