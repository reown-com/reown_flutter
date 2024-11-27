import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/icons/themed_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';

class AllWalletsItem extends StatelessWidget {
  const AllWalletsItem({
    super.key,
    this.title = 'All wallets',
    this.titleAlign = TextAlign.left,
    this.leading,
    this.trailing,
    this.onTap,
  });
  final String title;
  final TextAlign titleAlign;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return BaseListItem(
      onTap: onTap,
      child: LayoutBuilder(builder: (_, constraints) {
        return Row(
          children: [
            SizedBox.square(
              dimension: constraints.maxHeight,
              child: leading ??
                  ThemedIcon(
                    iconPath: 'lib/modal/assets/icons/dots.svg',
                  ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  title,
                  textAlign: titleAlign,
                  style: themeData.textStyles.paragraph500.copyWith(
                    color: themeColors.foreground100,
                  ),
                ),
              ),
            ),
            SizedBox.square(
              dimension: constraints.maxHeight,
              child: Container(),
            ),
          ],
        );
      }),
      trailing: trailing,
    );
  }
}
