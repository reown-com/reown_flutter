import 'dart:math';

import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/modal/widgets/toast/toast_presenter.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/transition_container.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';

class ModalContainer extends StatefulWidget {
  const ModalContainer({super.key, this.startWidget});

  final Widget? startWidget;

  @override
  State<ModalContainer> createState() => _ModalContainerState();
}

class _ModalContainerState extends State<ModalContainer> {
  bool _initialized = false;
  Widget? _currentScreen;

  @override
  void initState() {
    super.initState();
    widgetStack.instance.addListener(_widgetStackUpdated);

    if (widget.startWidget != null) {
      widgetStack.instance.push(widget.startWidget!, renderScreen: true);
    } else {
      widgetStack.instance.addDefault();
    }

    _initialize();
  }

  @override
  void dispose() {
    widgetStack.instance.removeListener(_widgetStackUpdated);
    super.dispose();
  }

  void _initialize() => setState(() => _initialized = true);

  void _widgetStackUpdated() {
    //
    try {
      _currentScreen = widgetStack.instance.getCurrent();
    } catch (_) {}
    setState(() {});
  }

  bool get _isLoading => !_initialized || _currentScreen == null;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final bottomSheet = PlatformUtils.isBottomSheet();
    final isTabletSize = PlatformUtils.isTablet(context);
    final maxRadius = min(radiuses.radiusM, 36.0);
    final innerContainerBorderRadius = bottomSheet && !isTabletSize
        ? BorderRadius.only(
            topLeft: Radius.circular(maxRadius),
            topRight: Radius.circular(maxRadius),
          )
        : BorderRadius.all(
            Radius.circular(maxRadius),
          );

    return ResponsiveContainer(
      child: ClipRRect(
        borderRadius: innerContainerBorderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: themeColors.grayGlass005,
              width: 1,
            ),
            color: themeColors.background125,
          ),
          child: Stack(
            children: [
              TransitionContainer(
                child: _isLoading ? const ContentLoading() : _currentScreen!,
              ),
              const ToastPresenter(),
            ],
          ),
        ),
      ),
    );
  }
}
