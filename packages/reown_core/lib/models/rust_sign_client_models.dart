import 'package:event/event.dart';
import 'package:reown_core/reown_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rust_sign_client_models.g.dart';
part 'rust_sign_client_models.freezed.dart';

class YttriumSessionPropose extends EventArgs {
  String pairingTopic;
  SessionProposal proposal;

  YttriumSessionPropose(
    this.pairingTopic,
    this.proposal,
  );
}

@freezed
class SessionProposal with _$SessionProposal {
  const factory SessionProposal({
    required String id,
    required String topic,
    required String pairingSymKey, // hex encoded string
    required String proposerPublicKey, // hex encoded string
    required List<Relay> relays,
    required Map<String, Map<String, dynamic>> requiredNamespaces,
    Map<String, Map<String, dynamic>>? optionalNamespaces,
    required PairingMetadata metadata,
    Map<String, String>? sessionProperties,
    Map<String, String>? scopedProperties,
    int? expiryTimestamp,
  }) = _SessionProposal;

  factory SessionProposal.fromJson(Map<String, dynamic> json) =>
      _$SessionProposalFromJson(json);
}

@freezed
class ApproveResult with _$ApproveResult {
  @JsonSerializable()
  const factory ApproveResult({
    required String sessionSymKey, // hex encoded string
    required String selfPublicKey, // hex encoded string
  }) = _ApproveResult;

  factory ApproveResult.fromJson(Map<String, dynamic> json) =>
      _$ApproveResultFromJson(json);
}
