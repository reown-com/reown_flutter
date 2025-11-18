import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_sign/models/cacao_models.dart';

import 'package:reown_sign/models/session_models.dart';

part 'sign_client_models.g.dart';
part 'sign_client_models.freezed.dart';

class ConnectResponse {
  final String pairingTopic;
  final Completer<SessionData> session;
  final Uri? uri;

  ConnectResponse({
    required this.pairingTopic,
    required this.session,
    this.uri,
  });

  @override
  String toString() {
    return 'ConnectResponse(pairingTopic: $pairingTopic, session: $session, uri: $uri)';
  }
}

class ApproveResponse {
  final String topic;
  final SessionData? session;

  ApproveResponse({required this.topic, required this.session});

  @override
  String toString() {
    return 'ApproveResponse(topic: $topic, session: $session)';
  }
}

@freezed
sealed class ProposalRequestsResponses with _$ProposalRequestsResponses {
  @JsonSerializable(includeIfNull: false)
  const factory ProposalRequestsResponses({
    List<Cacao>? authentication,
    WalletPayResult? walletPayResult,
  }) = _ProposalRequestsResponses;

  factory ProposalRequestsResponses.fromJson(Map<String, dynamic> json) =>
      _$ProposalRequestsResponsesFromJson(json);
}
