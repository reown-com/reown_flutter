import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_pos/utils/extensions.dart';

part 'query_models.g.dart';
part 'query_models.freezed.dart';

@freezed
sealed class QueryParams with _$QueryParams {
  const factory QueryParams({
    required String projectId,
    required String deviceId,
    required String st,
    required String sv,
  }) = _QueryParams;

  factory QueryParams.fromJson(Map<String, dynamic> json) =>
      _$QueryParamsFromJson(json);
}

@freezed
sealed class PaymentIntentParams with _$PaymentIntentParams {
  const factory PaymentIntentParams({
    required String asset,
    required String amount,
    required String sender,
    required String recipient,
  }) = _PaymentIntentParams;

  factory PaymentIntentParams.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentParamsFromJson(json);

  factory PaymentIntentParams.fromPaymentIntent(
    PaymentIntent intent,
    String sender,
  ) => PaymentIntentParams(
    /// CAIP-19 Asset ID (e.g. `eip155:1/erc20:0xabc...`)
    asset: intent.caip19Token,
    amount: intent.amount,
    sender: sender, // should already be CAIP-10
    recipient: intent.caip10Recipient,
  );
}

@freezed
sealed class BuildTransactionParams with _$BuildTransactionParams {
  const factory BuildTransactionParams({
    required List<PaymentIntentParams> paymentIntents,
    dynamic capabilities,
  }) = _BuildTransactionParams;

  factory BuildTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$BuildTransactionParamsFromJson(json);
}

@freezed
sealed class CheckTransactionParams with _$CheckTransactionParams {
  const factory CheckTransactionParams({
    required String id,
    required String sendResult,
  }) = _CheckTransactionParams;

  factory CheckTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$CheckTransactionParamsFromJson(json);
}
