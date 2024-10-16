import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/models/email_login_step.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/verify_otp_view.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';

class ConfirmEmailPage extends StatefulWidget {
  const ConfirmEmailPage() : super(key: KeyConstants.confirmEmailPage);

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {
  IMagicService get _magicService => GetIt.I<IMagicService>();

  @override
  void initState() {
    super.initState();
    _magicService.onMagicError.subscribe(_onMagicErrorEvent);
  }

  @override
  void dispose() {
    _magicService.onMagicError.unsubscribe(_onMagicErrorEvent);
    _magicService.step.value = EmailLoginStep.idle;
    super.dispose();
  }

  void _onMagicErrorEvent(MagicErrorEvent? event) {
    if (event is ConnectEmailErrorEvent) {
      _goBack();
    } else {
      setState(() {});
    }
  }

  void _goBack() {
    _magicService.step.value = EmailLoginStep.idle;
    _magicService.setEmail('');
    FocusManager.instance.primaryFocus?.unfocus();
    widgetStack.instance.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EmailLoginStep>(
      valueListenable: _magicService.step,
      builder: (context, action, _) {
        final title = (action == EmailLoginStep.verifyDevice)
            ? 'Register device'
            : 'Confirm Email';
        return ModalNavbar(
          title: title,
          safeAreaLeft: true,
          safeAreaRight: true,
          onBack: _goBack,
          body: Builder(
            builder: (_) {
              if (action == EmailLoginStep.verifyDevice) {
                return _VerifyDeviceView();
              }
              if (action == EmailLoginStep.verifyOtp) {
                return VerifyOtpView(
                  currentEmail: _magicService.email.value,
                  resendEmail: _magicService.connectEmail,
                  verifyOtp: _magicService.connectOtp,
                );
              }
              return ContentLoading(viewHeight: 200.0);
            },
          ),
        );
      },
    );
  }
}

class _VerifyDeviceView extends StatefulWidget {
  @override
  State<_VerifyDeviceView> createState() => __VerifyDeviceViewState();
}

class __VerifyDeviceViewState extends State<_VerifyDeviceView> {
  late DateTime _resendEnabledAt;
  IMagicService get _magicService => GetIt.I<IMagicService>();

  @override
  void initState() {
    super.initState();
    _resendEnabledAt = DateTime.now().add(Duration(seconds: 30));
  }

  void _resendEmail() async {
    final diff = DateTime.now().difference(_resendEnabledAt).inSeconds;
    if (diff < 0) {
      GetIt.I<IToastService>().show(ToastMessage(
        type: ToastType.error,
        text: 'Try again after ${diff.abs()} seconds',
      ));
    } else {
      final email = _magicService.email.value;
      await _magicService.connectEmail(value: email);
      _resendEnabledAt = DateTime.now().add(Duration(seconds: 30));
      GetIt.I<IToastService>().show(ToastMessage(
        type: ToastType.success,
        text: 'Link email resent',
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final textStyles = ReownAppKitModalTheme.getDataOf(context).textStyles;
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadiusIcon = radiuses.isSquare() ? 0.0 : 20.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kPadding8,
            horizontal: kPadding12,
          ),
          child: Column(
            children: [
              const SizedBox.square(dimension: kPadding16),
              RoundedIcon(
                assetPath: 'lib/modal/assets/icons/verif.svg',
                assetColor: themeColors.accent100,
                circleColor: themeColors.accent100.withOpacity(0.15),
                borderColor: Colors.transparent,
                padding: 22.0,
                size: 70.0,
                borderRadius: borderRadiusIcon,
              ),
              const SizedBox.square(dimension: kPadding16),
              Text(
                'Approve the login link we sent to ',
                textAlign: TextAlign.center,
                style: textStyles.paragraph400.copyWith(
                  color: themeColors.foreground100,
                ),
              ),
              Text(
                _magicService.email.value,
                textAlign: TextAlign.center,
                style: textStyles.paragraph500.copyWith(
                  color: themeColors.foreground100,
                ),
              ),
              const SizedBox.square(dimension: kPadding12),
              Text(
                'The link expires in 20 minutes',
                style: textStyles.small400.copyWith(
                  color: themeColors.foreground200,
                ),
              ),
              const SizedBox.square(dimension: kPadding16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive it?',
                    style: textStyles.small400.copyWith(
                      color: themeColors.foreground200,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _resendEmail();
                    },
                    child: Text(
                      'Resend email',
                      style: textStyles.small600.copyWith(
                        color: themeColors.accent100,
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                        themeColors.accenGlass010,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
