import 'dart:async';

import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';

class ToastService extends IToastService {
  final _toastController = StreamController<ToastMessage?>.broadcast();

  @override
  Stream<ToastMessage?> get toasts => _toastController.stream;

  @override
  void show(ToastMessage? message) {
    _toastController.add(message);
  }

  @override
  void clear() {
    _toastController.add(null);
  }
}
