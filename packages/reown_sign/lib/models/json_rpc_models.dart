import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_sign/models/basic_models.dart';
import 'package:reown_sign/models/cacao_models.dart';
import 'package:reown_sign/models/session_auth_models.dart';
import 'package:reown_sign/models/proposal_models.dart';
import 'package:reown_sign/models/session_models.dart';
import 'package:reown_sign/models/sign_client_models.dart';

part 'json_rpc_models.g.dart';
part 'json_rpc_models.freezed.dart';

@freezed
sealed class WcPairingDeleteRequest with _$WcPairingDeleteRequest {
  @JsonSerializable()
  const factory WcPairingDeleteRequest({
    required int code,
    required String message,
  }) = _WcPairingDeleteRequest;

  factory WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingDeleteRequestFromJson(json);
}

@freezed
sealed class WcPairingPingRequest with _$WcPairingPingRequest {
  @JsonSerializable()
  const factory WcPairingPingRequest({required Map<String, dynamic> data}) =
      _WcPairingPingRequest;

  factory WcPairingPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingPingRequestFromJson(json);
}

@freezed
sealed class WcSessionProposeRequest with _$WcSessionProposeRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionProposeRequest({
    required List<Relay> relays,
    required Map<String, RequiredNamespace> requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    required ConnectionMetadata proposer,
    ProposalRequests? requests,
  }) = _WcSessionProposeRequest;

  factory WcSessionProposeRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeRequestFromJson(json);
}

@freezed
sealed class WcSessionSettleRequest with _$WcSessionSettleRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionSettleRequest({
    required Relay relay,
    required Map<String, Namespace> namespaces,
    required int expiry,
    required ConnectionMetadata controller,
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    ProposalRequestsResponses? proposalRequestsResponses,
  }) = _WcSessionSettleRequest;

  factory WcSessionSettleRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionSettleRequestFromJson(json);
}

@freezed
sealed class WcSessionProposeResponse with _$WcSessionProposeResponse {
  @JsonSerializable()
  const factory WcSessionProposeResponse({
    required Relay relay,
    required String responderPublicKey,
  }) = _WcSessionProposeResponse;

  factory WcSessionProposeResponse.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeResponseFromJson(json);
}

@freezed
sealed class WcSessionUpdateRequest with _$WcSessionUpdateRequest {
  @JsonSerializable()
  const factory WcSessionUpdateRequest({
    required Map<String, Namespace> namespaces,
  }) = _WcSessionUpdateRequest;

  factory WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionUpdateRequestFromJson(json);
}

@freezed
sealed class WcSessionExtendRequest with _$WcSessionExtendRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionExtendRequest({Map<String, dynamic>? data}) =
      _WcSessionExtendRequest;

  factory WcSessionExtendRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionExtendRequestFromJson(json);
}

@freezed
sealed class WcSessionDeleteRequest with _$WcSessionDeleteRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionDeleteRequest({
    required int code,
    required String message,
    String? data,
  }) = _WcSessionDeleteRequest;

  factory WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionDeleteRequestFromJson(json);
}

@freezed
sealed class WcSessionPingRequest with _$WcSessionPingRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionPingRequest({Map<String, dynamic>? data}) =
      _WcSessionPingRequest;

  factory WcSessionPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionPingRequestFromJson(json);
}

@freezed
sealed class WcSessionRequestRequest with _$WcSessionRequestRequest {
  @JsonSerializable()
  const factory WcSessionRequestRequest({
    required String chainId,
    required SessionRequestParams request,
  }) = _WcSessionRequestRequest;

  factory WcSessionRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionRequestRequestFromJson(json);
}

@freezed
sealed class WcSessionEventRequest with _$WcSessionEventRequest {
  @JsonSerializable()
  const factory WcSessionEventRequest({
    required String chainId,
    required SessionEventParams event,
  }) = _WcSessionEventRequest;

  factory WcSessionEventRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionEventRequestFromJson(json);
}

@freezed
sealed class WcSessionAuthRequestParams with _$WcSessionAuthRequestParams {
  @JsonSerializable()
  const factory WcSessionAuthRequestParams({
    required SessionAuthPayload authPayload,
    required ConnectionMetadata requester,
    required int expiryTimestamp,
  }) = _WcSessionAuthRequestParams;

  factory WcSessionAuthRequestParams.fromJson(Map<String, dynamic> json) =>
      _$WcSessionAuthRequestParamsFromJson(json);
}

@freezed
sealed class WcSessionAuthRequestResult with _$WcSessionAuthRequestResult {
  @JsonSerializable()
  const factory WcSessionAuthRequestResult({
    required List<Cacao> cacaos,
    required ConnectionMetadata responder,
  }) = _WcSessionAuthRequestResult;

  factory WcSessionAuthRequestResult.fromJson(Map<String, dynamic> json) =>
      _$WcSessionAuthRequestResultFromJson(json);
}
