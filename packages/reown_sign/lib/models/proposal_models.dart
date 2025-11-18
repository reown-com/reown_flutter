import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_sign/models/basic_models.dart';
import 'package:reown_sign/models/session_auth_models.dart';
import 'package:reown_sign/models/session_models.dart';

part 'proposal_models.g.dart';
part 'proposal_models.freezed.dart';

@freezed
sealed class RequiredNamespace with _$RequiredNamespace {
  @JsonSerializable(includeIfNull: false)
  const factory RequiredNamespace({
    List<String>? chains,
    required List<String> methods,
    required List<String> events,
  }) = _RequiredNamespace;

  factory RequiredNamespace.fromJson(Map<String, dynamic> json) =>
      _$RequiredNamespaceFromJson(json);
}

@freezed
sealed class SessionProposal with _$SessionProposal {
  @JsonSerializable()
  const factory SessionProposal({
    required int id,
    required ProposalData params,
  }) = _SessionProposal;

  factory SessionProposal.fromJson(Map<String, dynamic> json) =>
      _$SessionProposalFromJson(json);
}

@freezed
sealed class ProposalData with _$ProposalData {
  @JsonSerializable(includeIfNull: false)
  const factory ProposalData({
    required int id,
    required int expiry,
    required List<Relay> relays,
    required ConnectionMetadata proposer,
    required Map<String, RequiredNamespace> requiredNamespaces,
    required Map<String, RequiredNamespace> optionalNamespaces,
    required String pairingTopic,
    Map<String, String>? sessionProperties,
    Map<String, Namespace>? generatedNamespaces,
    ProposalRequests? requests,
  }) = _ProposalData;

  factory ProposalData.fromJson(Map<String, dynamic> json) =>
      _$ProposalDataFromJson(json);
}

@freezed
sealed class ProposalRequests with _$ProposalRequests {
  @JsonSerializable(includeIfNull: false)
  const factory ProposalRequests({
    List<SessionAuthPayload>? authentication,
    WalletPayRequestParams? walletPayRequest,
  }) = _ProposalRequests;

  factory ProposalRequests.fromJson(Map<String, dynamic> json) =>
      _$ProposalRequestsFromJson(json);
}

@freezed
sealed class WalletPayRequestParams with _$WalletPayRequestParams {
  const factory WalletPayRequestParams({
    required String version,
    required List<PaymentOption> acceptedPayments,
    required int expiry,
    String? orderId,
  }) = _WalletPayRequestParams;

  factory WalletPayRequestParams.fromJson(Map<String, dynamic> json) =>
      _$WalletPayRequestParamsFromJson(json);
}

@freezed
sealed class PaymentOption with _$PaymentOption {
  const factory PaymentOption({
    required String recipient,
    required String asset,
    required String amount, // Hex string
    // types
  }) = _PaymentOption;

  factory PaymentOption.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionFromJson(json);
}
