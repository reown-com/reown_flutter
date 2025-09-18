import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';

part 'query_models.g.dart';
part 'query_models.freezed.dart';

@freezed
sealed class QueryParams with _$QueryParams {
  const factory QueryParams({
    required String projectId,
    required String source,
    required String st,
    required String sv,
  }) = _QueryParams;

  factory QueryParams.fromJson(Map<String, dynamic> json) =>
      _$QueryParamsFromJson(json);
}

@freezed
sealed class GetExchangesParams with _$GetExchangesParams {
  @JsonSerializable(includeIfNull: false)
  const factory GetExchangesParams({
    @Default(1) int page,
    ExchangeAsset? asset, // CAIP-19 token address
    List<String>? includeOnly, // list of exchangeIds
    List<String>? exclude, // list of exchangeIds
  }) = _GetExchangesParams;

  factory GetExchangesParams.fromJson(Map<String, dynamic> json) =>
      _$GetExchangesParamsFromJson(json);
}

extension GetExchangesParamsExtensions on GetExchangesParams {
  Map<String, dynamic> toParams() {
    return {
      'page': page,
      if (asset != null) 'asset': asset!.toCaip19(),
      if (includeOnly != null) 'includeOnly': includeOnly,
      if (exclude != null) 'exclude': exclude,
    };
  }
}

@freezed
sealed class GetExchangeUrlParams with _$GetExchangeUrlParams {
  const factory GetExchangeUrlParams({
    required String exchangeId,
    required ExchangeAsset asset, // CAIP-19 token address
    required String amount, // double as String
    required String recipient, // CAIP-10 account
  }) = _GetExchangeUrlParams;

  factory GetExchangeUrlParams.fromJson(Map<String, dynamic> json) =>
      _$GetExchangeUrlParamsFromJson(json);
}

extension GetExchangeUrlParamsExtension on GetExchangeUrlParams {
  Map<String, dynamic> toParams() {
    return {
      'exchangeId': exchangeId,
      'asset': asset.toCaip19(),
      'amount': amount,
      'recipient': recipient,
    };
  }
}

@freezed
sealed class GetExchangeByStatusParams with _$GetExchangeByStatusParams {
  const factory GetExchangeByStatusParams({
    required String exchangeId,
    required String sessionId,
  }) = _GetExchangeByStatusParams;

  factory GetExchangeByStatusParams.fromJson(Map<String, dynamic> json) =>
      _$GetExchangeByStatusParamsFromJson(json);
}
