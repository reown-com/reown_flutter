import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/buttons/social_login_button.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AllSocialLoginsPage extends StatefulWidget {
  const AllSocialLoginsPage({
    required this.onSelect,
  }) : super(key: KeyConstants.allSocialLoginPageKey);
  final Function(AppKitSocialOption) onSelect;

  @override
  State<AllSocialLoginsPage> createState() =>
      _AppKitModalMainWalletsPageState();
}

class _AppKitModalMainWalletsPageState extends State<AllSocialLoginsPage> {
  @override
  Widget build(BuildContext context) {
    final listItems = GetIt.I<IMagicService>()
        .socials
        .map((item) => SocialLoginButton(
              logoPath: AssetUtils.getThemedAsset(
                context,
                '${item.name.toLowerCase()}_logo.svg',
              ),
              textAlign: TextAlign.left,
              onTap: () => widget.onSelect(item),
              title: item.name,
            ))
        .toList();
    return ModalNavbar(
      title: 'All socials',
      safeAreaLeft: true,
      safeAreaRight: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox.square(dimension: kListViewSeparatorHeight),
              const SizedBox.square(dimension: kListViewSeparatorHeight),
              ..._buttonsWithDivider(listItems),
            ],
          ),
        ),
      ),
    );
  }

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
