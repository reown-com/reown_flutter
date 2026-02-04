import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'walletconnect_pay_models.g.dart';
part 'walletconnect_pay_models.freezed.dart';

///
/// Initialize models
///

@freezed
sealed class SdkConfig with _$SdkConfig {
  const factory SdkConfig({
    required String baseUrl,
    String? apiKey,
    String? projectId,
    String? appId,
    required String sdkName,
    required String sdkVersion,
    required String sdkPlatform,
    required String bundleId,
    String? clientId,
  }) = _SdkConfig;

  factory SdkConfig.fromJson(Map<String, dynamic> json) =>
      _$SdkConfigFromJson(json);
}

extension SdkConfigExtension on SdkConfig {
  String toJsonString() => jsonEncode(toJson());
}

///
/// GetPaymentOptions request models
///

@freezed
sealed class GetPaymentOptionsRequest with _$GetPaymentOptionsRequest {
  const factory GetPaymentOptionsRequest({
    required String paymentLink,
    required List<String> accounts,
    @Default(false) bool includePaymentInfo,
  }) = _GetPaymentOptionsRequest;

  factory GetPaymentOptionsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentOptionsRequestFromJson(json);
}

///
/// GetPaymentOptions response models
///

@freezed
sealed class PaymentOptionsResponse with _$PaymentOptionsResponse {
  const factory PaymentOptionsResponse({
    required String paymentId,
    PaymentInfo? info,
    required List<PaymentOption> options,
    CollectDataAction? collectData,
  }) = _PaymentOptionsResponse;

  factory PaymentOptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionsResponseFromJson(json);
}

@freezed
sealed class PaymentInfo with _$PaymentInfo {
  const factory PaymentInfo({
    required PaymentStatus status,
    required PayAmount amount,
    required int expiresAt,
    required MerchantInfo merchant,
    BuyerInfo? buyer,
  }) = _PaymentInfo;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoFromJson(json);
}

@freezed
sealed class MerchantInfo with _$MerchantInfo {
  const factory MerchantInfo({required String name, String? iconUrl}) =
      _MerchantInfo;

  factory MerchantInfo.fromJson(Map<String, dynamic> json) =>
      _$MerchantInfoFromJson(json);
}

@freezed
sealed class BuyerInfo with _$BuyerInfo {
  const factory BuyerInfo({
    required String accountCaip10,
    required String accountProviderName,
    String? accountProviderIcon,
  }) = _BuyerInfo;

  factory BuyerInfo.fromJson(Map<String, dynamic> json) =>
      _$BuyerInfoFromJson(json);
}

@freezed
sealed class CollectDataAction with _$CollectDataAction {
  const factory CollectDataAction({
    String? url,
    @Default(<CollectDataField>[]) List<CollectDataField> fields,
  }) = _CollectDataAction;

  factory CollectDataAction.fromJson(Map<String, dynamic> json) =>
      _$CollectDataActionFromJson(json);
}

@freezed
sealed class CollectDataField with _$CollectDataField {
  const factory CollectDataField({
    required String id,
    required String name,
    required bool required,
    required CollectDataFieldType fieldType,
  }) = _CollectDataField;

  factory CollectDataField.fromJson(Map<String, dynamic> json) =>
      _$CollectDataFieldFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.none)
enum CollectDataFieldType { text, date, checkbox }

@freezed
sealed class PaymentOption with _$PaymentOption {
  const factory PaymentOption({
    required String id,
    required String account,
    required PayAmount amount,
    @JsonKey(name: 'etaS') required int etaSeconds,
    required List<Action> actions,
  }) = _PaymentOption;

  factory PaymentOption.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionFromJson(json);
}

@freezed
sealed class Action with _$Action {
  const factory Action({
    @JsonKey(name: 'walletRpc') required WalletRpcAction walletRpc,
  }) = _Action;

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);
}

@freezed
sealed class WalletRpcAction with _$WalletRpcAction {
  const factory WalletRpcAction({
    required String chainId,
    required String method,
    required String params,
  }) = _WalletRpcAction;

  factory WalletRpcAction.fromJson(Map<String, dynamic> json) =>
      _$WalletRpcActionFromJson(json);
}

@freezed
sealed class PayAmount with _$PayAmount {
  const factory PayAmount({
    required String unit,
    required String value,
    required AmountDisplay display,
  }) = _PayAmount;

  factory PayAmount.fromJson(Map<String, dynamic> json) =>
      _$PayAmountFromJson(json);
}

@freezed
sealed class AmountDisplay with _$AmountDisplay {
  const factory AmountDisplay({
    required String assetSymbol,
    required String assetName,
    required int decimals,
    String? iconUrl,
    String? networkName,
    String? networkIconUrl,
  }) = _AmountDisplay;

  factory AmountDisplay.fromJson(Map<String, dynamic> json) =>
      _$AmountDisplayFromJson(json);
}

///
/// GetRequiredPaymentActions request models
///

@freezed
sealed class GetRequiredPaymentActionsRequest
    with _$GetRequiredPaymentActionsRequest {
  const factory GetRequiredPaymentActionsRequest({
    required String optionId,
    required String paymentId,
  }) = _GetRequiredPaymentActionsRequest;

  factory GetRequiredPaymentActionsRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$GetRequiredPaymentActionsRequestFromJson(json);
}

///
/// ConfirmPayment request models
///

@freezed
sealed class ConfirmPaymentRequest with _$ConfirmPaymentRequest {
  const factory ConfirmPaymentRequest({
    required String paymentId,
    required String optionId,
    required List<String> signatures,
    List<CollectDataFieldResult>? collectedData,
    int? maxPollMs,
  }) = _ConfirmPaymentRequest;

  factory ConfirmPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentRequestFromJson(json);
}

@freezed
sealed class CollectDataFieldResult with _$CollectDataFieldResult {
  const factory CollectDataFieldResult({
    required String id,
    required String value,
  }) = _CollectDataFieldResult;

  factory CollectDataFieldResult.fromJson(Map<String, dynamic> json) =>
      _$CollectDataFieldResultFromJson(json);
}

///
/// ConfirmPayment response models
///

@freezed
sealed class ConfirmPaymentResponse with _$ConfirmPaymentResponse {
  const factory ConfirmPaymentResponse({
    required PaymentStatus status,
    required bool isFinal,
    int? pollInMs,
  }) = _ConfirmPaymentResponse;

  factory ConfirmPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentResponseFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.none)
enum PaymentStatus { requires_action, processing, succeeded, failed, expired }
