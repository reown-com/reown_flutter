import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_event.g.dart';
part 'basic_event.freezed.dart';

class BasicCoreEvent {
  final String? type;
  final String event;
  final CoreEventProperties? properties;

  BasicCoreEvent({this.type, required this.event, required this.properties});

  Map<String, dynamic> toJson() => {
    'type': type,
    'event': event,
    if (properties != null) 'properties': properties?.toJson(),
  };
}

@freezed
sealed class CoreEventProperties with _$CoreEventProperties {
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
    String? address,
    String? project_id,
    String? cursor,
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
  static const Error = _ErrorOptions();
  static const Track = _TrackOptions();
}

class _ErrorOptions {
  const _ErrorOptions();

  final NO_WSS_CONNECTION = 'NO_WSS_CONNECTION';
  final NO_INTERNET_CONNECTION = 'NO_INTERNET_CONNECTION';
  final MALFORMED_PAIRING_URI = 'MALFORMED_PAIRING_URI';
  final PAIRING_ALREADY_EXIST = 'PAIRING_ALREADY_EXIST';
  final PAIRING_SUBSCRIPTION_FAILURE = 'FAILED_TO_SUBSCRIBE_TO_PAIRING_TOPIC';
  final PAIRING_URI_EXPIRED = 'PAIRING_URI_EXPIRED';
  final PAIRING_EXPIRED = 'PAIRING_EXPIRED';
  final PROPOSAL_EXPIRED = 'PROPOSAL_EXPIRED';
  final SESSION_SUBSCRIPTION_FAILURE = 'SESSION_SUBSCRIPTION_FAILURE';
  final SESSION_APPROVE_PUBLISH_FAILURE = 'SESSION_APPROVE_PUBLISH_FAILURE';
  final SESSION_SETTLE_PUBLISH_FAILURE = 'SESSION_SETTLE_PUBLISH_FAILURE';
  final SESSION_APPROVE_NAMESPACE_VALIDATION_FAILURE =
      'SESSION_APPROVE_NAMESPACE_VALIDATION_FAILURE';
  final REQUIRED_NAMESPACE_VALIDATION_FAILURE =
      'REQUIRED_NAMESPACE_VALIDATION_FAILURE';
  final OPTIONAL_NAMESPACE_VALIDATION_FAILURE =
      'OPTIONAL_NAMESPACE_VALIDATION_FAILURE';
  final SESSION_PROPERTIES_VALIDATION_FAILURE =
      'SESSION_PROPERTIES_VALIDATION_FAILURE';
  final MISSING_SESSION_AUTH_REQUEST = 'MISSING_SESSION_AUTH_REQUEST';
  final SESSION_AUTH_REQUEST_EXPIRED = 'SESSION_AUTH_REQUEST_EXPIRED';
  final CHAINS_CAIP2_COMPLIANT_FAILURE = 'CHAINS_CAIP2_COMPLIANT_FAILURE';
  final CHAINS_EVM_COMPLIANT_FAILURE = 'CHAINS_EVM_COMPLIANT_FAILURE';
  final INVALID_CACAO = 'INVALID_CACAO';
  final SUBSCRIBE_AUTH_SESSION_TOPIC_FAILURE =
      'SUBSCRIBE_AUTH_SESSION_TOPIC_FAILURE';
  final AUTHENTICATED_SESSION_APPROVE_PUBLISH_FAILURE =
      'AUTHENTICATED_SESSION_APPROVE_PUBLISH_FAILURE';
  final AUTHENTICATED_SESSION_EXPIRED = 'AUTHENTICATED_SESSION_EXPIRED';
}

class _TrackOptions {
  const _TrackOptions();

  // AppKit
  final MODAL_CREATED = 'MODAL_CREATED';
  final MODAL_LOADED = 'MODAL_LOADED';
  final MODAL_OPEN = 'MODAL_OPEN';
  final MODAL_CLOSE = 'MODAL_CLOSE';
  final CLICK_ALL_WALLETS = 'CLICK_ALL_WALLETS';
  final CLICK_NETWORKS = 'CLICK_NETWORKS';
  final SWITCH_NETWORK = 'SWITCH_NETWORK';
  final SELECT_WALLET = 'SELECT_WALLET';
  final CONNECT_SUCCESS = 'CONNECT_SUCCESS';
  final CONNECT_ERROR = 'CONNECT_ERROR';
  final DISCONNECT_SUCCESS = 'DISCONNECT_SUCCESS';
  final DISCONNECT_ERROR = 'DISCONNECT_ERROR';
  final CLICK_WALLET_HELP = 'CLICK_WALLET_HELP';
  final CLICK_NETWORK_HELP = 'CLICK_NETWORK_HELP';
  final CLICK_GET_WALLET = 'CLICK_GET_WALLET';
  final EMAIL_LOGIN_SELECTED = 'EMAIL_LOGIN_SELECTED';
  final EMAIL_SUBMITTED = 'EMAIL_SUBMITTED';
  final DEVICE_REGISTERED_FOR_EMAIL = 'DEVICE_REGISTERED_FOR_EMAIL';
  final EMAIL_VERIFICATION_CODE_SENT = 'EMAIL_VERIFICATION_CODE_SENT';
  final EMAIL_VERIFICATION_CODE_PASS = 'EMAIL_VERIFICATION_CODE_PASS';
  final EMAIL_VERIFICATION_CODE_FAIL = 'EMAIL_VERIFICATION_CODE_FAIL';
  final EMAIL_EDIT = 'EMAIL_EDIT';
  final EMAIL_EDIT_COMPLETE = 'EMAIL_EDIT_COMPLETE';
  final EMAIL_UPGRADE_FROM_MODAL = 'EMAIL_UPGRADE_FROM_MODAL';
  final CLICK_SIGN_SIWE_MESSAGE = 'CLICK_SIGN_SIWE_MESSAGE';
  final CLICK_CANCEL_SIWE = 'CLICK_CANCEL_SIWE';
  final SIWE_AUTH_SUCCESS = 'SIWE_AUTH_SUCCESS';
  final SIWE_AUTH_ERROR = 'SIWE_AUTH_ERROR';
  final SOCIAL_LOGIN_STARTED = 'SOCIAL_LOGIN_STARTED';
  final SOCIAL_LOGIN_SUCCESS = 'SOCIAL_LOGIN_SUCCESS';
  final SOCIAL_LOGIN_ERROR = 'SOCIAL_LOGIN_ERROR';
  final SOCIAL_LOGIN_REQUEST_USER_DATA = 'SOCIAL_LOGIN_REQUEST_USER_DATA';
  final SOCIAL_LOGIN_CANCELED = 'SOCIAL_LOGIN_CANCELED';
  final OPEN_SEND = 'OPEN_SEND';
  final SEND_INITIATED = 'SEND_INITIATED';
  final SEND_SUCCESS = 'SEND_SUCCESS';
  final SEND_ERROR = 'SEND_ERROR';
  final SIGN_TRANSACTION = 'SIGN_TRANSACTION';
  final CLICK_TRANSACTIONS = 'CLICK_TRANSACTIONS'; // TODO
  final ERROR_FETCH_TRANSACTIONS = 'ERROR_FETCH_TRANSACTIONS'; // TODO
  final LOAD_MORE_TRANSACTIONS = 'LOAD_MORE_TRANSACTIONS'; // TODO
}
