import 'package:freezed_annotation/freezed_annotation.dart';

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
