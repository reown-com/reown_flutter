import 'dart:convert';

import 'package:flutter/services.dart';
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
    required String apiKey,
    required String sdkName,
    required String sdkVersion,
    required String sdkPlatform,
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
  }) = _GetPaymentOptionsRequest;

  factory GetPaymentOptionsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentOptionsRequestFromJson(json);
}

///
/// GetPaymentOptions response models
///

@freezed
sealed class PaymentOptionsResponse with _$PaymentOptionsResponse {
  const factory PaymentOptionsResponse({required List<PaymentOption> options}) =
      _PaymentOptionsResponse;

  factory PaymentOptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionsResponseFromJson(json);
}

@freezed
sealed class PaymentOption with _$PaymentOption {
  const factory PaymentOption({
    required String id,
    required PayAmount amount,
    required int etaSeconds,
    required List<RequiredAction> requiredActions,
  }) = _PaymentOption;

  factory PaymentOption.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionFromJson(json);
}

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
sealed class RequiredAction with _$RequiredAction {
  const factory RequiredAction.walletRpc({required WalletRpcAction data}) =
      RequiredActionWalletRpc;
  const factory RequiredAction.build({required BuildAction data}) =
      RequiredActionBuild;

  factory RequiredAction.fromJson(Map<String, dynamic> json) =>
      _$RequiredActionFromJson(json);
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
sealed class BuildAction with _$BuildAction {
  const factory BuildAction({required String data}) = _BuildAction;

  factory BuildAction.fromJson(Map<String, dynamic> json) =>
      _$BuildActionFromJson(json);
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
sealed class ConfirmPaymentJsonRequest with _$ConfirmPaymentJsonRequest {
  const factory ConfirmPaymentJsonRequest({
    required String paymentId,
    required String optionId,
    required List<SignatureResult> results,
    int? maxPollMs,
  }) = _ConfirmPaymentJsonRequest;

  factory ConfirmPaymentJsonRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentJsonRequestFromJson(json);
}

@freezed
sealed class SignatureResult with _$SignatureResult {
  const factory SignatureResult({required SignatureValue signature}) =
      _SignatureResult;

  factory SignatureResult.fromJson(Map<String, dynamic> json) =>
      _$SignatureResultFromJson(json);
}

@freezed
sealed class SignatureValue with _$SignatureValue {
  const factory SignatureValue({required String value}) = _SignatureValue;

  factory SignatureValue.fromJson(Map<String, dynamic> json) =>
      _$SignatureValueFromJson(json);
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
enum PaymentStatus { requiresAction, processing, succeeded, failed, expired }

///
/// Exceptions
/// 

class GetPaymentOptionsError extends PlatformException {
  GetPaymentOptionsError({
    required super.code,
    required super.message,
    required super.details,
    required super.stacktrace,
  });

  @override
  String toString() =>
      'GetPaymentOptionsError($code, $message, $details, $stacktrace)';
}

class GetRequiredActionError extends PlatformException {
  GetRequiredActionError({
    required super.code,
    required super.message,
    required super.details,
    required super.stacktrace,
  });

  @override
  String toString() =>
      'GetRequiredActionError($code, $message, $details, $stacktrace)';
}

class ConfirmPaymentError extends PlatformException {
  ConfirmPaymentError({
    required super.code,
    required super.message,
    required super.details,
    required super.stacktrace,
  });

  @override
  String toString() =>
      'ConfirmPaymentError($code, $message, $details, $stacktrace)';
}
