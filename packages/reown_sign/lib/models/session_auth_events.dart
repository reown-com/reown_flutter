import 'dart:convert';

import 'package:event/event.dart';

import 'package:reown_core/reown_core.dart';

import 'package:reown_sign/models/basic_models.dart';
import 'package:reown_sign/models/cacao_models.dart';
import 'package:reown_sign/models/session_models.dart';
import 'package:reown_sign/models/session_auth_models.dart';

class SessionAuthRequest extends EventArgs {
  final int id;
  final String topic;
  final SessionAuthPayload authPayload;
  final ConnectionMetadata requester;
  final TransportType transportType;
  final VerifyContext? verifyContext;

  SessionAuthRequest({
    required this.id,
    required this.topic,
    required this.authPayload,
    required this.requester,
    this.transportType = TransportType.relay,
    this.verifyContext,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        'authPayload': authPayload.toJson(),
        'requester': requester.toJson(),
        'transportType': transportType.name,
        if (verifyContext != null) 'verifyContext': verifyContext!.toJson(),
      };

  @override
  String toString() {
    return 'SessionAuthRequest(${jsonEncode(toJson())})';
  }
}

class SessionAuthResponse extends EventArgs {
  final int id;
  final String topic;
  final List<Cacao>? auths;
  final SessionData? session;
  final ReownSignError? error;
  final JsonRpcError? jsonRpcError;

  SessionAuthResponse({
    required this.id,
    required this.topic,
    this.auths,
    this.session,
    this.error,
    this.jsonRpcError,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        if (auths != null) 'auths': auths,
        if (session != null) 'session': session!.toJson(),
        if (error != null) 'error': error!.toJson(),
        if (jsonRpcError != null) 'jsonRpcError': jsonRpcError!.toJson(),
      };

  @override
  String toString() {
    return 'SessionAuthResponse(${jsonEncode(toJson())})';
  }
}
