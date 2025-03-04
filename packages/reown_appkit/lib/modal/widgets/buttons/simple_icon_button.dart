import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';

class SimpleIconButton extends StatelessWidget {
  const SimpleIconButton({
    super.key,
    required this.onTap,
    required this.title,
    this.fontSize,
    this.leftIcon,
    this.iconSize,
    this.rightIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.size = BaseButtonSize.regular,
    this.overlayColor,
    this.withBorder = true,
    this.borderRadius,
  });
  final VoidCallback? onTap;
  final String title;
  final double? fontSize;
  final String? leftIcon, rightIcon;
  final double? iconSize;
  final Color? backgroundColor, foregroundColor;
  final BaseButtonSize size;
  final WidgetStateProperty<Color>? overlayColor;
  final bool withBorder;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final textStyles = ReownAppKitModalTheme.getDataOf(context).textStyles;
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final radius = radiuses.isSquare()
        ? 0.0
        : radiuses.isCircular()
            ? 100.0
            : borderRadius ?? (size.height / 2);
    return BaseButton(
      semanticsLabel: 'SimpleIconButton',
      onTap: onTap,
      size: size,
      buttonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return themeColors.grayGlass005;
            }
            return backgroundColor ?? themeColors.accent100;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return themeColors.grayGlass005;
            }
            return foregroundColor ?? themeColors.inverse100;
          },
        ),
        overlayColor: overlayColor,
        shape: withBorder
            ? WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
                (states) {
                  return RoundedRectangleBorder(
                    side: BorderSide(
                      color: backgroundColor ?? themeColors.grayGlass010,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(radius),
                  );
                },
              )
            : null,
        padding:
            WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(0.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftIcon != null)
            Row(
              children: [
                SvgPicture.asset(
                  leftIcon!,
                  package: 'reown_appkit',
                  colorFilter: ColorFilter.mode(
                    onTap == null
                        ? themeColors.grayGlass025
                        : foregroundColor ?? themeColors.inverse100,
                    BlendMode.srcIn,
                  ),
                  width: iconSize ?? 14.0,
                  height: iconSize ?? 14.0,
                ),
                const SizedBox.square(dimension: 4.0),
              ],
            ),
          Text(
            title,
            style: textStyles.paragraph600.copyWith(
              color: foregroundColor,
              fontSize: fontSize,
            ),
          ),
          if (rightIcon != null)
            Row(
              children: [
                const SizedBox.square(dimension: 4.0),
                SvgPicture.asset(
                  rightIcon!,
                  package: 'reown_appkit',
                  colorFilter: ColorFilter.mode(
                    onTap == null
                        ? themeColors.grayGlass025
                        : foregroundColor ?? themeColors.inverse100,
                    BlendMode.srcIn,
                  ),
                  width: iconSize ?? 14.0,
                  height: iconSize ?? 14.0,
                ),
              ],
            ),
        ],
      ),
      overridePadding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        size == BaseButtonSize.regular
            ? EdgeInsets.only(
                left: (leftIcon != null) ? 12.0 : 16.0,
                right: (rightIcon != null) ? 12.0 : 16.0,
              )
            : EdgeInsets.only(
                left: (leftIcon != null) ? 10.0 : 12.0,
                right: (rightIcon != null) ? 10.0 : 12.0,
              ),
      ),
    );
  }
}
