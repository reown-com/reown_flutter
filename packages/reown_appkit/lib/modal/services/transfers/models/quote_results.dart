import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';

part 'quote_results.freezed.dart';
part 'quote_results.g.dart';

typedef GetQuoteResult = Quote;

@freezed
sealed class GetQuoteStatusResult with _$GetQuoteStatusResult {
  const factory GetQuoteStatusResult({required QuoteStatus status}) =
      _GetQuoteStatusResult;

  factory GetQuoteStatusResult.fromJson(Map<String, dynamic> json) =>
      _$GetQuoteStatusResultFromJson(json);
}
