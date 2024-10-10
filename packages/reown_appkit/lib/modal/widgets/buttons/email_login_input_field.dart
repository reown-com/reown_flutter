import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/pages/confirm_email_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service_singleton.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/models/email_login_step.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/input_email.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';

class EmailLoginInputField extends StatefulWidget {
  const EmailLoginInputField({super.key});

  @override
  State<EmailLoginInputField> createState() => _EmailLoginInputFieldState();
}

class _EmailLoginInputFieldState extends State<EmailLoginInputField> {
  bool _submitted = false;
  @override
  void initState() {
    super.initState();
    magicService.instance.step.addListener(_stepListener);
  }

  void _stepListener() {
    if ((magicService.instance.step.value == EmailLoginStep.verifyDevice ||
            magicService.instance.step.value == EmailLoginStep.verifyOtp ||
            magicService.instance.step.value == EmailLoginStep.verifyOtp2) &&
        _submitted) {
      widgetStack.instance.push(ConfirmEmailPage());
      _submitted = false;
    }
  }

  @override
  void dispose() {
    magicService.instance.step.removeListener(_stepListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: magicService.instance.isEmailEnabled,
      builder: (context, emailEnabled, _) {
        if (!emailEnabled) {
          return const SizedBox.shrink();
        }
        return InputEmailWidget(
          onFocus: (value) {
            if (value) {
              analyticsService.instance.sendEvent(EmailLoginSelected());
            }
          },
          onValueChange: (value) {
            magicService.instance.setEmail(value);
          },
          onSubmitted: (value) {
            setState(() => _submitted = true);
            final service = ModalProvider.of(context).instance;
            final chainId = service.selectedChain?.chainId;
            analyticsService.instance.sendEvent(EmailSubmitted());
            magicService.instance.connectEmail(
              value: value,
              chainId: chainId,
            );
          },
        );
      },
    );
  }
}
