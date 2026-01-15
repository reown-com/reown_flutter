import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';

part 'quote_params.freezed.dart';
part 'quote_params.g.dart';

@freezed
sealed class GetQuoteParams with _$GetQuoteParams {
  const factory GetQuoteParams({
    required ExchangeAsset sourceToken,
    required ExchangeAsset toToken,
    required String recipient,
    required String amount,
    String? address,
  }) = _GetQuoteParams;

  factory GetQuoteParams.fromJson(Map<String, dynamic> json) =>
      _$GetQuoteParamsFromJson(json);
}

@freezed
sealed class GetTransfersQuoteParams with _$GetTransfersQuoteParams {
  const factory GetTransfersQuoteParams({
    @JsonKey(includeIfNull: false) String? user,
    required String originChainId,
    required String originCurrency,
    required String destinationChainId,
    required String destinationCurrency,
    required String recipient,
    required String amount,
  }) = _GetTransfersQuoteParams;

  factory GetTransfersQuoteParams.fromJson(Map<String, dynamic> json) =>
      _$GetTransfersQuoteParamsFromJson(json);
}

@freezed
sealed class GetQuoteStatusParams with _$GetQuoteStatusParams {
  const factory GetQuoteStatusParams({required String requestId}) =
      _GetQuoteStatusParams;

  factory GetQuoteStatusParams.fromJson(Map<String, dynamic> json) =>
      _$GetQuoteStatusParamsFromJson(json);
}
