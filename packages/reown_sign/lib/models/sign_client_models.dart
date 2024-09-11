import 'dart:async';

import 'package:reown_sign/models/session_models.dart';

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

  ApproveResponse({
    required this.topic,
    required this.session,
  });

  @override
  String toString() {
    return 'ApproveResponse(topic: $topic, session: $session)';
  }
}
