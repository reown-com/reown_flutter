import 'package:freezed_annotation/freezed_annotation.dart';

part 'rust_sign_client.g.dart';
part 'rust_sign_client.freezed.dart';

@freezed
sealed class SessionProposalFfi with _$SessionProposalFfi {
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
sealed class SettleNamespaceFfi with _$SettleNamespaceFfi {
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
sealed class MetadataFfi with _$MetadataFfi {
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
sealed class RedirectFfi with _$RedirectFfi {
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
sealed class ApproveResultFfi with _$ApproveResultFfi {
  @JsonSerializable()
  const factory ApproveResultFfi({
    required List<int> sessionSymKey,
    required List<int> selfPublicKey,
  }) = _ApproveResultFfi;

  factory ApproveResultFfi.fromJson(Map<String, dynamic> json) =>
      _$ApproveResultFfiFromJson(json);
}

// RUST
@freezed
sealed class SessionRequestRequestFfi with _$SessionRequestRequestFfi {
  const factory SessionRequestRequestFfi({
    required String method,
    required String params, // JSON string
    int? expiry,
  }) = _SessionRequestRequestFfi;

  factory SessionRequestRequestFfi.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestRequestFfiFromJson(json);
}

// RUST
// Should be paired with WcSessionRequestRequest in reow_sign
@freezed
sealed class SessionRequestFfi with _$SessionRequestFfi {
  const factory SessionRequestFfi({
    required String chainId,
    required SessionRequestRequestFfi request,
  }) = _SessionRequestFfi;

  factory SessionRequestFfi.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestFfiFromJson(json);
}

// RUST
// Should be paired with JsonRpcRequest in reow_core
@freezed
sealed class SessionRequestJsonRpcFfi with _$SessionRequestJsonRpcFfi {
  const factory SessionRequestJsonRpcFfi({
    required int id,
    required String method,
    required SessionRequestFfi params,
  }) = _SessionRequestJsonRpcFfi;

  factory SessionRequestJsonRpcFfi.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestJsonRpcFfiFromJson(json);
}

// Comes from native through EventChannel
// should probably go in a different file as it does not pertains to rust itself
@freezed
sealed class SessionRequestNativeEvent with _$SessionRequestNativeEvent {
  const factory SessionRequestNativeEvent({
    required String topic,
    // JSON String. Should be transformed into SessionRequestJsonRpcFfi
    required String sessionRequest,
  }) = _SessionRequestNativeEvent;

  factory SessionRequestNativeEvent.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestNativeEventFromJson(json);
}

// @freezed
// class SessionRequestJsonRpcResultResponseFfi
//     with _$SessionRequestJsonRpcResultResponseFfi {
//   const factory SessionRequestJsonRpcResultResponseFfi({
//     required int id,
//     @Default('2.0') String jsonrpc,
//     required String result, // JSON string
//   }) = _SessionRequestJsonRpcResultResponseFfi;

//   factory SessionRequestJsonRpcResultResponseFfi.fromJson(
//           Map<String, dynamic> json) =>
//       _$SessionRequestJsonRpcResultResponseFfiFromJson(json);
// }

// @freezed
// class SessionRequestJsonRpcErrorResponseFfi
//     with _$SessionRequestJsonRpcErrorResponseFfi {
//   const factory SessionRequestJsonRpcErrorResponseFfi({
//     required int id,
//     @Default('2.0') String jsonrpc,
//     required String error, // JSON string
//   }) = _SessionRequestJsonRpcErrorResponseFfi;

//   factory SessionRequestJsonRpcErrorResponseFfi.fromJson(
//           Map<String, dynamic> json) =>
//       _$SessionRequestJsonRpcErrorResponseFfiFromJson(json);
// }

@freezed
sealed class SessionRequestJsonRpcResponseFfi
    with _$SessionRequestJsonRpcResponseFfi {
  const factory SessionRequestJsonRpcResponseFfi.result({
    required int id,
    @Default('2.0') String jsonrpc,
    required String result,
  }) = Result;

  const factory SessionRequestJsonRpcResponseFfi.error({
    required int id,
    @Default('2.0') String jsonrpc,
    required String error,
  }) = Error;

  factory SessionRequestJsonRpcResponseFfi.fromJson(
          Map<String, dynamic> json) =>
      _$SessionRequestJsonRpcResponseFfiFromJson(json);
}

@freezed
sealed class ErrorDataFfi with _$ErrorDataFfi {
  const factory ErrorDataFfi({
    required int code,
    required String message,
    String? data,
  }) = _ErrorDataFfi;

  factory ErrorDataFfi.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataFfiFromJson(json);
}
