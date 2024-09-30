import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/all_social_logins.dart';
import 'package:reown_appkit/modal/pages/social_login_page.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/buttons/social_login_button.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
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
        final secondRowList = [
          ...restItems.map(
            (item) => Expanded(
              child: isReady
                  ? SocialLoginButton(
                      logoPath: AssetUtils.getThemedAsset(
                        context,
                        '${item.name.toLowerCase()}_logo.svg',
                      ),
                      onTap: () => _initSocialLogin(item),
                    )
                  : ShimmerSocialLoginButton(),
            ),
          ),
          if (exceeds)
            Expanded(
              child: isReady
                  ? SocialLoginButton(
                      logoPath: AssetUtils.getThemedAsset(
                        context,
                        'more_social_icon.svg',
                      ),
                      onTap: () {
                        widgetStack.instance.push(
                          AllSocialLoginsPage(
                            onSelect: (selected) {
                              widgetStack.instance.pop();
                              _initSocialLogin(selected);
                            },
                          ),
                        );
                      },
                    )
                  : ShimmerSocialLoginButton(),
            ),
        ];
        return Column(
          children: [
            const SizedBox.square(dimension: kListViewSeparatorHeight),
            isReady
                ? SocialLoginButton(
                    logoPath: AssetUtils.getThemedAsset(
                      context,
                      '${firstItem.name.toLowerCase()}_logo.svg',
                    ),
                    onTap: () => _initSocialLogin(firstItem),
                    title: 'Continue with ${firstItem.name}',
                  )
                : ShimmerSocialLoginButton(
                    title: 'Continue with ${firstItem.name}',
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
        SocialLoginPage(socialOption: option),
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
