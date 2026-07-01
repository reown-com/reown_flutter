import 'dart:async';

import 'package:flutter/material.dart';

enum WCBottomSheetResult { reject, one, all, next, back, close }

class BottomSheetQueueItem {
  final Widget widget;
  final Completer<dynamic> completer;
  final int closeAfter;
  final bool showBackButton;
  final Widget? leadingWidget;
  final (int, int) stepper;

  /// When false, the sheet's drag-to-dismiss gesture is disabled. Needed for
  /// sheets whose body contains its own scrollable (e.g. the Pay option list):
  /// the modal sheet's vertical drag recognizer otherwise competes with the
  /// inner scroll, swallowing drags so the list won't scroll under a
  /// programmatic swipe (Maestro). Defaults to true to preserve behavior.
  final bool enableDrag;

  BottomSheetQueueItem({
    required this.widget,
    required this.completer,
    this.closeAfter = 0,
    this.showBackButton = false,
    this.leadingWidget,
    this.stepper = (0, 0),
    this.enableDrag = true,
  });
}

abstract class IBottomSheetService {
  abstract final ValueNotifier<BottomSheetQueueItem?> currentSheet;

  Future<dynamic> queueBottomSheet({
    required Widget widget,
    int closeAfter = 0,
    bool showBackButton = false,
    Widget? leadingWidget,
    (int, int) stepper = (0, 0),
    bool enableDrag = true,
  });

  void showNext();
}
