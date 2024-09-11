import 'dart:async';

import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';

abstract class IToastService {
  Stream<ToastMessage?> get toasts;

  void show(ToastMessage message);

  void clear();
}
