import 'package:get_it/get_it.dart';
import 'package:walletconnect_pay/walletconnect_pay.dart';

abstract class IWalletConnectPayService extends Disposable {
  Future<void> setUpAccounts(List<String> accounts);
  Future<void> init();
  Future<void> processPayment(String paymentLink);

  Future<PaymentOptionsResponse> getPaymentOptions(
    GetPaymentOptionsRequest request,
  );
  Future<List<Action>> getRequiredPaymentActions(
    String optionId,
    String paymentId,
  );
  Future<ConfirmPaymentResponse> confirmPayment(
    ConfirmPaymentRequest payment,
  );
}
