import 'package:flutter/material.dart';
import 'package:reown_core/events/models/basic_event.dart';

abstract class IWidgetStack with ChangeNotifier {
  abstract final ValueNotifier<bool> onRenderScreen;

  /// Returns the current widget.
  Widget getCurrent();

  /// Pushes a widget to the stack.
  Future<dynamic> push(
    Widget widget, {
    bool renderScreen = false,
    bool replace = false,
    BasicCoreEvent? event,
  });

  /// Removes a widget from the stack.
  void pop([dynamic value]);

  /// Checks if the stack can be popped.
  bool canPop();

  /// Removes widgets from the stack until the given type of widget is found.
  void popUntil(Key key);

  void popAllAndPush(Widget widget, {bool renderScreen = false});

  /// Checks if the stack contains a widget with the given key.
  bool containsKey(Key key);

  /// Clears the stack.
  void clear();

  /// Adds a default widget to the stack based on platform.
  void addDefault();
}
