import 'package:get_it/get_it.dart';
import 'package:walletconnect_pay/models/walletconnect_pay_models.dart';

abstract class IWalletConnectPayService extends Disposable {
  Future<void> setUpAccounts(List<String> accounts);
  Future<void> init();
  Future<void> processPayment(String paymentLink);
  Future<ConfirmPaymentResponse> confirmPayment(
    ConfirmPaymentJsonRequest payment,
  );
  Future<List<Action>> getPaymentActions(
    String optionId,
    String paymentId,
  );
}
