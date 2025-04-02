import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_event.g.dart';
part 'basic_event.freezed.dart';

@freezed
class CoreEventProperties with _$CoreEventProperties {
  @JsonSerializable(includeIfNull: false)
  const factory CoreEventProperties({
    String? message,
    String? name,
    String? method,
    bool? connected,
    String? network,
    String? explorer_id,
    String? provider,
    String? platform,
    List<String>? trace,
    String? topic,
    int? correlation_id,
    String? client_id,
    String? direction,
    String? userAgent,
    String? sendToken,
    String? sendAmount,
  }) = _CoreEventProperties;

  factory CoreEventProperties.fromJson(Map<String, dynamic> json) =>
      _$CoreEventPropertiesFromJson(json);
}

class CoreEventType {
  static const String ERROR = 'ERROR';
  static const String SUCCESS = 'SUCCESS';
  static const String INIT = 'INIT';
  static const String TRACK = 'TRACK';
}

class CoreEventEvent {
  static const Error = _Error();
  static const Track = _Track();
}

class _Error {
  const _Error();

  final String NO_WSS_CONNECTION = 'NO_WSS_CONNECTION';
  final String NO_INTERNET_CONNECTION = 'NO_INTERNET_CONNECTION';
  final String MALFORMED_PAIRING_URI = 'MALFORMED_PAIRING_URI';
  final String PAIRING_ALREADY_EXIST = 'PAIRING_ALREADY_EXIST';
  final String PAIRING_SUBSCRIPTION_FAILURE =
      'FAILED_TO_SUBSCRIBE_TO_PAIRING_TOPIC';
  final String PAIRING_URI_EXPIRED = 'PAIRING_URI_EXPIRED';
  final String PAIRING_EXPIRED = 'PAIRING_EXPIRED';
  final String PROPOSAL_EXPIRED = 'PROPOSAL_EXPIRED';
  final String SESSION_SUBSCRIPTION_FAILURE = 'SESSION_SUBSCRIPTION_FAILURE';
  final String SESSION_APPROVE_PUBLISH_FAILURE =
      'SESSION_APPROVE_PUBLISH_FAILURE';
  final String SESSION_SETTLE_PUBLISH_FAILURE =
      'SESSION_SETTLE_PUBLISH_FAILURE';
  final String SESSION_APPROVE_NAMESPACE_VALIDATION_FAILURE =
      'SESSION_APPROVE_NAMESPACE_VALIDATION_FAILURE';
  final String REQUIRED_NAMESPACE_VALIDATION_FAILURE =
      'REQUIRED_NAMESPACE_VALIDATION_FAILURE';
  final String OPTIONAL_NAMESPACE_VALIDATION_FAILURE =
      'OPTIONAL_NAMESPACE_VALIDATION_FAILURE';
  final String SESSION_PROPERTIES_VALIDATION_FAILURE =
      'SESSION_PROPERTIES_VALIDATION_FAILURE';
  final String MISSING_SESSION_AUTH_REQUEST = 'MISSING_SESSION_AUTH_REQUEST';
  final String SESSION_AUTH_REQUEST_EXPIRED = 'SESSION_AUTH_REQUEST_EXPIRED';
  final String CHAINS_CAIP2_COMPLIANT_FAILURE =
      'CHAINS_CAIP2_COMPLIANT_FAILURE';
  final String CHAINS_EVM_COMPLIANT_FAILURE = 'CHAINS_EVM_COMPLIANT_FAILURE';
  final String INVALID_CACAO = 'INVALID_CACAO';
  final String SUBSCRIBE_AUTH_SESSION_TOPIC_FAILURE =
      'SUBSCRIBE_AUTH_SESSION_TOPIC_FAILURE';
  final String AUTHENTICATED_SESSION_APPROVE_PUBLISH_FAILURE =
      'AUTHENTICATED_SESSION_APPROVE_PUBLISH_FAILURE';
  final String AUTHENTICATED_SESSION_EXPIRED = 'AUTHENTICATED_SESSION_EXPIRED';
}

class _Track {
  const _Track();

  final String MODAL_CREATED = 'MODAL_CREATED';
  final String MODAL_LOADED = 'MODAL_LOADED';
  final String MODAL_OPEN = 'MODAL_OPEN';
  final String MODAL_CLOSE = 'MODAL_CLOSE';
  final String CLICK_ALL_WALLETS = 'CLICK_ALL_WALLETS';
  final String CLICK_NETWORKS = 'CLICK_NETWORKS';
  final String SWITCH_NETWORK = 'SWITCH_NETWORK';
  final String SELECT_WALLET = 'SELECT_WALLET';
  final String CONNECT_SUCCESS = 'CONNECT_SUCCESS';
  final String CONNECT_ERROR = 'CONNECT_ERROR';
  final String DISCONNECT_SUCCESS = 'DISCONNECT_SUCCESS';
  final String DISCONNECT_ERROR = 'DISCONNECT_ERROR';
  final String CLICK_WALLET_HELP = 'CLICK_WALLET_HELP';
  final String CLICK_NETWORK_HELP = 'CLICK_NETWORK_HELP';
  final String CLICK_GET_WALLET = 'CLICK_GET_WALLET';
}

abstract class BasicCoreEvent {
  abstract final String type;
  abstract final String event;
  abstract final CoreEventProperties? properties;

  Map<String, dynamic> toMap();

  // BasicCoreEvent updatePropertiesWith(CoreEventProperties properties);
}
