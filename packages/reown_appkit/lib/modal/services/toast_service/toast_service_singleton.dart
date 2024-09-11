import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service.dart';

class ToastServiceSingleton {
  IToastService instance;

  ToastServiceSingleton() : instance = ToastService();
}

final toastService = ToastServiceSingleton();
