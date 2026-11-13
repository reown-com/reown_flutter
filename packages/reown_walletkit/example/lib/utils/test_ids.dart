/// Maestro test ids shared with the other WalletKit samples
/// (react-native-examples, reown-kotlin, reown-swift). The connect flows
/// (`.maestro/connect_*.yaml`, `sign_reject.yaml`) select on these, and the
/// wallet-side sub-flows are meant to live in WalletConnect/actions, so keep
/// the values in sync across repos.
class TestIds {
  /// Approve/confirm button of every request sheet: session proposal,
  /// session authenticate and sign/send requests.
  static const String walletRequestApprove = 'wallet-request-approve';

  /// Reject/cancel button of the same sheets.
  static const String walletRequestReject = 'wallet-request-reject';
}
