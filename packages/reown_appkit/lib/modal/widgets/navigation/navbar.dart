import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar_action_button.dart';

class ModalNavbar extends StatelessWidget {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();
  const ModalNavbar({
    super.key,
    this.onBack,
    this.onTapTitle,
    required this.body,
    required this.title,
    this.leftAction,
    this.rightActions = const [],
    this.safeAreaLeft = false,
    this.safeAreaRight = false,
    this.safeAreaBottom = true,
    this.noClose = false,
    this.noBack = false,
    this.divider = true,
  });

  final VoidCallback? onBack;
  final VoidCallback? onTapTitle;
  final Widget body;
  final String title;
  final NavbarActionButton? leftAction;
  final List<Widget> rightActions;
  final bool safeAreaLeft,
      safeAreaRight,
      safeAreaBottom,
      noClose,
      noBack,
      divider;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final keyboardOpened = ResponsiveData.isKeyboardShown(context);
    final paddingBottom = keyboardOpened
        ? ResponsiveData.paddingBottomOf(context)
        : 0.0;
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            left: true,
            right: true,
            top: false,
            bottom: false,
            child: SizedBox(
              height: kNavbarHeight,
              child: ValueListenableBuilder(
                valueListenable: _widgetStack.onRenderScreen,
                builder: (context, render, _) {
                  if (!render) return SizedBox.shrink();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _widgetStack.canPop() && !noBack
                          ? NavbarActionButton(
                              asset: 'lib/modal/assets/icons/chevron_left.svg',
                              action: onBack ?? _widgetStack.pop,
                            )
                          : (leftAction ??
                                const SizedBox.square(
                                  dimension: kNavbarHeight,
                                )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => onTapTitle?.call(),
                          child: Center(
                            child: Text(
                              title,
                              style: themeData.textStyles.paragraph600.copyWith(
                                color: themeColors.foreground100,
                              ),
                            ),
                          ),
                        ),
                      ),
                      noClose
                          ? const SizedBox.square(dimension: kNavbarHeight)
                          : NavbarActionButton(
                              asset: 'lib/modal/assets/icons/close.svg',
                              action: () {
                                ModalProvider.of(context).instance.closeModal();
                              },
                            ),
                      Row(children: rightActions),
                    ],
                  );
                },
              ),
            ),
          ),
          if (divider) Divider(color: themeColors.grayGlass005, height: 0.0),
          Flexible(
            child: SafeArea(
              left: safeAreaLeft,
              right: safeAreaRight,
              bottom: safeAreaBottom,
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
