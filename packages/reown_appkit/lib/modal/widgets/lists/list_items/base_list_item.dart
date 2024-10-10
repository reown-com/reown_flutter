import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

class BaseListItem extends StatelessWidget {
  const BaseListItem({
    super.key,
    required this.child,
    this.trailing,
    this.onTap,
    this.padding,
    this.hightlighted = false,
    this.flexible = false,
  });
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget child;
  final EdgeInsets? padding;
  final bool hightlighted;
  final bool flexible;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return FilledButton(
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: flexible
            ? MaterialStateProperty.all<Size>(
                const Size(1000.0, kListItemHeight),
              )
            : null,
        fixedSize: !flexible
            ? MaterialStateProperty.all<Size>(
                const Size(1000.0, kListItemHeight),
              )
            : null,
        backgroundColor: MaterialStateProperty.all<Color>(
          hightlighted ? themeColors.accenGlass015 : themeColors.grayGlass002,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          themeColors.grayGlass005,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiuses.radiusXS),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0.0),
        ),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(child: child),
            trailing ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
