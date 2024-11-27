import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';
import 'package:shimmer/shimmer.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.logoPath,
    required this.onTap,
    this.title,
    this.textAlign = TextAlign.center,
  });
  final String logoPath;
  final VoidCallback onTap;
  final String? title;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return BaseListItem(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(builder: (_, constraints) {
            return ClipRRect(
              borderRadius: radiuses.isSquare()
                  ? BorderRadius.zero
                  : BorderRadius.circular(constraints.maxHeight),
              child: SvgPicture.asset(
                logoPath,
                package: 'reown_appkit',
                height: constraints.maxHeight,
                width: constraints.maxHeight,
              ),
            );
          }),
          if (title != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: kListItemHeight - 12.0,
                ),
                child: Text(
                  title!,
                  textAlign: textAlign,
                  style: themeData.textStyles.paragraph500.copyWith(
                    color: themeColors.foreground100,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ShimmerSocialLoginButton extends StatelessWidget {
  const ShimmerSocialLoginButton({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Shimmer.fromColors(
      baseColor: themeColors.grayGlass005,
      highlightColor: themeColors.grayGlass020,
      child: BaseListItem(
        child: Row(
          children: [
            LayoutBuilder(builder: (_, constraints) {
              return ClipRRect(
                borderRadius: radiuses.isSquare()
                    ? BorderRadius.zero
                    : BorderRadius.circular(constraints.maxHeight),
                child: Container(
                  width: constraints.maxHeight,
                  height: constraints.maxHeight,
                  color: Colors.black.withOpacity(0.2),
                ),
              );
            }),
            if (title != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: kListItemHeight - 12.0),
                  child: Text(
                    title!,
                    style: themeData.textStyles.paragraph500.copyWith(
                      color: themeColors.foreground100,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
