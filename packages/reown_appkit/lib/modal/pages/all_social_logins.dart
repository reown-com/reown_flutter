import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';
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
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final listItems = magicService.instance.socials
        .map(
          (item) => BaseListItem(
            onTap: () => widget.onSelect(item),
            child: Row(
              children: [
                LayoutBuilder(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    item.name,
                    style: themeData.textStyles.paragraph500.copyWith(
                      color: themeColors.foreground100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
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
