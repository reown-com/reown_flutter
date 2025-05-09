import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
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
    final semantics = title ?? 'SocialLoginButton';
    return BaseListItem(
      semanticsLabel: semantics,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(builder: (_, constraints) {
            return ClipRRect(
              borderRadius: radiuses.isSquare()
                  ? BorderRadius.zero
                  : BorderRadius.circular(constraints.maxHeight * 0.9),
              child: SvgPicture.asset(
                logoPath,
                package: 'reown_appkit',
                height: constraints.maxHeight * 0.9,
                width: constraints.maxHeight * 0.9,
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

class FarcasterLoginButton extends StatelessWidget {
  const FarcasterLoginButton({
    super.key,
    required this.onTap,
    this.title,
    this.textAlign = TextAlign.center,
  });
  IMagicService get _magicService => GetIt.I<IMagicService>();

  final VoidCallback onTap;
  final String? title;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final semantics = title ?? 'SocialLoginButton';
    return ValueListenableBuilder<bool>(
      valueListenable: _magicService.isReady,
      builder: (context, isReady, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: _magicService.isTimeout,
          builder: (context, isTimeout, _) {
            if (!isReady) {
              return _ShimmerSocialLoginButton(
                title: ' $title',
              );
            }
            if (isTimeout) {
              return _ShimmerSocialLoginButton(
                title: ' $title',
              );
            }
            return BaseListItem(
              semanticsLabel: semantics,
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
                        AssetUtils.getThemedAsset(
                          context,
                          'farcaster_logo.svg',
                        ),
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
          },
        );
      },
    );
  }
}

class _ShimmerSocialLoginButton extends StatelessWidget {
  const _ShimmerSocialLoginButton({this.title});
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
        semanticsLabel: 'ShimmerSocialLoginButton',
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
                  color: Colors.black.withOpacity(0.6),
                ),
              );
            }),
            if (title != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: kListItemHeight - 12.0,
                    left: 8.0,
                  ),
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

class EmailLoginButton extends StatelessWidget {
  const EmailLoginButton({
    super.key,
    this.title = 'Continue with email',
    this.titleAlign = TextAlign.center,
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
      semanticsLabel: title,
      onTap: onTap,
      child: LayoutBuilder(builder: (_, constraints) {
        return Row(
          children: [
            SizedBox.square(
              dimension: constraints.maxHeight,
              child: RoundedIcon(
                padding: 10.0,
                assetPath: 'lib/modal/assets/icons/mail.svg',
                assetColor: themeColors.foreground100,
                circleColor: Colors.transparent,
                borderColor: Colors.transparent,
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
