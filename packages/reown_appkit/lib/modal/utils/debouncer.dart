import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer?.isActive == true) {
      _timer?.cancel();
      _timer = null;
    }
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}
