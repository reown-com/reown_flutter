import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_models.g.dart';
part 'result_models.freezed.dart';

@freezed
sealed class Exchange with _$Exchange {
  const factory Exchange({
    required String id,
    required String imageUrl,
    required String name,
  }) = _Exchange;

  factory Exchange.fromJson(Map<String, dynamic> json) =>
      _$ExchangeFromJson(json);
}

@freezed
sealed class GetExchangesResult with _$GetExchangesResult {
  const factory GetExchangesResult({
    required List<Exchange> exchanges,
    required int total,
  }) = _GetExchangesResult;

  factory GetExchangesResult.fromJson(Map<String, dynamic> json) =>
      _$GetExchangesResultFromJson(json);
}

@freezed
sealed class GetExchangeUrlResult with _$GetExchangeUrlResult {
  const factory GetExchangeUrlResult({
    required String sessionId,
    required String url,
  }) = _GetExchangeUrlResult;

  factory GetExchangeUrlResult.fromJson(Map<String, dynamic> json) =>
      _$GetExchangeUrlResultFromJson(json);
}
