import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/pages/confirm_email_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
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
  IMagicService get _magicService => GetIt.I<IMagicService>();
  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();

  bool _submitted = false;
  @override
  void initState() {
    super.initState();
    _magicService.step.addListener(_stepListener);
  }

  void _stepListener() {
    if ((_magicService.step.value == EmailLoginStep.verifyDevice ||
            _magicService.step.value == EmailLoginStep.verifyOtp ||
            _magicService.step.value == EmailLoginStep.verifyOtp2) &&
        _submitted) {
      widgetStack.instance.push(ConfirmEmailPage());
      _submitted = false;
    }
  }

  @override
  void dispose() {
    _magicService.step.removeListener(_stepListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _magicService.isEmailEnabled,
      builder: (context, emailEnabled, _) {
        if (!emailEnabled) {
          return const SizedBox.shrink();
        }
        return InputEmailWidget(
          onFocus: (value) {
            if (value) {
              _analyticsService.sendEvent(EmailLoginSelected());
            }
          },
          onValueChange: (value) {
            _magicService.setEmail(value);
          },
          onSubmitted: (value) {
            setState(() => _submitted = true);
            final service = ModalProvider.of(context).instance;
            final chainId = service.selectedChain?.chainId;
            _analyticsService.sendEvent(EmailSubmitted());
            _magicService.connectEmail(
              value: value,
              chainId: chainId,
            );
          },
        );
      },
    );
  }
}
