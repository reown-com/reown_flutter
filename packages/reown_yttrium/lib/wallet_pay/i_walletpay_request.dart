import 'package:reown_yttrium/models/walletpay_models.dart';

abstract class IWalletPayRequest {
  /// Parse raw (proposal or RPC) into UI-ready choices
  // Future<DisplayData> getDisplayData();
  Future<DisplayData> getDisplayData();

  /// Build signable action for selected option index
  // Future<WalletPayAction> getPaymentAction(int optionIndex);
  Future<WalletPayAction> getPaymentAction({required int optionIndex});

  /// Build signable action for selected payment option (raw data)
  // Future<WalletPayAction> getActionFromPaymentOption(
  //   PaymentOption paymentOption,
  // );
  Future<WalletPayAction> getActionFromPaymentOption({
    required Map<String, dynamic> paymentOption, // TODO PaymentItem object??
  });

  /// Execute/broadcast OR build authorization proof and return CAIP-358-compliant result
  // Future<WalletPayResponseResultV1> finalize(int optionIndex, String signature);
  Future<WalletPayResponseResultV1> finalize({
    required int optionIndex,
    required String signature,
  });

  Future<bool> dispose();
}
