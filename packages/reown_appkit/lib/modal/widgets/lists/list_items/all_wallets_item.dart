import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/icons/themed_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';

class AllWalletsItem extends StatelessWidget {
  const AllWalletsItem({
    super.key,
    this.title = 'All wallets',
    this.trailing,
    this.onTap,
  });
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return BaseListItem(
      onTap: onTap,
      child: Row(
        children: [
          LayoutBuilder(
            builder: (_, constraints) {
              return ThemedIcon(
                iconPath: 'lib/modal/assets/icons/dots.svg',
                size: constraints.maxHeight,
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                title,
                style: themeData.textStyles.paragraph500.copyWith(
                  color: themeColors.foreground100,
                ),
              ),
            ),
          ),
          trailing ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
