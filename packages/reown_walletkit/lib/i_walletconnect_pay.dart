import 'package:reown_walletkit/reown_walletkit.dart' hide Action;
import 'package:walletconnect_pay/walletconnect_pay.dart' show Action;

/// Interface for WalletConnect Pay functionality
abstract class IWalletConnectPay {
  /// WalletConnect Pay instance
  abstract final WalletConnectPay pay;

  /// Get payment options for a given payment link
  Future<PaymentOptionsResponse> getPaymentOptions({
    required GetPaymentOptionsRequest request,
  });

  /// Get required payment actions for a payment option
  Future<List<Action>> getRequiredPaymentActions({
    required GetRequiredPaymentActionsRequest request,
  });

  /// Confirm a payment
  Future<ConfirmPaymentResponse> confirmPayment({
    required ConfirmPaymentRequest request,
  });

  bool isPaymentLink(String uri);
}
