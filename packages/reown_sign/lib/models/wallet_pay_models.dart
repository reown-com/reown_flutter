import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_pay_models.g.dart';
part 'wallet_pay_models.freezed.dart';

@freezed
sealed class WalletPayRequestParams with _$WalletPayRequestParams {
  const factory WalletPayRequestParams({
    required String version,
    required List<PaymentOption> acceptedPayments,
    required int expiry,
    String? orderId,
  }) = _WalletPayRequestParams;

  factory WalletPayRequestParams.fromJson(Map<String, dynamic> json) =>
      _$WalletPayRequestParamsFromJson(json);
}

@freezed
sealed class PaymentOption with _$PaymentOption {
  const factory PaymentOption({
    required String recipient, // chain-specific addr
    required String asset, // CAIP-19
    required String amount, // Hex string
    required List<String> types, // "erc20-transfer", "erc3009-authorization"
  }) = _PaymentOption;

  factory PaymentOption.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionFromJson(json);
}
