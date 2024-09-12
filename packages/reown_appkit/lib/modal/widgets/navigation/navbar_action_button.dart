import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

class NavbarActionButton extends StatelessWidget {
  const NavbarActionButton({
    super.key,
    required this.asset,
    required this.action,
    this.color,
  });
  final String asset;
  final VoidCallback action;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return SizedBox.square(
      dimension: kNavbarHeight,
      child: IconButton(
        onPressed: action,
        icon: SvgPicture.asset(
          asset,
          package: 'reown_appkit',
          colorFilter: ColorFilter.mode(
            color ?? themeColors.foreground100,
            BlendMode.srcIn,
          ),
          width: 18.0,
          height: 18.0,
        ),
      ),
    );
  }
}
