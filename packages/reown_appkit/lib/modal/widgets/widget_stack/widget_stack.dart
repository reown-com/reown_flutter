import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/pages/public/appkit_modal_main_wallets_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service_singleton.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';

class WidgetStack extends IWidgetStack {
  final List<Widget> _stack = [];

  @override
  final ValueNotifier<bool> onRenderScreen = ValueNotifier<bool>(true);

  @override
  Widget getCurrent() => _stack.last;

  @override
  void push(
    Widget widget, {
    bool renderScreen = false,
    AnalyticsEvent? event,
  }) {
    if (event != null) {
      analyticsService.instance.sendEvent(event);
    }
    onRenderScreen.value = renderScreen;
    _stack.add(widget);
    notifyListeners();
  }

  @override
  void pop() {
    if (_stack.isNotEmpty) {
      onRenderScreen.value = false;
      _stack.removeLast();
      notifyListeners();
    } else {
      throw Exception('The stack is empty. No widget to pop.');
    }
  }

  @override
  bool canPop() => _stack.length > 1;

  @override
  void popUntil(Key key) {
    if (_stack.isEmpty) {
      throw Exception('The stack is empty. No widget to pop.');
    } else {
      onRenderScreen.value = false;
      while (_stack.isNotEmpty && _stack.last.key != key) {
        _stack.removeLast();
      }
      notifyListeners();

      // Check if the stack is empty or the widget type not found
      if (_stack.isEmpty) {
        throw Exception('No widget of specified type found.');
      }
    }
  }

  @override
  void popAllAndPush(Widget widget, {bool renderScreen = false}) {
    _stack.clear();
    push(widget, renderScreen: renderScreen);
  }

  @override
  bool containsKey(Key key) {
    return _stack.any((element) => element.key == key);
  }

  @override
  void clear() {
    onRenderScreen.value = false;
    _stack.clear();
    notifyListeners();
  }

  @override
  void addDefault() {
    final pType = PlatformUtils.getPlatformType();

    // Choose the state based on platform
    if (pType == PlatformType.mobile) {
      push(const ReownAppKitModalMainWalletsPage(), renderScreen: true);
    } else if (pType == PlatformType.desktop || pType == PlatformType.web) {
      // add(const QRCodeAndWalletListPage());
      push(const ReownAppKitModalMainWalletsPage(), renderScreen: true);
      // TODO [WidgetStack] fix non mobile page
    }
  }
}
