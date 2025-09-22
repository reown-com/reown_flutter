import 'package:freezed_annotation/freezed_annotation.dart';

part 'pos_models.g.dart';
part 'pos_models.freezed.dart';

@freezed
sealed class PaymentIntent with _$PaymentIntent {
  const factory PaymentIntent({
    required PosToken token, // PosToken value
    required String amount, // double as String, i.e. "12.5"
    required String recipient, // recipient address, 0x..... for EVM
  }) = _PaymentIntent;

  factory PaymentIntent.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentFromJson(json);
}

@freezed
sealed class Metadata with _$Metadata {
  const factory Metadata({
    required String merchantName,
    required String description,
    required String url,
    required String logoIcon,
  }) = _Metadata;

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
}

@freezed
sealed class PosNetwork with _$PosNetwork {
  const factory PosNetwork({required String name, required String chainId}) =
      _PosNetwork;

  factory PosNetwork.fromJson(Map<String, dynamic> json) =>
      _$PosNetworkFromJson(json);
}

@freezed
sealed class PosToken with _$PosToken {
  const factory PosToken({
    required PosNetwork network,
    required String symbol,
    required String standard, // erc20 for EVM
    required String address,
  }) = _PosToken;

  factory PosToken.fromJson(Map<String, dynamic> json) =>
      _$PosTokenFromJson(json);
}

// TODO update notion doc
