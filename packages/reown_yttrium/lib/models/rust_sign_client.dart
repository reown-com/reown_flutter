import 'package:freezed_annotation/freezed_annotation.dart';

part 'rust_sign_client.g.dart';
part 'rust_sign_client.freezed.dart';

@freezed
class SessionProposalFfi with _$SessionProposalFfi {
  const factory SessionProposalFfi({
    required String id,
    required String topic,
    required List<int> pairingSymKey,
    required List<int> proposerPublicKey,
    required List<Map<String, dynamic>> relays,
    required Map<String, Map<String, dynamic>> requiredNamespaces,
    Map<String, Map<String, dynamic>>? optionalNamespaces,
    required Map<String, dynamic> metadata,
    Map<String, String>? sessionProperties,
    Map<String, String>? scopedProperties,
    int? expiryTimestamp,
  }) = _SessionProposalFfi;

  factory SessionProposalFfi.fromJson(Map<String, dynamic> json) =>
      _$SessionProposalFfiFromJson(json);
}

@freezed
class SettleNamespaceFfi with _$SettleNamespaceFfi {
  const factory SettleNamespaceFfi({
    required List<String> accounts,
    required List<String> methods,
    required List<String> events,
    required List<String> chains,
  }) = _SettleNamespaceFfi;

  factory SettleNamespaceFfi.fromJson(Map<String, dynamic> json) =>
      _$SettleNamespaceFfiFromJson(json);
}

@freezed
class MetadataFfi with _$MetadataFfi {
  @JsonSerializable(includeIfNull: false)
  const factory MetadataFfi({
    required String name,
    required String description,
    @Default('') String url,
    @Default(<String>[]) List<String> icons,
    String? verifyUrl,
    RedirectFfi? redirect,
  }) = _MetadataFfi;

  factory MetadataFfi.fromJson(Map<String, dynamic> json) =>
      _$MetadataFfiFromJson(json);
}

@freezed
class RedirectFfi with _$RedirectFfi {
  @JsonSerializable()
  const factory RedirectFfi({
    String? native,
    String? universal,
    @Default(false) bool linkMode,
  }) = _RedirectFfi;

  factory RedirectFfi.fromJson(Map<String, dynamic> json) =>
      _$RedirectFfiFromJson(json);
}

@freezed
class ApproveResultFfi with _$ApproveResultFfi {
  @JsonSerializable()
  const factory ApproveResultFfi({
    required List<int> sessionSymKey,
    required List<int> selfPublicKey,
  }) = _ApproveResultFfi;

  factory ApproveResultFfi.fromJson(Map<String, dynamic> json) =>
      _$ApproveResultFfiFromJson(json);
}
