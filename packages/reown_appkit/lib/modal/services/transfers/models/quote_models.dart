import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';

part 'quote_models.freezed.dart';
part 'quote_models.g.dart';

@freezed
sealed class QuoteFee with _$QuoteFee {
  const factory QuoteFee({
    required String id,
    required String label,
    required String amount,
    required String amountFormatted,
    required String chainId,
    required String amountUsd,
    required ExchangeAsset currency,
  }) = _QuoteFee;

  factory QuoteFee.fromJson(Map<String, dynamic> json) =>
      _$QuoteFeeFromJson(json);
}

@freezed
sealed class QuoteCurrency with _$QuoteCurrency {
  const factory QuoteCurrency({
    required String amount,
    required String amountFormatted,
    required String chainId,
    String? symbol,
    int? decimals,
  }) = _QuoteCurrency;

  factory QuoteCurrency.fromJson(Map<String, dynamic> json) =>
      _$QuoteCurrencyFromJson(json);
}

enum QuoteStatus {
  @JsonValue('waiting')
  waiting,
  @JsonValue('pending')
  pending,
  @JsonValue('success')
  success,
  @JsonValue('failure')
  failure,
  @JsonValue('refund')
  refund,
  @JsonValue('timeout')
  timeout,
  @JsonValue('submitted')
  submitted,
}

enum QuoteType {
  @JsonValue('same-chain')
  sameChain,
  @JsonValue('cross-chain')
  crossChain,
}

@freezed
sealed class Quote with _$Quote {
  const factory Quote({
    required QuoteType type,
    required QuoteCurrency origin,
    required QuoteCurrency destination,
    required List<QuoteFee> fees,
    required String requestId,
    required String depositAddress,
    required int timeEstimate,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}
