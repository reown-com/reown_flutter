import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_core/reown_core.dart';

part 'basic_models.g.dart';
part 'basic_models.freezed.dart';

/// ERRORS

class ReownSignErrorSilent {}

@freezed
class ReownSignError with _$ReownSignError {
  @JsonSerializable(includeIfNull: false)
  const factory ReownSignError({
    required int code,
    required String message,
    String? data,
  }) = _ReownSignError;

  factory ReownSignError.fromJson(Map<String, dynamic> json) =>
      _$ReownSignErrorFromJson(json);
}

@freezed
class ConnectionMetadata with _$ConnectionMetadata {
  const factory ConnectionMetadata({
    required String publicKey,
    required PairingMetadata metadata,
  }) = _ConnectionMetadata;

  factory ConnectionMetadata.fromJson(Map<String, dynamic> json) =>
      _$ConnectionMetadataFromJson(json);
}

@freezed
class AuthPublicKey with _$AuthPublicKey {
  @JsonSerializable(includeIfNull: false)
  const factory AuthPublicKey({
    required String publicKey,
  }) = _AuthPublicKey;

  factory AuthPublicKey.fromJson(Map<String, dynamic> json) =>
      _$AuthPublicKeyFromJson(json);
}
