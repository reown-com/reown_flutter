import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/pages/public/dwe/widgets/asset_selector_page.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
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
    this.disabled = false,
  });
  final BaseButtonSize size;
  final bool iconOnly;
  final bool iconOnRight;
  final bool disabled;

  @override
  State<AssetsButton> createState() => _AssetsButtonState();
}

class _AssetsButtonState extends State<AssetsButton> {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();
  IDWEService get _dweService => GetIt.I<IDWEService>();

  @override
  Widget build(BuildContext context) {
    final chainInfo = ModalProvider.of(context).instance.selectedChain;
    if (chainInfo == null) {
      return SizedBox.shrink();
    }

    final chainIcon = GetIt.I<IExplorerService>().getChainIcon(chainInfo);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare() ? 0.0 : widget.size.height / 2;

    return ValueListenableBuilder(
      valueListenable: _dweService.selectedAsset,
      builder: (context, selectedAsset, _) {
        if (selectedAsset == null) {
          return const SizedBox.shrink();
        }
        return FutureBuilder(
          future: _dweService.getFungiblePrice(asset: selectedAsset),
          builder: (context, snapshot) {
            final fungible = snapshot.data;
            return Stack(
              children: [
                widget.iconOnly
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RoundedIcon(
                            assetPath: 'lib/modal/assets/icons/coin.svg',
                            imageUrl: fungible?.iconUrl,
                            size: widget.size.height * 0.7,
                            assetColor: themeColors.inverse100,
                            padding: widget.size == BaseButtonSize.small
                                ? 5.0
                                : 6.0,
                          ),
                        ],
                      )
                    : AbsorbPointer(
                        absorbing: widget.disabled,
                        child: BaseButton(
                          semanticsLabel: 'AppKitModalAssetButton',
                          size: widget.size,
                          onTap: () {
                            // if (_dweService.enableNetworkSelection) {
                            //   _widgetStack.push(
                            //     ReownAppKitModalSelectNetworkPage(
                            //       onTapNetwork: (info) async {
                            //         await _navigateAfterChainSelection(
                            //           appKitModal,
                            //           info,
                            //         );
                            //       },
                            //     ),
                            //   );
                            // } else {
                            _widgetStack.push(AssetSelectorPage());
                            // }
                          },
                          buttonStyle: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color>(
                                  (states) => themeColors.grayGlass002,
                                ),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  states,
                                ) {
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
                                      imageUrl: fungible?.iconUrl,
                                      size: widget.size.height * 0.6,
                                      assetColor: themeColors.inverse100,
                                      padding:
                                          widget.size == BaseButtonSize.small
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
                                      imageUrl: fungible?.iconUrl,
                                      size: widget.size.height * 0.6,
                                      assetColor: themeColors.inverse100,
                                      padding:
                                          widget.size == BaseButtonSize.small
                                          ? 5.0
                                          : 6.0,
                                    ),
                                  ],
                                ),
                              const SizedBox.square(dimension: 4.0),
                              Visibility(
                                visible: !widget.disabled,
                                child: SvgPicture.asset(
                                  'lib/modal/assets/icons/chevron_right.svg',
                                  package: 'reown_appkit',
                                  colorFilter: ColorFilter.mode(
                                    themeColors.foreground200,
                                    BlendMode.srcIn,
                                  ),
                                  width: 16.0,
                                  height: 16.0,
                                ),
                              ),
                            ],
                          ),
                          overridePadding:
                              WidgetStateProperty.all<EdgeInsetsGeometry>(
                                !widget.iconOnRight
                                    ? const EdgeInsets.only(
                                        left: 6.0,
                                        right: 10.0,
                                      )
                                    : const EdgeInsets.only(
                                        left: 10.0,
                                        right: 6.0,
                                      ),
                              ),
                        ),
                      ),
                Positioned(
                  bottom: 8,
                  left: 20,
                  child: Visibility(
                    visible: _dweService.showNetworkIcon,
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
                ),
              ],
            );
          },
        );
      },
    );
  }

  // TODO DWE: Not yet supported, dependes on `enableNetworkSelection`
  // Future<void> _navigateAfterChainSelection(
  //   IReownAppKitModal appKitModal,
  //   ReownAppKitModalNetworkInfo network,
  // ) async {
  //   await appKitModal.selectChain(network);
  //   final supportedAssets = _dweService.getPaymentAssetsForNetwork(
  //     chainId: network.chainId,
  //   );
  //   _dweService.setSupportedAssets(supportedAssets);
  //   _widgetStack.push(AssetSelectorPage());
  // }
}
