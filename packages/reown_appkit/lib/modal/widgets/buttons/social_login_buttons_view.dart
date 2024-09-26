import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/all_social_logins.dart';
import 'package:reown_appkit/modal/pages/social_login_page.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shimmer/shimmer.dart';

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
    final isPortrait = ResponsiveData.isPortrait(context);
    return ValueListenableBuilder<bool>(
      valueListenable: magicService.instance.isReady,
      builder: (context, isReady, _) {
        final socialButtons = magicService.instance.socials;
        final count = socialButtons.length;
        if (count == 0) {
          return SizedBox.shrink();
        }
        final maxItems = isPortrait ? 6 : 8;
        final fits = count == maxItems;
        final exceeds = count > maxItems;
        //
        final firstItem = socialButtons.first;
        final restItems = fits
            ? socialButtons.sublist(1, min(socialButtons.length, maxItems))
            : socialButtons.sublist(
                1, min(socialButtons.length, (maxItems - 1)));
        final radiuses = ReownAppKitModalTheme.radiusesOf(context);
        final secondRowList = [
          ...restItems.map(
            (item) => Expanded(
              child: isReady
                  ? BaseListItem(
                      onTap: () => _initSocialLogin(item),
                      child: LayoutBuilder(
                        builder: (_, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: radiuses.isSquare()
                                    ? BorderRadius.zero
                                    : BorderRadius.circular(
                                        constraints.maxHeight),
                                child: SvgPicture.asset(
                                  AssetUtils.getThemedAsset(
                                    context,
                                    '${item.name.toLowerCase()}_logo.svg',
                                  ),
                                  package: 'reown_appkit',
                                  height: constraints.maxHeight,
                                  width: constraints.maxHeight,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: themeColors.grayGlass005,
                      highlightColor: themeColors.grayGlass020,
                      child: BaseListItem(
                        child: LayoutBuilder(
                          builder: (_, constraints) => CircleAvatar(
                            radius: constraints.maxHeight / 2,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          if (exceeds)
            Expanded(
              child: isReady
                  ? BaseListItem(
                      onTap: () => widgetStack.instance.push(
                        AllSocialLoginsPage(
                          onSelect: (selected) {
                            widgetStack.instance.pop();
                            _initSocialLogin(selected);
                          },
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (_, constraints) {
                          return ClipRRect(
                            borderRadius: radiuses.isSquare()
                                ? BorderRadius.zero
                                : BorderRadius.circular(constraints.maxHeight),
                            child: SvgPicture.asset(
                              AssetUtils.getThemedAsset(
                                context,
                                'more_social_icon.svg',
                              ),
                              package: 'reown_appkit',
                              height: constraints.maxHeight,
                              width: constraints.maxHeight,
                            ),
                          );
                        },
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: themeColors.grayGlass005,
                      highlightColor: themeColors.grayGlass020,
                      child: BaseListItem(
                        child: LayoutBuilder(
                          builder: (_, constraints) => CircleAvatar(
                            radius: constraints.maxHeight / 2,
                          ),
                        ),
                      ),
                    ),
            ),
        ];
        return Column(
          children: [
            const SizedBox.square(dimension: kListViewSeparatorHeight),
            isReady
                ? BaseListItem(
                    onTap: () => _initSocialLogin(firstItem),
                    child: Row(
                      children: [
                        LayoutBuilder(
                          builder: (_, constraints) {
                            return ClipRRect(
                              borderRadius: radiuses.isSquare()
                                  ? BorderRadius.zero
                                  : BorderRadius.circular(
                                      constraints.maxHeight),
                              child: SvgPicture.asset(
                                AssetUtils.getThemedAsset(
                                  context,
                                  '${firstItem.name.toLowerCase()}_logo.svg',
                                ),
                                package: 'reown_appkit',
                                height: constraints.maxHeight,
                                width: constraints.maxHeight,
                              ),
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
                  )
                : Shimmer.fromColors(
                    baseColor: themeColors.grayGlass005,
                    highlightColor: themeColors.grayGlass020,
                    child: BaseListItem(
                      child: Row(
                        children: [
                          const SizedBox.square(dimension: 4.0),
                          LayoutBuilder(
                            builder: (_, constraints) => CircleAvatar(
                              radius: constraints.maxHeight / 2,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
