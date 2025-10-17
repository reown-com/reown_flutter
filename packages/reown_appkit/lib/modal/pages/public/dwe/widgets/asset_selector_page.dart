import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AssetSelectorPage extends StatelessWidget {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();
  IDWEService get _dweService => GetIt.I<IDWEService>();

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return ModalNavbar(
      title: 'Select asset',
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: false,
      divider: false,
      body: Container(
        constraints: BoxConstraints(
          maxHeight: ResponsiveData.maxHeightOf(context),
        ),
        padding: const EdgeInsets.symmetric(horizontal: kPadding12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._dweService.supportedAssets.mapIndexed((_, asset) {
                final imageId = ReownAppKitModalNetworks.getNetworkIconId(
                  asset.network,
                );
                final chainIcon = GetIt.I<IExplorerService>().getAssetImageUrl(
                  imageId,
                );
                final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
                  asset.network,
                  asset.network,
                );
                final subtitle = networkInfo?.name != null
                    ? ' - ${networkInfo!.name}'
                    : '';
                return FutureBuilder(
                  future: _dweService.getFungiblePrice(asset: asset),
                  builder: (context, snapshot) {
                    // if (snapshot.hasError) {
                    //   return const SizedBox.shrink();
                    // }
                    return AccountListItem(
                      padding: const EdgeInsets.all(0.0),
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      iconWidget: Padding(
                        padding: const EdgeInsets.only(left: kPadding6),
                        child: Stack(
                          children: [
                            RoundedIcon(
                              assetPath: 'lib/modal/assets/icons/coin.svg',
                              imageUrl: snapshot.data?.iconUrl ?? chainIcon,
                              assetColor: themeColors.inverse100,
                              borderRadius: radiuses.isSquare() ? 0.0 : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themeColors.background150,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(1.0),
                                clipBehavior: Clip.antiAlias,
                                child: RoundedIcon(
                                  imageUrl: chainIcon,
                                  padding: 2.0,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: asset.metadata.name,
                      titleStyle: themeData.textStyles.paragraph500.copyWith(
                        color: themeColors.foreground100,
                      ),
                      subtitle: '${asset.metadata.symbol}$subtitle',
                      subtitleStyle: themeData.textStyles.small400.copyWith(
                        color: themeColors.foreground200,
                      ),
                      onTap: () {
                        _dweService.selectedAsset.value = asset;
                        _widgetStack.pop();
                      },
                    );
                  },
                );
              }),
              SizedBox.square(
                dimension: MediaQuery.of(context).padding.bottom + kPadding6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
