import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/pages/public/appkit_modal_main_wallets_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_core/events/models/basic_event.dart';
import 'package:reown_core/i_core_impl.dart';

class WidgetStack extends IWidgetStack {
  WidgetStack({required IReownCore core}) : _core = core;
  final IReownCore _core;

  final List<Widget> _stack = [];

  @override
  final ValueNotifier<bool> onRenderScreen = ValueNotifier<bool>(true);

  @override
  Widget getCurrent() => _stack.last;

  @override
  void push(
    Widget widget, {
    bool replace = false,
    bool renderScreen = false,
    BasicCoreEvent? event,
  }) {
    _core.logger.d(
      '[$runtimeType] push ${widget.key}, replace: $replace, renderScreen: $renderScreen, event: $event',
    );
    if (event != null) {
      GetIt.I<IAnalyticsService>().sendEvent(event);
    }
    onRenderScreen.value = renderScreen;
    if (replace) {
      _stack.removeLast();
    }
    _stack.add(widget);
    notifyListeners();
  }

  @override
  void pop() {
    _core.logger.d('[$runtimeType] pop');
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
    _core.logger.d('[$runtimeType] popUntil $key');
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
    _core.logger.d(
      '[$runtimeType] popAllAndPush ${widget.key}, renderScreen: $renderScreen',
    );
    _stack.clear();
    push(widget, renderScreen: renderScreen);
  }

  @override
  bool containsKey(Key key) {
    _core.logger.d('[$runtimeType] containsKey $key');
    return _stack.any((element) => element.key == key);
  }

  @override
  void clear() {
    _core.logger.d('[$runtimeType] clear');
    onRenderScreen.value = false;
    _stack.clear();
    notifyListeners();
  }

  @override
  void addDefault() {
    _core.logger.d('[$runtimeType] addDefault');
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
