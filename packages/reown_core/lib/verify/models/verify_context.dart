import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_context.g.dart';
part 'verify_context.freezed.dart';

enum Validation {
  UNKNOWN,
  VALID,
  INVALID,
  SCAM;

  bool get invalid => this == INVALID;
  bool get valid => this == VALID;
  bool get unknown => this == UNKNOWN;
  bool get scam => this == SCAM;
}

@freezed
sealed class VerifyContext with _$VerifyContext {
  @JsonSerializable()
  const factory VerifyContext({
    required String origin,
    required Validation validation,
    required String verifyUrl,
    bool? isScam,
  }) = _VerifyContext;

  factory VerifyContext.fromJson(Map<String, dynamic> json) =>
      _$VerifyContextFromJson(json);
}

@freezed
sealed class AttestationResponse with _$AttestationResponse {
  @JsonSerializable()
  const factory AttestationResponse({
    required String origin,
    required String attestationId,
    bool? isScam,
  }) = _AttestationResponse;

  factory AttestationResponse.fromJson(Map<String, dynamic> json) =>
      _$AttestationResponseFromJson(json);
}


@freezed
sealed class VerifyClaims with _$VerifyClaims {
  const factory VerifyClaims({
    @JsonKey(name: 'origin') required String origin,
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'isScam') bool? isScam,
    @JsonKey(name: 'exp') required int expiration,
    @JsonKey(name: 'isVerified') required bool isVerified,
  }) = _VerifyClaims;

  factory VerifyClaims.fromJson(Map<String, dynamic> json) =>
      _$VerifyClaimsFromJson(json);
}

extension VerifyClaimsExtension on VerifyClaims {
  bool isExpired() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return expiration < now;
  }
}

class AttestationNotFound implements Exception {
  int code;
  String message;

  AttestationNotFound({required this.code, required this.message}) : super();
}
