import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'walletpay_models.freezed.dart';
part 'walletpay_models.g.dart';

@freezed
sealed class DisplayData with _$DisplayData {
  const factory DisplayData({required List<PaymentItem> paymentOptions}) =
      _DisplayData;

  factory DisplayData.fromJson(Map<String, dynamic> json) =>
      _$DisplayDataFromJson(json);
}

@freezed
sealed class PaymentItem with _$PaymentItem {
  const factory PaymentItem({
    required String asset,
    // hex string like "0x5F5E100"
    required String amount,
    String? chain,
    String? symbol,
    ParsedDataPaymentItem? parsedData,
  }) = _PaymentItem;

  factory PaymentItem.fromJson(Map<String, dynamic> json) =>
      _$PaymentItemFromJson(json);
}

@freezed
sealed class ParsedDataPaymentItem with _$ParsedDataPaymentItem {
  const factory ParsedDataPaymentItem({
    required String assetName,
    // decimal or human readable amount like "100"
    required String amount,
    required String chain,
  }) = _ParsedDataPaymentItem;

  factory ParsedDataPaymentItem.fromJson(Map<String, dynamic> json) =>
      _$ParsedDataPaymentItemFromJson(json);
}

@freezed
sealed class WalletPayAction with _$WalletPayAction {
  const factory WalletPayAction({
    required String method,
    required dynamic data,
    required String hash,
  }) = _WalletPayAction;

  factory WalletPayAction.fromJson(Map<String, dynamic> json) =>
      _$WalletPayActionFromJson(json);
}

@freezed
sealed class TransferData with _$TransferData {
  const factory TransferData({
    String? from,
    String? to,
    // human-readable or decimal value (kept as String to preserve formatting)
    String? value,
    // "not before" unix timestamp (seconds)
    int? nbf,
    // expiration unix timestamp (seconds)
    int? exp,
    // hex nonce
    String? nonce,
  }) = _TransferData;

  factory TransferData.fromJson(Map<String, dynamic> json) =>
      _$TransferDataFromJson(json);
}

extension TransferDataExtension on TransferData {
  TransferData fromString(String jsonString) {
    return TransferData.fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
  }
}

@freezed
sealed class TransferConfirmation with _$TransferConfirmation {
  const factory TransferConfirmation({
    // e.g. "erc3009-authorization"
    required String type,
    required String data,
    // hex hash string
    required String hash,
  }) = _TransferConfirmation;

  factory TransferConfirmation.fromJson(Map<String, dynamic> json) =>
      _$TransferConfirmationFromJson(json);
}

extension TransferConfirmationExtension on TransferConfirmation {
  TransferData transferData() {
    return TransferData.fromJson(
      jsonDecode(data) as Map<String, dynamic>,
    );
  }
}

@freezed
sealed class WalletPayResponseResultV1 with _$WalletPayResponseResultV1 {
  const factory WalletPayResponseResultV1({
    required TransferConfirmation transferConfirmation,
  }) = _WalletPayResponseResultV1;

  factory WalletPayResponseResultV1.fromJson(Map<String, dynamic> json) =>
      _$WalletPayResponseResultV1FromJson(json);
}
