import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

class BaseGridItem extends StatelessWidget {
  const BaseGridItem({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.child,
  });
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final maxRadius = min(radiuses.radiusXS, 32.0);
    return FilledButton(
      onPressed: onTap,
      clipBehavior: Clip.antiAlias,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all<Size>(
          const Size(kGridItemWidth, kGridItemHeight),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          isSelected ? themeColors.accenGlass020 : themeColors.grayGlass002,
        ),
        overlayColor: WidgetStateProperty.all<Color>(
          isSelected ? themeColors.accenGlass020 : themeColors.grayGlass005,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(maxRadius),
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: child,
      ),
    );
  }
}
