import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/social_login_page.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SocialLoginButtonsView extends StatefulWidget {
  const SocialLoginButtonsView({super.key});

  @override
  State<SocialLoginButtonsView> createState() => _SocialLoginButtonsViewState();
}

class _SocialLoginButtonsViewState extends State<SocialLoginButtonsView> {
  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ValueListenableBuilder<bool>(
      valueListenable: magicService.instance.isReady,
      builder: (context, value, _) {
        final socialButtons = magicService.instance.socials;
        final count = socialButtons.length;
        if (count == 0) {
          return SizedBox.shrink();
        }
        final fits = count == 6;
        final exceeds = count > 6;
        //
        final firstItem = socialButtons.first;
        final restItems = fits
            ? socialButtons.sublist(1, min(socialButtons.length, 6))
            : socialButtons.sublist(1, min(socialButtons.length, 5));

        final secondRowList = [
          ...restItems.map(
            (item) => Expanded(
              child: BaseListItem(
                onTap: value ? () => _initSocialLogin(item) : null,
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return SvgPicture.asset(
                      AssetUtils.getThemedAsset(
                        context,
                        '${item.name.toLowerCase()}_logo.svg',
                      ),
                      package: 'reown_appkit',
                      height: constraints.maxHeight,
                      width: constraints.maxHeight,
                    );
                  },
                ),
              ),
            ),
          ),
          if (exceeds)
            Expanded(
              child: BaseListItem(
                // TODO Social Login
                // onTap: value ? () => _initSocialLogin() : null,
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return SvgPicture.asset(
                      AssetUtils.getThemedAsset(
                        context,
                        'more_social_icon.svg',
                      ),
                      package: 'reown_appkit',
                      height: constraints.maxHeight,
                      width: constraints.maxHeight,
                    );
                  },
                ),
              ),
            ),
        ];
        return Column(
          children: [
            const SizedBox.square(dimension: kListViewSeparatorHeight),
            BaseListItem(
              onTap: value ? () => _initSocialLogin(firstItem) : null,
              child: Row(
                children: [
                  LayoutBuilder(
                    builder: (_, constraints) {
                      return SvgPicture.asset(
                        AssetUtils.getThemedAsset(
                          context,
                          '${firstItem.name.toLowerCase()}_logo.svg',
                        ),
                        package: 'reown_appkit',
                        height: constraints.maxHeight,
                        width: constraints.maxHeight,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Continue with ${firstItem.name}',
                      style: themeData.textStyles.paragraph500.copyWith(
                        color: themeColors.foreground100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox.square(dimension: kListViewSeparatorHeight),
                Row(
                  children: _buttonsWithDivider(secondRowList),
                ),
              ],
            ),
            const SizedBox.square(dimension: kListViewSeparatorHeight),
          ],
        );
      },
    );
  }

  void _initSocialLogin(AppKitSocialOption option) => widgetStack.instance.push(
        SocialLoginPage(
          socialOption: option,
        ),
      );

  List<Widget> _buttonsWithDivider(List<Widget> widgets) {
    List<Widget> spacedWidgets = [];
    for (int i = 0; i < widgets.length; i++) {
      spacedWidgets.add(widgets[i]);
      if (i < widgets.length - 1) {
        spacedWidgets.add(
          const SizedBox.square(dimension: kListViewSeparatorHeight),
        );
      }
    }
    return spacedWidgets;
  }
}
