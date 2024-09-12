import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';

class WalletListItemSimple extends StatelessWidget {
  const WalletListItemSimple({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return BaseListItem(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            package: 'reown_appkit',
            colorFilter: ColorFilter.mode(
              themeColors.foreground200,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox.square(dimension: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: themeData.textStyles.paragraph600.copyWith(
              color: themeColors.foreground200,
            ),
          ),
        ],
      ),
    );
  }
}
