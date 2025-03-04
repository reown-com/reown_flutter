import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

class BaseListItem extends StatelessWidget {
  const BaseListItem({
    super.key,
    required this.child,
    required this.semanticsLabel,
    this.trailing,
    this.onTap,
    this.padding,
    this.hightlighted = false,
    this.flexible = false,
    this.backgroundColor,
  });
  final Widget? trailing;
  final String semanticsLabel;
  final VoidCallback? onTap;
  final Widget child;
  final EdgeInsets? padding;
  final bool hightlighted;
  final bool flexible;
  final WidgetStateProperty<Color?>? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Semantics(
      // Semantic label for Maestro
      label: onTap != null
          ? '$semanticsLabel enabled'
          : '$semanticsLabel disabled',
      // Marks it as a button for accessibility
      button: true,
      // Reflects if the button is tappable
      child: FilledButton(
        onPressed: onTap,
        style: ButtonStyle(
          minimumSize: flexible
              ? WidgetStateProperty.all<Size>(
                  const Size(1000.0, kListItemHeight),
                )
              : null,
          fixedSize: !flexible
              ? WidgetStateProperty.all<Size>(
                  const Size(1000.0, kListItemHeight),
                )
              : null,
          backgroundColor: backgroundColor ??
              WidgetStateProperty.all<Color>(
                hightlighted
                    ? themeColors.accenGlass015
                    : themeColors.grayGlass002,
              ),
          overlayColor: WidgetStateProperty.all<Color>(
            themeColors.grayGlass005,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiuses.radiusXS),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
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
      ),
    );
  }
}
