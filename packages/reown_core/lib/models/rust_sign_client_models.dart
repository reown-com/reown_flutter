import 'package:convert/convert.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_core/reown_core.dart';

part 'rust_sign_client_models.g.dart';
part 'rust_sign_client_models.freezed.dart';

@freezed
sealed class SessionProposal with _$SessionProposal {
  const factory SessionProposal({
    required int id,
    required String pairingTopic,
    required String pairingSymKey, // hex encoded string
    required String proposerPublicKey, // hex encoded string
    required List<Map<String, dynamic>> relays,
    required Map<String, Map<String, dynamic>> requiredNamespaces,
    Map<String, Map<String, dynamic>>? optionalNamespaces,
    required Map<String, dynamic> metadata,
    Map<String, String>? sessionProperties,
    Map<String, String>? scopedProperties,
    int? expiry,
  }) = _SessionProposal;

  factory SessionProposal.fromJson(Map<String, dynamic> json) =>
      _$SessionProposalFromJson(json);

  factory SessionProposal.fromFfi(SessionProposalFfi ffi) => SessionProposal(
        id: int.parse(ffi.id),
        pairingTopic: ffi.topic,
        pairingSymKey: hex.encode(ffi.pairingSymKey),
        proposerPublicKey: hex.encode(ffi.proposerPublicKey),
        relays: ffi.relays,
        requiredNamespaces: ffi.requiredNamespaces,
        optionalNamespaces: ffi.optionalNamespaces,
        metadata: ffi.metadata,
        sessionProperties: ffi.sessionProperties,
        scopedProperties: ffi.scopedProperties,
        expiry: ffi.expiryTimestamp ??
            ReownCoreUtils.calculateExpiry(
              ReownConstants.FIVE_MINUTES,
            ),
      );
}

@freezed
sealed class ApproveResult with _$ApproveResult {
  @JsonSerializable()
  const factory ApproveResult({
    required String sessionSymKey, // hex encoded string
    required String selfPublicKey, // hex encoded string
  }) = _ApproveResult;

  factory ApproveResult.fromJson(Map<String, dynamic> json) =>
      _$ApproveResultFromJson(json);

  factory ApproveResult.fromFfi(ApproveResultFfi ffi) => ApproveResult(
        sessionSymKey: hex.encode(ffi.sessionSymKey),
        selfPublicKey: hex.encode(ffi.selfPublicKey),
      );
}
