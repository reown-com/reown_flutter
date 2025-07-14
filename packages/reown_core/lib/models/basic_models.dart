import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';

part 'basic_models.g.dart';
part 'basic_models.freezed.dart';

/// ERRORS

class ReownCoreErrorSilent {}

@freezed
class ReownCoreError with _$ReownCoreError {
  @JsonSerializable(includeIfNull: false)
  const factory ReownCoreError({
    required int code,
    required String message,
    String? data,
  }) = _ReownCoreError;

  factory ReownCoreError.fromJson(Map<String, dynamic> json) =>
      _$ReownCoreErrorFromJson(json);
}

@JsonSerializable()
class PublishOptions {
  final int ttl;
  final int? tag;
  final int? correlationId;
  final Map<String, dynamic>? tvf;
  final String? publishMethod;

  const PublishOptions({
    required this.ttl,
    required this.tag,
    this.correlationId,
    this.tvf,
    this.publishMethod,
  });

  factory PublishOptions.fromJson(Map<String, dynamic> json) =>
      _$PublishOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$PublishOptionsToJson(this);
  Map<String, dynamic> toPublishParams() => {
        'ttl': ttl,
        if (tag != null) 'tag': tag,
        if (correlationId != null) 'correlationId': correlationId,
        ...?tvf,
      };

  PublishOptions copyWith({
    int? ttl,
    int? tag,
    int? correlationId,
    Map<String, dynamic>? tvf,
    String? publishMethod,
  }) {
    return PublishOptions(
      ttl: ttl ?? this.ttl,
      tag: tag ?? this.tag,
      correlationId: correlationId ?? this.correlationId,
      tvf: tvf ?? this.tvf,
      publishMethod: publishMethod ?? this.publishMethod,
    );
  }
}

@JsonSerializable()
class SubscribeOptions {
  final String topic;
  final TransportType transportType;
  final bool skipSubscribe;

  const SubscribeOptions({
    required this.topic,
    required this.transportType,
    this.skipSubscribe = false,
  });

  factory SubscribeOptions.fromJson(Map<String, dynamic> json) =>
      _$SubscribeOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$SubscribeOptionsToJson(this);

  SubscribeOptions copyWith({
    String? topic,
    TransportType? transportType,
    bool? skipSubscribe,
  }) {
    return SubscribeOptions(
      topic: topic ?? this.topic,
      transportType: transportType ?? this.transportType,
      skipSubscribe: skipSubscribe ?? this.skipSubscribe,
    );
  }
}
