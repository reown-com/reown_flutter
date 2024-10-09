import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';

import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/avatars/wallet_avatar.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/grid_items/base_grid_item.dart';

class WalletGridItem extends StatelessWidget {
  const WalletGridItem({
    super.key,
    required this.title,
    this.imageUrl,
    this.bottom,
    this.onTap,
    this.isSelected = false,
    this.isNetwork = false,
    this.showCheckmark = false,
  });

  final String title;
  final String? imageUrl;
  final Widget? bottom;
  final VoidCallback? onTap;
  final bool isSelected, isNetwork, showCheckmark;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return BaseGridItem(
      onTap: onTap,
      isSelected: isSelected,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  ListAvatar(
                    borderRadius: radiuses.radiusXS,
                    imageUrl: imageUrl,
                    isNetwork: isNetwork,
                    color: isSelected ? themeColors.accent100 : null,
                    disabled: isNetwork && onTap == null,
                  ),
                  Visibility(
                    visible: showCheckmark,
                    child: Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeColors.background150,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        padding: const EdgeInsets.all(1.0),
                        clipBehavior: Clip.antiAlias,
                        child: RoundedIcon(
                          assetPath: 'lib/modal/assets/icons/checkmark.svg',
                          assetColor: themeColors.success100,
                          circleColor: themeColors.success100.withOpacity(0.3),
                          borderColor: themeColors.background150,
                          padding: 2.0,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 2.0),
          Padding(
            padding: const EdgeInsets.only(
              top: kPadding6,
              left: kPadding8,
              right: kPadding8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: radiuses.isCircular()
                      ? TextOverflow.fade
                      : TextOverflow.ellipsis,
                  softWrap: !radiuses.isCircular(),
                  style: themeData.textStyles.tiny500.copyWith(
                    color: isSelected
                        ? themeColors.accent100
                        : (isNetwork && onTap == null)
                            ? themeColors.background300
                            : themeColors.foreground100,
                    height: 1.0,
                  ),
                ),
                bottom ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
