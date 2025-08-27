import 'package:freezed_annotation/freezed_annotation.dart';

part 'pos_models.g.dart';
part 'pos_models.freezed.dart';

@freezed
sealed class PaymentIntent with _$PaymentIntent {
  const factory PaymentIntent({
    required String token, // TODO validate to CAIP-19
    required String amount,
    required String chainId, // TODO validate to CAIP-2
    required String recipient, // TODO validate to CAIP-10
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
