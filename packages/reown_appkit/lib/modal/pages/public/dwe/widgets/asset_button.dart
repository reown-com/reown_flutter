import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/pages/public/dwe/widgets/asset_selector_page.dart';
import 'package:reown_appkit/modal/services/dwe_service/dwe_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AssetsButton extends StatefulWidget {
  const AssetsButton({
    super.key,
    this.size = BaseButtonSize.regular,
    this.iconOnly = false,
    this.iconOnRight = false,
  });
  final BaseButtonSize size;
  final bool iconOnly;
  final bool iconOnRight;

  @override
  State<AssetsButton> createState() => _AssetsButtonState();
}

class _AssetsButtonState extends State<AssetsButton> {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();
  DWEService get _dweService => GetIt.I<DWEService>();

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare() ? 0.0 : widget.size.height / 2;

    final chainInfo = ModalProvider.of(context).instance.selectedChain;
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(
      chainInfo?.chainId ?? 'eip155:1',
    );
    final chainIcon = GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
    return ValueListenableBuilder(
      valueListenable: _dweService.selectedAsset,
      builder: (context, selectedAsset, _) {
        if (selectedAsset == null) {
          return const SizedBox.shrink();
        }
        return FutureBuilder(
          future: _dweService.getFungiblePrice(asset: selectedAsset),
          builder: (context, snapshot) {
            final token = snapshot.data;
            return Stack(
              children: [
                widget.iconOnly
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RoundedIcon(
                            assetPath: 'lib/modal/assets/icons/coin.svg',
                            imageUrl: token?.iconUrl ?? chainIcon,
                            size: widget.size.height * 0.7,
                            assetColor: themeColors.inverse100,
                            padding: widget.size == BaseButtonSize.small
                                ? 5.0
                                : 6.0,
                          ),
                        ],
                      )
                    : BaseButton(
                        semanticsLabel: 'AppKitModalAssetButton',
                        size: widget.size,
                        onTap: () => _widgetStack.push(AssetSelectorPage()),
                        buttonStyle: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                                (states) => themeColors.grayGlass002,
                              ),
                          foregroundColor:
                              WidgetStateProperty.resolveWith<Color>((states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return themeColors.grayGlass015;
                                }
                                return themeColors.foreground100;
                              }),
                          shape:
                              WidgetStateProperty.resolveWith<
                                RoundedRectangleBorder
                              >((states) {
                                return RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: themeColors.grayGlass002,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    borderRadius,
                                  ),
                                );
                              }),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!widget.iconOnRight)
                              Row(
                                children: [
                                  RoundedIcon(
                                    assetPath:
                                        'lib/modal/assets/icons/coin.svg',
                                    imageUrl: token?.iconUrl ?? chainIcon,
                                    size: widget.size.height * 0.6,
                                    assetColor: themeColors.inverse100,
                                    padding: widget.size == BaseButtonSize.small
                                        ? 5.0
                                        : 6.0,
                                  ),
                                  const SizedBox.square(dimension: 4.0),
                                ],
                              ),
                            Text(' ${selectedAsset.metadata.symbol}'),
                            if (widget.iconOnRight)
                              Row(
                                children: [
                                  const SizedBox.square(dimension: 4.0),
                                  RoundedIcon(
                                    assetPath:
                                        'lib/modal/assets/icons/coin.svg',
                                    imageUrl: token?.iconUrl ?? chainIcon,
                                    size: widget.size.height * 0.6,
                                    assetColor: themeColors.inverse100,
                                    padding: widget.size == BaseButtonSize.small
                                        ? 5.0
                                        : 6.0,
                                  ),
                                ],
                              ),
                          ],
                        ),
                        overridePadding:
                            WidgetStateProperty.all<EdgeInsetsGeometry>(
                              !widget.iconOnRight
                                  ? const EdgeInsets.only(
                                      left: 6.0,
                                      right: 16.0,
                                    )
                                  : const EdgeInsets.only(
                                      left: 16.0,
                                      right: 6.0,
                                    ),
                            ),
                      ),
                Positioned(
                  bottom: 8,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeColors.background150,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    padding: const EdgeInsets.all(1.0),
                    clipBehavior: Clip.antiAlias,
                    child: RoundedIcon(
                      imageUrl: chainIcon,
                      padding: 2.0,
                      size: 14.0,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
