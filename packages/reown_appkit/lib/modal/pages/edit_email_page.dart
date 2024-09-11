import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/pages/confirm_email_page.dart';
import 'package:reown_appkit/modal/services/magic_service/models/email_login_step.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service_singleton.dart';
import 'package:reown_appkit/modal/widgets/buttons/primary_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/secondary_button.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/input_email.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/verify_otp_view.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';

class EditEmailPage extends StatefulWidget {
  const EditEmailPage() : super(key: KeyConstants.editEmailPage);

  @override
  State<EditEmailPage> createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  late final String _currentEmailValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      magicService.instance.onMagicError.subscribe(_onMagicErrorEvent);
      _currentEmailValue = magicService.instance.email.value;
      if (!magicService.instance.isConnected.value) {
        magicService.instance.connectEmail(value: _currentEmailValue);
        widgetStack.instance.popAllAndPush(ConfirmEmailPage());
      }
    });
  }

  @override
  void dispose() {
    magicService.instance.onMagicError.unsubscribe(_onMagicErrorEvent);
    super.dispose();
  }

  void _onMagicErrorEvent(MagicErrorEvent? event) {
    toastService.instance.show(ToastMessage(
      type: ToastType.error,
      text: event?.error ?? 'An error occurred.',
    ));
    setState(() {});
  }

  void _goBack() {
    FocusManager.instance.primaryFocus?.unfocus();
    magicService.instance.setEmail(_currentEmailValue);
    magicService.instance.setNewEmail('');
    widgetStack.instance.pop();
    magicService.instance.step.value = EmailLoginStep.idle;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EmailLoginStep>(
      valueListenable: magicService.instance.step,
      builder: (context, action, _) {
        String title = 'Edit Email';
        if (action == EmailLoginStep.verifyOtp) {
          title = 'Confirm current email';
        }
        if (action == EmailLoginStep.verifyOtp2) {
          title = 'Confirm new email';
        }
        return ModalNavbar(
          title: title,
          safeAreaLeft: true,
          safeAreaRight: true,
          onBack: _goBack,
          body: Builder(
            builder: (_) {
              if (action == EmailLoginStep.loading) {
                return ContentLoading(viewHeight: 200.0);
              }
              if (action == EmailLoginStep.verifyOtp ||
                  action == EmailLoginStep.verifyOtp2) {
                return VerifyOtpView(
                  currentEmail: (action == EmailLoginStep.verifyOtp2)
                      ? magicService.instance.newEmail.value
                      : magicService.instance.email.value,
                  resendEmail: _resendEmail,
                  verifyOtp: (action == EmailLoginStep.verifyOtp2)
                      ? magicService.instance.updateEmailSecondaryOtp
                      : magicService.instance.updateEmailPrimaryOtp,
                );
              }
              return _EditEmailView();
            },
          ),
        );
      },
    );
  }

  Future<void> _resendEmail({String? value}) async {
    final email = magicService.instance.newEmail.value;
    magicService.instance.updateEmail(value: email);
  }
}

class _EditEmailView extends StatefulWidget {
  @override
  State<_EditEmailView> createState() => __EditEmailViewState();
}

class __EditEmailViewState extends State<_EditEmailView> {
  String _newEmailValue = '';
  late final String _currentEmailValue;
  bool _isValidEmail = false;

  @override
  void initState() {
    super.initState();
    _currentEmailValue = magicService.instance.email.value;
    _newEmailValue = _currentEmailValue;
  }

  void _onValueChange(String value) {
    magicService.instance.setNewEmail(value);
    _newEmailValue = value;
    final valid = CoreUtils.isValidEmail(value);
    setState(() {
      _isValidEmail = valid && (_newEmailValue != _currentEmailValue);
    });
  }

  void _onSubmittedEmail(String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    // magicService.instance.setNewEmail(value);
    magicService.instance.updateEmail(value: value);
  }

  void _goBack() {
    FocusManager.instance.primaryFocus?.unfocus();
    magicService.instance.setEmail(_currentEmailValue);
    magicService.instance.setNewEmail('');
    widgetStack.instance.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputEmailWidget(
            suffixIcon: const SizedBox.shrink(),
            initialValue: _currentEmailValue,
            onValueChange: _onValueChange,
            onSubmitted: _onSubmittedEmail,
          ),
          const SizedBox.square(dimension: 4.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox.square(dimension: 4.0),
              Expanded(
                child: SecondaryButton(
                  title: 'Cancel',
                  onTap: _goBack,
                ),
              ),
              const SizedBox.square(dimension: kPadding8),
              Expanded(
                child: PrimaryButton(
                  title: 'Save',
                  onTap: _isValidEmail
                      ? () => _onSubmittedEmail(_newEmailValue)
                      : null,
                ),
              ),
              const SizedBox.square(dimension: 4.0),
            ],
          ),
        ],
      ),
    );
  }
}
