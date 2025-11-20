abstract class IWalletPayRequest {
  /// Parse raw (proposal or RPC) into UI-ready choices
  // Future<DisplayData> getDisplayData();
  Future<Map<String, dynamic>> getDisplayData();

  /// Build signable action for selected option index
  // Future<WalletPayAction> getPaymentAction(int optionIndex);
  Future<Map<String, dynamic>> getPaymentAction({required int optionIndex});

  /// Build signable action for selected payment option (raw data)
  // Future<WalletPayAction> getActionFromPaymentOption(
  //   PaymentOption paymentOption,
  // );
  Future<Map<String, dynamic>> getActionFromPaymentOption({
    required Map<String, dynamic> paymentOption,
  });

  /// Execute/broadcast OR build authorization proof and return CAIP-358-compliant result
  // Future<WalletPayResponseResultV1> finalize(int optionIndex, String signature);
  Future<Map<String, dynamic>> finalize({
    required int optionIndex,
    required String signature,
  });

  Future<bool> dispose();
}
