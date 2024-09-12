import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ThemedIcon extends StatelessWidget {
  const ThemedIcon({
    super.key,
    required this.iconPath,
    this.size,
  });
  final String iconPath;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiuses.radius2XS),
        border: Border.all(
          color: themeColors.accenGlass010,
          width: 1.0,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        color: themeColors.accenGlass010,
      ),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(kPadding8),
      child: SvgPicture.asset(
        iconPath,
        package: 'reown_appkit',
        colorFilter: ColorFilter.mode(
          themeColors.accent100,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class ThemedButton extends StatelessWidget {
  const ThemedButton({
    super.key,
    required this.onPressed,
    required this.iconPath,
    this.size,
  });
  final Function()? onPressed;
  final String iconPath;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return TextButton(
      onPressed: onPressed,
      clipBehavior: Clip.antiAlias,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(kSearchFieldHeight, kSearchFieldHeight),
        ),
        maximumSize: MaterialStateProperty.all<Size>(
          const Size(kSearchFieldHeight, kSearchFieldHeight),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        iconSize: MaterialStateProperty.all<double?>(0.0),
        elevation: MaterialStateProperty.all<double?>(0.0),
        overlayColor: MaterialStateProperty.all<Color>(
          themeColors.accenGlass010,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0.0),
        ),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiuses.radius2XS),
            );
          },
        ),
      ),
      child: ThemedIcon(
        size: size,
        iconPath: iconPath,
      ),
    );
  }
}
