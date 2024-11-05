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
    this.size = BaseButtonSize.regular,
    this.serviceStatus = ReownAppKitModalStatus.idle,
    this.chainInfo,
    this.onTap,
  });
  final ReownAppKitModalNetworkInfo? chainInfo;
  final BaseButtonSize size;
  final ReownAppKitModalStatus serviceStatus;
  final VoidCallback? onTap;

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
    return BaseButton(
      size: size,
      onTap: serviceStatus.isInitialized ? onTap : null,
      buttonStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return themeColors.grayGlass005;
            }
            return themeColors.grayGlass010;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return themeColors.grayGlass015;
            }
            return themeColors.foreground100;
          },
        ),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) {
            return RoundedRectangleBorder(
              side: states.contains(MaterialState.disabled)
                  ? BorderSide(color: themeColors.grayGlass005, width: 1.0)
                  : BorderSide(color: themeColors.grayGlass010, width: 1.0),
              borderRadius: BorderRadius.circular(borderRadius),
            );
          },
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          serviceStatus.isLoading
              ? Row(
                  children: [
                    const SizedBox.square(dimension: kPadding6),
                    CircularLoader(
                      size: size.height * 0.4,
                      strokeWidth: size == BaseButtonSize.small ? 1.0 : 1.5,
                    ),
                    const SizedBox.square(dimension: kPadding6),
                  ],
                )
              : RoundedIcon(
                  assetPath: 'lib/modal/assets/icons/network.svg',
                  imageUrl: imageUrl,
                  size: size.height * 0.7,
                  assetColor: themeColors.inverse100,
                  padding: size == BaseButtonSize.small ? 5.0 : 6.0,
                ),
          const SizedBox.square(dimension: 4.0),
          Text(
            chainInfo?.name ??
                (size == BaseButtonSize.small
                    ? UIConstants.selectNetworkShort
                    : UIConstants.selectNetwork),
          ),
        ],
      ),
      overridePadding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.only(left: 6.0, right: 16.0),
      ),
    );
  }
}
