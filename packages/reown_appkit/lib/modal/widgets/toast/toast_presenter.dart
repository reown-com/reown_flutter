import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/widgets/toast/toast.dart';

class ToastPresenter extends StatelessWidget {
  const ToastPresenter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ToastMessage?>(
      stream: GetIt.I<IToastService>().toasts,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ToastWidget(message: snapshot.data!);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
