import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/models/public/appkit_network_info.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/public/appkit_modal_default_networks.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';

class NetworkButton extends StatelessWidget {
  const NetworkButton({
    super.key,
    this.title,
    this.size = BaseButtonSize.regular,
    this.serviceStatus = ReownAppKitModalStatus.idle,
    this.chainInfo,
    this.onTap,
    this.iconOnly = false,
    this.iconOnRight = false,
    this.iconUrl,
  });
  final String? title;
  final ReownAppKitModalNetworkInfo? chainInfo;
  final BaseButtonSize size;
  final ReownAppKitModalStatus serviceStatus;
  final VoidCallback? onTap;
  final bool iconOnly;
  final bool iconOnRight;
  final String? iconUrl;

  String _getImageUrl(ReownAppKitModalNetworkInfo? chainInfo) {
    if (chainInfo == null) return '';

    if (chainInfo.chainIcon != null && chainInfo.chainIcon!.contains('http')) {
      return chainInfo.chainIcon!;
    }
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(
      chainInfo.chainId,
    );
    return GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final imageUrl = _getImageUrl(chainInfo);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare() ? 0.0 : size.height / 2;
    return iconOnly
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedIcon(
                assetPath: 'lib/modal/assets/icons/network.svg',
                imageUrl: iconUrl ?? imageUrl,
                size: size.height * 0.7,
                assetColor: themeColors.inverse100,
                padding: size == BaseButtonSize.small ? 5.0 : 6.0,
              ),
            ],
          )
        : BaseButton(
            semanticsLabel: 'AppKitModalNetworkButton',
            size: size,
            onTap: serviceStatus.isInitialized ? onTap : null,
            buttonStyle: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) => themeColors.grayGlass002,
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.disabled)) {
                    return themeColors.grayGlass015;
                  }
                  return themeColors.foreground100;
                },
              ),
              shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
                (states) {
                  return RoundedRectangleBorder(
                    side: BorderSide(
                      color: themeColors.grayGlass002,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  );
                },
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!iconOnRight)
                  Row(
                    children: [
                      serviceStatus.isLoading
                          ? Row(
                              children: [
                                const SizedBox.square(dimension: kPadding6),
                                CircularLoader(
                                  size: size.height * 0.4,
                                  strokeWidth:
                                      size == BaseButtonSize.small ? 1.0 : 1.5,
                                ),
                                const SizedBox.square(dimension: kPadding6),
                              ],
                            )
                          : RoundedIcon(
                              assetPath: 'lib/modal/assets/icons/network.svg',
                              imageUrl: iconUrl ?? imageUrl,
                              size: size.height * 0.55,
                              assetColor: themeColors.inverse100,
                              padding: size == BaseButtonSize.small ? 5.0 : 6.0,
                            ),
                      const SizedBox.square(dimension: 4.0),
                    ],
                  ),
                Text(
                  (title ?? chainInfo?.name) ??
                      (size == BaseButtonSize.small
                          ? UIConstants.selectNetworkShort
                          : UIConstants.selectNetwork),
                ),
                if (iconOnRight)
                  Row(
                    children: [
                      const SizedBox.square(dimension: 4.0),
                      serviceStatus.isLoading
                          ? Row(
                              children: [
                                const SizedBox.square(dimension: kPadding6),
                                CircularLoader(
                                  size: size.height * 0.4,
                                  strokeWidth:
                                      size == BaseButtonSize.small ? 1.0 : 1.5,
                                ),
                                const SizedBox.square(dimension: kPadding6),
                              ],
                            )
                          : RoundedIcon(
                              assetPath: 'lib/modal/assets/icons/network.svg',
                              imageUrl: iconUrl ?? imageUrl,
                              size: size.height * 0.55,
                              assetColor: themeColors.inverse100,
                              padding: size == BaseButtonSize.small ? 5.0 : 6.0,
                            ),
                    ],
                  ),
              ],
            ),
            overridePadding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              !iconOnRight
                  ? const EdgeInsets.only(left: 6.0, right: 16.0)
                  : const EdgeInsets.only(left: 16.0, right: 6.0),
            ),
          );
  }
}
