enum EmailLoginStep {
  verifyDevice('VERIFY_DEVICE'),
  verifyOtp('VERIFY_OTP'),
  verifyOtp2('VERIFY_OTP_2'), // not an actual action from service
  loading('LOADING'),
  idle('');

  final String action;
  const EmailLoginStep(this.action);

  factory EmailLoginStep.fromAction(String action) {
    return values.firstWhere((e) => e.action == action);
  }
}
