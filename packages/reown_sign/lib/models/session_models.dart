import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_core/verify/models/verify_context.dart';
import 'package:reown_sign/models/cacao_models.dart';
import 'package:reown_sign/models/basic_models.dart';
import 'package:reown_sign/models/proposal_models.dart';

part 'session_models.g.dart';
part 'session_models.freezed.dart';

class SessionProposalCompleter {
  final int id;
  final String selfPublicKey;
  final String pairingTopic;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final Map<String, RequiredNamespace> optionalNamespaces;
  final Map<String, String>? sessionProperties;
  final Map<String, dynamic>? scopedProperties;
  final Completer completer;

  const SessionProposalCompleter({
    required this.id,
    required this.selfPublicKey,
    required this.pairingTopic,
    required this.requiredNamespaces,
    required this.optionalNamespaces,
    required this.completer,
    this.sessionProperties,
    this.scopedProperties,
  });

  @override
  String toString() {
    return 'SessionProposalCompleter(id: $id, selfPublicKey: $selfPublicKey, pairingTopic: $pairingTopic, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, scopedProperties: $scopedProperties, completer: $completer)';
  }
}

@freezed
class Namespace with _$Namespace {
  @JsonSerializable(includeIfNull: false)
  const factory Namespace({
    List<String>? chains,
    required List<String> accounts,
    required List<String> methods,
    required List<String> events,
  }) = _Namespace;

  factory Namespace.fromJson(Map<String, dynamic> json) =>
      _$NamespaceFromJson(json);
}

@freezed
class SessionData with _$SessionData {
  @JsonSerializable(includeIfNull: false)
  const factory SessionData({
    required String topic,
    required String pairingTopic,
    required Relay relay,
    required int expiry,
    required bool acknowledged,
    required String controller,
    required Map<String, Namespace> namespaces,
    required ConnectionMetadata self,
    required ConnectionMetadata peer,
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    Map<String, dynamic>? scopedProperties,
    List<Cacao>? authentication,
    @Default(TransportType.relay) TransportType transportType,
  }) = _SessionData;

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);
}

@freezed
class SessionRequest with _$SessionRequest {
  @JsonSerializable()
  const factory SessionRequest({
    required int id,
    required String topic,
    required String method,
    required String chainId,
    required dynamic params,
    required VerifyContext verifyContext,
    @Default(TransportType.relay) TransportType transportType,
  }) = _SessionRequest;

  factory SessionRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestFromJson(json);
}
