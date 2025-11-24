import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/all_social_logins.dart';
import 'package:reown_appkit/modal/pages/social_login_page.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/buttons/social_login_button.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SocialLoginButtonsView extends StatefulWidget {
  const SocialLoginButtonsView({super.key});

  @override
  State<SocialLoginButtonsView> createState() => _SocialLoginButtonsViewState();
}

class _SocialLoginButtonsViewState extends State<SocialLoginButtonsView> {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

  @override
  Widget build(BuildContext context) {
    final isPortrait = ResponsiveData.isPortrait(context);
    final modalInstance = ModalProvider.of(context).instance;
    final emailEnabled = modalInstance.featuresConfig.socials.contains(
      AppKitSocialOption.Email,
    );
    final socialOptions = List<AppKitSocialOption>.from(
      modalInstance.featuresConfig.socials,
    )..remove(AppKitSocialOption.Email);
    //
    if (socialOptions.isEmpty) {
      return Visibility(
        visible: emailEnabled,
        child: Column(
          children: [
            const SizedBox.square(dimension: kListViewSeparatorHeight),
            EmailLoginButton(
              onTap: () => _initSocialLogin(AppKitSocialOption.Email),
              title: 'Continue with email',
            ),
            const SizedBox.square(dimension: kListViewSeparatorHeight),
          ],
        ),
      );
    }
    if (socialOptions.length == 1) {
      return Column(
        children: [
          const SizedBox.square(dimension: kListViewSeparatorHeight),
          Visibility(
            visible: emailEnabled,
            child: EmailLoginButton(
              onTap: () => _initSocialLogin(AppKitSocialOption.Email),
              title: 'Continue with Email',
            ),
          ),
          const SizedBox.square(dimension: kListViewSeparatorHeight),
          (socialOptions.first == AppKitSocialOption.Farcaster)
              ? FarcasterLoginButton(
                  onTap: () => _initSocialLogin(AppKitSocialOption.Farcaster),
                  title: 'Continue with Farcaster',
                )
              : SocialLoginButton(
                  logoPath: AssetUtils.getThemedAsset(
                    context,
                    '${socialOptions.first.name.toLowerCase()}_logo.svg',
                  ),
                  onTap: () => _initSocialLogin(socialOptions.first),
                  title: 'Continue with ${socialOptions.first.name}',
                ),
          const SizedBox.square(dimension: kListViewSeparatorHeight),
        ],
      );
    }
    return Builder(
      builder: (context) {
        final count = socialOptions.length;
        final maxItems = isPortrait ? 6 : 8;
        final isLess = count <= 4;
        final fits = count == maxItems;
        final exceeds = count > maxItems;
        //
        final firstItem = isLess ? null : socialOptions.first;
        final restItems = isLess
            ? socialOptions
            : fits
            ? socialOptions.sublist(1, min(socialOptions.length, maxItems))
            : socialOptions.sublist(
                1,
                min(socialOptions.length, (maxItems - 1)),
              );
        //
        final secondRowList = [
          ...restItems.map(
            (item) => Expanded(
              child: (socialOptions.first == AppKitSocialOption.Farcaster)
                  ? FarcasterLoginButton(
                      onTap: () => _initSocialLogin(socialOptions.first),
                    )
                  : SocialLoginButton(
                      logoPath: AssetUtils.getThemedAsset(
                        context,
                        '${item.name.toLowerCase()}_logo.svg',
                      ),
                      onTap: () => _initSocialLogin(item),
                    ),
            ),
          ),
          if (exceeds)
            Expanded(
              child: SocialLoginButton(
                logoPath: AssetUtils.getThemedAsset(
                  context,
                  'more_social_icon.svg',
                ),
                onTap: () {
                  _widgetStack.push(
                    AllSocialLoginsPage(
                      onSelect: (selected) {
                        _widgetStack.pop();
                        _initSocialLogin(selected);
                      },
                    ),
                  );
                },
              ),
            ),
        ];
        return Column(
          children: [
            Visibility(
              visible: emailEnabled,
              child: Column(
                children: [
                  EmailLoginButton(
                    onTap: () => _initSocialLogin(AppKitSocialOption.Email),
                    title: 'Continue with email',
                  ),
                ],
              ),
            ),
            Builder(
              builder: (_) {
                if (firstItem == null) {
                  return SizedBox.shrink();
                }
                return Column(
                  children: [
                    const SizedBox.square(dimension: kListViewSeparatorHeight),
                    (socialOptions.first == AppKitSocialOption.Farcaster)
                        ? FarcasterLoginButton(
                            onTap: () => _initSocialLogin(socialOptions.first),
                            title: 'Continue with ${firstItem.name}',
                          )
                        : SocialLoginButton(
                            logoPath: AssetUtils.getThemedAsset(
                              context,
                              '${firstItem.name.toLowerCase()}_logo.svg',
                            ),
                            onTap: () => _initSocialLogin(firstItem),
                            title: 'Continue with ${firstItem.name}',
                          ),
                  ],
                );
              },
            ),
            Column(
              children: [
                const SizedBox.square(dimension: kListViewSeparatorHeight),
                Row(children: _buttonsWithDivider(secondRowList)),
              ],
            ),
            const SizedBox.square(dimension: kListViewSeparatorHeight),
          ],
        );
      },
    );
  }

  void _initSocialLogin(AppKitSocialOption option) =>
      _widgetStack.push(SocialLoginPage(socialOption: option));

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
