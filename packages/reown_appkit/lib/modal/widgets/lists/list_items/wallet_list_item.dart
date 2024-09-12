import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/avatars/wallet_avatar.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';

class WalletListItem extends StatelessWidget {
  const WalletListItem({
    super.key,
    required this.title,
    this.imageUrl,
    this.trailing,
    this.hideAvatar = false,
    this.showCheckmark = false,
    this.onTap,
  });

  final String title;
  final String? imageUrl;
  final Widget? trailing;
  final bool hideAvatar;
  final bool showCheckmark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return BaseListItem(
      onTap: onTap,
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          const SizedBox.square(dimension: 8.0),
          Visibility(
            visible: !hideAvatar,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: ListAvatar(
                    borderRadius: radiuses.radius2XS,
                    imageUrl: imageUrl,
                  ),
                ),
                Visibility(
                  visible: showCheckmark,
                  child: Positioned(
                    bottom: 6,
                    right: 6,
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
                        size: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 4.0,
                right: 8.0,
              ),
              child: Text(
                title,
                style: themeData.textStyles.paragraph500.copyWith(
                  color: onTap == null
                      ? themeColors.foreground200
                      : themeColors.foreground100,
                ),
              ),
            ),
          ),
          trailing ?? const SizedBox.shrink(),
          const SizedBox.square(dimension: 8.0),
        ],
      ),
    );
  }
}
