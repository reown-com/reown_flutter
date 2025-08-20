import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';

part 'basic_models.g.dart';
part 'basic_models.freezed.dart';

/// ERRORS

class ReownCoreErrorSilent {}

@freezed
sealed class ReownCoreError with _$ReownCoreError {
  @JsonSerializable(includeIfNull: false)
  const factory ReownCoreError({
    required int code,
    required String message,
    String? data,
  }) = _ReownCoreError;

  factory ReownCoreError.fromJson(Map<String, dynamic> json) =>
      _$ReownCoreErrorFromJson(json);
}

@freezed
sealed class PublishOptions with _$PublishOptions {
  @JsonSerializable(includeIfNull: false)
  const factory PublishOptions({
    int? ttl,
    int? tag,
    int? correlationId,
    Map<String, dynamic>? tvf,
    String? publishMethod,
  }) = _PublishOptions;

  factory PublishOptions.fromJson(Map<String, dynamic> json) =>
      _$PublishOptionsFromJson(json);
}

@freezed
sealed class SubscribeOptions with _$SubscribeOptions {
  @JsonSerializable(includeIfNull: false)
  const factory SubscribeOptions({
    required String topic,
    @Default(TransportType.relay) TransportType transportType,
    @Default(false) bool skipSubscribe,
  }) = _SubscribeOptions;

  factory SubscribeOptions.fromJson(Map<String, dynamic> json) =>
      _$SubscribeOptionsFromJson(json);
}
