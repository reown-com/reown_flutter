import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service_singleton.dart';
import 'package:reown_appkit/modal/widgets/toast/toast.dart';

class ToastPresenter extends StatelessWidget {
  const ToastPresenter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ToastMessage?>(
      stream: toastService.instance.toasts,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ToastWidget(message: snapshot.data!);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
