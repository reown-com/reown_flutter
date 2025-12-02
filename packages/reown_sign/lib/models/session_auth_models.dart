import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_core/verify/models/verify_context.dart';

import 'package:reown_sign/models/cacao_models.dart';
import 'package:reown_sign/models/json_rpc_models.dart';
import 'package:reown_sign/models/session_auth_events.dart';
import 'package:reown_sign/models/basic_models.dart';

part 'session_auth_models.g.dart';
part 'session_auth_models.freezed.dart';

class SessionAuthRequestResponse {
  final int id;
  final String pairingTopic;
  final Completer<SessionAuthResponse> completer;
  final Uri? uri;

  SessionAuthRequestResponse({
    required this.id,
    required this.pairingTopic,
    required this.completer,
    this.uri,
  });
}

@freezed
sealed class SessionAuthRequestParams with _$SessionAuthRequestParams {
  @JsonSerializable(includeIfNull: false)
  const factory SessionAuthRequestParams({
    required String domain,
    required List<String> chains,
    required String nonce,
    required String uri,
    //
    CacaoHeader? type,
    String? exp,
    String? nbf,
    String? statement,
    String? requestId,
    List<String>? resources,
    int? expiry,
    Map<String, List<String>>? signatureTypes,
    @Deprecated(
      '`methods` will be deprecated soon. Please use `connect` with `authentication` param',
    )
    List<String>? methods,
  }) = _SessionAuthRequestParams;
  //
  factory SessionAuthRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SessionAuthRequestParamsFromJson(json);
}

@freezed
sealed class SessionAuthPayload with _$SessionAuthPayload {
  @JsonSerializable(includeIfNull: false)
  const factory SessionAuthPayload({
    required String domain,
    required List<String> chains,
    required String nonce,
    required String aud,
    required String type,
    //
    required String version,
    required String iat,
    //
    String? nbf,
    String? exp,
    String? statement,
    String? requestId,
    List<String>? resources,
  }) = _SessionAuthPayload;

  factory SessionAuthPayload.fromRequestParams(
    SessionAuthRequestParams params,
  ) {
    final now = DateTime.now();
    return SessionAuthPayload(
      chains: params.chains,
      domain: params.domain,
      nonce: params.nonce,
      aud: params.uri,
      type: params.type?.t ?? 'eip4361',
      version: '1',
      iat: DateTime.utc(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
      ).toIso8601String(),
      nbf: params.nbf,
      exp: params.exp,
      statement: params.statement,
      requestId: params.requestId,
      resources: params.resources,
    );
  }

  factory SessionAuthPayload.fromJson(Map<String, dynamic> json) =>
      _$SessionAuthPayloadFromJson(json);
}

@freezed
sealed class PendingSessionAuthRequest with _$PendingSessionAuthRequest {
  @JsonSerializable(includeIfNull: false)
  const factory PendingSessionAuthRequest({
    required int id,
    required String pairingTopic,
    required ConnectionMetadata requester,
    required int expiryTimestamp,
    required CacaoRequestPayload authPayload,
    required VerifyContext verifyContext,
    @Default(TransportType.relay) TransportType transportType,
  }) = _PendingSessionAuthRequest;

  factory PendingSessionAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$PendingSessionAuthRequestFromJson(json);
}

class SessionAuthenticateCompleter {
  final int id;
  final String pairingTopic;
  final String responseTopic;
  final String selfPublicKey;
  final String? walletUniversalLink;
  final WcSessionAuthRequestParams request;
  final Completer<SessionAuthResponse> completer;

  SessionAuthenticateCompleter({
    required this.id,
    required this.pairingTopic,
    required this.responseTopic,
    required this.selfPublicKey,
    required this.walletUniversalLink,
    required this.request,
    required this.completer,
  });
}
