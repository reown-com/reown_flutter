import 'dart:async';

import 'package:flutter/material.dart';

enum WCBottomSheetResult {
  reject,
  one,
  all,
  next,
  back,
  close;
}

class BottomSheetQueueItem {
  final Widget widget;
  final Completer<dynamic> completer;
  final int closeAfter;
  final bool showBackButton;
  final (int, int) stepper;

  BottomSheetQueueItem({
    required this.widget,
    required this.completer,
    this.closeAfter = 0,
    this.showBackButton = false,
    this.stepper = (0, 0),
  });
}

abstract class IBottomSheetService {
  abstract final ValueNotifier<BottomSheetQueueItem?> currentSheet;

  Future<dynamic> queueBottomSheet({
    required Widget widget,
    int closeAfter = 0,
    bool showBackButton = false,
    (int, int) stepper = (0, 0),
  });

  void showNext();
}
